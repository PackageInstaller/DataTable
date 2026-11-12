#define LOG_WARNING
using System;
using UnityEngine;
using UnityEngine.Playables;

public class DormEntity : DynamicSimpleEntity, IOcclusionRendererOccludeeListener
{
	private bool _isPlayingTimelineAnimation;

	private bool _isPlayingTimelineSequence;

	private PlayableDirector _currentTimelineAnimationDirector;

	private DormTimelineSequenceConfigData.PlaybackData _currentTimelineSequencePlayback;

	private int _currentTimelineAnimationPlaybackSegmentIndex;

	private int _currentTimelineAnimationLoopRemaining;

	private Action _onTimelineAnimationComplete;

	private const string kActorAnimatorTrackName = "ACTOR";

	private const string kActorFacialExpressionTrackName = "EXPR";

	private const string kActorFacialBlinkTrackName = "BLINK";

	private int _hideRC;

	private bool _isOutlineHighlightDisplaying;

	private bool _isDisplayOnTopHighlightDisplaying;

	public Animator animator { get; protected set; }

	public SDFacialAnimator facialAnimator { get; protected set; }

	public PlayableDirector director { get; protected set; }

	public AnimationSlotConfigComponent slotConfig { get; protected set; }

	public bool isPlayingTimelineAnimation => _isPlayingTimelineAnimation;

	public PlayableDirector currentTimelineAnimationDirector => _currentTimelineAnimationDirector;

	public DormTimelineSequenceConfigData.PlaybackData currentTimelineSequencePlayback => _currentTimelineSequencePlayback;

	public float visibleRadius { get; protected set; }

	public float visibleHeight { get; protected set; }

	public RendererMaterialStackComponent materialController { get; protected set; }

	public OcclusionRendererOccludee occlusionRendererOccludee { get; protected set; }

	public InteractiveEnvironmentPawn interactiveEnvPawn { get; protected set; }

	public ScaledMeshRendererCuller scaledMeshRendererCuller { get; protected set; }

	public bool isHide => _hideRC > 0;

	protected override void InitializeComponents()
	{
		InitializeAnimation();
		InitializeVisual();
	}

	protected override void ReleaseComponents()
	{
		ReleaseVisual();
		ReleaseAnimation();
	}

	protected void SetupBasicAnimationComponents()
	{
		if (animator == null)
		{
			animator = gameObject.GetComponentInChildren<Animator>();
		}
		if (facialAnimator == null)
		{
			facialAnimator = gameObject.GetComponentInChildren<SDFacialAnimator>();
		}
		if (director == null)
		{
			director = gameObject.GetComponentInChildren<PlayableDirector>();
		}
		if (slotConfig == null)
		{
			slotConfig = gameObject.GetComponentInChildren<AnimationSlotConfigComponent>();
		}
		if (animator != null)
		{
			animator.updateMode = AnimatorUpdateMode.Normal;
			animator.applyRootMotion = false;
			animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
			animator.keepAnimatorStateOnDisable = true;
		}
	}

	protected virtual void InitializeAnimation()
	{
		SetupBasicAnimationComponents();
	}

	protected virtual void ReleaseAnimation()
	{
	}

	public void PlayTimelineAnimation(GameObject timelinePrefab, int loopCount = 1, Action onComplete = null, DirectorWrapMode wrapMode = DirectorWrapMode.None, bool isInterruptOnReplace = true)
	{
		if (_isPlayingTimelineAnimation)
		{
			StopTimelineAnimation(isInterruptOnReplace);
		}
		_onTimelineAnimationComplete = onComplete;
		PlayTimeline(timelinePrefab, wrapMode);
		_currentTimelineAnimationLoopRemaining = Mathf.Max(1, loopCount) - 1;
		_isPlayingTimelineAnimation = true;
		_isPlayingTimelineSequence = false;
	}

	public void PlayTimelineSequenceAnimation(DormTimelineSequenceConfigData sequenceConfigData, Action onComplete = null)
	{
		if (_isPlayingTimelineAnimation)
		{
			StopTimelineAnimation();
		}
		_currentTimelineSequencePlayback = sequenceConfigData.Resolve();
		_onTimelineAnimationComplete = onComplete;
		if (_currentTimelineSequencePlayback != null && _currentTimelineSequencePlayback.sequence.Count > 0)
		{
			_currentTimelineAnimationPlaybackSegmentIndex = 0;
			PlayTimelineAnimationSegment();
			_isPlayingTimelineAnimation = true;
			_isPlayingTimelineSequence = true;
		}
		else
		{
			FinishTimelineAnimation();
		}
	}

	public void PlayTimelineAnimation(string animationAssetPath, Action onComplete = null)
	{
		if (animationAssetPath.EndsWith(".prefab"))
		{
			GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, animationAssetPath, typeof(GameObject)) as GameObject;
			if (gameObject != null)
			{
				PlayTimelineAnimation(gameObject, 1, onComplete);
			}
		}
		else if (GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, animationAssetPath, typeof(DormTimelineSequenceConfigData)) is DormTimelineSequenceConfigData sequenceConfigData)
		{
			PlayTimelineSequenceAnimation(sequenceConfigData, onComplete);
		}
	}

	public void StopTimelineAnimation(bool isInterrupt = true)
	{
		if (!_isPlayingTimelineAnimation)
		{
			return;
		}
		if (_currentTimelineAnimationDirector != null)
		{
			_currentTimelineAnimationDirector.stopped -= OnTimelineAnimationDirectorStopped;
			if (_currentTimelineAnimationDirector.playableGraph.IsValid())
			{
				_currentTimelineAnimationDirector.Stop();
			}
			DespawnTimelineInstance(_currentTimelineAnimationDirector);
			_currentTimelineAnimationDirector = null;
		}
		_isPlayingTimelineAnimation = false;
		_isPlayingTimelineSequence = false;
		_currentTimelineSequencePlayback = null;
		_currentTimelineAnimationPlaybackSegmentIndex = 0;
		_currentTimelineAnimationLoopRemaining = 0;
		_onTimelineAnimationComplete = null;
		if (isInterrupt)
		{
			OnInterruptTimelineAnimation();
		}
	}

	public void SyncTimelineAnimationTransform()
	{
		if (_currentTimelineAnimationDirector != null)
		{
			Transform transform = ((animator != null) ? animator.transform : base.transform);
			_currentTimelineAnimationDirector.transform.SetPositionAndRotation(transform.position, transform.rotation);
		}
	}

	protected virtual void OnInterruptTimelineAnimation()
	{
	}

	private void PlayTimeline(GameObject timelinePrefab, DirectorWrapMode wrapMode)
	{
		_currentTimelineAnimationDirector = SpawnTimelineInstance(timelinePrefab);
		_currentTimelineAnimationDirector.extrapolationMode = wrapMode;
		_currentTimelineAnimationDirector.stopped += OnTimelineAnimationDirectorStopped;
		SyncTimelineAnimationTransform();
		if (animator != null)
		{
			BindTimelineActorAnimator(_currentTimelineAnimationDirector, animator);
			if (_currentTimelineAnimationDirector.TryGetComponent<DormTimelineBinder>(out var component))
			{
				component.Retarget(animator.transform);
			}
		}
		if (facialAnimator != null)
		{
			BindTimelineActorFacialExpression(_currentTimelineAnimationDirector, facialAnimator);
			BindTimelineActorFacialBlink(_currentTimelineAnimationDirector, facialAnimator);
		}
		_currentTimelineAnimationDirector.Play();
		_currentTimelineAnimationDirector.Evaluate();
	}

	private void PlayTimelineAnimationSegment()
	{
		DormTimelineSequenceConfigData.TimelinePlaybackSegment timelinePlaybackSegment = _currentTimelineSequencePlayback.sequence.get_Item(_currentTimelineAnimationPlaybackSegmentIndex);
		PlayTimeline(timelinePlaybackSegment.timelinePrefab, DirectorWrapMode.None);
		_currentTimelineAnimationLoopRemaining = timelinePlaybackSegment.loopCount - 1;
	}

	private void OnTimelineAnimationDirectorStopped(PlayableDirector director)
	{
		if (_currentTimelineAnimationLoopRemaining > 0)
		{
			_currentTimelineAnimationLoopRemaining--;
			director.time = 0.0;
			director.Play();
		}
		else if (_isPlayingTimelineSequence)
		{
			director.stopped -= OnTimelineAnimationDirectorStopped;
			DespawnTimelineInstance(_currentTimelineAnimationDirector);
			_currentTimelineAnimationDirector = null;
			_currentTimelineAnimationPlaybackSegmentIndex++;
			if (_currentTimelineAnimationPlaybackSegmentIndex < _currentTimelineSequencePlayback.sequence.Count)
			{
				PlayTimelineAnimationSegment();
			}
			else
			{
				FinishTimelineAnimation();
			}
		}
		else
		{
			FinishTimelineAnimation();
		}
	}

	private void FinishTimelineAnimation()
	{
		Action onTimelineAnimationComplete = _onTimelineAnimationComplete;
		StopTimelineAnimation(isInterrupt: false);
		onTimelineAnimationComplete?.Invoke();
	}

	private static void BindTimelineActorAnimator(PlayableDirector director, Animator actorAnimator)
	{
		Animator animator = director.GetGenericBinding("ACTOR") as Animator;
		if (animator != null && animator.gameObject.CompareTag("EditorOnly"))
		{
			animator.gameObject.SetActive(value: false);
		}
		if (animator != actorAnimator)
		{
			director.SetGenericBinding("ACTOR", actorAnimator);
		}
	}

	private static void BindTimelineActorFacialExpression(PlayableDirector director, SDFacialAnimator facialAnimator)
	{
		SDFacialAnimator sDFacialAnimator = director.GetGenericBinding("EXPR") as SDFacialAnimator;
		if (sDFacialAnimator != null && sDFacialAnimator.gameObject.CompareTag("EditorOnly"))
		{
			sDFacialAnimator.gameObject.SetActive(value: false);
		}
		if (sDFacialAnimator != facialAnimator)
		{
			director.SetGenericBinding("EXPR", facialAnimator);
		}
	}

	private static void BindTimelineActorFacialBlink(PlayableDirector director, SDFacialAnimator facialAnimator)
	{
		SDFacialAnimator sDFacialAnimator = director.GetGenericBinding("BLINK") as SDFacialAnimator;
		if (sDFacialAnimator != null && sDFacialAnimator.gameObject.CompareTag("EditorOnly"))
		{
			sDFacialAnimator.gameObject.SetActive(value: false);
		}
		if (sDFacialAnimator != facialAnimator)
		{
			director.SetGenericBinding("BLINK", facialAnimator);
		}
	}

	private PlayableDirector SpawnTimelineInstance(GameObject prefab)
	{
		GameObject gameObject = ObjectPoolUtils.SpawnGameObjectFromPool(prefab, "Timeline", autoDespawn: false);
		gameObject.transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Timeline"));
		if (gameObject.TryGetComponent<PlayableDirector>(out var component))
		{
			return component;
		}
		LogError("Timeline预制体\"" + prefab.name + "\"上没有找到PlayableDirector组件");
		return null;
	}

	private void DespawnTimelineInstance(PlayableDirector instance)
	{
		ObjectPoolUtils.DespawnToPool(instance.transform, "Timeline");
	}

	protected void SetupRendererMaterialStackComponent()
	{
		if (!(materialController == null))
		{
			return;
		}
		materialController = gameObject.AddComponent<RendererMaterialStackComponent>();
		materialController.InitRendererMaterialStacks(includeInactive: false, includeMeshRenderer: true, includeSkinnedMeshRenderer: true, includeParticleSystemRenderer: false);
		if (facialAnimator != null)
		{
			if (facialAnimator.faceRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.faceRenderer);
			}
			if (facialAnimator.blankFaceRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.blankFaceRenderer);
			}
			if (facialAnimator.eyebrowRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.eyebrowRenderer);
			}
			if (facialAnimator.specialEyeRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.specialEyeRenderer);
			}
			if (facialAnimator.specialEyeMirrorRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.specialEyeMirrorRenderer);
			}
			if (facialAnimator.blushRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.blushRenderer);
			}
			if (facialAnimator.blushMirrorRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.blushMirrorRenderer);
			}
			if (facialAnimator.mouthRenderer != null)
			{
				materialController.AddRendererMaterialStack(facialAnimator.mouthRenderer);
			}
		}
	}

	protected void SetupOcclusionRendererOccludeeComponent(float visibleRadius, float visibleHeight)
	{
		this.visibleRadius = visibleRadius;
		this.visibleHeight = visibleHeight;
		if (occlusionRendererOccludee == null)
		{
			occlusionRendererOccludee = gameObject.AddComponent<OcclusionRendererOccludee>();
			occlusionRendererOccludee.listener = this;
			occlusionRendererOccludee.occlusionVisibleDetectEnabled = true;
			occlusionRendererOccludee.occlusionLightingDetectEnabled = true;
		}
	}

	protected void SetupScaledMeshRendererCullerComponent()
	{
		if (scaledMeshRendererCuller == null && gameObject.TryGetComponent<ScaledMeshRendererCuller>(out var component))
		{
			scaledMeshRendererCuller = component;
		}
		if (scaledMeshRendererCuller != null)
		{
			scaledMeshRendererCuller.enabled = true;
		}
	}

	protected virtual void InitializeVisual()
	{
	}

	protected virtual void ReleaseVisual()
	{
		if (scaledMeshRendererCuller != null)
		{
			scaledMeshRendererCuller.ResetCull();
		}
		DeactiveHighlightDisplay();
	}

	protected void InitializeVisualComponents(float visibleRadius, float visibleHeight, bool isOccludee)
	{
		SetupRendererMaterialStackComponent();
		if (isOccludee)
		{
			SetupOcclusionRendererOccludeeComponent(visibleRadius, visibleHeight);
		}
		SetupScaledMeshRendererCullerComponent();
		ResetVisible();
		ResetRenderLayer();
		ResetRenderingLayerMask();
	}

	public void Visible()
	{
		_hideRC--;
		if (_hideRC == 0)
		{
			DoVisible();
		}
		if (_hideRC < 0)
		{
			_hideRC = 0;
			NovaLogger.Warning("Show与Hide使用不匹配，请成对使用");
		}
	}

	public void Hide()
	{
		_hideRC++;
		if (_hideRC == 1)
		{
			DoHide();
		}
		if (_hideRC > 1)
		{
			_hideRC = 1;
			NovaLogger.Warning("Show与Hide使用不匹配，请成对使用");
		}
	}

	protected virtual void DoVisible()
	{
		if (materialController != null)
		{
			materialController.Visible();
		}
		if (occlusionRendererOccludee != null)
		{
			occlusionRendererOccludee.enabled = true;
		}
		if (interactiveEnvPawn != null)
		{
			interactiveEnvPawn.Active();
		}
	}

	protected virtual void DoHide()
	{
		if (materialController != null)
		{
			materialController.Hide();
		}
		if (occlusionRendererOccludee != null)
		{
			occlusionRendererOccludee.enabled = false;
		}
		if (interactiveEnvPawn != null)
		{
			interactiveEnvPawn.Deactive();
		}
	}

	protected void ResetVisible()
	{
		if (isHide)
		{
			_hideRC = 0;
			DoVisible();
		}
	}

	protected void SetRenderLayer(int layer)
	{
		if (materialController != null)
		{
			materialController.SetRenderLayer(layer);
		}
		if (currentTimelineAnimationDirector != null)
		{
			currentTimelineAnimationDirector.transform.SetLayerRecursively(layer);
		}
	}

	protected void ResetRenderLayer()
	{
		if (materialController != null)
		{
			materialController.SetRenderLayer(entityType);
		}
		if (currentTimelineAnimationDirector != null)
		{
			currentTimelineAnimationDirector.transform.SetLayerRecursively(0);
		}
	}

	public void SetRenderingLayerMask(uint renderingLayerMask)
	{
		if (materialController != null)
		{
			materialController.SetRenderingLayerMask(renderingLayerMask);
		}
	}

	public void ResetRenderingLayerMask()
	{
		if (materialController != null)
		{
			materialController.SetRenderingLayerMask(1u);
		}
	}

	public void ActiveHighlightDisplay(bool outline = false, bool displayOnTop = false)
	{
		DormCameraController instance = SceneSingleton<DormCameraController>.Instance;
		if (outline && !_isOutlineHighlightDisplaying)
		{
			instance?.ActiveHighlightOutline(gameObject);
			_isOutlineHighlightDisplaying = true;
		}
		if (displayOnTop && !_isDisplayOnTopHighlightDisplaying)
		{
			instance?.EnableCloseupCamera();
			SetRenderLayer(26);
			_isDisplayOnTopHighlightDisplaying = true;
		}
	}

	public void DeactiveHighlightDisplay()
	{
		DormCameraController instance = SceneSingleton<DormCameraController>.Instance;
		if (_isOutlineHighlightDisplaying)
		{
			instance?.DeactiveHighlightOutline(gameObject);
			_isOutlineHighlightDisplaying = false;
		}
		if (_isDisplayOnTopHighlightDisplaying)
		{
			instance?.DisableCloseupCamera();
			ResetRenderLayer();
			_isDisplayOnTopHighlightDisplaying = false;
		}
	}

	public Vector3 GetDetectPositionForOcclusionVisible()
	{
		return transform.position + new Vector3(0f, visibleHeight * 0.75f, 0f);
	}

	public float GetDetectRadiusForOcclusionVisible()
	{
		return 0f;
	}

	public float GetDetectOffsetForOcclusionVisible()
	{
		return visibleRadius * -2f;
	}

	public Vector3 GetDetectPositionForOcclusionTransparent()
	{
		return transform.position + new Vector3(0f, visibleHeight * 0.5f, 0f);
	}

	public float GetDetectRadiusForOcclusionTransparent()
	{
		return visibleRadius;
	}

	public float GetDetectOffsetForOcclusionTransparent()
	{
		return 0f;
	}

	public Vector3 GetDetectPositionForOcclusionLighting()
	{
		return transform.position + new Vector3(0f, visibleHeight * 0.5f, 0f);
	}

	public float GetDetectRadiusForOcclusionLighting()
	{
		return visibleRadius;
	}

	public float GetDetectOffsetForOcclusionLighting()
	{
		return 0f;
	}

	public void OnObscuredVisibleEnter()
	{
	}

	public void OnObscuredVisibleExit()
	{
	}

	public void OnObscuredLightingEnter()
	{
	}

	public void OnObscuredLightingExit()
	{
	}

	public void OnOcclusionShadowFade(float fadeFactor)
	{
	}
}
