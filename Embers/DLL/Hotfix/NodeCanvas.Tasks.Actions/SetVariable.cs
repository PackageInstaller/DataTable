using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
[Preserve]
public class SetVariable<T> : ActionTask
{
	[BlackboardOnly]
	public BBParameter<T> valueA;

	public BBParameter<T> valueB;

	protected override string info => valueA?.ToString() + " = " + valueB;

	protected override void OnExecute()
	{
		valueA.value = valueB.value;
		EndAction();
	}
}
