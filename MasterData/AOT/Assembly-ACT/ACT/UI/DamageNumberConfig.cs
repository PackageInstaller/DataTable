using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class DamageNumberConfig : LuminSerializedScriptableObject
{
	[Space(10f)]
	public float mobileSize = 1f;

	[Space(10f)]
	public Dictionary<DmgNumStyle, StyleAnimation> styleAnimations = new Dictionary<DmgNumStyle, StyleAnimation>();

	[Space(10f)]
	public Dictionary<Element, ElementColor> elementDamageNumberColor = new Dictionary<Element, ElementColor>();

	[Space(10f)]
	public Dictionary<EntityType, float> entityScale = new Dictionary<EntityType, float>();

	[Space(10f)]
	public float randomOffsetX;

	[Space(10f)]
	public float randomOffsetY;

	[Space(10f)]
	public Dictionary<MonsterWeigtType, SpawnNumPositionConfig> normalPositionConfigs = new Dictionary<MonsterWeigtType, SpawnNumPositionConfig>();

	[Space(10f)]
	public SpawnNumPositionConfig buffPositionConfig;

	[Space(10f)]
	public SpawnNumPositionConfig deBuffPositionConfig;

	[Space(30f)]
	[Space(10f)]
	public Sprite[] healNumSprites;

	[Space(10f)]
	public Color healNumColor;

	[Space(10f)]
	public Sprite[] sacrificeSprites;

	[Space(10f)]
	public Color sacrificeColor;

	[Space(10f)]
	public Dictionary<int, Sprite[]> comboNumEffectSprites;

	[Space(10f)]
	public Dictionary<int, Sprite[]> comboNumNormalSprites;

	public bool TryGetStyleAnimation(DmgNumStyle style, out StyleAnimation styleAnimation)
	{
		return styleAnimations.TryGetValue(style, out styleAnimation);
	}

	public bool TryGetNormalPositionConfigs(MonsterWeigtType type, out SpawnNumPositionConfig config)
	{
		return normalPositionConfigs.TryGetValue(type, out config);
	}

	public Sprite[] GetNumSprites(Element element)
	{
		if (elementDamageNumberColor.TryGetValue(element, out var value))
		{
			return value.numSprites;
		}
		return elementDamageNumberColor.Values.First().numSprites;
	}

	public WeakColor GetWeakColor(Element element)
	{
		if (elementDamageNumberColor.TryGetValue(element, out var value))
		{
			return value.weakColor;
		}
		return WeakColor.Null;
	}

	public CriticalGlowColor GetCriticalGlowColor(Element element)
	{
		if (elementDamageNumberColor.TryGetValue(element, out var value))
		{
			return value.criticalGlowColor;
		}
		return CriticalGlowColor.Null;
	}

	public (Sprite icon1, Sprite icon2) GetCriticalIcon(Element element)
	{
		if (elementDamageNumberColor.TryGetValue(element, out var value))
		{
			return (icon1: value.criticalIcon1, icon2: value.criticalIcon2);
		}
		return (icon1: null, icon2: null);
	}

	public Sprite GetDotIcon(Element element, int dotId)
	{
		if (elementDamageNumberColor.TryGetValue(element, out var value) && value.dotIcon.TryGetValue(dotId, out var value2))
		{
			return value2;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"跳字要显示 {dotId} 的dot伤害图标，但是没有找到");
		}
		return null;
	}

	public Sprite GetMannerIcon(Element element, MannerType mannerType)
	{
		if (elementDamageNumberColor.TryGetValue(element, out var value) && value.mannerIcon.TryGetValue(mannerType, out var value2))
		{
			return value2;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"跳字要显示 {mannerType} 的风格伤害图标，但是没有找到");
		}
		return null;
	}
}
