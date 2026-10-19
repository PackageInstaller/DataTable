using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class OpenReadableViewCondition : MissionCondition
{
	private bool m_Finished;

	protected override async void OnInMissionWorld()
	{
		m_Finished = false;
		do
		{
			IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
			if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_BATTLEMAIN)
			{
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
		if (!InMissionWorld)
		{
			return;
		}
		OpenReadableViewConditionParam openReadableViewConditionParam = Param as OpenReadableViewConditionParam;
		ReadableViewData uiData = new ReadableViewData
		{
			id = openReadableViewConditionParam.textLibraryContentId,
			onClose = () =>
			{
				m_Finished = true;
			}
		};
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_READABLE, uiData);
		while (!CheckCondition())
		{
			await UniTask.Yield();
			if (!InMissionWorld)
			{
				break;
			}
		}
		MarkSuccess();
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
	}

	private bool CheckCondition()
	{
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null)
		{
			return false;
		}
		if (topActiveUI.UIType != UI_TYPE.UI_BATTLEMAIN)
		{
			return false;
		}
		if (!m_Finished)
		{
			return false;
		}
		return true;
	}
}
