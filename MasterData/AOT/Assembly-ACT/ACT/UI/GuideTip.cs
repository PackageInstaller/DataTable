using ACT.Utility;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class GuideTip : BaseTip
{
	public static GuideTip guideTipInstance;

	public LocalizeStringEvent contentTextLocalize;

	private GuideTipData data;

	public override void OnGet()
	{
		base.OnGet();
		guideTipInstance = this;
		data = m_Data as GuideTipData;
		if (data != null)
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
	}

	private void UpdateText()
	{
		contentTextLocalize.SetTable(data.tableName);
		contentTextLocalize.StringReference.TableEntryReference = data.localizeId;
		if (data.variableList != null && data.variableList.Count > 0)
		{
			contentTextLocalize.StringReference.GetVariable<string>("0").Value = data.variableList[0];
		}
	}

	protected override void Update()
	{
	}
}
