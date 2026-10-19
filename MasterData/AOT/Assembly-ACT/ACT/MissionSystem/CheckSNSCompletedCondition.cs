using System.Collections.Generic;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class CheckSNSCompletedCondition : MissionCondition, IConditionDescriptionHyperLink
{
	private LocalizedString m_Description;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (m_Description == null)
		{
			m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
		}
		yield return new ConditionDescription
		{
			HaveContent = (Desc != 0),
			DescriptionContent = m_Description,
			HaveHyperLink = true,
			HyperLinkTextId = 41000211,
			HyperLinkTextTable = LocalizationUtility.localizeTableName_Common,
			HyperLinkLogic = this
		};
	}

	void IConditionDescriptionHyperLink.OnClick()
	{
		if (IsActive && Model<SNSModel>.HasInstance() && Param is CheckSNSCompletedConditionParam checkSNSCompletedConditionParam)
		{
			SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(checkSNSCompletedConditionParam.snsId);
			if (session != null)
			{
				Model<SNSModel>.Interface.SetSpecificMsg(new SNSModel.SpecificMsg
				{
					ContactId = session.ContactsId,
					SessionId = checkSNSCompletedConditionParam.snsId
				}, needUnlock: true);
			}
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SNS, null, isneedinqueue: false).Forget();
		}
	}

	protected override async void OnInMissionWorld()
	{
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
		CheckSNSCompletedConditionParam checkSNSCompletedConditionParam = Param as CheckSNSCompletedConditionParam;
		if (Model<SNSModel>.Interface.GetSessionState(checkSNSCompletedConditionParam.snsId) != SNSModel.SnsSession.SessionState.Finish)
		{
			return false;
		}
		if (checkSNSCompletedConditionParam.waitBattleMain)
		{
			if (!Singleton<NewUIManager>.HasInstance())
			{
				return false;
			}
			IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
			if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_BATTLEMAIN && topActiveUI.State == UIState.Opened)
			{
				return true;
			}
			return false;
		}
		return true;
	}
}
