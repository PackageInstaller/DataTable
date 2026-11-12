using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._16101;

public static class EarthMarkUtil
{
	private static readonly int[] earthMarks = new int[6]
	{
		CommonDefine.EarthMark1,
		CommonDefine.EarthMark2,
		CommonDefine.EarthMark3,
		CommonDefine.EarthMark4,
		CommonDefine.EarthMark5,
		CommonDefine.Earth
	};

	private const int buffId_LandMark = 6011;

	private const string areaEffectKey_TriggerLandMark = "AreaEffect_161_LandTag_Stone";

	private const string tipsKey_TriggerMark = "LandMark_Trigger_Effect_02";

	private const int hitDmgId_TriggerLandMark = 0;

	private const string hitEffect_TriggerLandMark = "";

	public static bool TryTrigger(AdventureActor triggerActor, MonsterAdventureActor monster)
	{
		if (triggerActor == null || monster == null || monster.buffComponent == null)
		{
			return false;
		}
		int num = 0;
		for (int i = 0; i < earthMarks.Length; i++)
		{
			if (CommonUtils.CheckElementMark(earthMarks[i], monster))
			{
				num = earthMarks[i];
				break;
			}
		}
		if (num == 0)
		{
			return false;
		}
		if (!CommonUtils.CheckTriggerElementMarkCD(triggerActor, monster))
		{
			return false;
		}
		monster.buffComponent.RemoveBuffByTag(num);
		ILRuntimeAPI.PlayAreaEffect(triggerActor, "AreaEffect_161_LandTag_Stone", monster.tsTransform.Position);
		CommonUtils.TriggerElementMarkEvent(num, HotfixEnum.AdventureActorElementTriggerType.EarthElementTriggerType, triggerActor, monster, "LandMark_Trigger_Effect_02");
		return true;
	}

	public static void Attach(AdventureActor actor, MonsterAdventureActor monster)
	{
		if (!(actor == null) && !(monster == null) && !(monster.buffComponent == null))
		{
			monster.buffComponent.AddBuff(6011, actor);
		}
	}
}
