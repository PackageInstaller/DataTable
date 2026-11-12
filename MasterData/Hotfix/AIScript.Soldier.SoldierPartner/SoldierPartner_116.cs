namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_116 : SoldierPartnerBase
{
	private readonly struct LevelCfg(int buffId, int buffLayer)
	{
		public readonly int buffId = buffId;

		public readonly int buffLayer = buffLayer;
	}

	private readonly LevelCfg[] _levelCfg = new LevelCfg[3]
	{
		new LevelCfg(260111611, 1),
		new LevelCfg(260111612, 1),
		new LevelCfg(260111613, 1)
	};

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.DianFengZhanShi;

	private SoldierLevelController _levelCtrl;

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
		_levelCtrl = null;
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv < 1 || actor == null || !actor.HasPartnerType(partnerTypes) || actor.isDead || actor.buffComponent == null || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		int num = partnerLv - 1;
		if (num >= 0 && num < _levelCfg.Length)
		{
			LevelCfg levelCfg = _levelCfg[num];
			if (levelCfg.buffId > 0)
			{
				actor.buffComponent.AddBuffNum(levelCfg.buffId, levelCfg.buffLayer, actor);
			}
		}
	}
}
