namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_Demo : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.LianHeZhongYe;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		partnerLv = soldierLevelController.GetPartnerLv(partnerTypes);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
	}
}
