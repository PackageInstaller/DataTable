using AdventureBehaviour;

namespace AIScript.Monster.Soldier._139;

public static class UltraSkillHelper
{
	public static bool ShouldTrigger(AdventureActor actor)
	{
		SoldierActor obj = actor as SoldierActor;
		if ((object)obj != null && obj.GetPotentialLv() < 2)
		{
			return false;
		}
		if (actor.buffComponent == null)
		{
			return false;
		}
		return actor.buffComponent.GetBuffNumByID(250105102) >= 3;
	}

	public static void TriggerPerformance(AdventureActor actor)
	{
		int buffNumByID = actor.buffComponent.GetBuffNumByID(250105102);
		actor.buffComponent.RemoveBuffByBuffId(250105102);
		for (int i = 0; i < MainSkill.removeSoulFxList.Length && i <= buffNumByID - 1; i++)
		{
			new PlayFX().Play(actor, null, MainSkill.removeSoulFxList[i], default, actor.tsTransform.Position, default);
		}
		actor.buffComponent.AddBuff(250105101, actor);
	}
}
