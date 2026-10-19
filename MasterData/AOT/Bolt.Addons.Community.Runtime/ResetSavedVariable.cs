using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[UnitCategory("Community/Variables")]
[TypeIcon(typeof(FlowGraph))]
[UnitTitle("ResetSavedVariable")]
public class ResetSavedVariable : Unit
{
	[SerializeAs("_argumentCount")]
	private int _argumentCount;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput Reset;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput OnReset;

	[DoNotSerialize]
	public List<ValueInput> Keys;

	[UnitHeaderInspectable("Keys")]
	[DoNotSerialize]
	public int KeyCount
	{
		get
		{
			return Mathf.Max(1, _argumentCount);
		}
		set
		{
			_argumentCount = Mathf.Clamp(value, 1, 10);
		}
	}

	protected override void Definition()
	{
		Keys = new List<ValueInput>();
		Reset = ControlInput("Reset", _Enter_);
		OnReset = ControlOutput("OnReset");
		for (int i = 0; i < KeyCount; i++)
		{
			ValueInput valueInput = ValueInput("Key " + i, "");
			Requirement(valueInput, Reset);
			Keys.Add(valueInput);
		}
		Succession(Reset, OnReset);
	}

	public ControlOutput _Enter_(Flow flow)
	{
		foreach (ValueInput key in Keys)
		{
			string value = flow.GetValue<string>(key);
			VariableDeclaration variableDeclaration = SavedVariables.initial.GetDeclaration(value).CloneViaFakeSerialization();
			SavedVariables.saved[value] = variableDeclaration.value;
			if (SavedVariables.current != SavedVariables.initial)
			{
				SavedVariables.current[value] = variableDeclaration.value;
			}
		}
		return OnReset;
	}
}
