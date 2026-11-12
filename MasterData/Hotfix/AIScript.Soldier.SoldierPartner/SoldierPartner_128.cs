using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_128 : SoldierPartnerBase
{
	private class WindowState
	{
		public FP windowStart;

		public int addedInWindow;
	}

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.HuoLiYaZhi;

	private readonly int[] _buff1IdPerLevel = new int[4] { 1400663148, 1819044203, 1734954079, 1852404840 };

	private const int BUFF2_ID = 260112851;

	private static readonly FP STACK_WINDOW = FP.One * 5 / 10;

	private const int MAX_STACK_PER_WINDOW = 1;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _actorBuffer = new List<SoldierActor>();

	private readonly Dictionary<int, WindowState> _windows = new Dictionary<int, WindowState>();

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
		_windows.Clear();
		_actorBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (partnerLv < 1 || _levelCtrl == null || damageEvent.damageType != HotfixEnum.damageType.NORMAL || !(damageEvent.from is SoldierActor { isEnemyCamp: false, isDead: false } soldierActor) || soldierActor.buffComponent == null || !soldierActor.HasPartnerType(partnerTypes) || IsSummoned(soldierActor, out var _) || damageEvent.to is SoldierActor { isEnemyCamp: false })
		{
			return;
		}
		int buff1Id = GetBuff1Id();
		if (buff1Id > 0)
		{
			if (CanStack(soldierActor.dataID))
			{
				soldierActor.buffComponent.AddBuffNum(buff1Id, 1, soldierActor);
			}
			SyncBuff2(soldierActor, buff1Id);
		}
	}

	public void OnUpdate()
	{
		if (partnerLv < 1 || _levelCtrl == null)
		{
			return;
		}
		int buff1Id = GetBuff1Id();
		if (buff1Id <= 0)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _actorBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				SyncBuff2(soldierActor, buff1Id);
			}
		}
	}

	private void SyncBuff2(SoldierActor actor, int buff1Id)
	{
		bool flag = actor.buffComponent.HaveBuffNumMax(buff1Id);
		bool flag2 = actor.buffComponent.GetBuffNumByID(260112851) > 0;
		if (flag && !flag2)
		{
			actor.buffComponent.AddBuff(260112851, actor);
		}
		else if (!flag & flag2)
		{
			actor.buffComponent.RemoveBuffByBuffId(260112851);
		}
	}

	private bool CanStack(int dataId)
	{
		FP time = LockStepManager.time;
		if (!_windows.TryGetValue(dataId, out var value))
		{
			value = new WindowState
			{
				windowStart = time,
				addedInWindow = 0
			};
			_windows.set_Item(dataId, value);
		}
		else if (time - value.windowStart >= STACK_WINDOW)
		{
			value.windowStart = time;
			value.addedInWindow = 0;
		}
		if (value.addedInWindow >= 1)
		{
			return false;
		}
		value.addedInWindow++;
		return true;
	}

	private int GetBuff1Id()
	{
		if (partnerLv < 1 || _buff1IdPerLevel.Length == 0)
		{
			return 0;
		}
		int num = partnerLv - 1;
		if (num >= _buff1IdPerLevel.Length)
		{
			num = _buff1IdPerLevel.Length - 1;
		}
		return _buff1IdPerLevel[num];
	}
}
