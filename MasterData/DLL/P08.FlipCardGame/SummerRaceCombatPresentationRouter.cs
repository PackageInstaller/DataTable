using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

public static class SummerRaceCombatPresentationRouter
{
	private static readonly List<ISummerRaceCombatPresentationSink> SinkBuffer = new List<ISummerRaceCombatPresentationSink>(4);

	public static WeaponKind ResolveWeaponKind(WeaponModuleDefinition weaponDefinition)
	{
		if (weaponDefinition == null)
		{
			return WeaponKind.MachineGun;
		}
		return SummerRaceConfigLoader.ToRuntimeWeaponKind(weaponDefinition.WeaponType);
	}

	public static EquipKind ResolveEquipKind(UtilityModuleDefinition equipDefinition)
	{
		if (equipDefinition == null)
		{
			return EquipKind.Thruster;
		}
		return SummerRaceConfigLoader.ToRuntimeEquipKind(equipDefinition.EquipType);
	}

	public static SummerRacePresentationDeliveryKind ResolveWeaponDeliveryKind(WeaponModuleDefinition weaponDefinition)
	{
		return ResolveWeaponDeliveryKindFromKind(ResolveWeaponKind(weaponDefinition));
	}

	public static SummerRacePresentationDeliveryKind ResolveEquipDeliveryKind(UtilityModuleDefinition equipDefinition)
	{
		return ResolveEquipDeliveryKindFromKind(ResolveEquipKind(equipDefinition));
	}

	public static SummerRacePresentationPhaseContract ResolveWeaponPresentationContract(WeaponModuleDefinition weaponDefinition)
	{
		return ResolveWeaponPresentationContract(ResolveWeaponKind(weaponDefinition));
	}

	public static SummerRacePresentationPhaseContract ResolveWeaponPresentationContract(WeaponKind weaponKind)
	{
		return ResolvePresentationContract(ResolveWeaponDeliveryKindFromKind(weaponKind));
	}

	public static SummerRacePresentationPhaseContract ResolveEquipPresentationContract(UtilityModuleDefinition equipDefinition)
	{
		return ResolveEquipPresentationContract(ResolveEquipKind(equipDefinition));
	}

	public static SummerRacePresentationPhaseContract ResolveEquipPresentationContract(EquipKind equipKind)
	{
		return ResolvePresentationContract(ResolveEquipDeliveryKindFromKind(equipKind));
	}

	public static SummerRacePresentationPhaseContract ResolveProjectilePresentationContract(WeaponModuleDefinition weaponDefinition)
	{
		return ResolveProjectilePresentationContract(ResolveWeaponKind(weaponDefinition));
	}

	public static SummerRacePresentationPhaseContract ResolveProjectilePresentationContract(WeaponKind weaponKind)
	{
		return ResolveProjectilePresentationContract(ResolveWeaponDeliveryKindFromKind(weaponKind));
	}

	public static SummerRacePresentationPhaseContract ResolveProjectilePresentationContract(SummerRacePresentationDeliveryKind deliveryKind)
	{
		switch (deliveryKind)
		{
		case SummerRacePresentationDeliveryKind.Bullet:
		case SummerRacePresentationDeliveryKind.Rocket:
		case SummerRacePresentationDeliveryKind.Beam:
			return new SummerRacePresentationPhaseContract(deliveryKind, canReject: false, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.Hit, SummerRacePresentationPhase.Recycled, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 3);
		case SummerRacePresentationDeliveryKind.Boomerang:
			return new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.Boomerang, canReject: false, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.ReturnStarted, SummerRacePresentationPhase.Hit, SummerRacePresentationPhase.Recycled, SummerRacePresentationPhase.Rejected, 4);
		default:
			return new SummerRacePresentationPhaseContract(deliveryKind, canReject: false, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 0);
		}
	}

	public static SummerRacePresentationPhaseContract ResolvePresentationContract(SummerRacePresentationDeliveryKind deliveryKind)
	{
		return deliveryKind switch
		{
			SummerRacePresentationDeliveryKind.Bullet => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.Bullet, canReject: true, SummerRacePresentationPhase.Fired, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 2), 
			SummerRacePresentationDeliveryKind.Rocket => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.Rocket, canReject: true, SummerRacePresentationPhase.Fired, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.Recycled, SummerRacePresentationPhase.Rejected, 4), 
			SummerRacePresentationDeliveryKind.Beam => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.Beam, canReject: true, SummerRacePresentationPhase.Fired, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.ActiveExpired, SummerRacePresentationPhase.Rejected, 4), 
			SummerRacePresentationDeliveryKind.Boomerang => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.Boomerang, canReject: true, SummerRacePresentationPhase.Fired, SummerRacePresentationPhase.ReturnStarted, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 3), 
			SummerRacePresentationDeliveryKind.SpinMelee => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.SpinMelee, canReject: true, SummerRacePresentationPhase.Fired, SummerRacePresentationPhase.Activated, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.ActiveExpired, SummerRacePresentationPhase.Rejected, 4), 
			SummerRacePresentationDeliveryKind.Dash => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.Dash, canReject: true, SummerRacePresentationPhase.Activated, SummerRacePresentationPhase.ActiveExpired, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 2), 
			SummerRacePresentationDeliveryKind.ShieldAura => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.ShieldAura, canReject: true, SummerRacePresentationPhase.Activated, SummerRacePresentationPhase.ActiveExpired, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 2), 
			SummerRacePresentationDeliveryKind.PunchLine => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.PunchLine, canReject: true, SummerRacePresentationPhase.Activated, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.Recycled, SummerRacePresentationPhase.Rejected, 4), 
			SummerRacePresentationDeliveryKind.AreaPulse => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.AreaPulse, canReject: true, SummerRacePresentationPhase.Activated, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.Recycled, SummerRacePresentationPhase.Rejected, 4), 
			SummerRacePresentationDeliveryKind.HookLine => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.HookLine, canReject: true, SummerRacePresentationPhase.Activated, SummerRacePresentationPhase.Spawned, SummerRacePresentationPhase.Impact, SummerRacePresentationPhase.Recycled, SummerRacePresentationPhase.Rejected, 4), 
			_ => new SummerRacePresentationPhaseContract(SummerRacePresentationDeliveryKind.None, canReject: true, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, SummerRacePresentationPhase.Rejected, 0), 
		};
	}

	public static bool TryResolveWeaponBridgePhaseFromProjectile(SummerRacePresentationDeliveryKind deliveryKind, SummerRacePresentationPhase projectilePhase, out SummerRacePresentationPhase weaponPhase)
	{
		if (!ResolveProjectilePresentationContract(deliveryKind).SupportsPhase(projectilePhase))
		{
			weaponPhase = SummerRacePresentationPhase.Rejected;
			return false;
		}
		SummerRacePresentationPhaseContract summerRacePresentationPhaseContract = ResolvePresentationContract(deliveryKind);
		switch (projectilePhase)
		{
		case SummerRacePresentationPhase.ReturnStarted:
			if (deliveryKind == SummerRacePresentationDeliveryKind.Boomerang && summerRacePresentationPhaseContract.SupportsPhase(SummerRacePresentationPhase.ReturnStarted))
			{
				weaponPhase = SummerRacePresentationPhase.ReturnStarted;
				return true;
			}
			break;
		case SummerRacePresentationPhase.Hit:
			if (summerRacePresentationPhaseContract.SupportsPhase(SummerRacePresentationPhase.Impact))
			{
				weaponPhase = SummerRacePresentationPhase.Impact;
				return true;
			}
			break;
		}
		weaponPhase = SummerRacePresentationPhase.Rejected;
		return false;
	}

	public static bool TryResolveTransientPhasePolicy(SummerRacePresentationDeliveryKind deliveryKind, out SummerRaceTransientPhasePolicy policy)
	{
		SummerRacePresentationPhaseContract summerRacePresentationPhaseContract = ResolvePresentationContract(deliveryKind);
		if (!summerRacePresentationPhaseContract.SupportsPhase(SummerRacePresentationPhase.Spawned))
		{
			policy = default(SummerRaceTransientPhasePolicy);
			return false;
		}
		SummerRacePresentationPhase summerRacePresentationPhase = (summerRacePresentationPhaseContract.SupportsPhase(SummerRacePresentationPhase.ActiveExpired) ? SummerRacePresentationPhase.ActiveExpired : SummerRacePresentationPhase.Recycled);
		if (!summerRacePresentationPhaseContract.SupportsPhase(summerRacePresentationPhase))
		{
			policy = default(SummerRaceTransientPhasePolicy);
			return false;
		}
		policy = new SummerRaceTransientPhasePolicy(hasStartPhase: true, summerRacePresentationPhase);
		return true;
	}

	public static bool ShouldEmitTransientStartPhase(SummerRacePresentationDeliveryKind deliveryKind)
	{
		if (TryResolveTransientPhasePolicy(deliveryKind, out var policy))
		{
			return policy.HasStartPhase;
		}
		return false;
	}

	public static bool TryResolveTransientEndPhase(SummerRacePresentationDeliveryKind deliveryKind, out SummerRacePresentationPhase phase)
	{
		if (TryResolveTransientPhasePolicy(deliveryKind, out var policy))
		{
			phase = policy.EndPhase;
			return true;
		}
		phase = SummerRacePresentationPhase.Rejected;
		return false;
	}

	private static SummerRacePresentationDeliveryKind ResolveWeaponDeliveryKindFromKind(WeaponKind weaponKind)
	{
		switch (weaponKind)
		{
		case WeaponKind.RocketLauncher:
			return SummerRacePresentationDeliveryKind.Rocket;
		case WeaponKind.Boomerang:
			return SummerRacePresentationDeliveryKind.Boomerang;
		case WeaponKind.ScatterShell:
			return SummerRacePresentationDeliveryKind.Bullet;
		case WeaponKind.LaserCannon:
			return SummerRacePresentationDeliveryKind.Beam;
		case WeaponKind.Drill:
		case WeaponKind.RotatingSaw:
		case WeaponKind.Shovel:
			return SummerRacePresentationDeliveryKind.SpinMelee;
		default:
			return SummerRacePresentationDeliveryKind.Bullet;
		}
	}

	private static SummerRacePresentationDeliveryKind ResolveEquipDeliveryKindFromKind(EquipKind equipKind)
	{
		return equipKind switch
		{
			EquipKind.Thruster => SummerRacePresentationDeliveryKind.Dash, 
			EquipKind.BoxingGlove => SummerRacePresentationDeliveryKind.PunchLine, 
			EquipKind.ElectricNet => SummerRacePresentationDeliveryKind.AreaPulse, 
			EquipKind.Hook => SummerRacePresentationDeliveryKind.HookLine, 
			EquipKind.ShieldGenerator => SummerRacePresentationDeliveryKind.ShieldAura, 
			_ => SummerRacePresentationDeliveryKind.None, 
		};
	}

	public static void PublishWeapon(Transform sourceTransform, SummerRaceWeaponPresentationEvent presentationEvent)
	{
		if (!ResolvePresentationContract(presentationEvent.DeliveryKind).SupportsPhase(presentationEvent.Phase) || !ResolveSinks(sourceTransform, SinkBuffer))
		{
			return;
		}
		try
		{
			for (int i = 0; i < SinkBuffer.Count; i++)
			{
				ISummerRaceCombatPresentationSink summerRaceCombatPresentationSink = SinkBuffer[i];
				if (summerRaceCombatPresentationSink != null)
				{
					try
					{
						summerRaceCombatPresentationSink.HandleWeaponPresentation(presentationEvent);
					}
					catch (Exception ex)
					{
						SummerRaceRuntimeLog.Error("[SummerRace][Presentation] weapon sink dispatch failed. sink=" + summerRaceCombatPresentationSink.GetType().Name + " source=" + ((sourceTransform != null) ? sourceTransform.name : "<null>") + " delivery=" + presentationEvent.DeliveryKind.ToString() + " phase=" + presentationEvent.Phase.ToString() + "\n" + ex);
					}
				}
			}
		}
		finally
		{
			SinkBuffer.Clear();
		}
	}

	public static void PublishWeaponOverload(Transform sourceTransform, SummerRaceWeaponOverloadPresentationEvent presentationEvent)
	{
		if ((presentationEvent.Phase != SummerRacePresentationPhase.Activated && presentationEvent.Phase != SummerRacePresentationPhase.ActiveExpired) || !ResolveSinks(sourceTransform, SinkBuffer))
		{
			return;
		}
		try
		{
			for (int i = 0; i < SinkBuffer.Count; i++)
			{
				ISummerRaceCombatPresentationSink summerRaceCombatPresentationSink = SinkBuffer[i];
				if (summerRaceCombatPresentationSink != null)
				{
					try
					{
						summerRaceCombatPresentationSink.HandleWeaponOverloadPresentation(presentationEvent);
					}
					catch (Exception ex)
					{
						string[] obj = new string[10]
						{
							"[SummerRace][Presentation] weapon overload sink dispatch failed. sink=",
							summerRaceCombatPresentationSink.GetType().Name,
							" source=",
							(sourceTransform != null) ? sourceTransform.name : "<null>",
							" slot=",
							null,
							null,
							null,
							null,
							null
						};
						int slotIndex = presentationEvent.SlotIndex;
						obj[5] = slotIndex.ToString();
						obj[6] = " phase=";
						obj[7] = presentationEvent.Phase.ToString();
						obj[8] = "\n";
						obj[9] = ex?.ToString();
						SummerRaceRuntimeLog.Error(string.Concat(obj));
					}
				}
			}
		}
		finally
		{
			SinkBuffer.Clear();
		}
	}

	public static void PublishEquip(Transform sourceTransform, SummerRaceEquipPresentationEvent presentationEvent)
	{
		if (!ResolvePresentationContract(presentationEvent.DeliveryKind).SupportsPhase(presentationEvent.Phase) || !ResolveSinks(sourceTransform, SinkBuffer))
		{
			return;
		}
		try
		{
			for (int i = 0; i < SinkBuffer.Count; i++)
			{
				ISummerRaceCombatPresentationSink summerRaceCombatPresentationSink = SinkBuffer[i];
				if (summerRaceCombatPresentationSink != null)
				{
					try
					{
						summerRaceCombatPresentationSink.HandleEquipPresentation(presentationEvent);
					}
					catch (Exception ex)
					{
						SummerRaceRuntimeLog.Error("[SummerRace][Presentation] equip sink dispatch failed. sink=" + summerRaceCombatPresentationSink.GetType().Name + " source=" + ((sourceTransform != null) ? sourceTransform.name : "<null>") + " delivery=" + presentationEvent.DeliveryKind.ToString() + " phase=" + presentationEvent.Phase.ToString() + "\n" + ex);
					}
				}
			}
		}
		finally
		{
			SinkBuffer.Clear();
		}
	}

	public static void PublishProjectile(Transform sourceTransform, SummerRaceProjectilePresentationEvent presentationEvent)
	{
		if (!ResolveProjectilePresentationContract(presentationEvent.DeliveryKind).SupportsPhase(presentationEvent.Phase) || !ResolveSinks(sourceTransform, SinkBuffer))
		{
			return;
		}
		try
		{
			for (int i = 0; i < SinkBuffer.Count; i++)
			{
				ISummerRaceCombatPresentationSink summerRaceCombatPresentationSink = SinkBuffer[i];
				if (summerRaceCombatPresentationSink != null)
				{
					try
					{
						summerRaceCombatPresentationSink.HandleProjectilePresentation(presentationEvent);
					}
					catch (Exception ex)
					{
						SummerRaceRuntimeLog.Error("[SummerRace][Presentation] projectile sink dispatch failed. sink=" + summerRaceCombatPresentationSink.GetType().Name + " source=" + ((sourceTransform != null) ? sourceTransform.name : "<null>") + " delivery=" + presentationEvent.DeliveryKind.ToString() + " phase=" + presentationEvent.Phase.ToString() + "\n" + ex);
					}
				}
			}
		}
		finally
		{
			SinkBuffer.Clear();
		}
	}

	public static float PublishDefeat(Transform sourceTransform, SummerRaceDefeatPresentationEvent presentationEvent)
	{
		if (!ResolveSinks(sourceTransform, SinkBuffer))
		{
			return 0f;
		}
		float num = 0f;
		try
		{
			for (int i = 0; i < SinkBuffer.Count; i++)
			{
				ISummerRaceCombatPresentationSink summerRaceCombatPresentationSink = SinkBuffer[i];
				if (summerRaceCombatPresentationSink != null)
				{
					try
					{
						num = Mathf.Max(num, summerRaceCombatPresentationSink.HandleDefeatPresentation(presentationEvent));
					}
					catch (Exception ex)
					{
						SummerRaceRuntimeLog.Error("[SummerRace][Presentation] defeat sink dispatch failed. sink=" + summerRaceCombatPresentationSink.GetType().Name + " source=" + ((sourceTransform != null) ? sourceTransform.name : "<null>") + " effect=" + presentationEvent.EffectPath + "\n" + ex);
					}
				}
			}
		}
		finally
		{
			SinkBuffer.Clear();
		}
		return Mathf.Max(0f, num);
	}

	public static string DescribeContract(SummerRacePresentationPhaseContract contract)
	{
		StringBuilder stringBuilder = new StringBuilder(96);
		stringBuilder.Append("delivery=").Append(contract.DeliveryKind);
		stringBuilder.Append(" reject=").Append(contract.CanReject ? "Y" : "N");
		stringBuilder.Append(" success=");
		if (contract.SuccessPhaseCount <= 0)
		{
			stringBuilder.Append("-");
			return stringBuilder.ToString();
		}
		for (int i = 0; i < contract.SuccessPhaseCount; i++)
		{
			if (i > 0)
			{
				stringBuilder.Append(" -> ");
			}
			stringBuilder.Append(contract.GetSuccessPhase(i));
		}
		return stringBuilder.ToString();
	}

	public static string DescribeProjectileBridgeContract(SummerRacePresentationDeliveryKind deliveryKind)
	{
		SummerRacePresentationPhaseContract summerRacePresentationPhaseContract = ResolveProjectilePresentationContract(deliveryKind);
		StringBuilder stringBuilder = new StringBuilder(96);
		stringBuilder.Append("delivery=").Append(deliveryKind);
		stringBuilder.Append(" bridge=");
		bool flag = false;
		for (int i = 0; i < summerRacePresentationPhaseContract.SuccessPhaseCount; i++)
		{
			SummerRacePresentationPhase successPhase = summerRacePresentationPhaseContract.GetSuccessPhase(i);
			if (TryResolveWeaponBridgePhaseFromProjectile(deliveryKind, successPhase, out var weaponPhase))
			{
				if (flag)
				{
					stringBuilder.Append(", ");
				}
				stringBuilder.Append(successPhase).Append(" -> ").Append(weaponPhase);
				flag = true;
			}
		}
		if (!flag)
		{
			stringBuilder.Append("-");
		}
		return stringBuilder.ToString();
	}

	private static bool ResolveSinks(Transform sourceTransform, List<ISummerRaceCombatPresentationSink> sinks)
	{
		sinks.Clear();
		if (sourceTransform == null)
		{
			return false;
		}
		MonoBehaviour[] componentsInParent = sourceTransform.GetComponentsInParent<MonoBehaviour>(includeInactive: true);
		for (int i = 0; i < componentsInParent.Length; i++)
		{
			if (componentsInParent[i] is ISummerRaceCombatPresentationSink item)
			{
				sinks.Add(item);
			}
		}
		return sinks.Count > 0;
	}
}
