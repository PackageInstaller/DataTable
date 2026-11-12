using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214010 : DiscScriptBase
{
	private const int discId = 214010;

	private static readonly List<int> skillIds_1 = new List<int> { 4010000, 4010001, 4010002, 4010003, 4010004 };

	private static readonly List<int> buffIdList_1_1 = new List<int> { 4010000, 4010001, 4010002, 4010003, 4010004 };

	private static readonly List<int> shieldIdList_1_1 = new List<int> { 4010001, 4010001, 4010001, 4010001, 4010001 };

	private const int shield_1_3 = 4010002;

	private int _discSkillLevel_1;

	private int _discSkillStage_1;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(_discSkillStage_1, _discSkillLevel_1) = GetDiscInfo(214010, skillIds_1);
		if (_discSkillLevel_1 <= 0)
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (CheckActorIsLE(actorL))
			{
				actorL.buffComponent.AddBuff(buffIdList_1_1.get_Item(_discSkillStage_1), actorL);
			}
		}
	}

	protected override void OnFirstEnterBattleState(IEvent evt)
	{
		base.OnFirstEnterBattleState(evt);
		if (_discSkillLevel_1 > 0)
		{
			_actor.actorShield.AddShield(shieldIdList_1_1.get_Item(_discSkillStage_1), _actor);
		}
		if (_discSkillLevel_1 > 2)
		{
			_actor.actorShield.AddShield(4010002, _actor);
		}
	}

	private bool CheckActorIsLE(PlayerAdventureActor actor, bool checkAssit = false, bool isAssist = false)
	{
		if (actor == null)
		{
			return false;
		}
		if (actor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
		{
			if (checkAssit)
			{
				return actor.isAssist == isAssist;
			}
			return true;
		}
		return false;
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		_discSkillLevel_1 = 0;
		_discSkillStage_1 = 0;
	}
}
