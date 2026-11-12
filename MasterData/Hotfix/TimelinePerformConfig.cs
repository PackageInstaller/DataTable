using MagicaCloth;
using UnityEngine;
using UnityEngine.Playables;

[AddComponentMenu("游戏/冒险模块/演出/Timeline演出配置")]
[RequireComponent(typeof(PlayableDirector))]
[DisallowMultipleComponent]
public class TimelinePerformConfig : MonoBehaviour
{
	public enum SubsequentActionType
	{
		None,
		PlayAVG,
		PlayOnceTimeline
	}

	public enum PlayableType
	{
		Instance,
		Path
	}

	public bool isUseEnterBlackBlock;

	public bool isUseExitBlackBlock;

	public bool isCloseBlackBlockOnFinish = true;

	public bool isUseMainCamera;

	public bool isUseCloseUpCamera;

	public bool isCinemaMode;

	[Space]
	public bool isPauseLogic = true;

	public bool isSuspendPlayer;

	public bool isEnableJump;

	public bool finishDelete = true;

	public SubsequentActionType subsequentActionType;

	public string subsequentAvgId;

	public PlayableType subsequentPlayableType;

	public PlayableDirector subsequentDirector;

	public string subsequentDirectorPath;

	[HideInInspector]
	public CustomModelMaterialVariantComponent.VariantNames variantNames;

	private PlayableDirector _director;

	private bool _initialized;

	private void Awake()
	{
		_director = GetComponent<PlayableDirector>();
	}

	public void Setup()
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
		if (variantNames == CustomModelMaterialVariantComponent.VariantNames.None)
		{
			return;
		}
		CustomModelMaterialVariantComponent[] componentsInChildren3 = _director.gameObject.GetComponentsInChildren<CustomModelMaterialVariantComponent>();
		for (int k = 0; k < componentsInChildren3.Length; k++)
		{
			if (componentsInChildren3[k].currentVariantName != variantNames)
			{
				componentsInChildren3[k].SetVariant(variantNames);
			}
		}
	}

	private void OnDisable()
	{
		variantNames = CustomModelMaterialVariantComponent.VariantNames.None;
	}

	private void OnUseMainCameraStateChanged()
	{
		if (!isUseMainCamera && isUseCloseUpCamera)
		{
			isUseCloseUpCamera = false;
		}
	}

	private void OnSubsequentActionTypeChanged()
	{
		if (subsequentActionType != SubsequentActionType.PlayAVG)
		{
			subsequentAvgId = string.Empty;
		}
		if (subsequentActionType != SubsequentActionType.PlayOnceTimeline)
		{
			subsequentDirector = null;
		}
	}

	public void AutoSetup()
	{
		MagicaBoneCloth[] componentsInChildren = gameObject.GetComponentsInChildren<MagicaBoneCloth>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.SetActive(value: false);
		}
		MagicaBoneSpring[] componentsInChildren2 = gameObject.GetComponentsInChildren<MagicaBoneSpring>(includeInactive: true);
		for (int i = 0; i < componentsInChildren2.Length; i++)
		{
			componentsInChildren2[i].gameObject.SetActive(value: false);
		}
	}
}
