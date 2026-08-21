using System;
using System.Collections;
using LuaInterface;
using UnityEngine;

public static class LuaCoroutine
{
	private static MonoBehaviour mb = null;

	private static string strCo = "\n        local _WaitForSeconds, _WaitForFixedUpdate, _WaitForEndOfFrame, _Yield, _StopCoroutine = WaitForSeconds, WaitForFixedUpdate, WaitForEndOfFrame, Yield, StopCoroutine        \n        local error = error\n        local debug = debug\n        local coroutine = coroutine\n        local comap = {}\n        setmetatable(comap, {__mode = 'k'})\n\n        function _resume(co)\n            if comap[co] then\n                comap[co] = nil\n                local flag, msg = coroutine.resume(co)\n                    \n                if not flag then\n                    msg = debug.traceback(co, msg)\n                    error(msg)\n                end\n            end        \n        end\n\n        function WaitForSeconds(t)\n            local co = coroutine.running()\n            local resume = function()                    \n                _resume(co)                     \n            end\n            \n            comap[co] = _WaitForSeconds(t, resume)\n            return coroutine.yield()\n        end\n\n        function WaitForFixedUpdate()\n            local co = coroutine.running()\n            local resume = function()          \n                _resume(co)     \n            end\n        \n            comap[co] = _WaitForFixedUpdate(resume)\n            return coroutine.yield()\n        end\n\n        function WaitForEndOfFrame()\n            local co = coroutine.running()\n            local resume = function()        \n                _resume(co)     \n            end\n        \n            comap[co] = _WaitForEndOfFrame(resume)\n            return coroutine.yield()\n        end\n\n        function Yield(o)\n            local co = coroutine.running()\n            local resume = function()        \n                _resume(co)     \n            end\n        \n            comap[co] = _Yield(o, resume)\n            return coroutine.yield()\n        end\n\n        function StartCoroutine(func)\n            local co = coroutine.create(func)                       \n            local flag, msg = coroutine.resume(co)\n\n            if not flag then\n                msg = debug.traceback(co, msg)\n                error(msg)\n            end\n\n            return co\n        end\n\n        function StopCoroutine(co)\n            local _co = comap[co]\n\n            if _co == nil then\n                return\n            end\n\n            comap[co] = nil\n            _StopCoroutine(_co)\n        end\n        ";

	public static void Register(LuaState state, MonoBehaviour behaviour)
	{
		state.BeginModule(null);
		state.RegFunction("WaitForSeconds", _WaitForSeconds);
		state.RegFunction("WaitForFixedUpdate", WaitForFixedUpdate);
		state.RegFunction("WaitForEndOfFrame", WaitForEndOfFrame);
		state.RegFunction("Yield", Yield);
		state.RegFunction("StopCoroutine", StopCoroutine);
		state.RegFunction("WrapLuaCoroutine", WrapLuaCoroutine);
		state.EndModule();
		state.LuaDoString(strCo, "LuaCoroutine.cs");
		mb = behaviour;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _WaitForSeconds(IntPtr L)
	{
		try
		{
			float sec = (float)LuaDLL.luaL_checknumber(L, 1);
			LuaFunction func = ToLua.ToLuaFunction(L, 2);
			Coroutine o = mb.StartCoroutine(CoWaitForSeconds(sec, func));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static IEnumerator CoWaitForSeconds(float sec, LuaFunction func)
	{
		yield return new WaitForSeconds(sec);
		func.Call();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WaitForFixedUpdate(IntPtr L)
	{
		try
		{
			LuaFunction func = ToLua.ToLuaFunction(L, 1);
			Coroutine o = mb.StartCoroutine(CoWaitForFixedUpdate(func));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static IEnumerator CoWaitForFixedUpdate(LuaFunction func)
	{
		yield return new WaitForFixedUpdate();
		func.Call();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WaitForEndOfFrame(IntPtr L)
	{
		try
		{
			LuaFunction func = ToLua.ToLuaFunction(L, 1);
			Coroutine o = mb.StartCoroutine(CoWaitForEndOfFrame(func));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static IEnumerator CoWaitForEndOfFrame(LuaFunction func)
	{
		yield return new WaitForEndOfFrame();
		func.Call();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Yield(IntPtr L)
	{
		try
		{
			object o = ToLua.ToVarObject(L, 1);
			LuaFunction func = ToLua.ToLuaFunction(L, 2);
			Coroutine o2 = mb.StartCoroutine(CoYield(o, func));
			ToLua.PushSealed(L, o2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static IEnumerator CoYield(object o, LuaFunction func)
	{
		if (o is IEnumerator)
		{
			yield return mb.StartCoroutine((IEnumerator)o);
		}
		else
		{
			yield return o;
		}
		func.Call();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopCoroutine(IntPtr L)
	{
		try
		{
			Coroutine routine = (Coroutine)ToLua.CheckObject(L, 1, typeof(Coroutine));
			mb.StopCoroutine(routine);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WrapLuaCoroutine(IntPtr L)
	{
		IEnumerator iter = CoWrap(ToLua.ToLuaFunction(L, 1));
		ToLua.Push(L, iter);
		return 1;
	}

	private static IEnumerator CoWrap(LuaFunction func)
	{
		if (!(func == null))
		{
			while (func.Invoke<bool>())
			{
				yield return null;
			}
		}
	}
}
