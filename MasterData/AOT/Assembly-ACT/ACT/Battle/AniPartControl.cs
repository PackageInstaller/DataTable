using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class AniPartControl : LuminSerializedMonoBehaviour
{
	public enum PartType
	{
		WeaponDissolve,
		Weapon2,
		Weapon1EdgeLight,
		Weapon2EdgeLight,
		BP,
		SwitchRoleDissolve,
		FishBait,
		Dither,
		GetHit,
		SuperEndure,
		LightHit,
		Dissolve,
		Role_01_01_WeaponAnipart,
		Role_27_01_WeaponAnipart,
		RoleChangeShow,
		RoleChangeHide,
		RoleSwitchSKillChangeShow,
		RoleSwitchSKillChangeHide,
		EnemyDieGlitch,
		DedgeEffectSuccess,
		Role26Weapon1,
		Role26Weapon2,
		Role26Weapon3,
		EnemyDieDevourborne,
		CanDefenseEffect,
		Boss18EarthEruption,
		Boss18GroundImpact,
		RoleDieEffect,
		Boss_20_WingDissolve,
		Boss_MaterialOverride,
		SpecialEffect,
		SystemDither,
		SystemWeaponDither
	}

	public Renderer[] normalRender;

	public SkinnedMeshRenderer[] skinRenders;

	protected MonoEntity monoEntity;

	public bool hasEntity;

	private float entityLogicScale;

	public Dictionary<PartType, AniPart[]> aniParts = new Dictionary<PartType, AniPart[]>();

	public MaterialPropertyBlock propertyBlock;

	private readonly Dictionary<Renderer, MaterialPropertyBlock> m_PropertyBlocks = new Dictionary<Renderer, MaterialPropertyBlock>();

	private readonly List<Renderer> m_DirtyRenderers = new List<Renderer>();

	private readonly HashSet<Renderer> m_DirtyRendererSet = new HashSet<Renderer>();

	private readonly Dictionary<Renderer, Material[]> m_VisibilityMaterials = new Dictionary<Renderer, Material[]>();

	private readonly Dictionary<Renderer, CharacterVisibilityEffect> m_AppliedVisibility = new Dictionary<Renderer, CharacterVisibilityEffect>();

	private readonly Dictionary<Renderer, int> m_VisibilityHiddenCounts = new Dictionary<Renderer, int>();

	private readonly Dictionary<Renderer, int> m_VisibilityScores = new Dictionary<Renderer, int>();

	private readonly Dictionary<Renderer, CharacterVisibilityEffect> m_DesiredVisibility = new Dictionary<Renderer, CharacterVisibilityEffect>();

	private readonly List<Renderer> m_VisibilityCleanup = new List<Renderer>();

	internal MaterialPropertyBlock GetPropertyBlock(Renderer renderer)
	{
		if (!m_PropertyBlocks.TryGetValue(renderer, out var value))
		{
			value = new MaterialPropertyBlock();
			m_PropertyBlocks.Add(renderer, value);
		}
		if (m_DirtyRendererSet.Add(renderer))
		{
			value.Clear();
			renderer.GetPropertyBlock(value);
			m_DirtyRenderers.Add(renderer);
		}
		return value;
	}

	private void FlushPropertyBlocks()
	{
		for (int i = 0; i < m_DirtyRenderers.Count; i++)
		{
			Renderer renderer = m_DirtyRenderers[i];
			if (renderer != null)
			{
				renderer.SetPropertyBlock(m_PropertyBlocks[renderer]);
			}
		}
		m_DirtyRenderers.Clear();
		m_DirtyRendererSet.Clear();
	}

	public void ReSetMats()
	{
		if (aniParts == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		foreach (KeyValuePair<PartType, AniPart[]> aniPart2 in aniParts)
		{
			AniPart[] value = aniPart2.Value;
			foreach (AniPart aniPart in value)
			{
				try
				{
					aniPart.Init(this);
				}
				catch (Exception)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.Log(gameObject.name + " AniPartControl 初始化失败， 请检查！！！");
					}
				}
			}
		}
	}

	private void Awake()
	{
		propertyBlock = new MaterialPropertyBlock();
		ReSetMats();
		monoEntity = GetComponent<MonoEntity>();
		hasEntity = monoEntity != null;
		entityLogicScale = 1f;
	}

	private void OnDisable()
	{
		if (aniParts != null)
		{
			foreach (KeyValuePair<PartType, AniPart[]> aniPart2 in aniParts)
			{
				AniPart[] value = aniPart2.Value;
				foreach (AniPart aniPart in value)
				{
					if (aniPart.running)
					{
						aniPart.OnDisable();
					}
				}
			}
		}
		SettleVisibility();
		FlushPropertyBlocks();
	}

	private void LateUpdate()
	{
		if (aniParts == null)
		{
			FlushPropertyBlocks();
			return;
		}
		if (hasEntity)
		{
			if (monoEntity.entity.GetCompTime() != null)
			{
				entityLogicScale = monoEntity.entity.GetCompTime().logicScale;
			}
			else
			{
				entityLogicScale = 1f;
			}
		}
		foreach (KeyValuePair<PartType, AniPart[]> aniPart2 in aniParts)
		{
			AniPart[] value = aniPart2.Value;
			foreach (AniPart aniPart in value)
			{
				if (aniPart.running)
				{
					if (entityLogicScale != 0f && aniPart.needEntityLogicScale)
					{
						aniPart.UpdateCurPlaybackProgress(entityLogicScale);
					}
					else
					{
						aniPart.UpdateCurPlaybackProgress(1f);
					}
				}
			}
		}
		SettleVisibility();
		FlushPropertyBlocks();
	}

	public bool ForwardPlay(PartType part, float duration, Entity entity = default(Entity), Action callback = null, bool reset = false, bool needEntityLogicScale = false)
	{
		if (aniParts == null)
		{
			return false;
		}
		if (aniParts.TryGetValue(part, out var value))
		{
			AniPart[] array = value;
			foreach (AniPart aniPart in array)
			{
				aniPart.isShowing = true;
				aniPart.curVal = (reset ? 0f : aniPart.curVal);
				aniPart.showCb = callback;
				aniPart.needEntityLogicScale = needEntityLogicScale;
				if (duration <= 0f)
				{
					aniPart.CompletePlaybackImmediate(entity);
					continue;
				}
				aniPart.running = true;
				aniPart.speed = 1f / duration;
				aniPart.HandleForwardPlayStart(entity);
			}
			SettleVisibility();
			FlushPropertyBlocks();
			return true;
		}
		return false;
	}

	public bool BackwardPlay(PartType part, float duration, Entity entity = default(Entity), Action callback = null, bool reset = false, bool needEntityLogicScale = false)
	{
		if (aniParts == null)
		{
			return false;
		}
		if (aniParts.TryGetValue(part, out var value))
		{
			AniPart[] array = value;
			foreach (AniPart aniPart in array)
			{
				aniPart.isShowing = false;
				aniPart.curVal = (reset ? 1f : aniPart.curVal);
				aniPart.hideCb = callback;
				aniPart.needEntityLogicScale = needEntityLogicScale;
				if (duration <= 0f)
				{
					aniPart.CompletePlaybackImmediate(entity);
					continue;
				}
				aniPart.running = true;
				aniPart.speed = -1f / duration;
				aniPart.HandleBackWardPlayStart(entity);
			}
			SettleVisibility();
			FlushPropertyBlocks();
			return true;
		}
		return false;
	}

	public static bool IsVisibilityPart(PartType part)
	{
		switch (part)
		{
		case PartType.WeaponDissolve:
		case PartType.Weapon2:
		case PartType.SwitchRoleDissolve:
		case PartType.Dither:
		case PartType.Dissolve:
		case PartType.RoleDieEffect:
		case PartType.Boss_20_WingDissolve:
		case PartType.SystemDither:
			return true;
		default:
			return false;
		}
	}

	public bool PlayVisible(PartType part, float duration, Entity entity = default(Entity), Action callback = null, bool reset = false, bool needEntityLogicScale = false)
	{
		if (duration <= 0f)
		{
			bool result = ResetVisibilityToVisible(part);
			callback?.Invoke();
			return result;
		}
		return BackwardPlay(part, duration, entity, callback, reset, needEntityLogicScale);
	}

	public bool PlayHidden(PartType part, float duration, Entity entity = default(Entity), Action callback = null, bool reset = false, bool needEntityLogicScale = false)
	{
		return ForwardPlay(part, duration, entity, callback, reset, needEntityLogicScale);
	}

	public bool ResetVisibilityToVisible(PartType part)
	{
		if (aniParts == null)
		{
			return false;
		}
		if (!aniParts.TryGetValue(part, out var value))
		{
			return false;
		}
		AniPart[] array = value;
		for (int i = 0; i < array.Length; i++)
		{
			array[i]?.ResetToVisible();
		}
		SettleVisibility();
		FlushPropertyBlocks();
		return true;
	}

	internal void SetVisibilityRenderersHidden(IReadOnlyList<Renderer> renderers, bool hidden)
	{
		if (renderers == null)
		{
			return;
		}
		for (int i = 0; i < renderers.Count; i++)
		{
			Renderer renderer = renderers[i];
			if (renderer == null)
			{
				continue;
			}
			int value2;
			if (hidden)
			{
				if (!m_VisibilityHiddenCounts.TryGetValue(renderer, out var value))
				{
					value = 0;
				}
				value++;
				m_VisibilityHiddenCounts[renderer] = value;
				if (value == 1)
				{
					CharacterVisibilityDrawSkip.Add(renderer);
				}
			}
			else if (m_VisibilityHiddenCounts.TryGetValue(renderer, out value2))
			{
				value2--;
				if (value2 <= 0)
				{
					m_VisibilityHiddenCounts.Remove(renderer);
					CharacterVisibilityDrawSkip.Remove(renderer);
				}
				else
				{
					m_VisibilityHiddenCounts[renderer] = value2;
				}
			}
		}
	}

	private void SettleVisibility()
	{
		m_VisibilityScores.Clear();
		m_DesiredVisibility.Clear();
		if (aniParts != null)
		{
			foreach (KeyValuePair<PartType, AniPart[]> aniPart2 in aniParts)
			{
				if (aniPart2.Value == null)
				{
					continue;
				}
				AniPart[] value = aniPart2.Value;
				foreach (AniPart aniPart in value)
				{
					if (aniPart == null || !aniPart.TryGetVisibilityClaim(out var effect, out var isPlay))
					{
						continue;
					}
					IReadOnlyList<Renderer> visibilityRenderers = aniPart.VisibilityRenderers;
					if (visibilityRenderers == null)
					{
						continue;
					}
					int num = (int)((isPlay ? 10 : 0) + effect);
					for (int j = 0; j < visibilityRenderers.Count; j++)
					{
						Renderer renderer = visibilityRenderers[j];
						if (!(renderer == null) && (!m_VisibilityScores.TryGetValue(renderer, out var value2) || value2 < num))
						{
							m_VisibilityScores[renderer] = num;
							m_DesiredVisibility[renderer] = effect;
						}
					}
				}
			}
		}
		foreach (KeyValuePair<Renderer, CharacterVisibilityEffect> item in m_DesiredVisibility)
		{
			ApplyVisibility(item.Key, item.Value);
		}
		m_VisibilityCleanup.Clear();
		foreach (KeyValuePair<Renderer, CharacterVisibilityEffect> item2 in m_AppliedVisibility)
		{
			if (item2.Key == null || !m_DesiredVisibility.ContainsKey(item2.Key))
			{
				m_VisibilityCleanup.Add(item2.Key);
			}
		}
		for (int k = 0; k < m_VisibilityCleanup.Count; k++)
		{
			ApplyVisibility(m_VisibilityCleanup[k], CharacterVisibilityEffect.None);
		}
	}

	private void ApplyVisibility(Renderer renderer, CharacterVisibilityEffect effect)
	{
		if (renderer == null)
		{
			m_AppliedVisibility.Remove(renderer);
			return;
		}
		if (m_AppliedVisibility.TryGetValue(renderer, out var value) && value == effect)
		{
			if (effect != CharacterVisibilityEffect.Dither)
			{
				GetPropertyBlock(renderer).SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, 1f);
			}
			return;
		}
		Material[] cachedVisibilityMaterials = GetCachedVisibilityMaterials(renderer);
		if (cachedVisibilityMaterials != null)
		{
			foreach (Material material in cachedVisibilityMaterials)
			{
				if (!(material == null) && !CharacterVisibilityMaterialState.SetEffect(material, effect))
				{
					VisibilityMaterialKeywords.SetEffectKeywords(material, effect);
				}
			}
		}
		if (effect == CharacterVisibilityEffect.None)
		{
			m_AppliedVisibility.Remove(renderer);
		}
		else
		{
			m_AppliedVisibility[renderer] = effect;
		}
		if (effect != CharacterVisibilityEffect.Dither)
		{
			GetPropertyBlock(renderer).SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, 1f);
		}
	}

	private Material[] GetCachedVisibilityMaterials(Renderer renderer)
	{
		if (m_VisibilityMaterials.TryGetValue(renderer, out var value) && value != null)
		{
			return value;
		}
		value = renderer.materials;
		m_VisibilityMaterials[renderer] = value;
		return value;
	}

	public void EnablePartRenderers(PartType part, bool enable)
	{
		if (aniParts != null && aniParts.TryGetValue(part, out var value))
		{
			AniPart[] array = value;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].EnableRenderers(enable);
			}
		}
	}

	private void OnDestroy()
	{
		foreach (KeyValuePair<Renderer, int> visibilityHiddenCount in m_VisibilityHiddenCounts)
		{
			if (visibilityHiddenCount.Key != null)
			{
				CharacterVisibilityDrawSkip.Remove(visibilityHiddenCount.Key, visibilityHiddenCount.Value);
			}
		}
		if (Application.isPlaying)
		{
			foreach (Material[] value in m_VisibilityMaterials.Values)
			{
				if (value == null)
				{
					continue;
				}
				foreach (Material material in value)
				{
					if (material != null)
					{
						UnityEngine.Object.Destroy(material);
					}
				}
			}
		}
		m_PropertyBlocks.Clear();
		m_DirtyRenderers.Clear();
		m_DirtyRendererSet.Clear();
		m_VisibilityMaterials.Clear();
		m_AppliedVisibility.Clear();
		m_VisibilityHiddenCounts.Clear();
		propertyBlock?.Clear();
	}
}
