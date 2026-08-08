using System;
using LuaInterface;
using UnityEngine;

public class LuaLooper : MonoBehaviour
{
	public LuaState luaState;

	public LuaBeatEvent UpdateEvent { get; private set; }

	public LuaBeatEvent LateUpdateEvent { get; private set; }

	public LuaBeatEvent FixedUpdateEvent { get; private set; }

	private void Start()
	{
		try
		{
			UpdateEvent = GetEvent("UpdateBeat");
			LateUpdateEvent = GetEvent("LateUpdateBeat");
			FixedUpdateEvent = GetEvent("FixedUpdateBeat");
		}
		catch (Exception ex)
		{
			UnityEngine.Object.Destroy(this);
			throw ex;
		}
	}

	private LuaBeatEvent GetEvent(string name)
	{
		LuaTable table = luaState.GetTable(name);
		if (table == null)
		{
			throw new LuaException($"Lua table {name} not exists");
		}
		LuaBeatEvent result = new LuaBeatEvent(table);
		table.Dispose();
		return result;
	}

	private void ThrowException()
	{
		string msg = luaState.LuaToString(-1);
		luaState.LuaPop(2);
		throw new LuaException(msg, LuaException.GetLastError());
	}

	private void Update()
	{
		if (luaState.LuaUpdate(Time.deltaTime, Time.unscaledDeltaTime) != 0)
		{
			ThrowException();
		}
		luaState.LuaPop(1);
		luaState.Collect();
	}

	private void LateUpdate()
	{
		if (luaState.LuaLateUpdate() != 0)
		{
			ThrowException();
		}
		luaState.StepCollect();
		luaState.LuaPop(1);
	}

	private void FixedUpdate()
	{
		if (luaState.LuaFixedUpdate(Time.fixedDeltaTime) != 0)
		{
			ThrowException();
		}
		luaState.LuaPop(1);
	}

	public void Destroy()
	{
		if (luaState != null)
		{
			if (UpdateEvent != null)
			{
				UpdateEvent.Dispose();
				UpdateEvent = null;
			}
			if (LateUpdateEvent != null)
			{
				LateUpdateEvent.Dispose();
				LateUpdateEvent = null;
			}
			if (FixedUpdateEvent != null)
			{
				FixedUpdateEvent.Dispose();
				FixedUpdateEvent = null;
			}
			luaState = null;
		}
	}

	private void OnDestroy()
	{
		if (luaState != null)
		{
			Destroy();
		}
	}
}
