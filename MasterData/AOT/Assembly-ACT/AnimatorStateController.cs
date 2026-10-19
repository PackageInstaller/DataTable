using ACT;
using UnityEngine;

[ExecuteInEditMode]
public class AnimatorStateController : MonoBehaviour
{
	[SerializeField]
	private Animator animator;

	[SerializeField]
	private string parameter1 = "Param1";

	[SerializeField]
	private string parameter2 = "Param2";

	[SerializeField]
	private string parameter3 = "Param3";

	[SerializeField]
	private string parameter4 = "Param4";

	[SerializeField]
	private string idleState = "Idle";

	[SerializeField]
	private bool useStateReset = true;

	private void Start()
	{
		if (animator == null)
		{
			animator = GetComponent<Animator>();
		}
	}

	public void TriggerParameter1()
	{
		if (animator != null)
		{
			ResetAllParameters();
			animator.Play(idleState, 0, 0f);
			animator.SetTrigger(parameter1);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("触发参数: " + parameter1);
			}
		}
	}

	public void TriggerParameter2()
	{
		if (animator != null)
		{
			ResetAllParameters();
			animator.Play(idleState, 0, 0f);
			animator.SetTrigger(parameter2);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("触发参数: " + parameter2);
			}
		}
	}

	public void TriggerParameter3()
	{
		if (animator != null)
		{
			animator.SetTrigger(parameter3);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("触发参数: " + parameter3);
			}
		}
	}

	public void TriggerParameter4()
	{
		if (animator != null)
		{
			animator.SetTrigger(parameter4);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("触发参数: " + parameter4);
			}
		}
	}

	public void ResetToIdle()
	{
		if (animator != null)
		{
			ResetAllParameters();
			animator.Play(idleState);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("重置回Idle状态");
			}
		}
	}

	private void ResetAllParameters()
	{
		AnimatorControllerParameter[] parameters = animator.parameters;
		foreach (AnimatorControllerParameter animatorControllerParameter in parameters)
		{
			if (animatorControllerParameter.type == AnimatorControllerParameterType.Trigger)
			{
				animator.ResetTrigger(animatorControllerParameter.name);
			}
			else if (animatorControllerParameter.type == AnimatorControllerParameterType.Bool)
			{
				animator.SetBool(animatorControllerParameter.name, value: false);
			}
		}
	}
}
