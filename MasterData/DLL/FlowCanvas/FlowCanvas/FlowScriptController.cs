using System;
using NodeCanvas.Framework;
using UnityEngine;

namespace FlowCanvas;

[AddComponentMenu("FlowCanvas/FlowScript Controller")]
public class FlowScriptController : GraphOwner<FlowScript>
{
	public object CallFunction(string name, params object[] args)
	{
		return base.behaviour.CallFunction(name, args);
	}

	public void CallFunctionAsync(string name, Action<object> callback, params object[] args)
	{
		base.behaviour.CallFunctionAsync(name, callback, args);
	}
}
