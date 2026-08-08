using System;
using Cinemachine;
using Cinemachine.Utility;
using UnityEngine;

public class RenderPendant : MonoBehaviour, IPendant
{
	public int PendantID;

	public Action m_lateInitAction;

	private TimelinePlayer _timeline;

	public bool ActionSync;

	public float m_scale6132 = 1f;

	public bool _hide;

	private Transform _casterPoint;

	public int Radius = 400;

	private CharacterEffect _CharacterEffect;

	private CinemachineBrain _Brain;

	public bool DitherAplphaSync;

	private CharacterEffect _casterCharacterEffect;

	public bool PositionSync;

	public static Action<int, int> AgentPushCommandToGhost { get; set; }

	public void ActionHandler(AgentAction action)
	{
		if (!ActionSync)
		{
			return;
		}
		if (action is AgentActionAbilityEnter)
		{
			AgentActionAbilityEnter agentActionAbilityEnter = action as AgentActionAbilityEnter;
			if (agentActionAbilityEnter.mAblityID == 0)
			{
				_timeline.Stop(isForceClean: false);
			}
			else if (agentActionAbilityEnter.mAblityID > 0)
			{
				int mAblityID = agentActionAbilityEnter.mAblityID;
				mAblityID = mAblityID % 1000 + PendantID * 1000;
				TimelineInfo timelineInfo = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(mAblityID);
				if (null != timelineInfo)
				{
					_timeline.Play(mAblityID, agentActionAbilityEnter.mTimeScale, agentActionAbilityEnter.mFrameCount);
				}
			}
		}
		else if (action is AgentActionAbilityLeave)
		{
			_timeline.Stop(isForceClean: false);
		}
		else if (action is AgentActionTimeStepChange)
		{
			AgentActionTimeStepChange agentActionTimeStepChange = action as AgentActionTimeStepChange;
			int num = agentActionTimeStepChange.mAbilityID % 1000 + PendantID * 1000;
			if (null != _timeline.TimelineInfo && (num == _timeline.TimelineInfo.ID || agentActionTimeStepChange.mIsIdle))
			{
				_timeline.CurrentTimelineTimeScale = agentActionTimeStepChange.mTimeScale;
				_timeline.UpdateWorldAndEntityTimeScale(agentActionTimeStepChange.mTimeScale);
			}
		}
	}

	public void Finish()
	{
		_timeline.Stop();
		_timeline.Shutdown();
		_timeline = null;
		_hide = false;
		PooledAsset.DestroyOrReturn(base.gameObject);
	}

	private void OnDestroy()
	{
		AgentPushCommandToGhost = null;
	}

	public void Initialize(NAgent parent)
	{
		if (_timeline == null)
		{
			_timeline = new TimelinePlayer();
		}
		_timeline.Initialize(base.transform, parent, parent.AgentID);
		if (_casterPoint == null)
		{
			_casterPoint = base.transform.FindChildInAllChild("caster_point");
		}
	}

	public void Update()
	{
		if (_timeline != null)
		{
			_timeline.Update();
			UpdatePendantPosition();
			UpdatePendantDitherAlpha();
			UpdatePendantShadowHeight();
		}
	}

	public void OnAnimatorMove()
	{
		if (!(_casterPoint != null))
		{
			return;
		}
		float num = 1f;
		if (PendantID == 6132)
		{
			int num2 = _timeline.TimelineInfo.ID % 1000;
			if (num2 == 202 || num2 == 221 || num2 == 222 || num2 == 223)
			{
				num = m_scale6132;
			}
		}
		base.transform.position = _timeline.NAgent.transform.position + (base.transform.position - _casterPoint.position) * num;
		base.transform.forward = _timeline.NAgent.transform.forward;
	}

	private void LateUpdate()
	{
		if (m_lateInitAction != null)
		{
			m_lateInitAction();
			m_lateInitAction = null;
		}
	}

	public void PlayTimeline(int timelineID)
	{
		if (_timeline != null)
		{
			_timeline.Play(timelineID);
		}
	}

	public void UpdatePendantDitherAlpha()
	{
		if (_CharacterEffect == null)
		{
			_CharacterEffect = base.gameObject.GetComponent<CharacterEffect>();
		}
		if (!(_CharacterEffect != null))
		{
			return;
		}
		if (_hide)
		{
			_CharacterEffect.ditherAlpha = 0.5f;
			return;
		}
		if (DitherAplphaSync)
		{
			if (_casterCharacterEffect == null)
			{
				_casterCharacterEffect = _timeline.NAgent.transform.GetComponent<CharacterEffect>();
			}
			if (_casterCharacterEffect != null)
			{
				_CharacterEffect.ditherAlpha = _casterCharacterEffect.ditherAlpha;
				return;
			}
		}
		if (_Brain == null)
		{
			_Brain = Camera.main.transform.GetComponent<CinemachineBrain>();
		}
		if (!(_Brain != null))
		{
			return;
		}
		Transform lookAt = _Brain.ActiveVirtualCamera.LookAt;
		float num = float.MaxValue;
		float num2 = float.MaxValue;
		float num3 = 0f;
		if (lookAt != null)
		{
			Vector3 vector = base.transform.position.NewY(0f);
			Vector3 vector2 = Camera.main.transform.position.NewY(0f);
			Vector3 vector3 = lookAt.position.NewY(0f);
			num = vector.ClosestPointOnSegment(vector2, vector3);
			num2 = Vector3.SqrMagnitude(vector - Vector3.Lerp(vector2, vector3, num));
			int radius = Radius;
			int num4 = 500;
			num3 = (float)radius / 1000f + (float)num4 / 1000f;
			num3 *= num3;
		}
		if (num2 < num3 && num < 0.8f)
		{
			if (_CharacterEffect.ditherAlpha != 0.5f)
			{
				_CharacterEffect.ditherAlpha = 0.5f;
			}
		}
		else if (_CharacterEffect.ditherAlpha != 1f)
		{
			_CharacterEffect.ditherAlpha = 1f;
		}
	}

	private void UpdatePendantShadowHeight()
	{
		if (_CharacterEffect == null)
		{
			_CharacterEffect = base.gameObject.GetComponent<CharacterEffect>();
		}
		if (!(_CharacterEffect == null))
		{
			_CharacterEffect.shadowHeight = base.transform.root.transform.position.y;
		}
	}

	public void EnableRenders()
	{
		if (_timeline != null)
		{
			_timeline.EnableRenders();
		}
	}

	public void DisableRenders()
	{
		if (_timeline != null)
		{
			_timeline.DisableRenders();
		}
	}

	private void UpdatePendantPosition()
	{
		if (PositionSync)
		{
			base.transform.position = _timeline.NAgent.transform.position;
		}
	}

	public EffectController PlayCommonEffect(string pEffectPath, string pParentFullPath, Vector3 pOffsetPos, Vector3 pScale, Vector3 pOffsetRotation, Vector3 pForward, bool pIsAttach = false, bool pIsLoop = false, bool pNeedManager = false, float pNormalize = 0f, float pEffectKeepTime = 5f, bool pUsePosition = false, Vector3 pCenterPos = default(Vector3), bool pIsLockEffectRotation = false, float timeScale = 1f)
	{
		if (_timeline != null)
		{
			return _timeline.PlayeCommonEffect(pEffectPath, pParentFullPath, pOffsetPos, pScale, pOffsetRotation, pForward, pIsAttach, pIsLoop, pNeedManager, pNormalize, pEffectKeepTime, pUsePosition, pCenterPos, pIsLockEffectRotation, timeScale);
		}
		return null;
	}

	public void SetHideEffect(bool active)
	{
		_hide = active;
	}
}
