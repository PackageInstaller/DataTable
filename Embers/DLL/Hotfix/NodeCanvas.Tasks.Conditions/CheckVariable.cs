#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
[Description("It's best to use the respective Condition for a type if existant since they support operations as well")]
[Preserve]
public class CheckVariable<T> : ConditionTask
{
	[BlackboardOnly]
	public BBParameter<T> valueA;

	public BBParameter<T> valueB;

	protected override string info => valueA?.ToString() + " == " + valueB;

	protected override bool OnCheck()
	{
		try
		{
			return EqualityComparer<T>.Default.Equals(valueA.value, valueB.value);
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message);
			return false;
		}
	}
}
