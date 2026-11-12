using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214012 : DiscScriptBase
{
	private const int discId = 214012;

	private List<int> skillId_s3 = new List<int> { 401201, 401202, 401203, 401204, 401205, 401206 };

	private List<int> shield_s3 = new List<int> { 4012020, 4012020, 4012020, 4012020, 4012020, 4012020 };

	private FP cd_s3 = 20;

	private int stage_3;

	private int lv_s3;

	private FP curTime;

	private int Dark = CommonHelper.StringToHash("Dark");

	private int DarkMark1 = CommonHelper.StringToHash("DarkMark1");

	private int DarkMark2 = CommonHelper.StringToHash("DarkMark2");

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnAddBuff);
		curTime = 0;
		(stage_3, lv_s3) = GetDiscInfo(214012, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnAddBuff);
	}

	private void OnAddBuff(IEvent evt)
	{
		if (lv_s3 > 0 && evt is AdventureActorGetBuff adventureActorGetBuff && (adventureActorGetBuff.eventInfo.buffTags.Contains(Dark) || adventureActorGetBuff.eventInfo.buffTags.Contains(DarkMark1) || adventureActorGetBuff.eventInfo.buffTags.Contains(DarkMark2)))
		{
			bool flag = false;
			PlayerAdventureActor playerAdventureActor = adventureActorGetBuff.from as PlayerAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				flag = true;
			}
			MonsterAdventureActor monsterAdventureActor = adventureActorGetBuff.from as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.IsPlayerMinion(out var _))
			{
				flag = true;
			}
			if (flag && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && (_actor.LogicTime - curTime > cd_s3 || curTime <= 0))
			{
				mainCtrActor.actorShield.AddShield(shield_s3.get_Item(stage_3), _actor);
				curTime = _actor.LogicTime;
			}
		}
	}
}
