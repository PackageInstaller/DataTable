using System;
using System.Collections.Generic;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

[Serializable]
public class CharacterDisplayElements
{
	[Header("Left")]
	public LocalizeStringEvent textName;

	public BImage imageName;

	public List<GameObject> starList;

	public GameObject goNew;

	public CharacterProfessionIcon imageProfession;

	public BImage imageInfluences;

	[Header("Mid")]
	public BImage characterImage;

	[Header("Right")]
	public List<AcquireCharacterShowExtraItem> extraItems;

	[Header("Quality")]
	public BImage ImageQuality;

	public GameObject EffectQualityS;

	public GameObject EffectQualityA;

	[Header("Character Background")]
	public BImage characterBgImage;
}
