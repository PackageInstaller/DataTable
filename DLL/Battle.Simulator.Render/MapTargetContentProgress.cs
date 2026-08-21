using UnityEngine;
using UnityEngine.UI;

public class MapTargetContentProgress : MonoBehaviour
{
	public Animator animator;

	public Text content;

	public Text number1;

	public Text number2;

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

	public void SetNumber(string number1, string number2, bool playAnimation)
	{
		if (this.number1 != null)
		{
			this.number1.text = number1;
		}
		if (this.number2 != null)
		{
			this.number2.text = number2;
		}
		if (playAnimation && animator != null)
		{
			animator.Play(animtionStateName, 0, 0f);
		}
	}

	public void SetColor(Color color)
	{
		if (number1 != null)
		{
			number1.color = color;
		}
	}
}
