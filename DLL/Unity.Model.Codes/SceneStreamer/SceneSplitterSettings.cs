using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace SceneStreamer;

public class SceneSplitterSettings : MonoBehaviour
{
	public enum SplitterType
	{
		CPU,
		GPU
	}

	[Serializable]
	public class EnvironmentParams
	{
		public Material skybox;

		public Light sun;

		public int ambientModeIndex;

		public AmbientMode ambientMode;

		public float ambientInstensity = 1f;

		[ColorUsage(true, true)]
		public Color ambientSkyColor = new Color(0.212f, 0.227f, 0.259f);

		[ColorUsage(true, true)]
		public Color ambientEquatorColor = Color.grey;

		[ColorUsage(true, true)]
		public Color ambientGroundColor = Color.black;

		public DefaultReflectionMode reflectionSource;

		public int defaultReflectionResolution = 128;

		public string[] resolutionValuesText = new string[4] { "128", "256", "512", "1024" };

		public int[] resolutionValues = new int[4] { 128, 256, 512, 1024 };

		public float reflectionInstensity = 1f;

		public int reflectionBounces;

		public Texture reflectionTexture;

		public ReflectionCubemapCompression reflectionCubemapCompression = ReflectionCubemapCompression.Auto;

		public bool fog;

		public Color fogColor = Color.gray;

		public FogMode fogMode = FogMode.ExponentialSquared;

		public float fogDensity = 0.01f;
	}

	public string scenesPath = "World Assets/WorldStreamer/SplitScenes/";

	public SceneCollectionManager sceneCollectionManager;

	public List<SceneSplitManager> extraSceneSplitManagers = new List<SceneSplitManager>();

	public bool lightingSettingsisExpanded;

	public LightingSettings lightingSettings;

	public EnvironmentParams environmentParams = new EnvironmentParams();

	public Vector2Int splitSize = new Vector2Int(100, 100);

	public int terrainsCount = 16;

	public SplitterType splitterType = SplitterType.GPU;

	public string GetScenesPath()
	{
		string text = scenesPath;
		if (!text.StartsWith("Assets/"))
		{
			text = ((!text.StartsWith("/") && !text.StartsWith("\\")) ? ("Assets/" + scenesPath) : ("Assets" + scenesPath));
		}
		if (text[text.Length - 1] != '/' && text[text.Length - 1] != '\\')
		{
			text += "/";
		}
		return text;
	}

	public string GetTerrainDataPath()
	{
		string text = scenesPath;
		if (!text.StartsWith("Assets/"))
		{
			text = ((!text.StartsWith("/") && !text.StartsWith("\\")) ? ("Assets/" + scenesPath + "/TerrainData/") : ("Assets" + scenesPath + "/TerrainData/"));
		}
		if (text[text.Length - 1] != '/' && text[text.Length - 1] != '\\')
		{
			text += "/";
		}
		return text;
	}
}
