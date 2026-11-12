using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private int monsterId_candao = 1;

	private int killCount = 1;

	private int killTime = 3;

	private int count;

	private int countTotle;

	private FP curTime;

	public override void OnStart()
	{
		base.OnStart();
		count = 0;
		countTotle = 0;
		curTime = _actor.LogicTime;
	}

	public override void OnDied(int monsterId)
	{
		if (monsterId == monsterId_candao)
		{
			count++;
			countTotle++;
			if (count >= killCount)
			{
				if (!ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.CanCha_001))
				{
					ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.CanCha_001);
				}
				count = 0;
			}
		}
		else if (monsterId == _actor.dataID)
		{
			if (countTotle == 0 && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.CanCha_002))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.CanCha_002);
			}
			if (_actor.LogicTime - curTime < killTime && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.CanCha_003))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.CanCha_003);
			}
		}
	}
}
