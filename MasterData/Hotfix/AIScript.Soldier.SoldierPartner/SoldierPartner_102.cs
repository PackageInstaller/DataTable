using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_102 : SoldierPartnerBase
{
	private readonly struct LevelCfg(int buffId, int buffLayer)
	{
		public readonly int buffId = buffId;

		public readonly int buffLayer = buffLayer;
	}

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.WanSongWu;

	private readonly LevelCfg[] _levelCfg = new LevelCfg[2]
	{
		new LevelCfg(260110211, 1),
		new LevelCfg(260110212, 2)
	};

	private const int BUFF_ID_FROZEN = 260110221;

	private const int TRANSFORM_THRESHOLD = 10;

	private static readonly FP CD = 0.5;

	private SoldierLevelController _levelCtrl;

	private readonly Dictionary<long, FP> _lastTriggerTime = new Dictionary<long, FP>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (!(_levelCtrl == null))
		{
			partnerLv = _levelCtrl.GetPartnerLv(partnerTypes);
		}
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_lastTriggerTime.Clear();
		_levelCtrl = null;
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		int num = partnerLv - 1;
		if (num < 0 || num >= _levelCfg.Length)
		{
			return;
		}
		_ = damageEvent.from;
		if (damageEvent.damageType != HotfixEnum.damageType.SKILL && damageEvent.damageType != HotfixEnum.damageType.ULTIMATE)
		{
			return;
		}
		SoldierActor soldierActor = damageEvent.from as SoldierActor;
		if (soldierActor == null || soldierActor.isEnemyCamp)
		{
			return;
		}
		bool flag = soldierActor.HasPartnerType(partnerTypes);
		if (!flag && IsSummoned(soldierActor, out var summoner))
		{
			flag = summoner.HasPartnerType(partnerTypes);
		}
		if (!flag)
		{
			return;
		}
		SoldierActor soldierActor2 = damageEvent.to as SoldierActor;
		if (soldierActor2 == null || !soldierActor2.isEnemyCamp || soldierActor2.isDead || soldierActor2.buffComponent == null)
		{
			return;
		}
		long id = soldierActor2.Id;
		FP time = LockStepManager.time;
		if (!_lastTriggerTime.TryGetValue(id, out var value) || !(time - value < CD))
		{
			_lastTriggerTime.set_Item(id, time);
			LevelCfg levelCfg = _levelCfg[num];
			soldierActor2.buffComponent.AddBuffNum(levelCfg.buffId, levelCfg.buffLayer, soldierActor);
			if (partnerLv == 2 && soldierActor2.buffComponent.GetBuffNumByID(levelCfg.buffId) >= 10)
			{
				soldierActor2.buffComponent.RemoveBuffByBuffId(levelCfg.buffId);
				soldierActor2.buffComponent.AddBuffNum(260110221, 1, soldierActor);
			}
		}
	}
}
