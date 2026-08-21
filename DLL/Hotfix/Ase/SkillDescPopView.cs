using Ase.ECS;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class SkillDescPopView : UIView
{
	public new TextMeshProUGUI name;

	public TextMeshProUGUI resume;

	public new TextMeshProUGUI tag;

	public TextMeshProUGUI desc;

	[SerializeField]
	private SkillDescAutoFit autoFit;

	public void Init(HeroSkillData skill, RectTransform parent)
	{
		((TMP_Text)name).text = skill.Name;
		((TMP_Text)tag).text = skill.SkillTag;
		((TMP_Text)desc).text = skill.SimpleDesc;
		base.transform.SetParent(parent);
		GetComponent<RectTransform>().anchoredPosition = new Vector2(0f, 0f);
		CanvasGroup.alpha = 0f;
		autoFit.UpdateDesc();
		autoFit.AddOnShow(OnShow);
	}

	private void OnShow()
	{
		CanvasGroup.alpha = 1f;
	}
}
