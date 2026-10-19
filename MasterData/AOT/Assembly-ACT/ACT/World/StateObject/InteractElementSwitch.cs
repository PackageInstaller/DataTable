using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractElementSwitch : StateObjectBase
{
	public BoxCollider attackField;

	public Animator switchAnimator;

	public BoxCollider finalBoxTrigger;

	private ElementSwitchData m_Data;

	private Entity m_AttackEntity;

	private IDisposable m_SyncAttackablePositionDisposable;

	private CancellationTokenSource m_TokenSource;

	private const string CANTBEATTACK = "damageableCantbeAttack";

	private bool m_init;

	private float m_Timer;

	private const int DEFAULTSTATE = 0;

	private const int COUNTDOWNSTATE = 1;

	private const int FINALSTATE = -1;

	private MaterialPropertyBlock m_Block;

	private static readonly int State = Animator.StringToHash("state");

	private AssetLoadHandle m_linkHandle;

	private MeshRenderer[] m_Renders;

	private Vector4 m_UvOffset = new Vector4(1f, 1f, 0f, 0f);

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is ElementSwitchData data))
		{
			return;
		}
		m_Data = data;
		m_TokenSource = new CancellationTokenSource();
		m_Block = new MaterialPropertyBlock();
		finalBoxTrigger.gameObject.SetActive(m_Data.toFinalState);
		if (m_Data.toFinalState && finalBoxTrigger != null)
		{
			m_Data.finalBoxTrigger.CopyTo(finalBoxTrigger, finalBoxTrigger.transform);
		}
		if (m_Data.linkAddressAssetID != null && m_Data.linkAddressAssetID.RuntimeKeyIsValid())
		{
			m_linkHandle = AssetStationManager.BattleStation.Instantiate(m_Data.linkAddressAssetID, transform);
			GameObject gameObject = m_linkHandle.AsGameObject();
			gameObject.transform.position = m_Data.linkPos.value;
			gameObject.transform.rotation = m_Data.linkPos.rotate;
			MeshRenderer[] componentsInChildren = gameObject.GetComponentsInChildren<MeshRenderer>(includeInactive: true);
			List<MeshRenderer> list = new List<MeshRenderer>();
			MeshRenderer[] array = componentsInChildren;
			foreach (MeshRenderer meshRenderer in array)
			{
				if (meshRenderer.gameObject.CompareTag("ElectricPipe"))
				{
					list.Add(meshRenderer);
				}
			}
			m_Renders = list.ToArray();
		}
		CoSpawnAttackEntity().Forget();
		base.InitStateObject(stateId);
	}

	private async UniTaskVoid CoSpawnAttackEntity()
	{
		m_AttackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = m_AttackEntity;
		MonoECS.instance.SpawnAttackInteractObject(eb, 2, m_Data.trapType, m_Data.defenceTowerType, m_Data.initPos, Alliance.Netural, (attackField != null) ? attackField.size : Vector3.one, m_Data.initRotate);
		if (m_TokenSource.IsCancellationRequested)
		{
			return;
		}
		eb.GetCompStateObject().StateWorldAssetData = m_Data;
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, new Action<Entity>(OnHited));
		compAbility.AddAbility(eb, "damageableCantbeAttack", AbilitySource.Ability, default, 1);
		m_SyncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (m_AttackEntity.IsValid)
			{
				eb.GetRootTransform().position = transform.position;
			}
		});
		m_init = true;
	}

	private void OnHited(Entity attacker)
	{
		if (attacker.IsCharacter() && currentStateId == 0 && m_Data.elementType.HasFlag(attacker.GetCompAbility().GetElementBit()))
		{
			NetEnterState(1).Forget();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		SetLinkObjsState(stateId).Forget();
		if (switchAnimator != null)
		{
			switchAnimator.SetInteger(State, stateId);
		}
		if (stateId == 1)
		{
			m_Timer = m_Data.cdTime;
		}
		if (stateId == -1)
		{
			m_Timer = 0f;
		}
	}

	private int GetLinkObjStateFromSwitchState(LinkObjComp linkObjObj, int switchState)
	{
		if (linkObjObj.stateMappings == null || linkObjObj.stateMappings.Count == 0)
		{
			return 0;
		}
		int num = ((switchState == -1) ? 2 : switchState);
		if (num >= 0 && num < linkObjObj.stateMappings.Count)
		{
			return linkObjObj.stateMappings[num].targetState;
		}
		return 0;
	}

	private async UniTask SetLinkObjsState(int switchState)
	{
		int count = m_Data.linkObjComps.Length;
		StateChangeInfo[] infos = new StateChangeInfo[count];
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		for (int i = 0; i < count; i++)
		{
			LinkObjComp linkObjComp = m_Data.linkObjComps[i];
			StateWorldUid uid = linkObjComp.stateWorldUid;
			if (!StateWorldAsset.TryGetWorldAssetBySwid(uid, out var _))
			{
				int num;
				do
				{
					num = uid;
				}
				while (num != await ruleManager.parentSwid.WaitAsync());
				InitLinkObjectState(infos, i, uid, GetLinkObjStateFromSwitchState(linkObjComp, switchState));
			}
			else
			{
				InitLinkObjectState(infos, i, uid, GetLinkObjStateFromSwitchState(linkObjComp, switchState));
			}
		}
		MonoECS.instance.ruleManager.SharedChangeStates(infos);
	}

	private void InitLinkObjectState(StateChangeInfo[] infos, int i, int uid, int stateID)
	{
		infos[i] = new StateChangeInfo
		{
			uid = uid,
			stateId = stateID
		};
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!m_AttackEntity.IsValid)
		{
			return;
		}
		if (m_AttackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(m_AttackEntity);
			return;
		}
		await UniTask.WaitUntil(() => m_AttackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(m_AttackEntity);
	}

	public override void ReleaseStateObject()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		m_SyncAttackablePositionDisposable?.Dispose();
		ReleaseAttackEntity().Forget();
		if (m_Block != null)
		{
			m_Block.Clear();
		}
		if (AssetLoadHandleExtensions.IsValid(m_linkHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_linkHandle);
		}
		base.ReleaseStateObject();
	}

	public void OnDestroy()
	{
		if (m_Block != null)
		{
			m_Block.Clear();
		}
		m_SyncAttackablePositionDisposable?.Dispose();
	}

	private void FixedUpdate()
	{
		if (!m_init)
		{
			return;
		}
		float z = 0.25f - Mathf.Clamp01(m_Timer / m_Data.cdTime) * 0.5f;
		m_UvOffset.z = z;
		m_Block.SetVector(BattleConsts.SHADER_EFFECT_MASKUVOFFSET, m_UvOffset);
		MeshRenderer[] renders = m_Renders;
		foreach (MeshRenderer meshRenderer in renders)
		{
			if (meshRenderer != null)
			{
				meshRenderer.SetPropertyBlock(m_Block);
			}
		}
		if (m_Timer > 0f && currentStateId == 1)
		{
			m_Timer -= m_AttackEntity.GetCompTime().fixedDeltaTime;
			if (m_Timer < 0f)
			{
				NetEnterState(0).Forget();
			}
		}
	}

	public void ChangeToFinalState()
	{
		if (currentStateId != -1)
		{
			NetEnterState(-1).Forget();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == -1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
