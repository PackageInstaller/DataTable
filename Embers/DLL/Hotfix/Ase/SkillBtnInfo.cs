using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillBtnInfo : MonoBehaviour
{
	public LoadUISprite icon;

	public Button btn;

	public new TextMeshProUGUI tag;

	public HeroSkillTypeEnum key;

	public RectTransform pos;

	private bool isInit;

	private Action<SkillBtnInfo> select;

	public void Init(Action<SkillBtnInfo> action)
	{
		if (!isInit)
		{
			isInit = true;
			select = action;
		}
	}

	private void Start()
	{
		btn.onClick.AddListener(OnClick);
	}

	public async void LoadImg(string iconName)
	{
		icon.Path = "ItemIcons/Skill/" + iconName;
	}

	public void UpdateTag(string tagName)
	{
		if ((UnityEngine.Object)(object)tag != null)
		{
			((TMP_Text)tag).text = tagName;
		}
	}

	private void OnClick()
	{
		select?.Invoke(this);
	}
}
