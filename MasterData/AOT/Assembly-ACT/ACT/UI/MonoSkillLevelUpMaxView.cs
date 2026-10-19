using System.Collections.Generic;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;

namespace ACT.UI;

public class MonoSkillLevelUpMaxView : BaseUIView
{
	public class SkillLevelUpMaxData : UIViewData
	{
		public int iconId;

		public int titleId;

		public int levelAfter;

		public List<(int, int, int)> itemData;
	}

	public BImage icon;

	public TextMeshProUGUI fromLevel;

	public TextMeshProUGUI toLevel;

	protected override void Init()
	{
		base.Init();
		SkillLevelUpMaxData skillLevelUpMaxData = (SkillLevelUpMaxData)uiViewData;
		toLevel.text = skillLevelUpMaxData.levelAfter.ToString();
		ListPool<(int, int, int)>.Release(skillLevelUpMaxData.itemData);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("SkillSuccessShow");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("SkillSuccessHide");
	}
}
