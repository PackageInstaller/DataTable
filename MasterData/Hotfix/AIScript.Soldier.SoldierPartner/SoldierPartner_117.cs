using System.Collections.Generic;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_117 : SoldierPartnerBase
{
	private readonly struct LevelCfg(int buffId, int buffLayer)
	{
		public readonly int buffId = buffId;

		public readonly int buffLayer = buffLayer;
	}

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.MeiLiManYi;

	private readonly LevelCfg[] _levelCfg = new LevelCfg[3]
	{
		new LevelCfg(260111711, 1),
		new LevelCfg(260111712, 1),
		new LevelCfg(260111713, 1)
	};

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

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
		_enemyBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv < 1 || actor == null || !actor.HasPartnerType(partnerTypes) || _levelCtrl == null || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		int num = partnerLv - 1;
		if (num < 0 || num >= _levelCfg.Length)
		{
			return;
		}
		LevelCfg levelCfg = _levelCfg[num];
		if (levelCfg.buffId <= 0)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _enemyBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuffNum(levelCfg.buffId, levelCfg.buffLayer, actor);
			}
		}
	}
}
