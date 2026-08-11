using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard/Dictionaries")]
[Preserve]
public class TryGetValue<T> : ConditionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<Dictionary<string, T>> targetDictionary;

	[RequiredField]
	public BBParameter<string> key;

	[BlackboardOnly]
	public BBParameter<T> saveValueAs;

	protected override string info => $"{targetDictionary}.TryGetValue({key} as {saveValueAs})";

	protected override bool OnCheck()
	{
		if (targetDictionary.value == null)
		{
			return false;
		}
		if (targetDictionary.value.TryGetValue(key.value, out var value))
		{
			saveValueAs.value = value;
			return true;
		}
		return false;
	}
}
