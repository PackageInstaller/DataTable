using UnityEngine;

public class Elfin : MonoBehaviour, IPendant
{
	public int RoleID;

	public float RunSpeed;

	public float RushSpeed;

	public float RotationSpeed;

	public float RushDistance;

	public Vector3 Offset = Vector3.zero;

	public int Run;

	public int Rush;

	public int Idle;

	public int Stop;

	private int _timelineID;

	private bool _isPlaying;

	private NAgent _parent;

	private BBHumanoid _blackboard;

	private TimelinePlayer _timeline;

	public void ActionHandler(AgentAction agentAction)
	{
		if (agentAction is AgentActionAbilityEnter)
		{
			AgentActionAbilityEnter agentActionAbilityEnter = agentAction as AgentActionAbilityEnter;
			int mAblityID = agentActionAbilityEnter.mAblityID;
			TimelineInfo timelineInfo = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(mAblityID);
			if (null == timelineInfo)
			{
				Debug.Log("Can't Find " + agentActionAbilityEnter.mAblityID);
				return;
			}
			mAblityID = RoleID * 1000 + timelineInfo.PandentPlayTimelineID;
			TimelineInfo timelineInfo2 = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(mAblityID);
			if (null == timelineInfo2)
			{
				base.transform.gameObject.SetActive(!timelineInfo.PandentIsHide);
				return;
			}
			_timelineID = mAblityID;
			_isPlaying = true;
		}
		else if (agentAction is AgentActionAbilityLeave)
		{
			_isPlaying = false;
		}
	}

	public void Finish()
	{
		_parent = null;
		_timelineID = 0;
		_isPlaying = false;
		_timeline.Shutdown();
		PooledAsset.DestroyOrReturn(base.gameObject);
	}

	public void Initialize(NAgent parent)
	{
		_parent = parent;
		_blackboard = _parent.Blackboard as BBHumanoid;
		if (_timeline == null)
		{
			_timeline = new TimelinePlayer();
			_timeline.Initialize(base.transform);
		}
	}

	public void Update()
	{
		Vector3 target = GetTarget();
		float num = Vector3.Distance(base.transform.position, target);
		bool flag = num >= RushDistance;
		if (_isPlaying)
		{
			_timeline.Play(_timelineID);
		}
		else if (_blackboard.inputMovement.Magnitude > 0f || num >= Offset.magnitude)
		{
			_timeline.Play(flag ? Rush : Run);
		}
		else
		{
			_timeline.Play(Idle);
		}
		MoveTo(target, flag ? RushSpeed : RunSpeed);
		_timeline.Update();
	}

	private Vector3 GetTarget()
	{
		return _parent.Position + _parent.Forward * Offset.z + _parent.Right * Offset.x + Vector3.up * Offset.y;
	}

	private void MoveTo(Vector3 target, float speed)
	{
		if (Vector3.Distance(base.transform.position, target) < Time.deltaTime * speed)
		{
			base.transform.position = target;
		}
		else
		{
			base.transform.position += (target - base.transform.position).normalized * Time.deltaTime * speed;
		}
		base.transform.forward = Vector3.Lerp(base.transform.forward, target - base.transform.position, Time.deltaTime * RotationSpeed);
	}
}
