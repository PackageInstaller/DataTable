using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[TypeIcon(typeof(If))]
[UnitCategory("Community/Control")]
[UnitTitle("Else If")]
public class ElseIfUnit : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput Enter;

	[Inspectable]
	public int amount = 1;

	[DoNotSerialize]
	public ControlOutput If;

	[DoNotSerialize]
	public ControlOutput Else;

	[DoNotSerialize]
	public ValueInput condition;

	[DoNotSerialize]
	[PortLabelHidden]
	public List<ControlOutput> elseIfs;

	[DoNotSerialize]
	[PortLabelHidden]
	public List<ValueInput> elseIfConditions;

	protected override void Definition()
	{
		amount = Mathf.Clamp(amount, 1, 10);
		elseIfs = new List<ControlOutput>();
		elseIfConditions = new List<ValueInput>();
		Enter = ControlInput("Enter", ElseIf);
		If = ControlOutput("If");
		Succession(Enter, If);
		condition = ValueInput<bool>("condition");
		for (int i = 0; i < amount; i++)
		{
			ControlOutput controlOutput = ControlOutput("elseif" + i);
			elseIfs.Add(controlOutput);
			Succession(Enter, controlOutput);
			ValueInput valueInput = ValueInput<bool>(i.ToString());
			elseIfConditions.Add(valueInput);
			relations.Add(new UnitRelation(valueInput, controlOutput));
			Requirement(valueInput, Enter);
		}
		Else = ControlOutput("Else");
		Succession(Enter, Else);
	}

	public ControlOutput ElseIf(Flow flow)
	{
		if (flow.GetValue<bool>(condition))
		{
			return If;
		}
		for (int i = 0; i < amount; i++)
		{
			if (flow.GetValue<bool>(elseIfConditions[i]))
			{
				return elseIfs[i];
			}
		}
		return Else;
	}
}
