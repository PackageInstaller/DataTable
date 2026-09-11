using System;

namespace LuaInterface;

public class EventObject
{
	[NoToLua]
	public EventOp op;

	[NoToLua]
	public Delegate func;

	[NoToLua]
	public Type type;

	[NoToLua]
	public EventObject(Type t)
	{
		type = t;
	}

	public static EventObject operator +(EventObject a, Delegate b)
	{
		a.op = EventOp.Add;
		a.func = b;
		return a;
	}

	public static EventObject operator -(EventObject a, Delegate b)
	{
		a.op = EventOp.Sub;
		a.func = b;
		return a;
	}
}
