using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214001 : DiscScriptBase
{
	private const int discId = 214001;

	private const int buffId_fire = 4029999;

	private List<int> skillId_s1 = new List<int> { 4029000, 4029001, 4029002, 4029003, 4029004 };

	private List<int> buff_s1v1 = new List<int> { 4029000, 4029001, 4029002, 4029003, 4029004 };

	private List<int> buff_s1v1_extra = new List<int> { 4029005, 4029005, 4029005, 4029005, 4029005 };

	private int count_s1v1 = 1;

	private List<int> skillId_s2 = new List<int> { 40291, 40291, 40291, 40291, 40291 };

	private List<int> buff_s2 = new List<int> { 0, 0, 0, 0, 0 };

	private int count_s2 = 10;

	private List<int> skillId_s3 = new List<int> { 40292, 40292, 40292, 40292, 40292 };

	private List<int> buff_s3 = new List<int> { 0, 0, 0, 0, 0 };

	private int count_s3 = 5;

	private List<int> interval_3 = new List<int> { 1, 1, 1, 1, 1 };

	private CoroutineNode corAddBuff;

	private HashSet<int> hashActor_lv2 = new HashSet<int>();

	private HashSet<int> hashActor_lv3 = new HashSet<int>();

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private int killCount;

	private PlayerAdventureActor mainCtr => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		killCount = 0;
		(stage_s1, lv_s1) = GetDiscInfo(214001, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214001, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214001, skillId_s3);
		if (lv_s1 > 0)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_s1v1.get_Item(stage_s1), playerAdventureActor);
				}
			}
		}
		if (lv_s2 > 0)
		{
			AddFireBuff(mainCtr);
		}
		if (lv_s3 > 0)
		{
			StartCoroutine(ref corAddBuff, DoAddBuff());
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		hashActor_lv2.Clear();
		hashActor_lv3.Clear();
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor playerAdventureActor = evt.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(playerAdventureActor == null) && !(monsterAdventureActor == null) && lv_s1 >= 1 && evt.isKill && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE && ++killCount >= count_s1v1)
		{
			AddFireBuff(mainCtr);
			killCount = 0;
		}
	}

	private IEnumerator DoAddBuff()
	{
		while (true)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					AddFireBuff(playerAdventureActor);
				}
			}
			yield return mainCtr.WaitTime(interval_3.get_Item(stage_s2));
		}
	}

	private void AddFireBuff(PlayerAdventureActor player)
	{
		player.buffComponent.AddBuff(4029999, player);
		player.buffComponent.GetBuffNumByID(4029999);
		int buffNumByID = mainCtr.buffComponent.GetBuffNumByID(4029999);
		if (lv_s1 >= 1)
		{
			player.buffComponent.AddBuff(buff_s1v1_extra.get_Item(stage_s1), player);
		}
		if (lv_s2 > 0 && buffNumByID >= count_s2)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_s2.get_Item(stage_s2), playerAdventureActor);
				}
			}
		}
		if (lv_s3 <= 0 || buffNumByID < count_s3)
		{
			return;
		}
		for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
			if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor2.buffComponent.AddBuff(buff_s3.get_Item(stage_s3), playerAdventureActor2);
			}
		}
	}
}
