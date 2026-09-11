using System;
using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using UnityEngine;

public static class LuaEventUtils
{
	public interface IArgs
	{
		object Value { get; }
	}

	internal struct Args<T> : IArgs
	{
		[SerializeField]
		private T value;

		public object Value => value;
	}

	internal abstract class LuaEvalArg : IArgs
	{
		[TextArea]
		public string luaExpr;

		private object cachedResult;

		public object Value => cachedResult ?? Eval();

		private object Eval()
		{
			LuaState luaState = LuaHelper.GetLuaState();
			if (luaState.LuaDoString("return " + luaExpr))
			{
				cachedResult = GetEvelResult(luaState);
				return cachedResult;
			}
			return null;
		}

		protected abstract object GetEvelResult(LuaState L);
	}

	internal class LuaObjectArg : LuaEvalArg
	{
		protected override object GetEvelResult(LuaState L)
		{
			return L.CheckLuaTable(L.LuaGetTop());
		}
	}

	internal class LuaFuncArg : LuaEvalArg
	{
		protected override object GetEvelResult(LuaState L)
		{
			return L.CheckLuaFunction(L.LuaGetTop());
		}
	}

	internal static IEnumerable<Type> GetArgsAccacptTypes()
	{
		yield return typeof(Args<bool>);
		yield return typeof(Args<int>);
		yield return typeof(Args<float>);
		yield return typeof(Args<string>);
		yield return typeof(Args<GameObject>);
		yield return typeof(Args<Component>);
		yield return typeof(LuaObjectArg);
		yield return typeof(LuaFuncArg);
	}

	internal static void EmitFunction(string functionName, IEnumerable<IArgs> args)
	{
		if (!LuaHelper.IsLuaClientInited() || string.IsNullOrEmpty(functionName))
		{
			return;
		}
		if (args != null && args.Count() > 0)
		{
			object[] args2 = Enumerable.Empty<object>().Concat(args.Select((IArgs v) => v.Value)).ToArray();
			LuaHelper.CallFunction(functionName, args2);
		}
		else
		{
			LuaHelper.CallFunction(functionName);
		}
	}

	internal static void EmitEvent(string eventName, IEnumerable<IArgs> args)
	{
		if (!LuaHelper.IsLuaClientInited() || string.IsNullOrEmpty(eventName))
		{
			return;
		}
		if (args != null && args.Count() > 0)
		{
			LuaState luaState = LuaHelper.GetLuaState();
			int newTop = luaState.LuaGetTop();
			object[] args2 = Enumerable.Empty<object>().Append(null).Append(eventName)
				.Concat(args.Select((IArgs v) => v.Value))
				.ToArray();
			luaState.LuaSetTop(newTop);
			LuaHelper.CallFunction("NotificationCenter.Invoke", args2);
		}
		else
		{
			LuaHelper.GetFunc("NotificationCenter.Invoke")?.Call<object, string>(null, eventName);
		}
	}

	internal static void EmitEventWithArg<T>(string eventName, T arg)
	{
		if (LuaHelper.IsLuaClientInited() && !string.IsNullOrEmpty(eventName))
		{
			LuaHelper.GetFunc("NotificationCenter.Invoke")?.Call<object, string, T>(null, eventName, arg);
		}
	}
}
