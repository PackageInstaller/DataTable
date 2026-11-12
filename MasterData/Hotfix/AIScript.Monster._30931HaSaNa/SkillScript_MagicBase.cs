using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_MagicBase : SkillSimpleBase
{
	private readonly List<int> teammateIndexes_Device = new List<int> { 1, 2, 3, 4 };

	private readonly string comboTag_Stage1 = "Burrow_Down";

	private readonly string eventName_Hide = "Hide";

	private readonly string linkFx = "fx_30931JiGuanZhuangZhi_loop_charge_link";

	private readonly FP delayTime = 0.5;

	private readonly string comboTag_Stage2 = "Burrow_Up";

	protected readonly string LeftDodge_Combo = "LeftDodge";

	protected readonly string RightDodge_Combo = "RightDodge";

	protected readonly string LeftDodge_Combo_Fast = "LeftDodge_Fast";

	protected readonly string RightDodge_Combo_Fast = "RightDodge_Fast";

	private readonly List<MonsterAdventureActor> _activeDevices = new List<MonsterAdventureActor>(4);

	private readonly List<MonsterAdventureActor> _deactiveDevices = new List<MonsterAdventureActor>(4);

	protected int _chargeCount;

	private string Dodge_Combo;

	private bool NeedAnotherDodge;

	private bool IsAnotherDodge;

	private DeterministicShape ChooseShape;

	private LogicEntity Target;

	private TSVector2 DodgePosition;

	private TSVector2 DodgePosition_Tmp;

	private TSVector2 TargetPosition;

	private long FlashFX;

	private List<PlayFX> linkFxList;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_chargeCount = 0;
		_activeDevices.Clear();
		_deactiveDevices.Clear();
		NeedAnotherDodge = false;
		IsAnotherDodge = false;
		linkFxList = new List<PlayFX>();
	}

	private TSVector2 GetTeleportPosition()
	{
		if (GetLogicTagToggleValue(_actor, "IsMainline"))
		{
			return TSVector2.zero;
		}
		if (_activeDevices.Count >= 3)
		{
			return TSVector2.zero;
		}
		if (_activeDevices.Count == 2)
		{
			TSVector2 entityPosition = GetEntityPosition(_activeDevices.get_Item(0));
			TSVector2 tSVector = GetEntityPosition(_activeDevices.get_Item(1)) - entityPosition;
			return entityPosition + tSVector * 0.5;
		}
		if (_activeDevices.Count == 1)
		{
			TSVector2 entityPosition2 = GetEntityPosition(_activeDevices.get_Item(0));
			FP radius = _activeDevices.get_Item(0).GetRadius() + _actor.GetRadius() + 3;
			FP innerRadius = _activeDevices.get_Item(0).GetRadius() + 2;
			FP angle = 30;
			FP angle2 = (TSVector2.zero - GetEntityPosition(_activeDevices.get_Item(0))).GetAngle();
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, entityPosition2, default, default, radius, innerRadius, angle, angle2);
			return GetShapeRandomPoint(shapeData, _actor);
		}
		if (_deactiveDevices.Count >= 2)
		{
			_deactiveDevices.Sort((MonsterAdventureActor x, MonsterAdventureActor y) => _actor.DistanceWithRadius(x).CompareTo(_actor.DistanceWithRadius(y)));
			TSVector2 entityPosition3 = GetEntityPosition(_deactiveDevices.get_Item(0));
			TSVector2 tSVector2 = GetEntityPosition(_deactiveDevices.get_Item(1)) - entityPosition3;
			return entityPosition3 + tSVector2 * 0.5;
		}
		return TSVector2.zero;
	}

	protected override IEnumerator DoMainLogic()
	{
		UpdateDevice();
		yield return StartCor(ChooseDodgePoint(IsAnotherDodge: false));
		yield return StartCor(Dodge());
		if (NeedAnotherDodge)
		{
			IsAnotherDodge = true;
			yield return StartCor(ChooseDodgePoint(IsAnotherDodge: true));
			yield return StartCor(Dodge());
		}
		UpdateDevice();
		foreach (MonsterAdventureActor activeDevice in _activeDevices)
		{
			SetLogicTagToggleValue(activeDevice, "Locked", value: true);
		}
		_chargeCount = _activeDevices.Count;
		if (GetLogicTagFpValue(_actor, "Difficulty") == 1)
		{
			_chargeCount = 0;
		}
		foreach (MonsterAdventureActor activeDevice2 in _activeDevices)
		{
			linkFxList.Add(PlayLinkFX(linkFx, useCustomSource: true, activeDevice2.slotConfig.bodySlot.gameObject, TSVector.zero, 0, _actor.slotConfig.bodySlot.gameObject, TSVector.zero, 0));
		}
		StopWaitLookAt();
		yield return StartCor(SkillLogic());
	}

	private void UpdateDevice()
	{
		_activeDevices.Clear();
		_deactiveDevices.Clear();
		foreach (int item in teammateIndexes_Device)
		{
			int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, item);
			List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
			if (list == null || list.Count <= 0)
			{
				continue;
			}
			foreach (LogicEntity item2 in list)
			{
				if (item2 is MonsterAdventureActor monsterAdventureActor)
				{
					if (GetLogicTagToggleValue(monsterAdventureActor, "IsActive"))
					{
						_activeDevices.Add(monsterAdventureActor);
					}
					else
					{
						_deactiveDevices.Add(monsterAdventureActor);
					}
				}
			}
		}
	}

	protected virtual IEnumerator SkillLogic()
	{
		yield return null;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (string.Equals(eventName, eventName_Hide))
		{
			SetUnparalleledEnable();
			SetHideModelEnable();
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		foreach (PlayFX linkFx in linkFxList)
		{
			linkFx.Stop();
		}
		foreach (MonsterAdventureActor activeDevice in _activeDevices)
		{
			SetLogicTagToggleValue(activeDevice, "Locked", value: false);
		}
	}

	private IEnumerator Dodge()
	{
		if (Distance(DodgePosition, GetPosition()) <= 4 && IsAnotherDodge)
		{
			yield break;
		}
		if (AngleBetween2TSVector(GetPosition() - TargetPosition, GetPosition() - DodgePosition, signed: true) >= 0)
		{
			if (IsAnotherDodge)
			{
				Dodge_Combo = LeftDodge_Combo_Fast;
			}
			else
			{
				Dodge_Combo = LeftDodge_Combo;
			}
		}
		else if (IsAnotherDodge)
		{
			Dodge_Combo = RightDodge_Combo_Fast;
		}
		else
		{
			Dodge_Combo = RightDodge_Combo;
		}
		BeginAttack(2, Dodge_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(TargetPosition, 99, 9999);
		yield return WaitCustomEvent("Dodge");
		BeginDash(9, DodgePosition - GetPosition(), 40, Distance(DodgePosition, GetPosition()), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopEffect(FlashFX);
		StopWaitLookAt();
	}

	private IEnumerator ChooseDodgePoint(bool IsAnotherDodge)
	{
		DodgePosition = GetTeleportPosition();
		int num = 90;
		if (!IsAnotherDodge && Distance(DodgePosition, GetPosition()) > 7)
		{
			DodgePosition_Tmp = DodgePosition;
			DodgePosition = TransLocalPosToWorldPos((DodgePosition_Tmp + GetPosition()) / 2, RotateTo(DodgePosition_Tmp - GetPosition(), -num), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) / 3));
			NeedAnotherDodge = true;
		}
		yield break;
	}
}
