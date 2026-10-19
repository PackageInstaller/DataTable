using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class NewUIManagerTest : MonoBehaviour
{
	public void OpenPopUpTwice()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPSYSTEMUNLOCK, new PopupSystemUnlockViewData
		{
			systemId = 1008
		});
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPSYSTEMUNLOCK, new PopupSystemUnlockViewData
		{
			systemId = 1008
		});
	}

	public void OpenClosePopUp()
	{
		UIOpenResult uIOpenResult = Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPSYSTEMUNLOCK, new PopupSystemUnlockViewData
		{
			systemId = 1008
		});
		Singleton<NewUIManager>.instance.CloseUI(uIOpenResult.Uid);
	}
}
