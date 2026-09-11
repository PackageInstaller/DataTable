using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardFlyNumberUI : MonoBehaviour
{
	public ControllerExCollection mainEx;

	private ControllerEx stateCon;

	private ControllerEx fireCon;

	private bool _init;

	[SerializeField]
	private Text scoreText;

	[SerializeField]
	private Text scoreShadowText;

	[SerializeField]
	private Text multiText;

	[SerializeField]
	private Text multiShadowText;

	[SerializeField]
	private Text normalText;

	[SerializeField]
	private Text normalShadowText;

	public void Init()
	{
		stateCon = mainEx.GetController("state");
		fireCon = mainEx.GetController("fire");
		_init = true;
	}

	public void ShowFlyText(string text, FlyNumberType type)
	{
		if (_init)
		{
			switch (type)
			{
			case FlyNumberType.Score:
				stateCon.SetSelectedIndex(0);
				scoreText.text = text;
				scoreShadowText.text = text;
				break;
			case FlyNumberType.Multi:
				stateCon.SetSelectedIndex(1);
				multiText.text = text;
				multiShadowText.text = text;
				break;
			case FlyNumberType.Normal:
				stateCon.SetSelectedIndex(2);
				normalText.text = text;
				normalShadowText.text = text;
				break;
			}
			base.gameObject.SetActive(value: false);
			base.gameObject.SetActive(value: true);
		}
	}

	public void HideText()
	{
		base.gameObject.SetActive(value: false);
	}
}
