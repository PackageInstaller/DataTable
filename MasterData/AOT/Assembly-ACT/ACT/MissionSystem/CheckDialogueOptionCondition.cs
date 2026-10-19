using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class CheckDialogueOptionCondition : MissionCondition
{
	public override bool AllowRepeat => true;

	protected override async void OnInMissionWorld()
	{
		if (IsRepeat)
		{
			do
			{
				if (CheckCondition())
				{
					MarkSuccess();
				}
				await UniTask.Yield();
			}
			while (InMissionWorld);
			return;
		}
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

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		CheckDialogueOptionConditionParam checkDialogueOptionConditionParam = Param as CheckDialogueOptionConditionParam;
		if (Singleton<ConversationManager>.instance.HaveKeyPoint(checkDialogueOptionConditionParam.optionId))
		{
			return true;
		}
		return false;
	}
}
