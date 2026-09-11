using System;
using Dorm.Character;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace QWorld.Story.Runtime;

[DisallowMultipleComponent]
public class QWStoryGraphActor : MonoBehaviour
{
	private GameObject root;

	private Animator anim;

	private bool enableRootmotion;

	private Action mOnAnimatorEnd;

	private bool waitAnimEnd;

	private float animStartTime;

	private float animDuration;

	public bool isInRush;

	private Action mOnEmoteEnd;

	private bool waitEmoteEnd;

	private float emoteStartTime;

	private float emoteDuration;

	private PlayerCharacterFaceControl faceControl;

	private QWSeekerMoveComponent seeker;

	private float seekerSpped;

	private QWLookAtComponent lookAtComp;

	private QWAttachPointSetup attachPoint;

	[NonSerialized]
	[NoToLua]
	public QWCriLipsComponent criLipsComp;

	private CriAtomExPlayback _Playback;

	[NoToLua]
	public GameObject customFace;

	private Transform mHead;

	public Action OnAnimatorEnd
	{
		get
		{
			return mOnAnimatorEnd;
		}
		set
		{
			if (value == null)
			{
				mOnAnimatorEnd = null;
				return;
			}
			if (mOnAnimatorEnd != null && waitAnimEnd)
			{
				waitAnimEnd = false;
				Action action = mOnAnimatorEnd;
				mOnAnimatorEnd = null;
				action?.Invoke();
			}
			mOnAnimatorEnd = value;
		}
	}

	public Action OnEmoteEnd
	{
		get
		{
			return mOnEmoteEnd;
		}
		set
		{
			if (value == null)
			{
				mOnEmoteEnd = null;
				return;
			}
			if (mOnEmoteEnd != null && waitEmoteEnd)
			{
				waitEmoteEnd = false;
				Action action = mOnEmoteEnd;
				mOnEmoteEnd = null;
				action?.Invoke();
			}
			mOnEmoteEnd = value;
		}
	}

	public void InitActor()
	{
		root = base.gameObject;
		anim = root.GetComponentInChildren<Animator>();
		QWNPCMoveComponent qWNPCMoveComponent = anim.gameObject.AddComponent<QWNPCMoveComponent>();
		qWNPCMoveComponent.animatorMoveDelgate = (Action)Delegate.Combine(qWNPCMoveComponent.animatorMoveDelgate, new Action(OnAnimMove));
		attachPoint = root.GetComponent<QWAttachPointSetup>();
		enableRootmotion = false;
		waitAnimEnd = false;
		isInRush = false;
		animStartTime = 0f;
		animDuration = 0f;
		faceControl = attachPoint.GetPerformRoot().GetComponent<PlayerCharacterFaceControl>();
		InitAnim();
	}

	private void InitAnim()
	{
		Transform transform = attachPoint.GetPerformRoot().Find("face");
		if (transform != null)
		{
			mHead = transform.GetComponent<SkinnedMeshRenderer>().rootBone;
		}
	}

	[NoToLua]
	public void Dispose()
	{
	}

	public void PlayAnimaton(bool needWait, string animName, float crossFadeTime, float time = 0f)
	{
		anim?.CrossFade(animName, crossFadeTime, 0, 0f);
		if (needWait)
		{
			waitAnimEnd = true;
			animStartTime = Time.time;
			animDuration = time;
		}
	}

	public void PlayEmote(string animName, float crossFadeTime, float time = 0f, bool isLoop = false)
	{
		if (isLoop)
		{
			anim?.CrossFade(animName, crossFadeTime, 1, 0f);
			waitEmoteEnd = false;
			OnEmoteEnd?.Invoke();
			OnEmoteEnd = null;
		}
		else
		{
			anim?.CrossFade(animName, crossFadeTime, 1, 0f);
			waitEmoteEnd = true;
			emoteStartTime = Time.time;
			emoteDuration = time;
		}
		anim.SetLayerWeight(1, 1f);
	}

	public void PlayTalkSheet(string cueSheet, string cueName, bool useStream = true)
	{
		if (criLipsComp == null)
		{
			criLipsComp = new QWCriLipsComponent(attachPoint.GetPerformRoot().GetComponent<SDCharacter>());
		}
		_Playback = AudioManager.Instance.Play("voice", cueSheet, cueName, useStream);
		if (criLipsComp != null)
		{
			criLipsComp.Play(cueSheet, cueName, _Playback);
		}
	}

	public void EndEmote()
	{
		anim.SetLayerWeight(1, 0f);
		waitEmoteEnd = false;
		OnEmoteEnd?.Invoke();
		OnEmoteEnd = null;
	}

	public void OnClear()
	{
		waitAnimEnd = false;
		waitEmoteEnd = false;
		ClearSeeker();
		OnAnimatorEnd = null;
		OnEmoteEnd = null;
		anim.SetLayerWeight(1, 0f);
	}

	public void ClearOnNext()
	{
		if (_Playback.status != CriAtomExPlayback.Status.Removed)
		{
			_Playback.Stop();
			_Playback = new CriAtomExPlayback(uint.MaxValue);
			if (criLipsComp != null)
			{
				criLipsComp.Stop();
			}
		}
	}

	public void SetTransform(Transform trans)
	{
		base.transform.position = trans.position;
		base.transform.rotation = trans.rotation;
		base.transform.localScale = trans.localScale;
	}

	public void EnableRootmotion(bool enable)
	{
		enableRootmotion = enable;
	}

	public void EnableNoneEyeFace(bool enable)
	{
		faceControl.normalFace.SetActive(!enable);
		faceControl.specialFace.SetActive(enable);
	}

	public void EnableLookAt(bool enableLookAt, Transform target)
	{
		if (lookAtComp == null)
		{
			lookAtComp = root.AddComponent<QWLookAtComponent>();
			lookAtComp.head = GetHeadTrans();
			lookAtComp.TryInit();
			lookAtComp.Show();
		}
		if (enableLookAt)
		{
			lookAtComp.SetTarget(target);
		}
		else
		{
			lookAtComp.SetTarget(null);
		}
	}

	public void SetLookAtParams(float headWeight, float ikWeight, float lookDuration)
	{
		if (lookAtComp == null)
		{
			lookAtComp = root.AddComponent<QWLookAtComponent>();
			lookAtComp.head = GetHeadTrans();
			lookAtComp.TryInit();
			lookAtComp.Show();
		}
		lookAtComp.headWeight = headWeight;
		lookAtComp.IKPositionWeight = ikWeight;
		lookAtComp.lerpDuration = lookDuration;
	}

	public void OnAnimMove()
	{
		if (enableRootmotion)
		{
			base.transform.position += anim.deltaPosition;
			base.transform.rotation *= anim.deltaRotation;
		}
		if (waitAnimEnd && Time.time - animStartTime > animDuration)
		{
			waitAnimEnd = false;
			Action action = mOnAnimatorEnd;
			mOnAnimatorEnd = null;
			action?.Invoke();
		}
		if (waitEmoteEnd && Time.time - emoteStartTime > emoteDuration)
		{
			waitEmoteEnd = false;
			anim.SetLayerWeight(1, 0f);
			Action action2 = mOnEmoteEnd;
			mOnEmoteEnd = null;
			action2?.Invoke();
		}
	}

	[NoToLua]
	public void Tick()
	{
		seeker?.Tick();
	}

	[NoToLua]
	public void LateTick()
	{
		criLipsComp?.LateTick();
	}

	public void StartSeeker(Vector3 endForward, Vector3[] routes, float speed, Action stopCallback)
	{
		isInRush = false;
		if (seeker == null)
		{
			seeker = new QWSeekerMoveComponent(base.transform);
			QWSeekerMoveComponent qWSeekerMoveComponent = seeker;
			qWSeekerMoveComponent.OnMove = (QWOnSeekerDelegate)Delegate.Combine(qWSeekerMoveComponent.OnMove, new QWOnSeekerDelegate(OnSeekerMove));
			QWSeekerMoveComponent qWSeekerMoveComponent2 = seeker;
			qWSeekerMoveComponent2.OnStartMove = (Action)Delegate.Combine(qWSeekerMoveComponent2.OnStartMove, new Action(OnSeekerStartMove));
			QWSeekerMoveComponent qWSeekerMoveComponent3 = seeker;
			qWSeekerMoveComponent3.OnStop = (Action)Delegate.Combine(qWSeekerMoveComponent3.OnStop, new Action(OnSeekerStop));
			QWSeekerMoveComponent qWSeekerMoveComponent4 = seeker;
			qWSeekerMoveComponent4.OnRotate = (QWOnRotateDelegate)Delegate.Combine(qWSeekerMoveComponent4.OnRotate, new QWOnRotateDelegate(OnSeekerRotate));
		}
		seekerSpped = speed;
		seeker.StartSeekerByRoute(new QWSeekerByRouteContext
		{
			needForward = true,
			endForward = endForward
		}, routes, stopCallback, null, isRun: false, 0f, -1f, null, lerpY: true);
	}

	private void OnSeekerMove(Vector3 dir, Vector3 targetPos)
	{
		base.transform.position += dir * seekerSpped * Time.deltaTime;
		base.transform.forward = Vector3.ProjectOnPlane(dir, Vector3.up);
	}

	private void OnSeekerStartMove()
	{
		if (seekerSpped <= 2f)
		{
			PlayAnimaton(needWait: false, "walk", 0.05f);
			isInRush = false;
		}
		else
		{
			PlayAnimaton(needWait: false, "rush", 0.05f);
			isInRush = true;
		}
	}

	private void OnSeekerStop()
	{
		if (!isInRush)
		{
			PlayAnimaton(needWait: false, "walk_stop", 0.05f);
		}
		else
		{
			PlayAnimaton(needWait: false, "rush_stop", 0.05f);
		}
		isInRush = false;
	}

	private void OnSeekerRotate(Quaternion rot)
	{
		if (isInRush)
		{
			PlayAnimaton(needWait: false, "walk", 0.05f);
			isInRush = false;
		}
		base.transform.rotation = rot;
	}

	private void ClearSeeker()
	{
		if (seeker != null)
		{
			seeker.StopNoNotify();
		}
	}

	public Transform GetAttachPoint(int id)
	{
		return attachPoint.GetAttachPoint((QW_BaseAttachPointType)id);
	}

	public Transform GetHeadTrans()
	{
		return mHead;
	}
}
