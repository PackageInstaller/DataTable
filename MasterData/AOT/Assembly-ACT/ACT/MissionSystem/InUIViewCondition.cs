using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class InUIViewCondition : MissionCondition
{
	public override bool AllowRepeat => true;

	protected override async void OnInMissionWorld()
	{
		if (IsRepeat)
		{
			do
			{
				if (!CheckCondition())
				{
					await UniTask.Yield();
					continue;
				}
				MarkSuccess();
				while (InMissionWorld && CheckCondition())
				{
					await UniTask.Yield();
				}
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
		InUIViewConditionParam inUIViewConditionParam = Param as InUIViewConditionParam;
		if (!Singleton<NewUIManager>.HasInstance())
		{
			return false;
		}
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(inUIViewConditionParam.uiType, out var ui))
		{
			return false;
		}
		if (ui.State != UIState.Opened)
		{
			return false;
		}
		return true;
	}
}
