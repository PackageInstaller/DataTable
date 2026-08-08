using UnityEngine;
using UnityEngine.UI;

public class TeachSkillItem : MonoBehaviour
{
	public Animator animator;

	public string successAnimatorStateName = "aniTeachSkills_skillLayout";

	public string failedAnimatorStateName = "aniTeachSkills_no";

	public string missAnimatorStateName = "aniTeachSkills_miss";

	public Image icon;

	public Image progress;

	public Text skillName;

	public int index;

	public GameObject loop;

	public void PlayAnimaton(bool success, bool miss)
	{
		if (loop != null)
		{
			loop.SetActive(value: false);
		}
		if (!(animator == null))
		{
			if (success)
			{
				animator.Play(successAnimatorStateName, 0, 0f);
			}
			else if (!miss)
			{
				animator.Play(failedAnimatorStateName, 0, 0f);
			}
			else
			{
				animator.Play(missAnimatorStateName, 0, 0f);
			}
		}
	}

	public void Init(Sprite spriteIcon, bool hasProgress, int index, string name)
	{
		if (icon != null)
		{
			icon.sprite = spriteIcon;
		}
		if (progress != null)
		{
			progress.gameObject.SetActive(hasProgress);
			progress.fillAmount = 0f;
		}
		this.index = index;
		skillName.text = name;
	}
}
