using System;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Services;

namespace FlowCanvas.Nodes;

[Description("Should always be used to return out of a Custom Function. The return value is only required if the Custom Function returns a value as well.")]
[Category("Functions/Custom")]
[ContextDefinedInputs(new Type[] { typeof(object) })]
public class Return : FlowControlNode
{
	[GatherPortsCallback]
	public bool useReturnValue = true;

	private ValueInput<object> returnPort;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		writer.Write(useReturnValue);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		useReturnValue = reader.ReadBoolean();
	}

	protected override void RegisterPorts()
	{
		if (useReturnValue)
		{
			returnPort = AddValueInput<object>("Value");
		}
		AddFlowInput(" ", delegate(Flow f)
		{
			Flow.ReturnData returnData = f.PopReturnData();
			if (returnData.returnCall == null)
			{
				Fail("The 'Return' node should be called as part of a Custom Function node.");
			}
			else if (useReturnValue)
			{
				object value = returnPort.value;
				if (returnData.returnType == null)
				{
					if (value != null)
					{
						Logger.LogWarning("Function Returns a value, but no value is required", null, this);
					}
					returnData.returnCall(value);
				}
				else
				{
					Type type = value?.GetType();
					if ((type == null && returnData.returnType.RTIsValueType()) || (type != null && !returnData.returnType.RTIsAssignableFrom(type)))
					{
						Fail($"Return Value is not of expected type '{returnData.returnType.FriendlyName()}'.");
					}
					else
					{
						returnData.returnCall(value);
					}
				}
			}
			else
			{
				returnData.returnCall(null);
			}
		});
	}
}
