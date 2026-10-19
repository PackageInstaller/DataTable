using System;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.World.StateObject;

public class InteractSwitchMotionPath : StateObjectBase
{
	public InteractEntry entry;

	public SwitchMotionPathData m_data;

	public PlayableAsset enterTimelineAsset;

	public PlayableAsset exitTimelineAsset;

	public float rotateTime = 0.5f;

	private PlayableDirector m_playableDirector;

	public CinemachineVirtualCamera vc1;

	public CinemachineVirtualCamera vc2;

	public Transform targetTrans;

	public BoxCollider confinerCollider;

	private bool cameraMoving;

	private CancellationTokenSource m_Cts;

	private CinemachineVirtualCamera currentCamera;

	private Vector3 currentDamping;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (!(compStateObject?.StateWorldAssetData is SwitchMotionPathData switchMotionPathData))
		{
			return;
		}
		m_data = switchMotionPathData;
		SwitchMotionPathData.SwitchPoint switchPoint = m_data.target;
		BoxCollider component = GetComponent<BoxCollider>();
		component.center = switchPoint.triggerCenter;
		component.size = switchPoint.triggerSize;
		component.enabled = !switchMotionPathData.HideTrigger;
		m_playableDirector = GetComponent<PlayableDirector>();
		targetTrans.position = switchPoint.position;
		if (switchPoint.useCameraProperties)
		{
			vc2.m_Lens.FieldOfView = switchPoint.cameraProperties.fov;
			vc2.GetCinemachineComponent<CinemachineFramingTransposerACT>().m_CameraDistance = switchPoint.cameraProperties.cameraDistance;
			if (switchPoint.cameraProperties.confinerVolume.size != Vector3.zero)
			{
				vc2.GetComponent<CinemachineConfiner>().m_BoundingVolume = confinerCollider;
				confinerCollider.size = switchPoint.cameraProperties.confinerVolume.size;
				confinerCollider.transform.position = switchPoint.cameraProperties.confinerVolume.center;
			}
		}
		InteractEntry entryConfig = m_data.entryConfig;
		entry = new InteractEntry();
		entry.Clone(entryConfig);
		InteractEntry interactEntry = entry;
		interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
		entry.BindInteractObjectBase(this);
		entry.BindData(compStateObject.StateWorldAssetData);
		base.InitStateObject(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == 0)
		{
			entry.HandleInit();
		}
		base.HandleInitState(stateId);
	}

	private void OnInteract(Entity behave)
	{
		if (Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.MovingPath))
		{
			entry.HandleExit();
			m_Cts = new CancellationTokenSource();
			Moving(behave, m_Cts.Token).Forget();
		}
	}

	private async UniTask Moving(Entity behave, CancellationToken token)
	{
		MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.MovingPath);
		MonoECS.instance.PushPauseInteract();
		MonoECS.instance.PushPauseAllInput();
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_BATTLEMAIN);
		try
		{
			await MovingCharacter(behave, token);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_SwitchMotionPath, null);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception, this);
		}
		finally
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			MonoECS.instance.PopPauseAllInput();
			MonoECS.instance.PopPauseInteract();
			CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Remove(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(OnGetBlendOverride));
			MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.MovingPath);
			MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.MovingPath);
		}
	}

	private async UniTask PlayTimelineAndWait(PlayableAsset timelineAsset, Animator animator, CancellationToken token)
	{
		m_playableDirector.playableAsset = timelineAsset;
		foreach (PlayableBinding output in timelineAsset.outputs)
		{
			if (output.sourceObject is AnimationTrack && (!(output.streamName != "player") || !(output.streamName != "position")))
			{
				m_playableDirector.SetGenericBinding(output.sourceObject, animator);
				break;
			}
		}
		bool timelineStopped = false;
		m_playableDirector.stopped += OnTimelineStopped;
		try
		{
			m_playableDirector.Play();
			await UniTask.WaitUntil(() => timelineStopped || !m_playableDirector || !m_playableDirector.playableGraph.IsValid() || m_playableDirector.time >= m_playableDirector.duration, PlayerLoopTiming.Update, token);
			if (!timelineStopped && (bool)m_playableDirector && m_playableDirector.playableGraph.IsValid())
			{
				m_playableDirector.time = m_playableDirector.duration;
				m_playableDirector.Evaluate();
				m_playableDirector.Stop();
			}
		}
		finally
		{
			if ((bool)m_playableDirector)
			{
				m_playableDirector.stopped -= OnTimelineStopped;
			}
			if (token.IsCancellationRequested && (bool)m_playableDirector)
			{
				m_playableDirector.Stop();
			}
		}
		void OnTimelineStopped(PlayableDirector _)
		{
			timelineStopped = true;
		}
	}

	private async UniTask MovingCharacter(Entity behave, CancellationToken token)
	{
		Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: true);
		CompTransform compTransform = behave.GetCompTransform();
		CompPhysics compPhysics = behave.GetCompPhysics();
		CompMotion compMotion = behave.GetCompMotion();
		FaceDir lastFaceDir = behave.GetFaceDir();
		float dampingTime = m_data.target.cameraDamping;
		behave.SetFaceDir(m_data.target.enterDir);
		await UniTask.Delay(TimeSpan.FromSeconds(rotateTime), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		UniTask uniTask = PlayTimelineAndWait(enterTimelineAsset, compMotion.animator, token);
		Debug.Log($"时间{Time.frameCount}, 1111");
		MonoECS.instance.EntityDissolve(behave, (float)enterTimelineAsset.duration, isShow: false);
		behave.GetMono().aniControl.PlayHidden(AniPartControl.PartType.WeaponDissolve, (float)enterTimelineAsset.duration, behave);
		MoveCamera().Forget();
		await uniTask;
		double num = (double)dampingTime - enterTimelineAsset.duration - exitTimelineAsset.duration;
		if (num > 0.0)
		{
			await UniTask.Delay(TimeSpan.FromSeconds(num), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		}
		SwitchMotionPathData.SwitchPoint switchPoint = m_data.target;
		compTransform.UpdatePosition(switchPoint.position);
		compPhysics.SetConstZ(switchPoint.position.z);
		behave.SetFaceDir(m_data.target.exitDir);
		compTransform.physicsRotateDegree = QuaternionUtility.FaceLocalYAngle(m_data.target.exitDir);
		compPhysics.characterMovement.SetRotation(Quaternion.Euler(0f, compTransform.physicsRotateDegree, 0f));
		UniTask uniTask2 = PlayTimelineAndWait(exitTimelineAsset, compMotion.animator, token);
		Debug.Log($"时间{Time.frameCount}, 2222");
		MonoECS.instance.mainEntity.GetRoot().SetActive(value: true);
		MonoECS.instance.EntityDissolve(behave, (float)exitTimelineAsset.duration, isShow: true);
		await UniTask.WhenAll(uniTask2, UniTask.WaitUntil(() => !cameraMoving, PlayerLoopTiming.Update, token));
		vc1.gameObject.SetActive(value: false);
		vc2.gameObject.SetActive(value: false);
		behave.SetFaceDir(lastFaceDir);
		await UniTask.Delay(TimeSpan.FromSeconds(rotateTime), DelayType.DeltaTime, PlayerLoopTiming.Update, token);
		Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: false);
	}

	private async UniTask MoveCamera()
	{
		cameraMoving = true;
		CinemachineCore.GetBlendOverride = (CinemachineCore.GetBlendOverrideDelegate)Delegate.Combine(CinemachineCore.GetBlendOverride, new CinemachineCore.GetBlendOverrideDelegate(OnGetBlendOverride));
		vc1.gameObject.SetActive(value: true);
		await UniTask.DelayFrame(1);
		vc2.gameObject.SetActive(value: true);
		await UniTask.Delay(TimeSpan.FromSeconds(m_data.target.cameraDamping));
		cameraMoving = false;
	}

	private CinemachineBlendDefinition OnGetBlendOverride(ICinemachineCamera vcam, ICinemachineCamera toVcam, CinemachineBlendDefinition blend, MonoBehaviour owner)
	{
		if ((CinemachineVirtualCamera)toVcam == vc1)
		{
			return new CinemachineBlendDefinition
			{
				m_Style = CinemachineBlendDefinition.Style.Cut,
				m_CustomCurve = null,
				m_Time = 0f
			};
		}
		if ((CinemachineVirtualCamera)vcam == vc2)
		{
			return new CinemachineBlendDefinition
			{
				m_Style = CinemachineBlendDefinition.Style.EaseInOut,
				m_CustomCurve = null,
				m_Time = 0.5f
			};
		}
		if ((CinemachineVirtualCamera)toVcam == vc2)
		{
			return new CinemachineBlendDefinition
			{
				m_Style = CinemachineBlendDefinition.Style.EaseInOut,
				m_CustomCurve = null,
				m_Time = m_data.target.cameraDamping
			};
		}
		return CinemachineCore.Instance.GetActiveBrain(0).m_DefaultBlend;
	}

	public void ModifyVirtualCameraDamping(Vector3 damping)
	{
		currentCamera = CinemachineCore.Instance.GetVirtualCamera(0) as CinemachineVirtualCamera;
		CinemachineFramingTransposerACT cinemachineComponent = currentCamera.GetCinemachineComponent<CinemachineFramingTransposerACT>();
		currentDamping = new Vector3(cinemachineComponent.m_XDamping, cinemachineComponent.m_YDamping, cinemachineComponent.m_ZDamping);
		cinemachineComponent.m_XDamping = damping.x;
		cinemachineComponent.m_YDamping = damping.y;
		cinemachineComponent.m_ZDamping = damping.z;
	}

	private void RevertDamping()
	{
		if ((bool)currentCamera)
		{
			CinemachineFramingTransposerACT cinemachineComponent = currentCamera.GetCinemachineComponent<CinemachineFramingTransposerACT>();
			currentDamping = new Vector3(cinemachineComponent.m_XDamping, cinemachineComponent.m_YDamping, cinemachineComponent.m_ZDamping);
			cinemachineComponent.m_XDamping = currentDamping.x;
			cinemachineComponent.m_YDamping = currentDamping.y;
			cinemachineComponent.m_ZDamping = currentDamping.z;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0)
		{
			entry.HandleExit();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0)
		{
			entry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 0)
		{
			entry.HandleUninit();
		}
	}

	protected override bool NeedInteractTip()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null || interactEntry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	private void OnDestroy()
	{
		m_Cts?.Cancel();
		m_Cts = null;
	}
}
