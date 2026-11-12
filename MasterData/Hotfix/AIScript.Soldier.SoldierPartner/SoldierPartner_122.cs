using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_122 : SoldierPartnerBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.ShaXieYongBingTuan;

	private const int sjrDataId = 100010;

	private readonly TSVector2 summonPosition = new TSVector2(-4, -3);

	private readonly FP spRoation = -60;

	private readonly int buff_Spwan = 260112221;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_actorBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (!(_levelCtrl == null))
		{
			int totalMemberStarLv = GetTotalMemberStarLv();
			SoldierActor summoned = _levelCtrl.SpawnSoldierSummon(null, 100010, summonPosition, spRoation);
			AddSpawnBuff(summoned, totalMemberStarLv);
		}
	}

	private void AddSpawnBuff(SoldierActor summoned, int buffLayer)
	{
		if (!(summoned == null) && buff_Spwan != 0 && !(summoned.buffComponent == null) && buffLayer >= 1)
		{
			summoned.buffComponent.AddBuffNum(buff_Spwan, buffLayer, summoned);
		}
	}

	private int GetTotalMemberStarLv()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return 0;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				num += soldierActor.GetPotentialLv();
			}
		}
		return num;
	}

	public void OnUpdate()
	{
	}
}
