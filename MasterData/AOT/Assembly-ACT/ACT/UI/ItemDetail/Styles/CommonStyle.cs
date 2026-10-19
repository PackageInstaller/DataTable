using System;
using ACT.UI.ItemDetail.Interface;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public sealed class CommonStyle : IStyle
{
	public GameObject[] qualityStyles;

	public GameObject[] qualityStylesPart;

	public LocalizeStringEvent name;

	public EquipGemIsLockBtn lockBtn;

	public OperateBtnPrompt lockOperateBtnPrompt;

	public BImage itemIcon;

	[Header("子标题")]
	public GameObject typeRoot;

	public GameObject typeIconRoot;

	public BImage typeIcon;

	public LocalizeStringEvent typeText;

	[Header("等级相关")]
	public GameObject levelRoot;

	public GameObject[] levelStyles;

	public CommonNumberComponent lvNumberComponent;

	[Header("数量相关")]
	public GameObject numberRoot;

	public CommonNumberComponent numberComponent;

	[Header("时效性道具相关")]
	public GameObject limitTimeRoot;

	public LocalizeStringEvent limitTimeDes;

	public GameObject disuseRoot;

	public void Reset()
	{
		levelRoot.SetActive(value: false);
		typeRoot.SetActive(value: true);
		lvNumberComponent.totalText.gameObject.SetActive(value: true);
		lvNumberComponent.slashText.gameObject.SetActive(value: true);
		lvNumberComponent.numberText.gameObject.SetActive(value: true);
		numberRoot.SetActive(value: false);
		numberComponent.totalText.gameObject.SetActive(value: true);
		numberComponent.slashText.gameObject.SetActive(value: true);
		numberComponent.numberText.gameObject.SetActive(value: true);
		lockBtn.gameObject.SetActive(value: false);
		limitTimeRoot?.SetActive(value: false);
		disuseRoot?.SetActive(value: false);
	}

	public void Release()
	{
	}
}
