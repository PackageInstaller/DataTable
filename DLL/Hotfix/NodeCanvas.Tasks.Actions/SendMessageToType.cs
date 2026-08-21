using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Reflected")]
[Description("Send a Unity message to all game objects with a component of the specified type.\nNotice: This is slow and should not be called per-fame.")]
public class SendMessageToType<T> : ActionTask where T : Component
{
	[RequiredField]
	public BBParameter<string> message;

	[BlackboardOnly]
	public BBParameter<object> argument;

	protected override string info => $"Message {message}({argument}) to all {typeof(T).Name}s";

	protected override void OnExecute()
	{
		T[] array = Object.FindObjectsOfType<T>();
		if (array.Length == 0)
		{
			EndAction(success: false);
			return;
		}
		T[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			array2[i].gameObject.SendMessage(message.value, argument.value);
		}
		EndAction(success: true);
	}
}
