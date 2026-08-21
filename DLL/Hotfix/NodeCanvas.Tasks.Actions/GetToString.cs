using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Name("Get Variable To String", 0)]
[Category("✫ Blackboard")]
public class GetToString : ActionTask
{
	[BlackboardOnly]
	public BBParameter<object> variable;

	[BlackboardOnly]
	public BBParameter<string> toString;

	protected override string info => $"{toString} = {variable}.ToString()";

	protected override void OnExecute()
	{
		toString.value = ((!variable.isNull) ? variable.value.ToString() : "NULL");
		EndAction();
	}
}
