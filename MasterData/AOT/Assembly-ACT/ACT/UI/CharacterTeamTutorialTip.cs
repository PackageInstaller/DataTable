using ACT.Utility;
using Fundamental;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CharacterTeamTutorialTip : BaseTip
{
	private CharacterTeamTutorialTipData data;

	public LocalizeStringEvent tip;

	public void CloseGuideTip()
	{
		Singleton<TipManager>.instance.OnTipClose(this);
	}

	public override void OnGet()
	{
		base.OnGet();
		data = m_Data as CharacterTeamTutorialTipData;
		remainTime = data.stayTime;
		if (data != null && data.targetMidText != 0)
		{
			UpdateText();
		}
	}

	public override void OnShow()
	{
		base.OnShow();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenAnimationFinish();
			}).Play();
		}
		else
		{
			OpenAnimationFinish();
		}
	}

	public override void OnHide()
	{
		base.OnHide();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseAnimationFinish();
			}).Play();
		}
		else
		{
			CloseAnimationFinish();
		}
	}

	private void UpdateText()
	{
		tip.SetTable(data.tableName);
		tip.StringReference.TableEntryReference = data.targetMidText;
		if (data.variableList != null && data.variableList.Count > 0)
		{
			tip.StringReference.GetVariable<string>("0").Value = data.variableList[0];
		}
	}
}
