using ACT.Config;
using ACT.EventTrack;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT;

[RequireComponent(typeof(ActButton))]
public class EscNewItem : EscItem
{
	[FormerlySerializedAs("Bgicon")]
	public BImage bgIcon;

	private ActButton _actButton;

	protected override void OnStart()
	{
		if (TryGetComponent<ActButton>(out _actButton))
		{
			if (systemId == 7001)
			{
				_actButton.OnClick.AddListener(OnClickQuestionnaire);
			}
			else
			{
				_actButton.OnClick.AddListener(OnClick);
			}
		}
	}

	private void OnDestroy()
	{
		_actButton?.OnClick.RemoveAllListeners();
	}

	protected override void ApplyIcon(ACT.Config.SystemOpen systemData)
	{
		if ((bool)bgIcon.icon)
		{
			GetComponentInParent<IBaseUIView>().Station.LoadImage(109, systemData.iconId, bgIcon);
		}
	}

	protected override int GetSystemOpenEventType()
	{
		return 2;
	}

	private void OnClickQuestionnaire()
	{
		if (!Model<QuestionnaireModel>.Interface.HasQuestionnaire())
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("没有问卷可填写");
			}
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				tableName = LocalizationUtility.localizeTableName_Common,
				localizeId = 1813
			});
		}
		else
		{
			G.service.QuestionnaireRead(Model<QuestionnaireModel>.Interface.GetQuestionnaireId());
			UIUtility.OpenWebView(Model<QuestionnaireModel>.Interface.WebUrl(), isPortrait: true);
			HyperlinkClick evt = EventTrackSolver.Instance.GetEvt<HyperlinkClick>();
			evt.title = Model<QuestionnaireModel>.Interface.Title();
			evt.link = Model<QuestionnaireModel>.Interface.WebUrl();
			evt.systemId = 7001;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}
}
