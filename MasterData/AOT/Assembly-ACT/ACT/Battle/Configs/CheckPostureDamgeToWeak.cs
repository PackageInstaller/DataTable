using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断架势Damge到弱点", "Predicate", new string[] { "check", "posture", "damge", "to", "weak", "predicate", "condition" })]
public class CheckPostureDamgeToWeak : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (!(memory.evt is EvtPostureDamage evtPostureDamage))
		{
			return false;
		}
		Entity attackee = evtPostureDamage.attackData.attackee;
		ConfigCharacter config = attackee.GetConfig();
		if (config.postureType == PostureType.Multi)
		{
			int maxPosture = attackee.GetCompAbility().maxPosture;
			float[] posturePercent = config.posturePercent;
			for (int i = 0; i < posturePercent.Length; i++)
			{
				float num = posturePercent[i] * (float)maxPosture;
				if (evtPostureDamage.beforePosture > num && evtPostureDamage.afterPosture <= num)
				{
					return true;
				}
			}
			return false;
		}
		if (evtPostureDamage.beforePosture > 0f)
		{
			return evtPostureDamage.afterPosture <= 0f;
		}
		return false;
	}
}
