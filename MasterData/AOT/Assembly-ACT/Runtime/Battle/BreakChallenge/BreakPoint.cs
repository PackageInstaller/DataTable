using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace Runtime.Battle.BreakChallenge;

public class BreakPoint : MonoBehaviour, IDamageable
{
	[SerializeField]
	private Animator _animator;

	private int _id;

	private int _state;

	private int _moveState;

	public Animator Animator => _animator;

	public void SetMeta(int id)
	{
		_id = id;
	}

	public void Do(ActionMemory actionMemory)
	{
		if (_state == 1 && actionMemory.owner.IsLogicAvailable() && actionMemory.owner.IsCharacter())
		{
			_animator.SetInteger("state", 0);
			_animator.SetInteger("moveState", 0);
		}
	}

	public void OnBreakByEvent()
	{
		Singleton<BreakChallengeManager>.instance.OnBreakPointHit(_id);
	}

	public void InitState(int state, int moveState)
	{
		_state = state;
		_moveState = moveState;
		_animator.SetInteger("state", _state);
		_animator.SetInteger("moveState", _moveState);
	}

	private void FixedUpdate()
	{
		if (_animator != null)
		{
			_animator.speed = (MonoECS.instance.running ? 1f : 0f);
		}
	}
}
