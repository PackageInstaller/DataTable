using UnityEngine;
using UnityEngine.UI;

public class MapTargetContentProgressSlider : MonoBehaviour
{
	public Animator animator;

	public Text content;

	public Slider slider;

	public Text precent;

	public string animtionStateName;

	public void SetContent(string content, bool playAnimation)
	{
		if (this.content != null)
		{
			this.content.text = content;
		}
		if (playAnimation && animator != null)
		{
			animator.Play(animtionStateName, 0, 0f);
		}
	}

	public void SetProgress(long number1, long number2, bool playAnimation)
	{
		if (number2 != 0L)
		{
			float value = (float)number1 / (float)number2;
			int value2 = (int)(number1 * 100 / number2);
			if (precent != null)
			{
				precent.text = CommonString.GetNumbers(value2);
			}
			if (slider != null)
			{
				slider.value = value;
			}
			if (playAnimation && animator != null)
			{
				animator.Play(animtionStateName, 0, 0f);
			}
		}
	}
}
