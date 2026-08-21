using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Dictionaries")]
[Preserve]
public class GetDictionaryElement<T> : ActionTask
{
	[BlackboardOnly]
	[RequiredField]
	public BBParameter<Dictionary<string, T>> dictionary;

	public BBParameter<string> key;

	[BlackboardOnly]
	public BBParameter<T> saveAs;

	protected override string info => $"{saveAs} = {dictionary}[{key}]";

	protected override void OnExecute()
	{
		if (dictionary.value == null)
		{
			EndAction(success: false);
			return;
		}
		saveAs.value = dictionary.value[key.value];
		EndAction();
	}
}
