using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_213016 : DiscScriptBase
{
	private const int discId = 213016;

	private List<int> skillId_s1 = new List<int> { 4019000, 4019001, 4019002, 4019003, 4019004 };

	private List<int> buff_s1v1_1 = new List<int> { 4019000, 4019001, 4019002, 4019003, 4019004 };

	private List<int> buff_s1v1_2 = new List<int> { 4019005, 4019005, 4019005, 4019005, 4019005 };

	private List<int> count_s1v1 = new List<int> { 6, 6, 6, 6, 6 };

	private FP invteral_s1v1 = 0.5;

	private int count_s1v2 = 4019000;

	private int shield_s1v2 = 4019006;

	private int cd_s1v2 = 4019001;

	private List<int> skillId_s2 = new List<int> { 40191, 40191, 40191, 40191, 40191 };

	private int buff_s2 = 4019100;

	private int count_s2 = 4019101;

	private CoroutineNode corAddBuff;

	private int _count_s1v2;

	private FP _cd_s1v2;

	private int _count_s2;

	private int lv_s1;

	private int lv_s2;

	private int stage_s1;

	private PlayerAdventureActor mainCtr => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		_count_s1v2 = 0;
		_count_s2 = 0;
		_cd_s1v2 = 0;
		(int, int) discInfo = GetDiscInfo(213016, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		lv_s2 = GetDiscInfo(213016, skillId_s2).Item2;
		if (lv_s1 < 1)
		{
			return;
		}
		StartCoroutine(ref corAddBuff, DoAddBuff());
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_s1v1_1.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		StopCoroutine(ref corAddBuff);
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor playerAdventureActor = evt.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (playerAdventureActor == null || monsterAdventureActor == null || !evt.isKill || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.FE)
		{
			return;
		}
		if (lv_s1 >= 2)
		{
			int num = CommonUtils.GetScriptValue(_actor, count_s1v2).AsInt();
			int num2 = CommonUtils.GetScriptValue(_actor, cd_s1v2).AsInt();
			if (++_count_s1v2 >= num && (playerAdventureActor.LogicTime - _cd_s1v2 >= num2 || _cd_s1v2 <= 0))
			{
				mainCtr.actorShield.AddShield(shield_s1v2, mainCtr);
				_cd_s1v2 = playerAdventureActor.LogicTime;
				_count_s1v2 = 0;
			}
		}
		if (lv_s2 > 0)
		{
			int num3 = CommonUtils.GetScriptValue(_actor, count_s2).AsInt();
			if (++_count_s2 >= num3)
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buff_s2, playerAdventureActor);
				_count_s2 = 0;
			}
		}
	}

	private IEnumerator DoAddBuff()
	{
		int buffId = buff_s1v1_2.get_Item(stage_s1);
		int count = count_s1v1.get_Item(stage_s1);
		while (true)
		{
			if (ModuleController<AdventureModuleController>.Instance.monsterActors.Count >= count)
			{
				for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
				{
					PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
					if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
					{
						playerAdventureActor.buffComponent.AddBuff(buffId, playerAdventureActor);
					}
				}
			}
			yield return _actor.WaitTime(invteral_s1v1);
		}
	}
}
