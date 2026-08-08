using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardHandTypeItem : MonoBehaviour
{
	public Text levelText;

	public Text nameText;

	public Text scoreText;

	public Text multiText;

	public Text useNumText;

	public ControllerExCollection mainEx;

	public Button btn;

	private ControllerEx selectCon;

	[HideInInspector]
	public int index;

	[HideInInspector]
	public HandType type;

	public void Init(int index, Action<int> onclickFunc)
	{
		selectCon = mainEx.GetController("select");
		this.index = index;
		btn.RemoveAllListener();
		btn.onClick.AddListener(delegate
		{
			onclickFunc(this.index);
		});
	}

	public void SetData(HandType type, int level, string name, int score, int multi, int useNum)
	{
		this.type = type;
		levelText.text = level.ToString();
		nameText.text = name;
		scoreText.text = score.ToString();
		multiText.text = multi.ToString();
		useNumText.text = useNum.ToString();
	}

	public void SetSelect(bool isSelect)
	{
		selectCon.SetSelectedState(isSelect ? "on" : "off");
	}

	public void SetActive(bool isActive)
	{
		base.gameObject.SetActive(isActive);
	}
}
