using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Reflected")]
[Description("SendMessage to the agent, optionaly with an argument")]
[Preserve]
public class SendMessage : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<string> methodName;

	protected override string info => $"Message {methodName}()";

	protected override void OnExecute()
	{
		base.agent.SendMessage(methodName.value);
		EndAction();
	}
}
[Category("✫ Reflected")]
[Description("SendMessage to the agent, optionaly with an argument")]
public class SendMessage<T> : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<string> methodName;

	public BBParameter<T> argument;

	protected override string info => $"Message {methodName}({argument.ToString()})";

	protected override void OnExecute()
	{
		if (argument.isNull)
		{
			base.agent.SendMessage(methodName.value);
		}
		else
		{
			base.agent.SendMessage(methodName.value, argument.value);
		}
		EndAction();
	}
}
