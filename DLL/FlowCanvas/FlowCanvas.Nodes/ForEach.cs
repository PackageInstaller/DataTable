using System;
using System.Collections;
using System.Collections.Generic;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Description("Enumerate a value (usualy a list or array) for each of it's elements")]
[Category("Flow Controllers/Iterators")]
[ContextDefinedInputs(new Type[] { typeof(IEnumerable) })]
[ContextDefinedOutputs(new Type[] { typeof(object) })]
public class ForEach : FlowControlNode
{
	private object currentObject;

	private int currentIndex;

	private bool broken;

	private ValueInput<IEnumerable> enumerableInput;

	protected override void RegisterPorts()
	{
		enumerableInput = AddValueInput<IEnumerable>("Value");
		AddValueOutput("Current", () => currentObject);
		AddValueOutput("Index", () => currentIndex);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			currentIndex = -1;
			IEnumerable value = enumerableInput.value;
			if (value == null)
			{
				fFinish.Call(f);
			}
			else
			{
				broken = false;
				f.breakCall = delegate
				{
					broken = true;
				};
				foreach (object item in value)
				{
					if (broken)
					{
						break;
					}
					currentObject = item;
					currentIndex++;
					fCurrent.Call(f);
				}
				f.breakCall = null;
				fFinish.Call(f);
			}
		});
		AddFlowInput("Break", delegate
		{
			broken = true;
		});
	}

	public override Type GetNodeWildDefinitionType()
	{
		return typeof(IEnumerable);
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (port == enumerableInput)
		{
			Type enumerableElementType = otherPort.type.GetEnumerableElementType();
			if (enumerableElementType != null)
			{
				ReplaceWith(typeof(ForEach<>).RTMakeGenericType(enumerableElementType));
			}
		}
	}
}
[Description("Enumerate a value (usualy a list or array) for each of it's elements")]
[Category("Flow Controllers/Iterators")]
[ContextDefinedInputs(new Type[] { typeof(IEnumerable<>) })]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[ExposeAsDefinition]
public class ForEach<T> : FlowControlNode
{
	private T currentObject;

	private int currentIndex;

	private bool broken;

	protected override void RegisterPorts()
	{
		ValueInput<IEnumerable<T>> list = AddValueInput<IEnumerable<T>>("Value");
		AddValueOutput("Current", () => currentObject);
		AddValueOutput("Index", () => currentIndex);
		FlowOutput fCurrent = AddFlowOutput("Do");
		FlowOutput fFinish = AddFlowOutput("Done");
		AddFlowInput("In", delegate(Flow f)
		{
			currentIndex = -1;
			IEnumerable<T> value = list.value;
			if (value == null)
			{
				fFinish.Call(f);
			}
			else
			{
				broken = false;
				f.breakCall = delegate
				{
					broken = true;
				};
				foreach (T item in value)
				{
					if (broken)
					{
						break;
					}
					currentObject = item;
					currentIndex++;
					fCurrent.Call(f);
				}
				f.breakCall = null;
				fFinish.Call(f);
			}
		});
		AddFlowInput("Break", delegate
		{
			broken = true;
		});
	}
}
