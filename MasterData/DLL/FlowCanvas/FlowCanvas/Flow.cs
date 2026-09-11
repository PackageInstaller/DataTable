using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas;

[SpoofAOT]
public struct Flow
{
	public struct ReturnData(FlowReturn call, Type type)
	{
		public FlowReturn returnCall = call;

		public Type returnType = type;
	}

	public int ticks;

	public Dictionary<string, object> parameters;

	public FlowBreak breakCall;

	public Stack<ReturnData> returnData;

	public object userData;

	public static Flow New => default(Flow);

	public void Call(FlowOutput port)
	{
		port.Call(this);
	}

	public T ReadParameter<T>(string name)
	{
		object value = default(T);
		if (parameters != null)
		{
			parameters.TryGetValue(name, out value);
		}
		if (!(value is T))
		{
			return default(T);
		}
		return (T)value;
	}

	public void WriteParameter<T>(string name, T value)
	{
		if (parameters == null)
		{
			parameters = new Dictionary<string, object>();
		}
		parameters[name] = value;
	}

	public void PushReturnData(FlowReturn call, Type type)
	{
		if (returnData == null)
		{
			returnData = new Stack<ReturnData>();
		}
		returnData.Push(new ReturnData(call, type));
	}

	public ReturnData PopReturnData()
	{
		if (returnData == null)
		{
			return default(ReturnData);
		}
		return returnData.Pop();
	}
}
