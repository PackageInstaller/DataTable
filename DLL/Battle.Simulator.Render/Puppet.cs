using UnityEngine;

public class Puppet : MonoBehaviour, IPendant
{
	private enum E_PuppetState
	{
		Idle,
		Moving,
		Attacking,
		Thinking,
		Stop
	}

	private NAgent _parent;

	private BBHumanoid _blackboard;

	public int RoleID;

	public float RunSpeed;

	public float RushSpeed;

	public float BackRushSpeed;

	public float RotationSpeed;

	public float IdleRange;

	public float ThinkTime;

	public float RushDistance;

	public float AttackDistance;

	public Vector3 Offset = Vector3.zero;

	public int Run;

	public int Rush;

	public int Idle;

	public int Stop;

	public string RopePath = string.Empty;

	public En_BaseAttachPointType ParentBone = En_BaseAttachPointType.LeftHand;

	private float _executeTime;

	private Transform _target;

	private int _currentAbilityID;

	private Vector3 _currentOffset = Vector3.zero;

	private E_PuppetState _state;

	private E_PuppetState _lastState;

	private TimelinePlayer _timelinePlayer = new TimelinePlayer();

	private Renderer _renderer;

	private SpringCurve _rope;

	private Transform _spine;

	private Transform _parentHand;

	public void ActionHandler(AgentAction agentAction)
	{
	}

	public void Finish()
	{
		if (null != _rope)
		{
			PooledAsset.DestroyOrReturn(_rope.gameObject);
		}
	}

	public void Initialize(NAgent parent)
	{
		_parent = parent;
		if (!string.IsNullOrEmpty(RopePath))
		{
			GameObject go = Asset.Instantiate(RopePath);
			_rope = U3DUtil.Get<SpringCurve>(go);
			_rope.Initialize();
			AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(base.gameObject);
			_spine = attachPointSetup.GetAttachPoint("Bip001");
			attachPointSetup = U3DUtil.Get<AttachPointSetup>(_parent.gameObject);
			_parentHand = attachPointSetup.GetAttachPoint(ParentBone);
			_rope.From = _spine.position;
			_rope.To = _parentHand.position;
		}
	}

	public void Update()
	{
		UpdateRope();
	}

	private void OnIdle()
	{
		Vector3 target = GetTarget();
		if (Vector3.Distance(base.transform.position, target) > IdleRange)
		{
			_target = _parent.transform;
			SetState(E_PuppetState.Moving, Run);
		}
		else
		{
			Play(Idle);
			UpdateRotation(_parent.Forward, targetPosIsForward: true);
		}
	}

	private void OnMoving()
	{
		Vector3 target = GetTarget();
		float num = Vector3.Distance(base.transform.position, target);
		bool flag = num > RushDistance;
		if (TargetIsParent() && _blackboard.inputMovement.Magnitude <= 0f && num <= AttackDistance)
		{
			SetState(E_PuppetState.Stop, Stop);
			return;
		}
		if (!TargetIsParent() && (num <= AttackDistance || _executeTime <= 0f))
		{
			SetState(E_PuppetState.Attacking, _currentAbilityID);
			return;
		}
		UpdateRotation(target, targetPosIsForward: false);
		if (!TargetIsParent())
		{
			MoveTo(target, RushSpeed);
			Play(Rush);
		}
		else if (TargetIsParent() && E_PuppetState.Thinking == _lastState)
		{
			MoveTo(target, BackRushSpeed);
			Play(Rush);
		}
		else
		{
			MoveTo(target, flag ? RushSpeed : RunSpeed);
			Play(flag ? Rush : Run);
		}
	}

	private void OnAttacking()
	{
		Play(_currentAbilityID);
		if (_executeTime <= 0f)
		{
			_renderer.enabled = true;
			_currentOffset = Offset;
			if (_target != _parent.transform)
			{
				SetState(E_PuppetState.Thinking, Idle, ThinkTime);
			}
			else
			{
				SetState(E_PuppetState.Idle, Idle);
			}
		}
	}

	private void OnThinking()
	{
		Play(Idle);
		UpdateRotation(GetTarget(), !TargetIsParent());
		if (_executeTime <= 0f)
		{
			_target = _parent.transform;
			SetState(E_PuppetState.Moving, Rush);
		}
	}

	private void OnStop()
	{
		Play(Stop);
		if (_executeTime <= 0f)
		{
			SetState(E_PuppetState.Idle, Idle);
		}
	}

	private Vector3 GetTarget()
	{
		return _target.position + _target.forward * _currentOffset.z + _target.right * _currentOffset.x + _target.up * _currentOffset.y;
	}

	private void Play(int id)
	{
		_timelinePlayer.Play(id);
	}

	private void MoveTo(Vector3 target, float speed)
	{
		if (Vector3.Distance(target, base.transform.position) <= speed * Time.deltaTime)
		{
			base.transform.position = target;
		}
		else
		{
			base.transform.position += (target - base.transform.position).normalized * speed * Time.deltaTime;
		}
	}

	private void UpdateRotation(Vector3 targetpOS, bool targetPosIsForward, bool forceSet = false)
	{
		Vector3 vector = targetpOS;
		if (!targetPosIsForward)
		{
			vector = targetpOS - base.transform.position;
		}
		if (forceSet)
		{
			base.transform.forward = vector;
		}
		else
		{
			base.transform.forward = Vector3.Lerp(base.transform.forward, vector, Time.deltaTime * RotationSpeed);
		}
	}

	private void SetState(E_PuppetState state, int abilityID, float executeTime = -1f)
	{
		_currentAbilityID = abilityID;
		_lastState = _state;
		_state = state;
		if (executeTime <= -1f)
		{
			TimelineInfo timelineInfo = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(abilityID);
			if (null != timelineInfo)
			{
				_executeTime = timelineInfo.duration;
				if (null != _timelinePlayer.TimelineInfo && abilityID == _timelinePlayer.TimelineInfo.ID)
				{
					_timelinePlayer.Stop();
				}
				Play(abilityID);
			}
		}
		else
		{
			_executeTime = executeTime;
		}
	}

	private void UpdateRope()
	{
		if (null != _rope)
		{
			_rope.From = _spine.position;
			_rope.To = _parentHand.position;
		}
	}

	private bool TargetIsParent()
	{
		return _target == _parent.transform;
	}

	public void RemoveRope()
	{
		if (_rope != null)
		{
			PooledAsset.DestroyOrReturn(_rope.gameObject);
			_rope = null;
		}
	}
}
