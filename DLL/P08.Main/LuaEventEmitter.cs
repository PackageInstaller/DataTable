using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

public class LuaEventEmitter : SerializedMonoBehaviour
{
	public string eventName;

	[SerializeField]
	protected List<LuaEventUtils.IArgs> args;

	public void EmitEvent()
	{
		LuaEventUtils.EmitEvent(eventName, args);
	}

	public void EmitEvent_Float(float arg)
	{
		LuaEventUtils.EmitEventWithArg(eventName, arg);
	}
}
