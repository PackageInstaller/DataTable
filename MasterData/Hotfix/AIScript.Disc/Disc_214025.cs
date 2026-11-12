using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Disc;

public class Disc_214025 : DiscScriptBase
{
	private const int discId = 214025;

	private List<int> skillId_s1 = new List<int> { 0 };

	private const int buffId_1 = 0;

	private const int buffId_2 = 0;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		if (GetDiscSkillv(214025, skillId_s1) <= 0)
		{
			return;
		}
		int buffID = CommonUtils.GetScriptValue(_actor, 0).AsInt();
		int buffID2 = CommonUtils.GetScriptValue(_actor, 0).AsInt();
		_actor.buffComponent.AddBuff(buffID, _actor);
		HotfixEnum.elementType elementType = _actor.actorElementInfo.elementType;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.Id != _actor.Id && playerAdventureActor.actorElementInfo.elementType == elementType)
			{
				_actor.buffComponent.AddBuff(buffID2, _actor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}
}
