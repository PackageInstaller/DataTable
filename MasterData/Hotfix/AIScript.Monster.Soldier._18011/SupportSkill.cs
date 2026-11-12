using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._18011;

public class SupportSkill : SkillAdvancedBase
{
	private const string comboTag = "ComboSupport";

	private const string eventName_GenerateAreaEffect = "Fire";

	private const string areaEffectKey = "AreaEffect_Soldier_18011_Support";

	private const string areaEffectKey_Potential3 = "AreaEffect_Soldier_18011_Support_P";

	private static readonly FP areaSpawnRadius = 3;

	private const int areaCount = 3;

	private const int areaCount_Potential3 = 5;

	private const int buffId_Potential2 = 250106201;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private static readonly int[] buffIds_Potential2ByPartnerLv = new int[3] { 1768641404, 1281322092, 1952999273 };

	private static readonly int[] onceDamageIds_extraAreaByPartnerLv;

	private int _potentialLv;

	private readonly List<SoldierActor> _battleActorBuffer = new List<SoldierActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_battleActorBuffer.Clear();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		if (_potentialLv >= 2)
		{
			AddBuffToBattleActors();
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("ComboSupport", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void AddBuffToBattleActors()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		int potential2BuffId = GetPotential2BuffId(soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.QiLiMoFa));
		if (potential2BuffId > 0)
		{
			soldierLevelController.GetBattleActors(_actor, _battleActorBuffer);
			for (int i = 0; i < _battleActorBuffer.Count; i++)
			{
				_battleActorBuffer.get_Item(i)?.buffComponent?.AddBuff(potential2BuffId, _actor);
			}
		}
	}

	private int GetPotential2BuffId(int partnerLv)
	{
		if (partnerLv < 1 || buffIds_Potential2ByPartnerLv.Length == 0)
		{
			return 250106201;
		}
		int num = partnerLv - 1;
		if (num >= buffIds_Potential2ByPartnerLv.Length)
		{
			num = buffIds_Potential2ByPartnerLv.Length - 1;
		}
		int num2 = buffIds_Potential2ByPartnerLv[num];
		if (num2 <= 0)
		{
			return 250106201;
		}
		return num2;
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "Fire"))
		{
			return;
		}
		TSVector2 center = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		int num = ((_potentialLv >= 3) ? 5 : 3);
		string fxAlias = ((_potentialLv >= 3) ? "AreaEffect_Soldier_18011_Support_P" : "AreaEffect_Soldier_18011_Support");
		for (int i = 0; i < num; i++)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, GetScatterPoint(center, i, num));
		}
		int partnerLv = GetPartnerLv();
		if (partnerLv < 1)
		{
			return;
		}
		int onceDamageId = GetExtraAreaOnceDamageId(partnerLv);
		for (int j = 0; j < num; j++)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, GetScatterPoint(center, j, num), default, (AreaEffectEntity entity) =>
			{
				entity?.AddAdditionalAttr(onceDamageId);
			});
		}
	}

	private int GetExtraAreaOnceDamageId(int partnerLv)
	{
		if (partnerLv < 1 || onceDamageIds_extraAreaByPartnerLv.Length == 0)
		{
			return 0;
		}
		int num = partnerLv - 1;
		if (num >= onceDamageIds_extraAreaByPartnerLv.Length)
		{
			num = onceDamageIds_extraAreaByPartnerLv.Length - 1;
		}
		return onceDamageIds_extraAreaByPartnerLv[num];
	}

	private TSVector2 GetScatterPoint(TSVector2 center, int index, int count)
	{
		if (count <= 1)
		{
			return center;
		}
		FP fP = (FP)360 / (FP)count;
		FP degrees = fP * index + TSRandom.value * fP;
		FP fP2 = areaSpawnRadius * (1 + TSRandom.value) / 2;
		return center + TSVector2.Rotate(new TSVector2(0, 1), degrees) * fP2;
	}

	private int GetPartnerLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.QiLiMoFa);
	}

	static SupportSkill()
	{
		//IL_002d: Field data (rva=0x4d8) could not be found in any section!
		//IL_002d: Field data (rva=0x4d8) could not be found in any section!
		int[] array = new int[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._03B1DF8029337FC87ACB8A15B1938682BA63C860335ECE2ED677AF9F7C119094));
		onceDamageIds_extraAreaByPartnerLv = array;
	}
}
