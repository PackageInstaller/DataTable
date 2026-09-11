using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

[DisallowMultipleComponent]
public sealed class SummerRaceCombatPresentationDebugSink : MonoBehaviour, ISummerRaceCombatPresentationSink
{
	private struct SequenceState
	{
		public bool HasPhase;

		public SummerRacePresentationPhase LastPhase;
	}

	private struct PendingBridgeExpectation
	{
		public int CorrelationId;

		public SummerRacePresentationPhase ProjectilePhase;

		public SummerRacePresentationPhase ExpectedWeaponPhase;

		public float CreatedAt;
	}

	[SerializeField]
	private bool logWeaponEvents = true;

	[SerializeField]
	private bool logEquipEvents = true;

	[SerializeField]
	private bool logProjectileEvents = true;

	[SerializeField]
	private bool echoToConsole;

	[SerializeField]
	private float bridgeExpectationTimeout = 1.25f;

	[SerializeField]
	private int maxEntries = 48;

	[SerializeField]
	[TextArea(8, 24)]
	private string recentEventsPreview = string.Empty;

	[SerializeField]
	[TextArea(6, 18)]
	private string recentIssuesPreview = string.Empty;

	[SerializeField]
	[TextArea(12, 32)]
	private string expectedContractsPreview = string.Empty;

	private readonly List<string> recentEntries = new List<string>(64);

	private readonly List<string> recentIssues = new List<string>(24);

	private readonly Dictionary<string, SequenceState> sequenceStates = new Dictionary<string, SequenceState>(64);

	private readonly Dictionary<string, Queue<PendingBridgeExpectation>> pendingBridgeExpectations = new Dictionary<string, Queue<PendingBridgeExpectation>>(32);

	public string RecentEventsPreview => recentEventsPreview;

	public string RecentIssuesPreview => recentIssuesPreview;

	public string ExpectedContractsPreview => expectedContractsPreview;

	private void OnEnable()
	{
		RebuildExpectedContractsPreview();
	}

	private void OnValidate()
	{
		RebuildExpectedContractsPreview();
		bridgeExpectationTimeout = Mathf.Max(0.1f, bridgeExpectationTimeout);
	}

	private void Update()
	{
		FlushExpiredBridgeExpectations();
	}

	public void HandleWeaponPresentation(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		FlushExpiredBridgeExpectations();
		ValidateAndRecordSequence(BuildWeaponSequenceKey(presentationEvent), SummerRaceCombatPresentationRouter.ResolvePresentationContract(presentationEvent.DeliveryKind), presentationEvent.Phase, $"weapon slot={presentationEvent.SlotIndex} delivery={presentationEvent.DeliveryKind}");
		ConsumeBridgeExpectation(presentationEvent);
		if (logWeaponEvents)
		{
			AppendEntry(FormatWeaponEvent(presentationEvent));
		}
	}

	public void HandleWeaponOverloadPresentation(SummerRaceWeaponOverloadPresentationEvent presentationEvent)
	{
		FlushExpiredBridgeExpectations();
		if (logWeaponEvents)
		{
			AppendEntry(FormatWeaponOverloadEvent(presentationEvent));
		}
	}

	public void HandleEquipPresentation(SummerRaceEquipPresentationEvent presentationEvent)
	{
		FlushExpiredBridgeExpectations();
		ValidateAndRecordSequence(BuildEquipSequenceKey(presentationEvent), SummerRaceCombatPresentationRouter.ResolvePresentationContract(presentationEvent.DeliveryKind), presentationEvent.Phase, $"equip slot={presentationEvent.SlotIndex} delivery={presentationEvent.DeliveryKind}");
		if (logEquipEvents)
		{
			AppendEntry(FormatEquipEvent(presentationEvent));
		}
	}

	public void HandleProjectilePresentation(SummerRaceProjectilePresentationEvent presentationEvent)
	{
		FlushExpiredBridgeExpectations();
		ValidateAndRecordSequence(BuildProjectileSequenceKey(presentationEvent), SummerRaceCombatPresentationRouter.ResolveProjectilePresentationContract(presentationEvent.DeliveryKind), presentationEvent.Phase, $"projectile corr={presentationEvent.CorrelationId} slot={presentationEvent.SlotIndex} delivery={presentationEvent.DeliveryKind}");
		TrackBridgeExpectation(presentationEvent);
		if (logProjectileEvents)
		{
			AppendEntry(FormatProjectileEvent(presentationEvent));
		}
	}

	public float HandleDefeatPresentation(SummerRaceDefeatPresentationEvent presentationEvent)
	{
		AppendEntry(string.Format("t={0:F2} defeat effect={1} source={2} target={3}", Time.time, presentationEvent.EffectPath, (presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform.name : "<null>", (presentationEvent.TargetTransform != null) ? presentationEvent.TargetTransform.name : "<null>"));
		return 0f;
	}

	[ContextMenu("Clear Recorded Events")]
	public void ClearRecordedEvents()
	{
		recentEntries.Clear();
		recentEventsPreview = string.Empty;
		recentIssues.Clear();
		recentIssuesPreview = string.Empty;
		sequenceStates.Clear();
		pendingBridgeExpectations.Clear();
	}

	[ContextMenu("Rebuild Expected Contracts Preview")]
	public void RebuildExpectedContractsPreview()
	{
		StringBuilder stringBuilder = new StringBuilder(2560);
		AppendWeaponContracts(stringBuilder);
		stringBuilder.AppendLine();
		AppendEquipContracts(stringBuilder);
		stringBuilder.AppendLine();
		AppendProjectileContracts(stringBuilder);
		stringBuilder.AppendLine();
		AppendBridgeContracts(stringBuilder);
		expectedContractsPreview = stringBuilder.ToString().TrimEnd();
	}

	private void AppendEntry(string entry)
	{
		if (!string.IsNullOrEmpty(entry))
		{
			int num = Mathf.Max(1, maxEntries);
			if (recentEntries.Count >= num)
			{
				recentEntries.RemoveAt(0);
			}
			recentEntries.Add(entry);
			RebuildPreview();
			if (echoToConsole)
			{
				SummerRaceRuntimeLog.Log("[SummerRacePresentationDebugSink] " + entry, this);
			}
		}
	}

	private void AppendIssue(string issue)
	{
		if (!string.IsNullOrEmpty(issue))
		{
			if (recentIssues.Count >= 24)
			{
				recentIssues.RemoveAt(0);
			}
			recentIssues.Add(issue);
			RebuildIssuesPreview();
			if (echoToConsole)
			{
				SummerRaceRuntimeLog.Warning("[SummerRacePresentationDebugSink] " + issue, this);
			}
		}
	}

	private void RebuildPreview()
	{
		if (recentEntries.Count == 0)
		{
			recentEventsPreview = string.Empty;
			return;
		}
		StringBuilder stringBuilder = new StringBuilder(recentEntries.Count * 96);
		for (int i = 0; i < recentEntries.Count; i++)
		{
			if (i > 0)
			{
				stringBuilder.AppendLine();
			}
			stringBuilder.Append(recentEntries[i]);
		}
		recentEventsPreview = stringBuilder.ToString();
	}

	private void RebuildIssuesPreview()
	{
		if (recentIssues.Count == 0)
		{
			recentIssuesPreview = string.Empty;
			return;
		}
		StringBuilder stringBuilder = new StringBuilder(recentIssues.Count * 96);
		for (int i = 0; i < recentIssues.Count; i++)
		{
			if (i > 0)
			{
				stringBuilder.AppendLine();
			}
			stringBuilder.Append(recentIssues[i]);
		}
		recentIssuesPreview = stringBuilder.ToString();
	}

	private void FlushExpiredBridgeExpectations()
	{
		if (pendingBridgeExpectations.Count <= 0)
		{
			return;
		}
		float num = Mathf.Max(0.1f, bridgeExpectationTimeout);
		List<string> list = null;
		foreach (KeyValuePair<string, Queue<PendingBridgeExpectation>> pendingBridgeExpectation2 in pendingBridgeExpectations)
		{
			Queue<PendingBridgeExpectation> value = pendingBridgeExpectation2.Value;
			while (value.Count > 0 && Time.time - value.Peek().CreatedAt >= num)
			{
				PendingBridgeExpectation pendingBridgeExpectation = value.Dequeue();
				AppendIssue($"t={Time.time:F2} missing-bridge delivery={ExtractDeliveryFromBridgeKey(pendingBridgeExpectation2.Key)} corr={pendingBridgeExpectation.CorrelationId}: projectile {pendingBridgeExpectation.ProjectilePhase} expected weapon {pendingBridgeExpectation.ExpectedWeaponPhase} within {num:F2}s");
			}
			if (value.Count == 0)
			{
				if (list == null)
				{
					list = new List<string>();
				}
				list.Add(pendingBridgeExpectation2.Key);
			}
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				pendingBridgeExpectations.Remove(list[i]);
			}
		}
	}

	private static string FormatWeaponEvent(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		return string.Format("t={0:F2} type=weapon phase={1} delivery={2} kind={3} slot={4} src=({5:F2},{6:F2}) target=({7:F2},{8:F2}) count={9} reason={10}", Time.time, presentationEvent.Phase, presentationEvent.DeliveryKind, presentationEvent.WeaponKind, presentationEvent.SlotIndex, presentationEvent.SourcePoint.x, presentationEvent.SourcePoint.y, presentationEvent.TargetPoint.x, presentationEvent.TargetPoint.y, presentationEvent.TargetCount, string.IsNullOrEmpty(presentationEvent.RejectReason) ? "-" : presentationEvent.RejectReason);
	}

	private static string FormatEquipEvent(SummerRaceEquipPresentationEvent presentationEvent)
	{
		return string.Format("t={0:F2} type=equip phase={1} delivery={2} kind={3} slot={4} src=({5:F2},{6:F2}) target=({7:F2},{8:F2}) radius={9:F2} reach={10:F2} count={11} reason={12}", Time.time, presentationEvent.Phase, presentationEvent.DeliveryKind, presentationEvent.EquipKind, presentationEvent.SlotIndex, presentationEvent.SourcePoint.x, presentationEvent.SourcePoint.y, presentationEvent.TargetPoint.x, presentationEvent.TargetPoint.y, presentationEvent.Radius, presentationEvent.ReachDistance, presentationEvent.TargetCount, string.IsNullOrEmpty(presentationEvent.RejectReason) ? "-" : presentationEvent.RejectReason);
	}

	private static string FormatProjectileEvent(SummerRaceProjectilePresentationEvent presentationEvent)
	{
		Vector2 position = presentationEvent.Position;
		return $"t={Time.time:F2} type=projectile phase={presentationEvent.Phase} delivery={presentationEvent.DeliveryKind} kind={presentationEvent.WeaponKind} corr={presentationEvent.CorrelationId} slot={presentationEvent.SlotIndex} pos=({position.x:F2},{position.y:F2}) damage={presentationEvent.DamageDealt} effects={presentationEvent.AppliedEffects}";
	}

	private static string FormatWeaponOverloadEvent(SummerRaceWeaponOverloadPresentationEvent presentationEvent)
	{
		Vector2 position = presentationEvent.Position;
		return string.Format("t={0:F2} type=weapon_overload phase={1} slot={2} pos=({3:F2},{4:F2}) weapon={5}", Time.time, presentationEvent.Phase, presentationEvent.SlotIndex, position.x, position.y, (presentationEvent.WeaponDefinition != null) ? ((object)presentationEvent.WeaponDefinition.WeaponType) : "<null>");
	}

	private static void AppendWeaponContracts(StringBuilder builder)
	{
		builder.AppendLine("[expected weapon]");
		Array values = Enum.GetValues(typeof(WeaponKind));
		for (int i = 0; i < values.Length; i++)
		{
			WeaponKind weaponKind = (WeaponKind)values.GetValue(i);
			SummerRacePresentationPhaseContract contract = SummerRaceCombatPresentationRouter.ResolveWeaponPresentationContract(weaponKind);
			builder.Append(weaponKind).Append(" => ").AppendLine(SummerRaceCombatPresentationRouter.DescribeContract(contract));
		}
	}

	private static void AppendEquipContracts(StringBuilder builder)
	{
		builder.AppendLine("[expected equip]");
		Array values = Enum.GetValues(typeof(EquipKind));
		for (int i = 0; i < values.Length; i++)
		{
			EquipKind equipKind = (EquipKind)values.GetValue(i);
			SummerRacePresentationPhaseContract contract = SummerRaceCombatPresentationRouter.ResolveEquipPresentationContract(equipKind);
			builder.Append(equipKind).Append(" => ").AppendLine(SummerRaceCombatPresentationRouter.DescribeContract(contract));
		}
	}

	private static void AppendProjectileContracts(StringBuilder builder)
	{
		builder.AppendLine("[expected projectile]");
		Array values = Enum.GetValues(typeof(WeaponKind));
		for (int i = 0; i < values.Length; i++)
		{
			WeaponKind weaponKind = (WeaponKind)values.GetValue(i);
			SummerRacePresentationPhaseContract contract = SummerRaceCombatPresentationRouter.ResolveProjectilePresentationContract(weaponKind);
			builder.Append(weaponKind).Append(" => ").AppendLine(SummerRaceCombatPresentationRouter.DescribeContract(contract));
		}
	}

	private static void AppendBridgeContracts(StringBuilder builder)
	{
		builder.AppendLine("[expected bridge]");
		Array values = Enum.GetValues(typeof(WeaponKind));
		for (int i = 0; i < values.Length; i++)
		{
			WeaponKind weaponKind = (WeaponKind)values.GetValue(i);
			SummerRacePresentationDeliveryKind deliveryKind = SummerRaceCombatPresentationRouter.ResolveWeaponPresentationContract(weaponKind).DeliveryKind;
			builder.Append(weaponKind).Append(" => ").AppendLine(SummerRaceCombatPresentationRouter.DescribeProjectileBridgeContract(deliveryKind));
		}
	}

	private void TrackBridgeExpectation(SummerRaceProjectilePresentationEvent presentationEvent)
	{
		if (SummerRaceCombatPresentationRouter.TryResolveWeaponBridgePhaseFromProjectile(presentationEvent.DeliveryKind, presentationEvent.Phase, out var weaponPhase))
		{
			string key = BuildBridgeSequenceKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, presentationEvent.DeliveryKind);
			if (!pendingBridgeExpectations.TryGetValue(key, out var value))
			{
				value = new Queue<PendingBridgeExpectation>(4);
				pendingBridgeExpectations[key] = value;
			}
			value.Enqueue(new PendingBridgeExpectation
			{
				CorrelationId = presentationEvent.CorrelationId,
				ProjectilePhase = presentationEvent.Phase,
				ExpectedWeaponPhase = weaponPhase,
				CreatedAt = Time.time
			});
		}
	}

	private void ConsumeBridgeExpectation(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		if (!TryResolveProjectilePhaseForWeaponBridge(presentationEvent.DeliveryKind, presentationEvent.Phase, out var projectilePhase))
		{
			return;
		}
		string key = BuildBridgeSequenceKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, presentationEvent.DeliveryKind);
		if (!pendingBridgeExpectations.TryGetValue(key, out var value) || value.Count <= 0)
		{
			AppendIssue($"t={Time.time:F2} orphan-bridge-target delivery={presentationEvent.DeliveryKind}: weapon {presentationEvent.Phase} arrived without projectile {projectilePhase}");
			return;
		}
		PendingBridgeExpectation pendingBridgeExpectation = value.Peek();
		if (pendingBridgeExpectation.ExpectedWeaponPhase != presentationEvent.Phase)
		{
			AppendIssue($"t={Time.time:F2} bridge-mismatch delivery={presentationEvent.DeliveryKind} corr={pendingBridgeExpectation.CorrelationId}: weapon {presentationEvent.Phase} arrived while pending projectile {pendingBridgeExpectation.ProjectilePhase} expected weapon {pendingBridgeExpectation.ExpectedWeaponPhase}");
		}
		else
		{
			value.Dequeue();
			if (value.Count == 0)
			{
				pendingBridgeExpectations.Remove(key);
			}
		}
	}

	private void ValidateAndRecordSequence(string sequenceKey, SummerRacePresentationPhaseContract contract, SummerRacePresentationPhase phase, string contextLabel)
	{
		if (!string.IsNullOrEmpty(sequenceKey))
		{
			SequenceState sequenceState = (sequenceStates.TryGetValue(sequenceKey, out var value) ? value : default(SequenceState));
			if (phase == SummerRacePresentationPhase.Rejected || IsContractStartPhase(contract, phase))
			{
				sequenceStates[sequenceKey] = new SequenceState
				{
					HasPhase = true,
					LastPhase = phase
				};
			}
			else if (!sequenceState.HasPhase)
			{
				sequenceStates[sequenceKey] = new SequenceState
				{
					HasPhase = true,
					LastPhase = phase
				};
				AppendIssue($"t={Time.time:F2} out-of-order {contextLabel}: got {phase} before start; expected {DescribeCycleStart(contract)}");
			}
			else if (IsPhaseProgressionAllowed(contract, sequenceState.LastPhase, phase))
			{
				sequenceStates[sequenceKey] = new SequenceState
				{
					HasPhase = true,
					LastPhase = phase
				};
			}
			else
			{
				AppendIssue($"t={Time.time:F2} out-of-order {contextLabel}: got {phase} after {sequenceState.LastPhase}; expected {DescribeExpectedNext(contract, sequenceState.LastPhase)}");
				sequenceStates[sequenceKey] = new SequenceState
				{
					HasPhase = true,
					LastPhase = phase
				};
			}
		}
	}

	private static string BuildWeaponSequenceKey(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		int num = ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform.GetInstanceID() : 0);
		return $"weapon:{num}:{presentationEvent.SlotIndex}:{presentationEvent.DeliveryKind}";
	}

	private static string BuildEquipSequenceKey(SummerRaceEquipPresentationEvent presentationEvent)
	{
		int num = ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform.GetInstanceID() : 0);
		return $"equip:{num}:{presentationEvent.SlotIndex}:{presentationEvent.DeliveryKind}";
	}

	private static string BuildProjectileSequenceKey(SummerRaceProjectilePresentationEvent presentationEvent)
	{
		int num = ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform.GetInstanceID() : 0);
		return $"projectile:{num}:{presentationEvent.CorrelationId}:{presentationEvent.SlotIndex}:{presentationEvent.DeliveryKind}";
	}

	private static string BuildBridgeSequenceKey(Transform sourceTransform, int slotIndex, SummerRacePresentationDeliveryKind deliveryKind)
	{
		int num = ((sourceTransform != null) ? sourceTransform.GetInstanceID() : 0);
		return $"bridge:{num}:{slotIndex}:{deliveryKind}";
	}

	private static string ExtractDeliveryFromBridgeKey(string bridgeKey)
	{
		if (string.IsNullOrEmpty(bridgeKey))
		{
			return SummerRacePresentationDeliveryKind.None.ToString();
		}
		int num = bridgeKey.LastIndexOf(':');
		if (num < 0 || num + 1 >= bridgeKey.Length)
		{
			return bridgeKey;
		}
		return bridgeKey.Substring(num + 1);
	}

	private static bool TryResolveProjectilePhaseForWeaponBridge(SummerRacePresentationDeliveryKind deliveryKind, SummerRacePresentationPhase weaponPhase, out SummerRacePresentationPhase projectilePhase)
	{
		SummerRacePresentationPhaseContract summerRacePresentationPhaseContract = SummerRaceCombatPresentationRouter.ResolveProjectilePresentationContract(deliveryKind);
		for (int i = 0; i < summerRacePresentationPhaseContract.SuccessPhaseCount; i++)
		{
			SummerRacePresentationPhase successPhase = summerRacePresentationPhaseContract.GetSuccessPhase(i);
			if (SummerRaceCombatPresentationRouter.TryResolveWeaponBridgePhaseFromProjectile(deliveryKind, successPhase, out var weaponPhase2) && weaponPhase2 == weaponPhase)
			{
				projectilePhase = successPhase;
				return true;
			}
		}
		projectilePhase = SummerRacePresentationPhase.Rejected;
		return false;
	}

	private static bool IsContractStartPhase(SummerRacePresentationPhaseContract contract, SummerRacePresentationPhase phase)
	{
		if (contract.SuccessPhaseCount > 0)
		{
			return contract.GetSuccessPhase(0) == phase;
		}
		return false;
	}

	private static bool IsPhaseProgressionAllowed(SummerRacePresentationPhaseContract contract, SummerRacePresentationPhase previousPhase, SummerRacePresentationPhase currentPhase)
	{
		if (currentPhase == SummerRacePresentationPhase.Rejected)
		{
			return true;
		}
		if (previousPhase == SummerRacePresentationPhase.Rejected)
		{
			return IsContractStartPhase(contract, currentPhase);
		}
		if (previousPhase == currentPhase && IsRepeatablePhase(currentPhase))
		{
			return true;
		}
		int successPhaseIndex = GetSuccessPhaseIndex(contract, previousPhase);
		int successPhaseIndex2 = GetSuccessPhaseIndex(contract, currentPhase);
		if (successPhaseIndex < 0 || successPhaseIndex2 < 0)
		{
			return false;
		}
		if (successPhaseIndex2 == successPhaseIndex + 1)
		{
			return true;
		}
		if (successPhaseIndex2 == 0 && successPhaseIndex == contract.SuccessPhaseCount - 1)
		{
			return true;
		}
		return false;
	}

	private static int GetSuccessPhaseIndex(SummerRacePresentationPhaseContract contract, SummerRacePresentationPhase phase)
	{
		for (int i = 0; i < contract.SuccessPhaseCount; i++)
		{
			if (contract.GetSuccessPhase(i) == phase)
			{
				return i;
			}
		}
		return -1;
	}

	private static bool IsRepeatablePhase(SummerRacePresentationPhase phase)
	{
		if (phase != SummerRacePresentationPhase.Impact)
		{
			return phase == SummerRacePresentationPhase.Hit;
		}
		return true;
	}

	private static string DescribeCycleStart(SummerRacePresentationPhaseContract contract)
	{
		if (contract.SuccessPhaseCount <= 0)
		{
			return "no success phase";
		}
		if (!contract.CanReject)
		{
			return contract.GetSuccessPhase(0).ToString();
		}
		return $"Rejected or {contract.GetSuccessPhase(0)}";
	}

	private static string DescribeExpectedNext(SummerRacePresentationPhaseContract contract, SummerRacePresentationPhase previousPhase)
	{
		if (previousPhase == SummerRacePresentationPhase.Rejected)
		{
			if (contract.SuccessPhaseCount <= 0)
			{
				return "-";
			}
			return contract.GetSuccessPhase(0).ToString();
		}
		int successPhaseIndex = GetSuccessPhaseIndex(contract, previousPhase);
		if (successPhaseIndex < 0)
		{
			return DescribeCycleStart(contract);
		}
		if (IsRepeatablePhase(previousPhase))
		{
			if (successPhaseIndex + 1 < contract.SuccessPhaseCount)
			{
				return $"{previousPhase} or {contract.GetSuccessPhase(successPhaseIndex + 1)}";
			}
			return $"{previousPhase} or cycle restart";
		}
		if (successPhaseIndex + 1 < contract.SuccessPhaseCount)
		{
			return contract.GetSuccessPhase(successPhaseIndex + 1).ToString();
		}
		return "cycle restart";
	}
}
