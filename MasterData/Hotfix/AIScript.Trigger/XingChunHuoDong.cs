using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trigger;

public class XingChunHuoDong : AIBase
{
	private readonly int monsterId = 3060101;

	private readonly int monsterId_1 = 3060091;

	private readonly int dropItemId = 122;

	private readonly FP dropCd = 1;

	private readonly FP monsterRate_1 = 80;

	private readonly FP monsterRate_2 = 100;

	private readonly FP monsterRate_3 = 10;

	private readonly FP checkBuff = 306010002;

	private readonly List<string> fxAreas = new List<string> { "Area_Sparkler_Blue", "Area_Sparkler_Purple", "Area_Sparkler_Red", "Area_Sparkler_Yellow" };

	private readonly FP roteteSpeed = -180;

	private readonly FP resetAreaTime = 10;

	private readonly FP posy = 1;

	private FP _lastDropTime;

	private FP _time;

	private List<AreaEffectEntity> areaLs = new List<AreaEffectEntity>();

	private List<string> areas = new List<string>();

	private AdventureActor mainActor;

	private SummonCfg summonCfg;

	public void OnEnable()
	{
		areaLs.Clear();
		areas.Clear();
		_lastDropTime = 0;
		_time = 0;
		Shuffle();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	public void OnDisable()
	{
		mainActor = null;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	private void OnDied(IEvent evt)
	{
		if ((evt as AdventureActorDiedEvent).actor is MonsterAdventureActor monsterAdventureActor && !monsterAdventureActor.IsPlayerSummoned(out var _, out var _) && monsterAdventureActor.dataID != monsterId && monsterAdventureActor.dataID != monsterId_1)
		{
			if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL)
			{
				TryDropItem(monsterAdventureActor.tsTransform.Position, monsterRate_1);
			}
			else if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE)
			{
				TryDropItem(monsterAdventureActor.tsTransform.Position, monsterRate_2);
			}
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent { to: MonsterAdventureActor to } && to.IsBossMonster() && to.dataID != monsterId && to.dataID != monsterId_1)
		{
			TryDropItem(to.tsTransform.Position, monsterRate_3);
		}
	}

	private bool TryDropItem(TSVector2 position, FP _dropRate)
	{
		if (_lastDropTime > 0 && LockStepManager.time - _lastDropTime <= dropCd)
		{
			return false;
		}
		if (TSRandom.Range(FP.Zero, 100) <= _dropRate)
		{
			AdventureActor owner = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
			SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(owner, dropItemId, position);
			_lastDropTime = LockStepManager.time;
			return true;
		}
		return false;
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.sender is PlayerAdventureActor && adventureActorGetBuff.eventInfo != null && adventureActorGetBuff.eventInfo.buffId == checkBuff)
		{
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
			if (summonCfg == null)
			{
				summonCfg = new SummonCfg();
				summonCfg.summonAttrType = SummonAttrType.Self;
				summonCfg.summonRelation = SummonRelation.Independent;
				summonCfg.attrPercent = 100;
				summonCfg.leftTime = 999999;
			}
			ILRuntimeAPI.SummonMonster(adventureActor, 0, monsterId, adventureActor.tsTransform.Position, TSVector2.zero, summonCfg);
		}
	}

	private void Shuffle()
	{
		areas.Clear();
		areas.AddRange(fxAreas);
		int num = areas.Count;
		while (num > 1)
		{
			int num2 = TSRandom.Range(0, num);
			num--;
			List<string> list = areas;
			int index = num;
			List<string> list2 = areas;
			int index2 = num2;
			string text = areas.get_Item(num2);
			string text2 = areas.get_Item(num);
			string text3;
			list.set_Item(index, text3 = text);
			list2.set_Item(index2, text3 = text2);
		}
	}

	private void PlayRandomArea()
	{
		int count = areaLs.Count;
		if (count > 0)
		{
			for (int i = 0; i < areaLs.Count; i++)
			{
				areaLs.get_Item(i).ModifyLeftTime(resetAreaTime);
			}
		}
		if (count < areas.Count)
		{
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
			long num = ILRuntimeAPI.PlayAreaEffect(adventureActor, areas.get_Item(count), adventureActor.tsTransform.Position);
			if (num > 0)
			{
				AreaEffectEntity areaEffect = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(num);
				areaLs.Add(areaEffect);
			}
			FixAreaRotation();
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (areaLs.Count < 1)
		{
			return;
		}
		for (int i = 0; i < areaLs.Count; i++)
		{
			if (areaLs.get_Item(i).Id == adventureAreaEffectFinishEvent.entityID)
			{
				areaLs.RemoveAt(i);
				string item = areas.get_Item(i);
				areas.RemoveAt(i);
				areas.Add(item);
				break;
			}
		}
		if (areaLs.Count < 1)
		{
			Shuffle();
		}
	}

	private void FixAreaRotation()
	{
		if (areaLs.Count >= 1)
		{
			if (mainActor == null)
			{
				mainActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
			}
			for (int i = 0; i < areaLs.Count; i++)
			{
				FP t = i * (360 / areaLs.Count) + _time * roteteSpeed;
				t = TSMath.Repeat(t, 360f);
				areaLs.get_Item(i).tsTransform.Rotation = t;
				areaLs.get_Item(i).tsTransform.PositionY = posy;
			}
		}
	}

	public void OnUpdate()
	{
		_time += LockStepManager.deltaTime;
		FixAreaRotation();
	}
}
