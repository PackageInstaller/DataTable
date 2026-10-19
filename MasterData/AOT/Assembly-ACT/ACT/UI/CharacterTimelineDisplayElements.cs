using System;
using System.Collections.Generic;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

[Serializable]
public class CharacterTimelineDisplayElements
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

	[Header("Right")]
	public List<AcquireCharacterShowExtraItem> extraItems = new List<AcquireCharacterShowExtraItem>();
}
