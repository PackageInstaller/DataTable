using System;
using System.Collections.Generic;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_103 : SoldierPartnerBase
{
	private readonly struct LevelCfg(int energyAmount, int dmgBuffId)
	{
		public readonly int energyAmount = energyAmount;

		public readonly int dmgBuffId = dmgBuffId;
	}

	private const HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.HuaLingLvTuan;

	private readonly LevelCfg[] _levelCfg = new LevelCfg[2]
	{
		new LevelCfg(6, 260110311),
		new LevelCfg(12, 260110312)
	};

	private static readonly int[] StarMultiplier = new int[5] { 1935879730, 16777216, 1073741824, 1936933212, 1551070309 };

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _targetBuffer = new List<SoldierActor>();

	private readonly List<SoldierActor> _supportBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.HuaLingLvTuan);
		}
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_targetBuffer.Clear();
		_supportBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (!actor.isSupport || partnerLv < 1 || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		int num = partnerLv - 1;
		if (num < 0 || num >= _levelCfg.Length)
		{
			return;
		}
		LevelCfg levelCfg = _levelCfg[num];
		if (_levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		int num2 = CalcBacklineMultiplier(mainControlActor);
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (soldierActor == null || soldierActor.isDead || !soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.HuaLingLvTuan))
			{
				continue;
			}
			if (levelCfg.energyAmount > 0)
			{
				soldierActor.SetEnergy(Math.Min(soldierActor.maxEnergy, soldierActor.energy + levelCfg.energyAmount));
			}
			if (levelCfg.dmgBuffId > 0)
			{
				if (soldierActor.isSupport)
				{
					soldierActor.buffComponent.AddBuffNum(levelCfg.dmgBuffId, 1, soldierActor);
				}
				else
				{
					soldierActor.buffComponent.AddBuffNum(levelCfg.dmgBuffId, num2, soldierActor);
				}
			}
		}
	}

	private int CalcBacklineMultiplier(AdventureActor anchor)
	{
		List<SoldierActor> supportActors = _levelCtrl.GetSupportActors(anchor, _supportBuffer);
		int num = 0;
		for (int i = 0; i < supportActors.Count; i++)
		{
			SoldierActor soldierActor = supportActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.HuaLingLvTuan))
			{
				int potentialLv = soldierActor.GetPotentialLv();
				if (potentialLv >= 1 && potentialLv < StarMultiplier.Length)
				{
					num += StarMultiplier[potentialLv];
				}
			}
		}
		if (num <= 0)
		{
			return 1;
		}
		return num;
	}
}
