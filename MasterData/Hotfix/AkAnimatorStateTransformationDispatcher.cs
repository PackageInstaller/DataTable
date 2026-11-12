using UnityEngine;

public class AkAnimatorStateTransformationDispatcher : StateMachineBehaviour
{
	public AkAnimatorAudio.State state;

	private AkAnimatorAudio _player;

	private static readonly int IsDazeHash = Animator.StringToHash("is_daze");

	private IHurtAnimatorHost _hurtHost;

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if ((object)_player == null)
		{
			_player = animator.GetComponent<AkAnimatorAudio>();
		}
		if (_hurtHost == null)
		{
			_hurtHost = animator.GetComponent<IHurtAnimatorHost>();
		}
		if (state == AkAnimatorAudio.State.Hurt_Large || state == AkAnimatorAudio.State.Hurt_Samll1 || state == AkAnimatorAudio.State.Hurt_Samll2)
		{
			_hurtHost?.SetHurt(value: true);
		}
		if (_player != null)
		{
			_player.OnStateEnter(state);
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (state == AkAnimatorAudio.State.Hurt_Large || state == AkAnimatorAudio.State.Hurt_Samll1 || state == AkAnimatorAudio.State.Hurt_Samll2)
		{
			animator.GetComponent<IHurtAnimatorHost>()?.SetHurt(value: false);
		}
		if (_player != null)
		{
			_player.OnStateExit(state);
		}
	}
}
