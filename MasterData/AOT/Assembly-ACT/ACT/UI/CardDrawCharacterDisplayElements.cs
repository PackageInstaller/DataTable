using System;
using System.Collections.Generic;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

[Serializable]
public class CardDrawCharacterDisplayElements
{
	[Header("CharacterRoot")]
	public GameObject CharacterRoot;

	[Header("Left")]
	public LocalizeStringEvent textName;

	public BImage imageName;

	public GameObject goNew;

	public CharacterProfessionIcon imageProfession;

	public CharacterMannerItem MannerItem;

	public List<GameObject> CharacterQualityList = new List<GameObject>();

	[Header("Mid")]
	public BImage characterImage;

	[Header("ItemRoot")]
	public GameObject ItemRoot;

	public LocalizeStringEvent TextItemName;

	public TextMeshProUGUI TextItemNum;

	public List<GameObject> QualityList = new List<GameObject>();

	[Header("Mid")]
	public BImage ItemImage;

	[Header("Right")]
	public List<AcquireCharacterShowExtraItem> extraItems;

	[Header("Quality")]
	public BImage ImageQuality;

	[Header("Background")]
	public GameObject GoBgRoot;
}
