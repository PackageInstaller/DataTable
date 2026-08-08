using UnityEngine;

namespace Dorm.Character.Animation;

public abstract class DormEntityStateEventBehaviour : StateMachineBehaviour
{
	[Range(0f, 1f)]
	public float chance = 1f;

	public float time;

	public bool repeat;

	private bool ready;

	private void Reset()
	{
		ready = true;
	}

	private bool Ready(in AnimatorStateInfo stateInfo)
	{
		float normalizedTime = stateInfo.normalizedTime;
		if (repeat)
		{
			int num = Mathf.FloorToInt(normalizedTime);
			if ((normalizedTime - (float)num) * stateInfo.length >= time)
			{
				if (ready)
				{
					ready = false;
					return true;
				}
			}
			else
			{
				ready = true;
			}
		}
		else if (ready && normalizedTime * stateInfo.length >= time)
		{
			ready = false;
			return true;
		}
		return false;
	}

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		base.OnStateEnter(animator, stateInfo, layerIndex);
		Reset();
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		base.OnStateUpdate(animator, stateInfo, layerIndex);
		if ((!animator.IsInTransition(layerIndex) || !(stateInfo.normalizedTime > 1f)) && Ready(in stateInfo) && Random.value <= chance)
		{
			int value = 0;
			IEidProvider component = animator.GetComponent<IEidProvider>();
			if (component != null)
			{
				value = component.EntityID;
			}
			if (DormEntityManager.Instance?.TryGet(value) is DormComplexEntity entity)
			{
				InvokeEvent(entity, in stateInfo, layerIndex);
			}
		}
	}

	public abstract void InvokeEvent(DormComplexEntity entity, in AnimatorStateInfo stateInfo, int layerIndex);
}
