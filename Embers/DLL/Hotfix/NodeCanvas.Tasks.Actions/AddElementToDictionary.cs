using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Dictionaries")]
[Preserve]
public class AddElementToDictionary<T> : ActionTask
{
	[BlackboardOnly]
	[RequiredField]
	public BBParameter<Dictionary<string, T>> dictionary;

	public BBParameter<string> key;

	public BBParameter<T> value;

	protected override string info => $"{dictionary}[{key}] = {value}";

	protected override void OnExecute()
	{
		if (dictionary.value == null)
		{
			EndAction(success: false);
			return;
		}
		dictionary.value[key.value] = value.value;
		EndAction();
	}
}
