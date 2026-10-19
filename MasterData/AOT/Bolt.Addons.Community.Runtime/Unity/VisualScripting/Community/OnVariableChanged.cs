using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[SpecialUnit]
[UnitCategory("Events/Community/Variables")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.OnVariableChanged")]
public sealed class OnVariableChanged : MachineEventUnit<EmptyEventArgs>, IUnifiedVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public new class Data : EventUnit<EmptyEventArgs>.Data
	{
		public object _previousValue;

		public bool firstExecution;
	}

	protected override string hookName => "Update";

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput value { get; private set; }

	[Serialize]
	[Inspectable]
	[InspectorLabel("Initial State")]
	public bool provideInitial { get; set; }

	[DoNotSerialize]
	public ValueInput Initial { get; private set; }

	[UnitHeaderInspectable]
	[Serialize]
	[Inspectable]
	public VariableKind kind { get; set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	[NullMeansSelf]
	public ValueInput @object { get; private set; }

	public override IGraphElementData CreateData()
	{
		return new Data();
	}

	protected override void Definition()
	{
		base.Definition();
		name = ValueInput("name", string.Empty);
		value = ValueOutput<object>("value");
		if (provideInitial)
		{
			Initial = ValueInput<object>("Initial").AllowsNull();
			Requirement(Initial, value);
		}
		if (kind == VariableKind.Object)
		{
			@object = ValueInput<GameObject>("object", null).NullMeansSelf();
		}
		if (kind == VariableKind.Object)
		{
			Requirement(@object, value);
		}
	}

	public override void StartListening(GraphStack stack)
	{
		base.StartListening(stack);
		Data elementData = stack.GetElementData<Data>(this);
		elementData._previousValue = null;
		elementData.firstExecution = true;
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.isListening)
		{
			return false;
		}
		string variable = flow.GetValue<string>(name);
		object obj = (kind switch
		{
			VariableKind.Flow => flow.variables, 
			VariableKind.Graph => Variables.Graph(flow.stack), 
			VariableKind.Object => Variables.Object(flow.GetValue<GameObject>(@object)), 
			VariableKind.Scene => Variables.Scene(flow.stack.scene), 
			VariableKind.Application => Variables.Application, 
			VariableKind.Saved => Variables.Saved, 
			_ => throw new UnexpectedEnumValueException<VariableKind>(kind), 
		}).Get(variable);
		if (elementData.firstExecution)
		{
			if (provideInitial)
			{
				elementData._previousValue = flow.GetValue<object>(Initial);
			}
			else
			{
				elementData._previousValue = obj;
			}
		}
		bool flag = OperatorUtility.Equal(elementData._previousValue, obj);
		if (!flag)
		{
			elementData._previousValue = obj;
			flow.SetValue(value, obj);
		}
		elementData.firstExecution = false;
		return !flag;
	}
}
