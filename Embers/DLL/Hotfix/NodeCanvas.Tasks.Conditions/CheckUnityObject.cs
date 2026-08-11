using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
[Obsolete("Use CheckVariable(T)")]
public class CheckUnityObject : ConditionTask
{
	[BlackboardOnly]
	public BBParameter<UnityEngine.Object> valueA;

	public BBParameter<UnityEngine.Object> valueB;

	protected override string info => valueA?.ToString() + " == " + valueB;

	protected override bool OnCheck()
	{
		return valueA.value == valueB.value;
	}
}
