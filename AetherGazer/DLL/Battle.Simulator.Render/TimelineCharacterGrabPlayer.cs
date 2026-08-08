using UnityEngine;

public class TimelineCharacterGrabPlayer
{
	private enum ClipStatus
	{
		None,
		Enter,
		Update,
		Exit
	}

	private NAgent _agent;

	private Transform _tran;

	private TimelineInfo _timeline;

	private Transform _grabTargetTran;

	private ClipStatus _grabStatus;

	private ClipStatus _throwStatus;

	private bool isRunning;

	private bool isGrab;

	internal void Initialize(Transform transform, NAgent agent)
	{
		_agent = agent;
		_tran = transform;
		_grabStatus = ClipStatus.None;
		_throwStatus = ClipStatus.None;
		_grabTargetTran = null;
		isGrab = false;
	}

	internal void Shutdown()
	{
		_agent = null;
		_tran = null;
		_timeline = null;
		_grabTargetTran = null;
		isGrab = false;
	}

	internal void Play(TimelineInfo timelineInfo)
	{
		_timeline = timelineInfo;
		_grabStatus = ClipStatus.None;
		_throwStatus = ClipStatus.None;
	}

	internal void Update(float currentNormalize)
	{
		if (_timeline.CharacterGrabClips != null && _timeline.CharacterGrabClips.Count > 0)
		{
			for (int i = 0; i < _timeline.CharacterGrabClips.Count; i++)
			{
				CharacterGrabClip characterGrabClip = _timeline.CharacterGrabClips[i];
				if (characterGrabClip == null)
				{
					continue;
				}
				float beginNormalized = characterGrabClip.GetBeginNormalized();
				float endNormalized = characterGrabClip.GetEndNormalized();
				if (currentNormalize >= beginNormalized && currentNormalize < endNormalized)
				{
					if (_grabStatus == ClipStatus.None)
					{
						_grabStatus = ClipStatus.Enter;
						isRunning = true;
						OnGrabEnter(characterGrabClip);
					}
					else if (_grabStatus == ClipStatus.Enter || _grabStatus == ClipStatus.Update)
					{
						_grabStatus = ClipStatus.Update;
						OnGrabUpdate(characterGrabClip);
					}
				}
				else if (_grabStatus == ClipStatus.Update)
				{
					OnGrabExit(characterGrabClip);
					_grabStatus = ClipStatus.Exit;
				}
				else if (_grabStatus == ClipStatus.Exit)
				{
					_grabStatus = ClipStatus.None;
				}
			}
		}
		if (_timeline.CharacterThrowClips == null || _timeline.CharacterThrowClips.Count <= 0)
		{
			return;
		}
		for (int j = 0; j < _timeline.CharacterThrowClips.Count; j++)
		{
			CharacterThrowClip characterThrowClip = _timeline.CharacterThrowClips[j];
			if (characterThrowClip == null)
			{
				continue;
			}
			float beginNormalized2 = characterThrowClip.GetBeginNormalized();
			float endNormalized2 = characterThrowClip.GetEndNormalized();
			if (currentNormalize >= beginNormalized2 && currentNormalize < endNormalized2)
			{
				_ = (_agent.Blackboard as BBHumanoid).AimingTarget;
				if (_throwStatus == ClipStatus.None)
				{
					_throwStatus = ClipStatus.Enter;
					OnThrowEnter(characterThrowClip);
				}
				else if (_throwStatus == ClipStatus.Enter || _throwStatus == ClipStatus.Update)
				{
					_throwStatus = ClipStatus.Update;
					OnThrowUpdate(characterThrowClip);
				}
			}
			else if (_throwStatus == ClipStatus.Update)
			{
				_throwStatus = ClipStatus.Exit;
				OnThrowExit(characterThrowClip);
			}
			else if (_throwStatus == ClipStatus.Exit)
			{
				_throwStatus = ClipStatus.None;
			}
		}
	}

	internal void Pause(bool isPause)
	{
	}

	internal void Stop(bool isForceCleanEffect)
	{
		_grabStatus = ClipStatus.None;
		OnThrowExit(null);
	}

	internal void UpdateTransform(Vector3 position, Vector3 forward)
	{
	}

	internal void SetTimeScale(float timeScale)
	{
	}

	private void OnGrabEnter(CharacterGrabClip grab)
	{
		int grabTarget = (_agent.Blackboard as BBHumanoid).m_NextSimFrameData.GrabTarget;
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(grabTarget);
		if (agent != null)
		{
			float normalizedTimeOffset = (float)grab.TargetGrabPoseFrame / grab.GetLength();
			float normalizedTransitionDuration = grab.TargetGrabPoseCrossFadeTime;
			agent.Animator.CrossFade(grab.TargetGrabAnimationName, normalizedTransitionDuration, 0, normalizedTimeOffset);
			agent.Animator.Update(0f);
			agent.Animator.speed = 0f;
			(agent.Blackboard as BBHumanoid).LastHeight = 0f;
			agent.transform.position = agent.transform.position.NewY(0f);
			_grabTargetTran = agent.transform;
			Transform attachPoint = _grabTargetTran.GetComponent<AttachPointSetup>().GetAttachPoint(grab.TargetGrabPoint);
			if (attachPoint == null)
			{
				Debug.LogError("找不到抓取点");
				attachPoint = _grabTargetTran.GetComponent<AttachPointSetup>().GetAttachPoint(En_BaseAttachPointType.HitPoint);
			}
			Vector3 vector = attachPoint.position - _grabTargetTran.position;
			Transform attachPoint2 = _tran.GetComponent<AttachPointSetup>().GetAttachPoint(grab.GrabPoint);
			_grabTargetTran.SetParent(attachPoint2);
			_grabTargetTran.localPosition = Vector3.zero;
			_grabTargetTran.position -= vector;
			isGrab = true;
		}
	}

	private void OnGrabExit(CharacterGrabClip grab)
	{
		isGrab = false;
	}

	private void OnGrabUpdate(CharacterGrabClip grab)
	{
		if (!isGrab)
		{
			OnGrabEnter(grab);
		}
	}

	private void OnThrowEnter(CharacterThrowClip throwClip)
	{
	}

	private void OnThrowExit(CharacterThrowClip throwClip)
	{
		if (!(_agent == null) && !(_agent.Blackboard == null) && _agent.IsInit && isRunning)
		{
			isRunning = false;
			int aimingTarget = (_agent.Blackboard as BBHumanoid).AimingTarget;
			_ = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(aimingTarget) != null;
			if (_grabTargetTran != null)
			{
				_grabTargetTran.SetParent(null);
				_grabTargetTran = null;
			}
		}
	}

	private void OnThrowUpdate(CharacterThrowClip throwClip)
	{
	}
}
