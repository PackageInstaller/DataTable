using UnityEngine;

namespace BehaviorDesigner.Runtime.Tasks;

public abstract class Composite : ParentTask
{
	[Tooltip("Specifies the type of conditional abort. More information is located at https://www.opsive.com/support/documentation/behavior-designer/conditional-aborts/.")]
	[SerializeField]
	protected AbortType abortType;

	public AbortType AbortType => abortType;

	public virtual bool OnReevaluationStarted()
	{
		return false;
	}

	public virtual void OnReevaluationEnded(TaskStatus status)
	{
	}
}
