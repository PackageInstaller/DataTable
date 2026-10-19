using System;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;

namespace Runtime.World.SceneChunks;

public class SceneChunkLightmapRecorder : MonoBehaviour
{
	[Serializable]
	private struct LightmapDataStorage(Texture2D color, Texture2D dir, Texture2D shadow)
	{
		[SerializeField]
		private Texture2D _color = color;

		[SerializeField]
		private Texture2D _dir = dir;

		[SerializeField]
		private Texture2D _shadow = shadow;

		private LightmapData _engineLightmapData = null;

		public LightmapData ToEngineLightmapData()
		{
			LightmapData lightmapData = _engineLightmapData;
			if (lightmapData == null)
			{
				LightmapData lightmapData2 = new LightmapData
				{
					lightmapColor = _color,
					lightmapDir = _dir,
					shadowMask = _shadow
				};
				LightmapData lightmapData3 = lightmapData2;
				_engineLightmapData = lightmapData2;
				lightmapData = lightmapData3;
			}
			return lightmapData;
		}
	}

	[SerializeField]
	[ReadOnly]
	private LightmapDataStorage[] _lightmapDatas;

	[SerializeField]
	[HideInInspector]
	private int _rendererCount;

	[SerializeField]
	[HideInInspector]
	private List<int> _renderLightmapOffset;

	[SerializeField]
	[HideInInspector]
	private List<Renderer> _renderers;

	private bool _hasInit;

	private Dictionary<Renderer, int> _renderDict;

	private void OnEnable()
	{
		if (!_hasInit)
		{
			LightmapData[] lightmaps = LightmapSettings.lightmaps;
			int num = lightmaps.Length;
			for (int num2 = _rendererCount - 1; num2 >= 0; num2--)
			{
				_renderers[num2].lightmapIndex = num + _renderLightmapOffset[num2];
			}
			LightmapData[] array = new LightmapData[num + _lightmapDatas.Length];
			Array.Copy(lightmaps, array, 0);
			for (int i = 0; i < _lightmapDatas.Length; i++)
			{
				array[num + i] = _lightmapDatas[i].ToEngineLightmapData();
			}
		}
	}

	private void InitializeRenderDict()
	{
		if (_renderDict == null)
		{
			if (_renderDict == null)
			{
				_renderDict = new Dictionary<Renderer, int>();
			}
			for (int i = 0; i < _renderers.Count; i++)
			{
				_renderDict[_renderers[i]] = _renderLightmapOffset[i];
			}
		}
	}

	public void WriteBindingInfoToRecorder(List<Renderer> bakedRenderers, LightmapData[] lightmaps)
	{
		_rendererCount = bakedRenderers.Count;
		_renderLightmapOffset = new List<int>(_rendererCount);
		_renderers = new List<Renderer>(_rendererCount);
		for (int i = 0; i < bakedRenderers.Count; i++)
		{
			Renderer renderer = bakedRenderers[i];
			_renderers.Add(renderer);
			_renderLightmapOffset.Add(renderer.lightmapIndex);
		}
		int num = lightmaps.Length;
		_lightmapDatas = new LightmapDataStorage[num];
		for (int j = 0; j < num; j++)
		{
			LightmapData obj = lightmaps[j];
			Texture2D lightmapColor = obj.lightmapColor;
			Texture2D lightmapDir = obj.lightmapDir;
			Texture2D shadowMask = obj.shadowMask;
			_lightmapDatas[j] = new LightmapDataStorage(lightmapColor, lightmapDir, shadowMask);
		}
	}
}
