using ACT.Event;
using ACT.UI.Controller.PopUpMissionSubmitView;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoPopUpMissionSubmitView : BaseUIView<PopUpMissionSubmitViewInputController>
{
	[HideInInspector]
	public int subMissionId;

	[HideInInspector]
	public int nextMissionId;

	[HideInInspector]
	public bool FinishMission;

	public ItemUIComponentBase[] items;

	public Button confirmBtn;

	private bool isClick;

	private bool isNeedSubmit;

	private bool isFinish;

	private bool isSend;

	private new bool isEmpty;

	protected override void Init()
	{
		base.Init();
		isSend = false;
		isFinish = false;
		isNeedSubmit = false;
		isClick = false;
		subMissionId = (int)uiViewData;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SubMission_Pass, SetSubMissionState);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Mission_Finish, SetMissionState);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SubMission_Pass_Fail, SetSubMissionState);
		SetItemInfo();
	}

	protected override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SubMission_Pass, SetSubMissionState);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Mission_Finish, SetMissionState);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SubMission_Pass_Fail, SetSubMissionState);
	}

	private void SetItemInfo()
	{
	}

	public void OnBtnDown(bool needSubmit)
	{
		isNeedSubmit = needSubmit;
		isClick = true;
	}

	public async UniTask<bool> GetSubmitMissionState()
	{
		if (isEmpty)
		{
			return true;
		}
		await UniTask.WaitUntil(() => isClick);
		if (!isNeedSubmit)
		{
			return false;
		}
		await UniTask.WaitUntil(() => isSend);
		return isFinish;
	}

	private void SetSubMissionState(BaseEventContent e)
	{
		PassSubMission passSubMission = (PassSubMission)e;
		if (passSubMission.from == subMissionId)
		{
			isFinish = passSubMission.state;
			isSend = true;
		}
	}

	private void SetMissionState(BaseEventContent e)
	{
	}
}
