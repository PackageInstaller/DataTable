using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class GameSpeedMaterialSet : SerializedMonoBehaviour
{
	[SerializeField]
	private ParticleSystemRenderer[] needChangeRenderers;

	private readonly List<Material> _cachedMaterials = new List<Material>(16);

	private float currentSpeed = 1f;

	private int _speedShaderId;

	private void Awake()
	{
		_speedShaderId = Shader.PropertyToID("_GameSpeed");
		CacheMaterials();
	}

	private void OnDestroy()
	{
		_cachedMaterials.Clear();
	}

	private void CacheMaterials()
	{
		_cachedMaterials.Clear();
		if (needChangeRenderers == null)
		{
			return;
		}
		List<Material> list = CollectionPool<List<Material>, Material>.Get();
		for (int i = 0; i < needChangeRenderers.Length; i++)
		{
			ParticleSystemRenderer val = needChangeRenderers[i];
			if ((Object)(object)val == null)
			{
				continue;
			}
			list.Clear();
			((Renderer)(object)val).GetSharedMaterials(list);
			for (int j = 0; j < list.Count; j++)
			{
				Material material = list[j];
				if (!(material == null) && material.HasProperty(_speedShaderId) && !_cachedMaterials.Contains(material))
				{
					_cachedMaterials.Add(material);
				}
			}
		}
		list.Clear();
		CollectionPool<List<Material>, Material>.Release(list);
	}

	public void SetGameSpeed(float speed)
	{
		if (speed != currentSpeed)
		{
			for (int i = 0; i < _cachedMaterials.Count; i++)
			{
				_cachedMaterials[i].SetFloat(_speedShaderId, speed);
			}
			currentSpeed = speed;
		}
	}
}
