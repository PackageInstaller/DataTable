using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PrefabLightmapData : MonoBehaviour
{
	[Serializable]
	public struct RendererData
	{
		public Renderer renderer;

		public int lightmapIndex;

		public Vector4 lightmapOffsetScale;
	}

	private readonly struct LightmapKey(Texture2D color)
	{
		private readonly Texture2D _color = color;

		public override bool Equals(object obj)
		{
			if (obj is LightmapKey lightmapKey)
			{
				return _color == lightmapKey._color;
			}
			return false;
		}

		public override int GetHashCode()
		{
			if (!(_color != null))
			{
				return 0;
			}
			return _color.GetHashCode();
		}
	}

	[SerializeField]
	private List<RendererData> m_RendererData = new List<RendererData>();

	[SerializeField]
	private Texture2D[] m_Lightmaps;

	private bool _lightmapsApplied;

	private int[] _lastAppliedLightmapIndices;

	private static readonly Dictionary<LightmapKey, int> _addedLightmaps = new Dictionary<LightmapKey, int>();

	private static readonly HashSet<PrefabLightmapData> _enabledLightmapData = new HashSet<PrefabLightmapData>();

	private static bool _isRebuildingLightmaps;

	private void OnEnable()
	{
		if (Application.isPlaying || HasSavedLightmapData())
		{
			_enabledLightmapData.Add(this);
			ScheduleRebuildAllEnabledLightmaps();
		}
	}

	private void OnDisable()
	{
		_enabledLightmapData.Remove(this);
		_lightmapsApplied = false;
		_lastAppliedLightmapIndices = null;
		ScheduleRebuildAllEnabledLightmaps();
	}

	private static void ScheduleRebuildAllEnabledLightmaps()
	{
		RebuildAllEnabledLightmaps();
	}

	private static void RebuildAllEnabledLightmaps()
	{
		if (_isRebuildingLightmaps)
		{
			return;
		}
		_isRebuildingLightmaps = true;
		try
		{
			List<PrefabLightmapData> list = new List<PrefabLightmapData>(_enabledLightmapData);
			for (int num = list.Count - 1; num >= 0; num--)
			{
				PrefabLightmapData prefabLightmapData = list[num];
				if (prefabLightmapData == null || !prefabLightmapData.isActiveAndEnabled || IsPersistentAsset(prefabLightmapData))
				{
					_enabledLightmapData.Remove(prefabLightmapData);
					list.RemoveAt(num);
				}
				else
				{
					prefabLightmapData._lightmapsApplied = false;
					prefabLightmapData._lastAppliedLightmapIndices = null;
				}
			}
			list.Sort((PrefabLightmapData left, PrefabLightmapData right) => left.GetInstanceID().CompareTo(right.GetInstanceID()));
			List<LightmapData> list2 = new List<LightmapData>();
			Dictionary<LightmapKey, int> addedLightmaps = new Dictionary<LightmapKey, int>();
			bool flag = false;
			for (int num2 = 0; num2 < list.Count; num2++)
			{
				PrefabLightmapData prefabLightmapData2 = list[num2];
				if (prefabLightmapData2 != null && prefabLightmapData2.isActiveAndEnabled && prefabLightmapData2.HasSavedLightmapData())
				{
					flag = true;
					prefabLightmapData2.ApplyLightmaps(list2, addedLightmaps);
				}
			}
			if (!flag)
			{
				return;
			}
			LightmapSettings.lightmaps = list2.ToArray();
			for (int num3 = 0; num3 < list.Count; num3++)
			{
				PrefabLightmapData prefabLightmapData3 = list[num3];
				if (prefabLightmapData3 != null && prefabLightmapData3.isActiveAndEnabled)
				{
					prefabLightmapData3.ApplyRendererLightmapData();
				}
			}
		}
		finally
		{
			_isRebuildingLightmaps = false;
		}
	}

	private static bool IsPersistentAsset(PrefabLightmapData instance)
	{
		return false;
	}

	private bool HasSavedLightmapData()
	{
		if (m_RendererData != null && m_RendererData.Count > 0 && m_Lightmaps != null)
		{
			return m_Lightmaps.Length != 0;
		}
		return false;
	}

	private void ApplyLightmaps()
	{
		if (!HasSavedLightmapData() || (!_isRebuildingLightmaps && _lightmapsApplied && IsAppliedLightmapStillValid()))
		{
			return;
		}
		List<LightmapData> list = new List<LightmapData>(LightmapSettings.lightmaps);
		_addedLightmaps.Clear();
		for (int i = 0; i < list.Count; i++)
		{
			LightmapData lightmapData = list[i];
			if (lightmapData != null && !(lightmapData.lightmapColor == null))
			{
				LightmapKey key = new LightmapKey(lightmapData.lightmapColor);
				if (!_addedLightmaps.ContainsKey(key))
				{
					_addedLightmaps.Add(key, i);
				}
			}
		}
		ApplyLightmaps(list, _addedLightmaps);
	}

	private void ApplyLightmaps(List<LightmapData> sceneLightmaps, Dictionary<LightmapKey, int> addedLightmaps)
	{
		if (!HasSavedLightmapData())
		{
			return;
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>(m_Lightmaps.Length);
		for (int i = 0; i < m_Lightmaps.Length; i++)
		{
			Texture2D texture2D = m_Lightmaps[i];
			if (!(texture2D == null))
			{
				LightmapKey key = new LightmapKey(texture2D);
				if (!addedLightmaps.TryGetValue(key, out var value))
				{
					value = sceneLightmaps.Count;
					sceneLightmaps.Add(new LightmapData
					{
						lightmapColor = texture2D
					});
					addedLightmaps.Add(key, value);
				}
				dictionary[i] = value;
			}
		}
		if (!_isRebuildingLightmaps)
		{
			LightmapSettings.lightmaps = sceneLightmaps.ToArray();
			ApplyRendererLightmapData(dictionary);
		}
		_lastAppliedLightmapIndices = new int[m_Lightmaps.Length];
		for (int j = 0; j < m_Lightmaps.Length; j++)
		{
			_lastAppliedLightmapIndices[j] = (dictionary.TryGetValue(j, out var value2) ? value2 : (-1));
		}
		_lightmapsApplied = true;
	}

	private void ApplyRendererLightmapData()
	{
		if (_lastAppliedLightmapIndices == null)
		{
			return;
		}
		foreach (RendererData rendererDatum in m_RendererData)
		{
			if (rendererDatum.renderer != null && rendererDatum.lightmapIndex >= 0 && rendererDatum.lightmapIndex < _lastAppliedLightmapIndices.Length)
			{
				int num = _lastAppliedLightmapIndices[rendererDatum.lightmapIndex];
				if (num >= 0)
				{
					rendererDatum.renderer.lightmapIndex = num;
					rendererDatum.renderer.lightmapScaleOffset = rendererDatum.lightmapOffsetScale;
				}
			}
		}
	}

	private void ApplyRendererLightmapData(Dictionary<int, int> indexRemap)
	{
		foreach (RendererData rendererDatum in m_RendererData)
		{
			if (rendererDatum.renderer != null && indexRemap.TryGetValue(rendererDatum.lightmapIndex, out var value))
			{
				rendererDatum.renderer.lightmapIndex = value;
				rendererDatum.renderer.lightmapScaleOffset = rendererDatum.lightmapOffsetScale;
			}
		}
	}

	private bool IsAppliedLightmapStillValid()
	{
		if (_lastAppliedLightmapIndices == null || _lastAppliedLightmapIndices.Length != m_Lightmaps.Length)
		{
			return false;
		}
		LightmapData[] lightmaps = LightmapSettings.lightmaps;
		for (int i = 0; i < m_Lightmaps.Length; i++)
		{
			int num = _lastAppliedLightmapIndices[i];
			if (num < 0 || num >= lightmaps.Length)
			{
				return false;
			}
			LightmapData lightmapData = lightmaps[num];
			if (lightmapData == null || lightmapData.lightmapColor != m_Lightmaps[i])
			{
				return false;
			}
		}
		foreach (RendererData rendererDatum in m_RendererData)
		{
			if (rendererDatum.renderer != null && rendererDatum.lightmapIndex >= 0 && rendererDatum.lightmapIndex < _lastAppliedLightmapIndices.Length)
			{
				int num2 = _lastAppliedLightmapIndices[rendererDatum.lightmapIndex];
				if (rendererDatum.renderer.lightmapIndex != num2 || rendererDatum.renderer.lightmapScaleOffset != rendererDatum.lightmapOffsetScale)
				{
					return false;
				}
			}
		}
		return true;
	}
}
