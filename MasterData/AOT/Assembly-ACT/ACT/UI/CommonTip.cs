using ACT.Utility;
using Fundamental;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CommonTip : BaseTip
{
	public LocalizeStringEvent contentTextLocalize;

	private CommonTipData commonTipData;

	private CommonStringTip commonStringTip;

	private CommonLocalizedStringTip commonLocalizedStringTip;

	public override void OnGet()
	{
		base.OnGet();
		this.commonStringTip = null;
		this.commonTipData = null;
		this.commonLocalizedStringTip = null;
		if (m_Data is CommonTipData commonTipData)
		{
			this.commonTipData = commonTipData;
		}
		else if (m_Data is CommonStringTip commonStringTip)
		{
			this.commonStringTip = commonStringTip;
		}
		else if (m_Data is CommonLocalizedStringTip commonLocalizedStringTip)
		{
			this.commonLocalizedStringTip = commonLocalizedStringTip;
		}
		if (this.commonTipData != null)
		{
			UpdateLocalizeText();
		}
		else if (this.commonStringTip != null)
		{
			UpdateCommonText();
		}
		else if (this.commonLocalizedStringTip != null)
		{
			UpdateLocalizeStringText();
		}
	}

	public override void OnShow()
	{
		base.OnShow();
		tipAnimator.Play("CommonTipShow", 0, 0f);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Tip");
	}

	public override void OnHide()
	{
		base.OnHide();
		tipAnimator.Play("CommonTipHide", 0, 0f);
	}

	private void UpdateLocalizeText()
	{
		contentTextLocalize.SetTable(commonTipData.tableName);
		contentTextLocalize.StringReference.TableEntryReference = commonTipData.localizeId;
		if (commonTipData.variableList != null && commonTipData.variableList.Count > 0)
		{
			contentTextLocalize.StringReference.GetVariable<string>("0").Value = commonTipData.variableList[0];
		}
	}

	private void UpdateCommonText()
	{
		contentTextLocalize.OnUpdateString?.Invoke(commonStringTip.content);
	}

	private void UpdateLocalizeStringText()
	{
		contentTextLocalize.StringReference = commonLocalizedStringTip.content;
	}
}
