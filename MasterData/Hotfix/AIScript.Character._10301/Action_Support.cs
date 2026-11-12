using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class Action_Support : ActorActionBase
{
	private const int perkId_3 = 510323;

	private const int skillId_3 = 10332000;

	private const int param_3_pro = 10323011;

	protected override void OnCastSkill()
	{
		CastBindSkill(() =>
		{
			if (GetPerkLv(510323, out var _))
			{
				FDP critRate = _actor.actorInfo.critRate;
				critRate = FDP.Clamp(critRate, FDP.FromDouble(0.02), FDP.One);
				int num = CommonUtils.GetScriptValue(_actor, 10323011).AsInt() + (int)(critRate * 100).AsLong();
				if (TSRandom.Range(0, 100) < num)
				{
					_actor.logicVariable.ToggleLogicTag("AutoSkill", value: true);
					ILRuntimeAPI.CreateSkill(10332000, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
					{
						_actor.logicVariable.ToggleLogicTag("AutoSkill", value: false);
						(_actor as PlayerAdventureActor).isAssistAIFinish = true;
					});
				}
				else
				{
					(_actor as PlayerAdventureActor).isAssistAIFinish = true;
				}
			}
			else
			{
				(_actor as PlayerAdventureActor).isAssistAIFinish = true;
			}
		});
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
