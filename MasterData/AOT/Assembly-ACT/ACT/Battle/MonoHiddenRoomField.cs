using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.World;
using Bamboo.ECS;
using DG.Tweening;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class MonoHiddenRoomField : MonoTriggerEvent
{
	public MeshRenderer[] meshRenderers;

	[Header("Dither值")]
	public float value;

	[Header("过渡时间")]
	public float duration = 1f;

	public List<BoxCollider> boxColliders;

	public bool overrideSize;

	private Dictionary<Collider, List<ITrigger>> m_DicAllColliders = new Dictionary<Collider, List<ITrigger>>();

	private Dictionary<ITrigger, List<Collider>> m_DicTriggerColliders = new Dictionary<ITrigger, List<Collider>>();

	private MaterialPropertyBlock m_Block;

	private readonly List<Material> m_RuntimeMaterials = new List<Material>();

	private bool m_DitherKeywordEnabled;

	private readonly List<MonoTrigger> m_TriggerProxies = new List<MonoTrigger>();

	private float TweenDuration => Mathf.Max(duration, 0.0001f);

	private void InitializeMaterials()
	{
		if (meshRenderers == null)
		{
			return;
		}
		for (int i = 0; i < meshRenderers.Length; i++)
		{
			MeshRenderer meshRenderer = meshRenderers[i];
			if (meshRenderer == null)
			{
				continue;
			}
			Material[] materials = meshRenderer.materials;
			foreach (Material material in materials)
			{
				if (!(material == null))
				{
					if (!m_RuntimeMaterials.Contains(material))
					{
						m_RuntimeMaterials.Add(material);
					}
					ToonGenericMaterialState.SetDitherEnabled(material, enabled: false);
				}
			}
		}
		ApplyDitherToMeshRenderers(1f);
	}

	private void SetDitherKeyword(bool enabled)
	{
		if (!enabled)
		{
			ApplyDitherToMeshRenderers(1f);
		}
		if (m_DitherKeywordEnabled != enabled)
		{
			m_DitherKeywordEnabled = enabled;
			for (int i = 0; i < m_RuntimeMaterials.Count; i++)
			{
				ToonGenericMaterialState.SetDitherEnabled(m_RuntimeMaterials[i], enabled);
			}
		}
	}

	private void EnsureMaterialPropertyBlock()
	{
		if (m_Block == null)
		{
			m_Block = new MaterialPropertyBlock();
		}
	}

	private void ApplyDitherToMeshRenderers(float ditherValue)
	{
		EnsureMaterialPropertyBlock();
		if (meshRenderers == null)
		{
			return;
		}
		for (int i = 0; i < meshRenderers.Length; i++)
		{
			MeshRenderer meshRenderer = meshRenderers[i];
			if (meshRenderer != null)
			{
				m_Block.Clear();
				meshRenderer.GetPropertyBlock(m_Block);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, ditherValue);
				meshRenderer.SetPropertyBlock(m_Block);
			}
		}
	}

	private void KillDitherTween()
	{
		DOTween.Kill(this);
	}

	private void RemoveColliderHiddenRoomTracking(Collider collider)
	{
		if (collider == null || m_DicTriggerColliders.Count == 0)
		{
			return;
		}
		List<ITrigger> list = new List<ITrigger>(m_DicTriggerColliders.Keys);
		for (int i = 0; i < list.Count; i++)
		{
			ITrigger key = list[i];
			if (m_DicTriggerColliders.TryGetValue(key, out var list2) && list2.Remove(collider) && list2.Count == 0)
			{
				m_DicTriggerColliders.Remove(key);
			}
		}
	}

	private bool IsCharacterCollider(Collider collider)
	{
		if (collider == null)
		{
			return false;
		}
		bool? flag = collider.GetComponent<MonoEntity>()?.entity.IsCharacter();
		if (flag.HasValue)
		{
			return flag.Value;
		}
		return false;
	}

	private void RemoveCharacterOccupantsFromFieldTracking()
	{
		if (m_DicTriggerColliders.Count > 0)
		{
			List<ITrigger> list = new List<ITrigger>(m_DicTriggerColliders.Keys);
			for (int i = 0; i < list.Count; i++)
			{
				ITrigger key = list[i];
				if (!m_DicTriggerColliders.TryGetValue(key, out var list2))
				{
					continue;
				}
				for (int num = list2.Count - 1; num >= 0; num--)
				{
					Collider collider = list2[num];
					if (collider == null || IsCharacterCollider(collider))
					{
						list2.RemoveAt(num);
					}
				}
				if (list2.Count == 0)
				{
					m_DicTriggerColliders.Remove(key);
				}
			}
		}
		if (m_DicAllColliders.Count <= 0)
		{
			return;
		}
		List<Collider> list3 = new List<Collider>(m_DicAllColliders.Keys);
		for (int j = 0; j < list3.Count; j++)
		{
			Collider collider2 = list3[j];
			if (collider2 == null || IsCharacterCollider(collider2))
			{
				m_DicAllColliders.Remove(collider2);
			}
		}
	}

	public void Start()
	{
		InitializeMaterials();
		EnsureMaterialPropertyBlock();
		if (boxColliders != null)
		{
			foreach (BoxCollider boxCollider in boxColliders)
			{
				if (boxCollider != null)
				{
					MonoTrigger monoTrigger = boxCollider.gameObject.AddComponent<MonoTrigger>();
					m_TriggerProxies.Add(monoTrigger);
					monoTrigger.triggerEnter = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerEnter, new Action<Collider, ITrigger>(TriggerEnter));
					monoTrigger.triggerExit = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerExit, new Action<Collider, ITrigger>(TriggerExit));
					monoTrigger.triggerExitEvt = (Action)Delegate.Combine(monoTrigger.triggerExitEvt, new Action(TriggerExitEvt));
				}
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ObjectEnableHiddenRoomTrigger, OnObjectEnableHiddenRoomTrigger);
	}

	private void OnObjectEnableHiddenRoomTrigger(BaseEventContent obj)
	{
		if (!(obj is ObjectEnableHiddenRoomTriggerEvent objectEnableHiddenRoomTriggerEvent) || objectEnableHiddenRoomTriggerEvent.collider == null)
		{
			return;
		}
		if (!objectEnableHiddenRoomTriggerEvent.enable)
		{
			RemoveColliderHiddenRoomTracking(objectEnableHiddenRoomTriggerEvent.collider);
			if (m_DicTriggerColliders.Count == 0)
			{
				KillDitherTween();
				SetDitherKeyword(enabled: true);
				DOTween.To(() => value, ApplyDitherToMeshRenderers, 1f, TweenDuration).SetId(this).OnComplete(() =>
				{
					SetDitherKeyword(enabled: false);
				});
			}
		}
		else
		{
			if (!m_DicAllColliders.TryGetValue(objectEnableHiddenRoomTriggerEvent.collider, out var list))
			{
				return;
			}
			foreach (ITrigger item in list)
			{
				if (item != null)
				{
					if (!m_DicTriggerColliders.ContainsKey(item))
					{
						m_DicTriggerColliders.Add(item, new List<Collider>());
					}
					List<Collider> list2 = m_DicTriggerColliders[item];
					if (!list2.Contains(objectEnableHiddenRoomTriggerEvent.collider))
					{
						list2.Add(objectEnableHiddenRoomTriggerEvent.collider);
					}
				}
			}
			if (m_DicTriggerColliders.Count == 1)
			{
				KillDitherTween();
				SetDitherKeyword(enabled: true);
				DOTween.To(() =>
				{
					EnsureMaterialPropertyBlock();
					return m_Block.GetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER);
				}, ApplyDitherToMeshRenderers, value, TweenDuration).SetId(this);
			}
		}
	}

	private void TriggerEnter(Collider collider, ITrigger trigger)
	{
		if (collider == null || trigger == null)
		{
			return;
		}
		if (!m_DicAllColliders.ContainsKey(collider))
		{
			m_DicAllColliders.Add(collider, new List<ITrigger>());
		}
		List<ITrigger> list = m_DicAllColliders[collider];
		if (!list.Contains(trigger))
		{
			list.Add(trigger);
		}
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if (!(component != null) || !component.entity.TryGetCompTrigger(out CompTrigger component2) || !component2.CanTriggerHiddenRoom())
		{
			return;
		}
		if (m_DicTriggerColliders.Count == 0)
		{
			KillDitherTween();
			SetDitherKeyword(enabled: true);
			DOTween.To(() =>
			{
				EnsureMaterialPropertyBlock();
				return m_Block.GetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER);
			}, ApplyDitherToMeshRenderers, value, TweenDuration).SetId(this);
		}
		if (m_DicTriggerColliders.TryGetValue(trigger, out var list2))
		{
			for (int num = list2.Count - 1; num >= 0; num--)
			{
				Collider collider2 = list2[num];
				if (collider2 == null)
				{
					list2.RemoveAt(num);
				}
				else
				{
					CompTrigger compTrigger = collider2.GetComponent<MonoEntity>()?.entity.GetCompTrigger();
					if (compTrigger != null && compTrigger.UintTransform() == component2.UintTransform())
					{
						list2.RemoveAt(num);
					}
				}
			}
		}
		else
		{
			m_DicTriggerColliders.Add(trigger, new List<Collider>());
		}
		List<Collider> list3 = m_DicTriggerColliders[trigger];
		if (!list3.Contains(collider))
		{
			list3.Add(collider);
		}
		if (component.entity.IsBehaveEntity())
		{
			OnEnterEvt(component.entity, trigger);
		}
	}

	private void TriggerExit(Collider collider, ITrigger trigger)
	{
		if (collider == null || trigger == null)
		{
			return;
		}
		if (m_DicAllColliders.TryGetValue(collider, out var list))
		{
			list.Remove(trigger);
			if (list.Count == 0)
			{
				m_DicAllColliders.Remove(collider);
			}
		}
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if (!(component != null) || !component.entity.TryGetCompTrigger(out CompTrigger component2) || !component2.CanTriggerHiddenRoom())
		{
			return;
		}
		if (m_DicTriggerColliders.TryGetValue(trigger, out var list2))
		{
			if (list2.Contains(collider))
			{
				list2.Remove(collider);
			}
			else
			{
				for (int num = list2.Count - 1; num >= 0; num--)
				{
					Collider collider2 = list2[num];
					if (collider2 == null)
					{
						list2.RemoveAt(num);
					}
					else
					{
						CompTrigger compTrigger = collider2.GetComponent<MonoEntity>()?.entity.GetCompTrigger();
						if (compTrigger != null && compTrigger.UintTransform() == component2.UintTransform())
						{
							list2.RemoveAt(num);
							break;
						}
					}
				}
			}
			if (list2.Count == 0)
			{
				m_DicTriggerColliders.Remove(trigger);
				if (m_DicTriggerColliders.Count == 0)
				{
					KillDitherTween();
					SetDitherKeyword(enabled: true);
					DOTween.To(() => value, ApplyDitherToMeshRenderers, 1f, TweenDuration).SetId(this).OnComplete(() =>
					{
						SetDitherKeyword(enabled: false);
					});
				}
			}
		}
		if (component.entity.IsCharacter())
		{
			OnExitEvt(component.entity, trigger);
		}
	}

	public void OnDestroy()
	{
		for (int i = 0; i < m_TriggerProxies.Count; i++)
		{
			MonoTrigger monoTrigger = m_TriggerProxies[i];
			if (monoTrigger != null)
			{
				monoTrigger.triggerEnter = (Action<Collider, ITrigger>)Delegate.Remove(monoTrigger.triggerEnter, new Action<Collider, ITrigger>(TriggerEnter));
				monoTrigger.triggerExit = (Action<Collider, ITrigger>)Delegate.Remove(monoTrigger.triggerExit, new Action<Collider, ITrigger>(TriggerExit));
				monoTrigger.triggerExitEvt = (Action)Delegate.Remove(monoTrigger.triggerExitEvt, new Action(TriggerExitEvt));
			}
		}
		KillDitherTween();
		if (m_Block != null)
		{
			m_Block.Clear();
		}
		for (int j = 0; j < m_RuntimeMaterials.Count; j++)
		{
			UnityEngine.Object.Destroy(m_RuntimeMaterials[j]);
		}
		m_RuntimeMaterials.Clear();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ObjectEnableHiddenRoomTrigger, OnObjectEnableHiddenRoomTrigger);
	}

	private void TriggerExitEvt()
	{
		RemoveCharacterOccupantsFromFieldTracking();
		if (!overrideSize && m_DicTriggerColliders.Count == 0)
		{
			KillDitherTween();
			SetDitherKeyword(enabled: true);
			DOTween.To(() => value, ApplyDitherToMeshRenderers, 1f, TweenDuration).SetId(this).OnComplete(() =>
			{
				SetDitherKeyword(enabled: false);
			});
		}
	}
}
