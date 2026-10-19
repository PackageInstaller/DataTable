using System.Collections.Generic;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class TextLibraryReadCondition : MissionCondition, IConditionDescriptionHyperLink
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
			HyperLinkLogic = this
		};
	}

	void IConditionDescriptionHyperLink.OnClick()
	{
		if (IsActive)
		{
			OpenReadableViewConditionParam openReadableViewConditionParam = Param as OpenReadableViewConditionParam;
			ReadableViewData uiData = new ReadableViewData
			{
				id = openReadableViewConditionParam.textLibraryContentId
			};
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_READABLE, uiData);
		}
	}

	protected override async void OnInMissionWorld()
	{
		if (!TryGetParam(out var _))
		{
			return;
		}
		while (InMissionWorld)
		{
			if (CheckCondition() && CurrentInBattleMain())
			{
				await MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		if (!TryGetParam(out var param) || !Model<TextLibraryModel>.HasInstance())
		{
			return false;
		}
		return Model<TextLibraryModel>.Interface.TextLibraryIsRead(param.textLibraryContentId);
	}

	private bool CurrentInBattleMain()
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
		return true;
	}

	private bool TryGetParam(out TextLibraryReadConditionParam param)
	{
		param = Param as TextLibraryReadConditionParam;
		return param != null;
	}
}
