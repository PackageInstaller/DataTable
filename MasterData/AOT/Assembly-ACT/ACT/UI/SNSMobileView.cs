using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SNSMobileView : SNSBaseView
{
	[SerializeField]
	private GameObject closeBtn;

	protected override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SNS_UpdateContactView, OnConversationFinish);
		if (Model<SNSModel>.Interface.FocusMessageLock)
		{
			closeBtn.SetActive(value: false);
		}
		else
		{
			closeBtn.SetActive(value: true);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SNS_UpdateContactView, OnConversationFinish);
	}

	public override void Close()
	{
		base.Close();
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.SNSClose);
	}

	private void OnConversationFinish(BaseEventContent content)
	{
		if (content is SNSContactsViewUpdateEvt)
		{
			closeBtn.SetActive(value: true);
		}
	}
}
