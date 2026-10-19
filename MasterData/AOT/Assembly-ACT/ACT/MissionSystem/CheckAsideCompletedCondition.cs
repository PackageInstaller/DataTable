using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class CheckAsideCompletedCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		CheckAsideCompletedConditionParam checkAsideCompletedConditionParam = Param as CheckAsideCompletedConditionParam;
		AsideManager.instance.BeginAside(checkAsideCompletedConditionParam.asideId);
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	private bool CheckCondition()
	{
		CheckAsideCompletedConditionParam checkAsideCompletedConditionParam = Param as CheckAsideCompletedConditionParam;
		if (Singleton<ConversationManager>.instance.HaveKeyPoint(checkAsideCompletedConditionParam.asideId))
		{
			return true;
		}
		return false;
	}
}
