using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MissionMessageComp : MonoBehaviour
{
	[SerializeField]
	private Image _missionTypeIcon;

	[SerializeField]
	private Color[] _colors;

	[SerializeField]
	private ActButton _btn;

	[SerializeField]
	private LocalizeStringEvent missionType;

	[SerializeField]
	private LocalizeStringEvent missionDes;

	[SerializeField]
	private List<TextMeshProUGUI> txt_group;

	[SerializeField]
	private Image _btnImage;

	[SerializeField]
	private OperateBtnPrompt tipsBtn;

	public List<Sprite> _missionStateSprite;

	public List<Sprite> _missionTypeSprite;

	private const int Main = 6;

	private const int other = 7;

	private const int person = 8;

	public ActButton Btn => _btn;

	public void Init(int sessionId, long messageId, int missionId, ImageAssetStation station, bool appear)
	{
		MissionBase data = CoreUtils.GetData(missionId, RuntimeConfigs.data.missionBases);
		if (data == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"任务id{missionId}不在任务表中,这里默认随便显示一个保证不报错");
			}
			foreach (TextMeshProUGUI item in txt_group)
			{
				item.color = _colors[2];
			}
		}
		else
		{
			int chapterID = data.chapterID;
			int id = data.name;
			LocalizeStringData data2 = new LocalizeStringData(LocalizeTable.ShortCommon, id);
			missionDes.SetReference(data2);
			bool flag = Singleton<MissionManager>.instance.IsFinished(missionId);
			_btnImage.sprite = (flag ? _missionStateSprite[1] : _missionStateSprite[0]);
			tipsBtn?.gameObject.SetActive(!flag);
			Btn.Interactable(!flag);
			if (chapterID >= 3000 && chapterID < 4000)
			{
				foreach (TextMeshProUGUI item2 in txt_group)
				{
					item2.color = _colors[0];
				}
				_missionTypeIcon.sprite = _missionTypeSprite[0];
				LocalizeStringData data3 = new LocalizeStringData(LocalizeTable.Common, 1719);
				missionType.SetReference(data3);
			}
			if (chapterID >= 5000 && chapterID < 6000)
			{
				foreach (TextMeshProUGUI item3 in txt_group)
				{
					item3.color = _colors[1];
				}
				_missionTypeIcon.sprite = _missionTypeSprite[1];
				LocalizeStringData data4 = new LocalizeStringData(LocalizeTable.Common, 956);
				missionType.SetReference(data4);
			}
			if (chapterID >= 2000 && chapterID < 3000)
			{
				foreach (TextMeshProUGUI item4 in txt_group)
				{
					item4.color = _colors[2];
				}
				_missionTypeIcon.sprite = _missionTypeSprite[2];
				LocalizeStringData data5 = new LocalizeStringData(LocalizeTable.Common, 1720);
				missionType.SetReference(data5);
			}
		}
		if (!appear)
		{
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.Mission;
			evt.sessionId = sessionId;
			evt.messageId = messageId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_UpdateLeftInfo, evt);
		}
		MessageConversation data6 = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		if (data6.nextConversation.Length == 0)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
		else if (data6.nextConversation.Length == 1 && CoreUtils.GetData(data6.nextConversation[0], RuntimeConfigs.data.messageConversations).conversationType == 3)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
	}
}
