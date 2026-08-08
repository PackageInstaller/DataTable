using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

public class LuaFunctionEmitter : SerializedMonoBehaviour
{
	public string functionName;

	[SerializeField]
	protected List<LuaEventUtils.IArgs> args;

	public void EmitFunction()
	{
		LuaEventUtils.EmitFunction(functionName, args);
	}
}
