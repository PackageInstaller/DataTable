using System;
using System.Collections.Generic;
using Game.Graphics.HighlightOutliner;
using Game.Graphics.Overdrawer;
using UnityEngine;

public class AdventureIndicatorController : SceneSingleton<AdventureIndicatorController>
{
	[Header("Graphic Indicator:")]
	public Transform indicatorsRootNode;

	public Transform graphicIndicatorRootNode;

	[Space]
	public GameObject circleGraphicIndicatorPrefab;

	public GameObject fanGraphicIndicatorPrefab;

	public GameObject rectangleGraphicIndicatorPrefab;

	public GameObject ringGraphicIndicatorPrefab;

	public GameObject lineGraphicIndicatorPrefab;

	[Space]
	public GameObject[] targetRangeGraphicIndicatorPrefabs;

	[Header("Highlight Outliner:")]
	public RenderingMode outlinerRenderingMode = RenderingMode.HDR;

	[Range(0.15f, 1f)]
	public float outlinerPrimaryRendererScale = 0.75f;

	[Range(0f, 2f)]
	public float outlinerBlurShift = 1f;

	[Range(0f, 2f)]
	public float outlinerDilateShift = 1f;

	public int outlinerDilateIterations = 1;

	public DilateQuality outlinerDilateQuality;

	public int outlinerBlurIterations = 1;

	public BlurType outlinerBlurType = BlurType.Box;

	[Space]
	public Material occlusionHighlightMaterial;

	private readonly Dictionary<int, FanGraphicIndicator> targetFanIndicatorLs = new Dictionary<int, FanGraphicIndicator>(4);

	private TrueSyncTransform _target;

	private ActorSearchTarget _AcT;

	public static int showIndicatorMode = 0;

	public static List<bool> indicatorLs = new List<bool>(4);

	private FanGraphicIndicator _value;

	[NonSerialized]
	public GameObject blobIndicatorsRootNode;

	[NonSerialized]
	public AdventureShadowBlob shadowBlob;

	[NonSerialized]
	public AdventureTargetBlob targetBlob;

	[NonSerialized]
	public AdventureHighlightBlob highlightBlob;

	[NonSerialized]
	public AdventureJoyStickBlob joyStickBlob;

	public HashSet<Outlinable> activedHighlightOutlines { get; private set; } = new HashSet<Outlinable>();

	public HashSet<Overdrawable> activedOcclusionHighlights { get; private set; } = new HashSet<Overdrawable>();

	public void Setup(HotfixEnum.worldLevelType levelType)
	{
		_ = AdventureModuleController.Config;
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		if (!mainCamera.TryGetComponent<Outliner>(out var component))
		{
			component = mainCamera.gameObject.AddComponent<Outliner>();
		}
		else
		{
			component.enabled = true;
		}
		component.enabled = true;
		component.RenderingMode = outlinerRenderingMode;
		component.PrimaryBufferSizeMode = BufferSizeMode.Scaled;
		component.PrimaryRendererScale = outlinerPrimaryRendererScale;
		component.BlurShift = outlinerBlurShift;
		component.DilateShift = outlinerDilateShift;
		component.DilateIterations = outlinerDilateIterations;
		component.DilateQuality = outlinerDilateQuality;
		component.BlurIterations = outlinerBlurIterations;
		component.BlurType = outlinerBlurType;
		if (!mainCamera.TryGetComponent<Overdrawer>(out var component2))
		{
			component2 = mainCamera.gameObject.AddComponent<Overdrawer>();
		}
		else
		{
			component2.enabled = true;
		}
		if (blobIndicatorsRootNode == null)
		{
			SetupDefaultBlobIndicators();
		}
	}

	public void Release()
	{
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		if (mainCamera.TryGetComponent<Outliner>(out var component))
		{
			component.enabled = false;
		}
		if (mainCamera.TryGetComponent<Overdrawer>(out var component2))
		{
			component2.enabled = false;
		}
	}

	public void DriveLateUpdate()
	{
		shadowBlob?.SetVerticesDirty();
		targetBlob?.OnRefresh();
		highlightBlob?.SetVerticesDirty();
		joyStickBlob?.OnRefresh();
	}

	public void SetupDefaultBlobIndicators()
	{
		string assetName = "Assets/AssetBundles/Adventure/Indicators/BlobIndicators.prefab";
		GameObject gameObject = UnityEngine.Object.Instantiate(GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject, indicatorsRootNode);
		if (gameObject != null)
		{
			SetupBlobIndicators(gameObject);
		}
	}

	public void SetupEmptyBlobIndicators()
	{
		GameObject newBlobIndicatorsRootNode = new GameObject("Empty BlobIndicators");
		SetupBlobIndicators(newBlobIndicatorsRootNode);
	}

	public void SetupBlobIndicators(GameObject newBlobIndicatorsRootNode)
	{
		DestroyBlobIndicators();
		if (newBlobIndicatorsRootNode != null)
		{
			blobIndicatorsRootNode = newBlobIndicatorsRootNode;
			shadowBlob = newBlobIndicatorsRootNode.GetComponentInChildren<AdventureShadowBlob>();
			targetBlob = newBlobIndicatorsRootNode.GetComponentInChildren<AdventureTargetBlob>();
			highlightBlob = newBlobIndicatorsRootNode.GetComponentInChildren<AdventureHighlightBlob>();
			joyStickBlob = newBlobIndicatorsRootNode.GetComponentInChildren<AdventureJoyStickBlob>();
		}
	}

	public void DestroyBlobIndicators()
	{
		if (blobIndicatorsRootNode != null)
		{
			UnityEngine.Object.Destroy(blobIndicatorsRootNode);
		}
		blobIndicatorsRootNode = null;
		shadowBlob = null;
		targetBlob = null;
		highlightBlob = null;
		joyStickBlob = null;
	}

	public void ShowHighlightBlob(bool show)
	{
		if (!(null == highlightBlob))
		{
			if (show)
			{
				highlightBlob.Show();
				joyStickBlob?.Show();
			}
			else
			{
				highlightBlob.Hide();
				joyStickBlob?.Hide();
			}
		}
	}

	public void ShowBlobIndicatorsRootNode(bool show)
	{
		if (!(null == blobIndicatorsRootNode))
		{
			blobIndicatorsRootNode.SetActive(show);
		}
	}

	public void ShowIndicatorN(bool showIndicator, ActorSearchTarget AcT, TrueSyncTransform targetTs = null)
	{
	}

	private void ShowIndicator(bool showIndicator, TrueSyncTransform targetTs = null, float _size = 5f, float _angel = 45f, ActorSearchTarget AcT = null, int _prefabIndex = 0)
	{
		if (showIndicator || !(targetTs != _target))
		{
			if (!targetFanIndicatorLs.ContainsKey(_prefabIndex))
			{
				targetFanIndicatorLs.Add(_prefabIndex, SpawnFanGraphicIndicator(targetRangeGraphicIndicatorPrefabs[_prefabIndex]));
			}
			if (targetFanIndicatorLs.get_Item(_prefabIndex).gameObject.activeInHierarchy != showIndicator)
			{
				targetFanIndicatorLs.get_Item(_prefabIndex).gameObject.SetActive(showIndicator);
			}
			_target = targetTs;
			_AcT = AcT;
			targetFanIndicatorLs.get_Item(_prefabIndex).size = _size;
			targetFanIndicatorLs.get_Item(_prefabIndex).angle = _angel;
		}
	}

	public void FadeInTargetBlobRangeGraphic()
	{
		targetBlob?.FadeInAttackRangeGraphic();
		highlightBlob?.FadeInHighlight();
		joyStickBlob?.FadeInJoy();
	}

	public void HintAttackRangeGraphic(float fadeInTime = 0.3f, float duration = 0.7f, Action onFinish = null)
	{
		targetBlob?.HintAttackRangeGraphic(fadeInTime, duration, onFinish);
	}

	public void StartHintAttackRangeGraphic(float fadeInTime = 0.3f)
	{
		targetBlob?.StartHintAttackRangeGraphic(fadeInTime);
	}

	public void StopHintAttackRangeGraphic(float fadeInTime = 0.3f)
	{
		targetBlob?.StopHintAttackRangeGraphic(fadeInTime);
	}

	protected T SpawnGraphicIndicator<T>(GameObject graphicIndicatorPrefab) where T : BaseGraphicIndicator
	{
		GameObject gameObject = ObjectPoolUtils.SpawnGameObjectFromPool(graphicIndicatorPrefab, "Indicator", autoDespawn: false);
		gameObject.transform.SetParent(graphicIndicatorRootNode);
		return gameObject.GetComponent<T>();
	}

	public CircleGraphicIndicator SpawnCircleGraphicIndicator(GameObject indicatorPrefab = null)
	{
		return SpawnGraphicIndicator<CircleGraphicIndicator>(indicatorPrefab ?? circleGraphicIndicatorPrefab);
	}

	public FanGraphicIndicator SpawnFanGraphicIndicator(GameObject indicatorPrefab = null)
	{
		return SpawnGraphicIndicator<FanGraphicIndicator>(indicatorPrefab ?? fanGraphicIndicatorPrefab);
	}

	public RectangleGraphicIndicator SpawnRectangleGraphicIndicator(GameObject indicatorPrefab = null)
	{
		return SpawnGraphicIndicator<RectangleGraphicIndicator>(indicatorPrefab ?? rectangleGraphicIndicatorPrefab);
	}

	public RingGraphicIndicator SpawnRingGraphicIndicator(GameObject indicatorPrefab = null)
	{
		return SpawnGraphicIndicator<RingGraphicIndicator>(indicatorPrefab ?? ringGraphicIndicatorPrefab);
	}

	public LineGraphicIndicator SpawnLineGraphicIndicator(GameObject indicatorPrefab = null)
	{
		return SpawnGraphicIndicator<LineGraphicIndicator>(indicatorPrefab ?? lineGraphicIndicatorPrefab);
	}

	public void DespawnGraphicInspector(BaseGraphicIndicator graphicInspectorInstance)
	{
		ObjectPoolUtils.DespawnToPool(graphicInspectorInstance.transform, "Indicator");
	}

	public void ActiveHighlightOutline(GameObject target, Color outlineColor)
	{
		_ = AdventureModuleController.Config;
		if (!target.TryGetComponent<Outlinable>(out var component))
		{
			component = target.AddComponent<Outlinable>();
			component.AddAllChildRenderersToRenderingList(Game.Graphics.HighlightOutliner.RenderersAddingMode.MeshRenderer | Game.Graphics.HighlightOutliner.RenderersAddingMode.SkinnedMeshRenderer);
		}
		activedHighlightOutlines.Add(component);
		component.enabled = true;
		component.OutlineParameters.Enabled = true;
		component.OutlineParameters.Color = outlineColor;
	}

	public void DeactiveHighlightOutline(GameObject target)
	{
		if (target.TryGetComponent<Outlinable>(out var component))
		{
			activedHighlightOutlines.Remove(component);
			component.enabled = false;
		}
	}

	public void ActiveOcclusionHighlight(GameObject target)
	{
		if (!target.TryGetComponent<Overdrawable>(out var component))
		{
			component = target.AddComponent<Overdrawable>();
			component.AddAllChildRenderersToRenderingList(Game.Graphics.Overdrawer.RenderersAddingMode.MeshRenderer | Game.Graphics.Overdrawer.RenderersAddingMode.SkinnedMeshRenderer);
		}
		activedOcclusionHighlights.Add(component);
		component.enabled = true;
		component.overdrawMaterial = occlusionHighlightMaterial;
	}

	public void DeactiveOcclusionHighlight(GameObject target)
	{
		if (target.TryGetComponent<Overdrawable>(out var component))
		{
			activedOcclusionHighlights.Remove(component);
			component.enabled = false;
			component.overdrawMaterial = null;
		}
	}
}
