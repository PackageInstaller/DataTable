using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_120 : SoldierPartnerBase
{
	private const int yhDataId = 100013;

	private readonly TSVector2 yhSummonPosition = new TSVector2(7, -6);

	private readonly FP yhRoation = 0;

	private SoldierLevelController _levelCtrl;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (!(_levelCtrl == null))
		{
			_levelCtrl.SpawnSoldierSummon(null, 100013, yhSummonPosition, yhRoation);
		}
	}

	public void OnUpdate()
	{
	}
}
