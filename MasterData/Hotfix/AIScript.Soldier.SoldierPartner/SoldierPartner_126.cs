using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_126 : SoldierPartnerBase
{
	private enum MoraleKind
	{
		AtkSpd,
		Energy,
		AddHp,
		Def,
		DefPen,
		Default
	}

	private readonly struct Commander(int dataId, MoraleKind kind, MoraleKind kind2 = MoraleKind.Default)
	{
		public readonly int dataId = dataId;

		public readonly MoraleKind kind = kind;

		public readonly MoraleKind kind2 = kind2;
	}

	private readonly struct MoraleCfg(int buffAtkSpd, FP energyPercent, int buffHp, int buffDef, int buffDefPen)
	{
		public readonly int buffAtkSpd = buffAtkSpd;

		public readonly FP energyPercent = energyPercent;

		public readonly int buffHp = buffHp;

		public readonly int buffDef = buffDef;

		public readonly int buffDefPen = buffDefPen;
	}

	private readonly struct LevelCfg(MoraleCfg morale, MoraleCfg chiefMorale)
	{
		public readonly MoraleCfg morale = morale;

		public readonly MoraleCfg chiefMorale = chiefMorale;
	}

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.ZhiHuiGuan;

	private static readonly Commander[] commanders = new Commander[4]
	{
		new Commander(2501044, MoraleKind.AtkSpd),
		new Commander(2501048, MoraleKind.Energy),
		new Commander(2501063, MoraleKind.AddHp, MoraleKind.Def),
		new Commander(2501064, MoraleKind.DefPen)
	};

	private readonly LevelCfg[] _levelCfg = new LevelCfg[2]
	{
		new LevelCfg(new MoraleCfg(260112611, 15, 260112621, 260112622, 260112631), new MoraleCfg(0, 0, 0, 0, 0)),
		new LevelCfg(new MoraleCfg(260112611, 15, 260112621, 260112622, 260112631), new MoraleCfg(260112641, 12, 260112651, 260112652, 260112661))
	};

	private const int BUFF_ID_COMMANDER_FX = 260112671;

	private const int BUFF_ID_CHIEF_FX = 260112671;

	private const int SUPPRESS_MIN = 2;

	private const int SUPPRESS_MAX = 3;

	private const int CHIEF_MIN_LV = 2;

	private const string MORALE_FX_PATH = "FX/Soldier/fx_soldier_base_commander";

	private static readonly TSVector2 moraleFxPosition = new TSVector2(0, 0);

	private static readonly FP moraleFxPositionY = 0;

	private static readonly FP moraleFxAngle = 0;

	private const float moraleFxScale = 1f;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _commanderBuffer = new List<SoldierActor>();

	private readonly List<SoldierActor> _followerBuffer = new List<SoldierActor>();

	private SoldierActor _pendingEnergyActor;

	private int _pendingEnergyAmount;

	private bool _isApplying;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_pendingEnergyActor = null;
		_pendingEnergyAmount = 0;
		_isApplying = false;
		_commanderBuffer.Clear();
		_followerBuffer.Clear();
		_levelCtrl = null;
	}

	public void OnUpdate()
	{
		SoldierActor pendingEnergyActor = _pendingEnergyActor;
		if (!(pendingEnergyActor == null))
		{
			int pendingEnergyAmount = _pendingEnergyAmount;
			_pendingEnergyActor = null;
			_pendingEnergyAmount = 0;
			if (!pendingEnergyActor.isDead && pendingEnergyAmount > 0)
			{
				pendingEnergyActor.SetEnergy(pendingEnergyActor.energy + pendingEnergyAmount);
			}
		}
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv < 1 || actor == null || _levelCtrl == null || castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B || !TryGetMoraleKind(actor.dataID, out var kind, out var kind2) || _isApplying)
		{
			return;
		}
		int num = CountBattleCommanders(actor);
		if (num >= 2 && num <= 3)
		{
			return;
		}
		int num2 = partnerLv - 1;
		if (num2 >= _levelCfg.Length)
		{
			num2 = _levelCfg.Length - 1;
		}
		if (num2 < 0)
		{
			return;
		}
		LevelCfg levelCfg = _levelCfg[num2];
		_isApplying = true;
		try
		{
			if (partnerLv >= 2)
			{
				ApplyChiefMorale(actor, levelCfg.morale, levelCfg.chiefMorale);
			}
			else
			{
				ApplyCommanderMorale(actor, kind, kind2, levelCfg.morale);
			}
		}
		finally
		{
			_isApplying = false;
		}
	}

	private void ApplyCommanderMorale(SoldierActor commander, MoraleKind kind, MoraleKind kind2, MoraleCfg cfg)
	{
		IList<int> partnerTags = GetPartnerTags(commander.dataID);
		if (partnerTags == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(commander, _followerBuffer);
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == commander) && IsFollowerCandidate(soldierActor) && ShareOtherPartnerTag(partnerTags, soldierActor.dataID))
			{
				ApplyMorale(soldierActor, kind, cfg, commander);
				ApplyMorale(soldierActor, kind2, cfg, commander);
				num++;
			}
		}
		if (num > 0)
		{
			AddBuff(commander, 260112671, commander);
			PlayMoraleFx();
		}
	}

	private void ApplyChiefMorale(SoldierActor commander, MoraleCfg cfgper, MoraleCfg cfg)
	{
		if (PickChief(commander) != commander)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(commander, _followerBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (IsFollowerCandidate(soldierActor))
			{
				MoraleCfg moraleCfg = cfgper;
				if (commander == soldierActor)
				{
					moraleCfg = cfg;
				}
				AddBuff(soldierActor, moraleCfg.buffAtkSpd, commander);
				AddEnergyByPercent(soldierActor, moraleCfg.energyPercent, commander);
				AddBuff(soldierActor, moraleCfg.buffHp, commander);
				AddBuff(soldierActor, moraleCfg.buffDef, commander);
				AddBuff(soldierActor, moraleCfg.buffDefPen, commander);
			}
		}
		AddBuff(commander, 260112671, commander);
		PlayMoraleFx();
	}

	private void ApplyMorale(SoldierActor target, MoraleKind kind, MoraleCfg cfg, SoldierActor commander)
	{
		switch (kind)
		{
		case MoraleKind.AtkSpd:
			AddBuff(target, cfg.buffAtkSpd, commander);
			break;
		case MoraleKind.Energy:
			AddEnergyByPercent(target, cfg.energyPercent, commander);
			break;
		case MoraleKind.AddHp:
			AddBuff(target, cfg.buffHp, commander);
			break;
		case MoraleKind.Def:
			AddBuff(target, cfg.buffDef, commander);
			break;
		case MoraleKind.DefPen:
			AddBuff(target, cfg.buffDefPen, commander);
			break;
		}
	}

	private SoldierActor PickChief(SoldierActor anchor)
	{
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(anchor, _commanderBuffer);
		SoldierActor soldierActor = null;
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor2 = allActors.get_Item(i);
			if (!(soldierActor2 == null) && !soldierActor2.isDead && IsCommander(soldierActor2.dataID))
			{
				int totalCostSafe = GetTotalCostSafe(soldierActor2);
				if (soldierActor == null || totalCostSafe > num || (totalCostSafe == num && soldierActor2.dataID < soldierActor.dataID))
				{
					soldierActor = soldierActor2;
					num = totalCostSafe;
				}
			}
		}
		return soldierActor;
	}

	private int CountBattleCommanders(SoldierActor anchor)
	{
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(anchor, _commanderBuffer);
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (soldierActor != null && !soldierActor.isDead && IsCommander(soldierActor.dataID))
			{
				num++;
			}
		}
		return num;
	}

	private int GetTotalCostSafe(SoldierActor actor)
	{
		if (Singleton<HotfixDataController>.Instance.GetSoldierCharacter(actor.dataID) == null)
		{
			return 0;
		}
		return actor.GetTotalCost();
	}

	private static IList<int> GetPartnerTags(int dataId)
	{
		return Singleton<HotfixDataController>.Instance.GetSoldierCharacter(dataId)?.PartnerType;
	}

	private bool ShareOtherPartnerTag(IList<int> commanderTags, int followerDataId)
	{
		IList<int> partnerTags = GetPartnerTags(followerDataId);
		if (partnerTags == null)
		{
			return false;
		}
		for (int i = 0; i < commanderTags.Count; i++)
		{
			int num = commanderTags.get_Item(i);
			if (num == (int)partnerTypes)
			{
				continue;
			}
			for (int j = 0; j < partnerTags.Count; j++)
			{
				if (partnerTags.get_Item(j) == num)
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool IsFollowerCandidate(SoldierActor actor)
	{
		if (actor == null || actor.isDead || actor.buffComponent == null)
		{
			return false;
		}
		SoldierActor summoner;
		return !IsSummoned(actor, out summoner);
	}

	private static bool IsCommander(int dataId)
	{
		MoraleKind kind;
		MoraleKind kind2;
		return TryGetMoraleKind(dataId, out kind, out kind2);
	}

	private static bool TryGetMoraleKind(int dataId, out MoraleKind kind, out MoraleKind kind2)
	{
		for (int i = 0; i < commanders.Length; i++)
		{
			if (commanders[i].dataId == dataId)
			{
				kind = commanders[i].kind;
				kind2 = commanders[i].kind2;
				return true;
			}
		}
		kind = MoraleKind.AtkSpd;
		kind2 = MoraleKind.Default;
		return false;
	}

	private void AddBuff(SoldierActor target, int buffId, SoldierActor fromActor)
	{
		if (buffId > 0 && !(target.buffComponent == null))
		{
			target.buffComponent.AddBuff(buffId, fromActor);
		}
	}

	private void AddEnergyByPercent(SoldierActor target, FP percent, SoldierActor caster)
	{
		if (percent <= 0)
		{
			return;
		}
		bool flag = target == caster;
		if (!flag && target.isEnergyFull)
		{
			return;
		}
		int num = (int)(long)(target.maxEnergy * percent / 100);
		if (num > 0)
		{
			if (flag)
			{
				_pendingEnergyActor = target;
				_pendingEnergyAmount = num;
			}
			else
			{
				target.SetEnergy(target.energy + num);
			}
		}
	}

	private void PlayMoraleFx()
	{
		if (!string.IsNullOrEmpty("FX/Soldier/fx_soldier_base_commander"))
		{
			Vector3 spawnPosition = new Vector3((float)moraleFxPosition.x, (float)moraleFxPositionY, (float)moraleFxPosition.y);
			Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)moraleFxAngle, 0f);
			AdventureFXManager.PlayFX("FX/Soldier/fx_soldier_base_commander", 1f, spawnPosition, spawnRotation);
		}
	}
}
