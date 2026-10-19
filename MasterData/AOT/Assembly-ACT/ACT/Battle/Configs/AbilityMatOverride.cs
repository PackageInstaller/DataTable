using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AbilityMatOverride : BaseAbilityMixin
{
	private ConfigMixinMatOverride m_Config;

	private Material _appliedMaterial;

	private AnimationCurve animationCurve;

	private float startTime;

	private Color startColor;

	public AbilityMatOverride(ConfigMixinMatOverride config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinMatOverride)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		_appliedMaterial = null;
		animationCurve = null;
		startTime = 0f;
		startColor = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		MonoEntity mono = owner.GetMono();
		if (mono.materialOverride == null)
		{
			return;
		}
		if (mono.materialOverride._MatList == null)
		{
			mono.materialOverride._MatList = new List<Material>();
		}
		ConfigCharacter config = owner.GetConfig();
		Material material = null;
		switch (m_Config.matType)
		{
		case ConfigMixinMatOverride.MatType.Custom:
			if (m_Config.material != null && m_Config.material.ContainsKey(config.monsterWeigtType))
			{
				material = m_Config.material[config.monsterWeigtType];
			}
			break;
		case ConfigMixinMatOverride.MatType.Preset:
		{
			int uintmaterialPreset = (int)m_Config.uintmaterialPreset;
			switch (config.monsterWeigtType)
			{
			case MonsterWeigtType.Normal:
				material = GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material1;
				break;
			case MonsterWeigtType.Big:
				material = GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material2;
				break;
			case MonsterWeigtType.Giant:
				material = GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material3;
				break;
			case MonsterWeigtType.Small:
				material = GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material4;
				break;
			case MonsterWeigtType.Middle:
				material = GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material5;
				break;
			}
			break;
		}
		}
		if (material != null && !mono.materialOverride._MatList.Contains(material))
		{
			mono.materialOverride._MatList.Add(material);
			_appliedMaterial = material;
			startTime = Time.time;
			if (m_Config.matType == ConfigMixinMatOverride.MatType.Custom)
			{
				animationCurve = m_Config.customCurve;
			}
			else if (m_Config.matType == ConfigMixinMatOverride.MatType.Preset)
			{
				try
				{
					int uintmaterialPreset2 = (int)m_Config.uintmaterialPreset;
					CurveLibrary curveLibrary = GameLoader.meta?.curveLibrary;
					if (curveLibrary != null && curveLibrary.matOverrides != null && uintmaterialPreset2 >= 0 && uintmaterialPreset2 < curveLibrary.matOverrides.Count)
					{
						animationCurve = curveLibrary.matOverrides[uintmaterialPreset2].animationCurve;
					}
					else
					{
						animationCurve = null;
					}
				}
				catch
				{
					animationCurve = null;
				}
			}
		}
		startColor = mono.materialOverride._CustomBufferColor;
	}

	internal override void Update()
	{
		if (!owner.IsValid)
		{
			MonoEntity mono = owner.GetMono();
			if ((object)mono != null && !(mono.materialOverride == null) && m_Config != null && animationCurve != null)
			{
				float time = Time.time - startTime;
				float a = animationCurve.Evaluate(time);
				Color white = Color.white;
				white.a = a;
				mono.materialOverride._CustomBufferColor = white;
			}
		}
	}

	internal override void OnRemove()
	{
		MonoEntity mono = owner.GetMono();
		if ((object)mono == null || mono.materialOverride == null || mono.materialOverride._MatList == null)
		{
			return;
		}
		Material appliedMaterial = _appliedMaterial;
		if (appliedMaterial == null)
		{
			ConfigCharacter config = owner.GetConfig();
			switch (m_Config.matType)
			{
			case ConfigMixinMatOverride.MatType.Custom:
				if (m_Config.material != null && m_Config.material.ContainsKey(config.monsterWeigtType))
				{
					appliedMaterial = m_Config.material[config.monsterWeigtType];
				}
				break;
			case ConfigMixinMatOverride.MatType.Preset:
			{
				int uintmaterialPreset = (int)m_Config.uintmaterialPreset;
				appliedMaterial = config.monsterWeigtType switch
				{
					MonsterWeigtType.Normal => GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material1, 
					MonsterWeigtType.Big => GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material2, 
					MonsterWeigtType.Giant => GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material3, 
					MonsterWeigtType.Small => GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material4, 
					MonsterWeigtType.Middle => GameLoader.meta.curveLibrary.matOverrides[uintmaterialPreset].material5, 
					_ => appliedMaterial, 
				};
				break;
			}
			}
		}
		else
		{
			if (mono.materialOverride._MatList.Contains(appliedMaterial))
			{
				mono.materialOverride._MatList.Remove(appliedMaterial);
			}
			_appliedMaterial = null;
		}
	}
}
