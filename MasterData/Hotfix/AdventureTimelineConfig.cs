using UnityEngine;
using UnityEngine.Playables;

public class AdventureTimelineConfig : MonoBehaviour
{
	[HideInInspector]
	public AdventureActor actor;

	public bool isUseMainCamera;

	public bool isUseCloseUpCamera;

	public float fadeInTime = 0.5f;

	public float fadeOutTime;

	public bool useCustomFadeInBackgroundColor;

	public Color fadeInBackgroundColor = new Color(0f, 0f, 0f, 0.5f);

	[Space]
	public Light closeupAnimMainLight;

	[Space]
	public bool isSuspendPlayer;

	public bool isEnableJump;

	[Space]
	public bool finishDelete = true;

	public string avgId;

	private PlayableDirector _director;

	private bool _initialized;

	private void Awake()
	{
		_director = GetComponent<PlayableDirector>();
	}

	private void OnUseMainCameraStateChanged()
	{
		if (!isUseMainCamera && isUseCloseUpCamera)
		{
			isUseCloseUpCamera = false;
		}
	}

	private void OnUseCloseUpCameraStateChanged()
	{
		if (!isUseCloseUpCamera)
		{
			useCustomFadeInBackgroundColor = false;
		}
	}

	public void Setup(PlayableDirectorConfig directorConfig)
	{
		if (_director == null)
		{
			return;
		}
		if (!_initialized)
		{
			AdventureSelfFXHandler[] componentsInChildren = _director.gameObject.GetComponentsInChildren<AdventureSelfFXHandler>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].Initialize();
			}
			Animator[] componentsInChildren2 = _director.gameObject.GetComponentsInChildren<Animator>();
			for (int j = 0; j < componentsInChildren2.Length; j++)
			{
				componentsInChildren2[j].cullingMode = AnimatorCullingMode.AlwaysAnimate;
			}
			_initialized = true;
		}
		if (directorConfig.variantNames == CustomModelMaterialVariantComponent.VariantNames.None)
		{
			return;
		}
		CustomModelMaterialVariantComponent[] componentsInChildren3 = _director.gameObject.GetComponentsInChildren<CustomModelMaterialVariantComponent>();
		for (int k = 0; k < componentsInChildren3.Length; k++)
		{
			if (componentsInChildren3[k].currentVariantName != directorConfig.variantNames)
			{
				componentsInChildren3[k].SetVariant(directorConfig.variantNames);
			}
		}
	}
}
