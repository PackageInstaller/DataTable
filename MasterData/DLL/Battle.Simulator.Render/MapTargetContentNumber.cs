using UnityEngine;
using UnityEngine.UI;

public class MapTargetContentNumber : MonoBehaviour
{
	public Animator animator;

	public Text content;

	public Text number;

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

	public void SetNumber(string number, bool playAnimation)
	{
		if (this.number != null)
		{
			this.number.text = number;
		}
		if (playAnimation && animator != null)
		{
			animator.Play(animtionStateName, 0, 0f);
		}
	}

	public void SetColor(Color color)
	{
		if (number != null)
		{
			number.color = color;
		}
	}
}
