using System;
using System.Collections.Generic;

public class ClientOpcode
{
	public DoubleMap<ushort, Type> opcodeTypes = new DoubleMap<ushort, Type>();

	private readonly Dictionary<ushort, List<IClientHandler>> handlers = new Dictionary<ushort, List<IClientHandler>>();

	public void AddHandler(ushort opcode, IClientHandler handler)
	{
		List<IClientHandler> value = null;
		if (handlers.TryGetValue(opcode, out value))
		{
			if (value == null)
			{
				value = new List<IClientHandler>();
			}
			value.Add(handler);
		}
		else
		{
			handlers.Add(opcode, new List<IClientHandler> { handler });
		}
	}

	public bool GetHandler(ushort opcode, out List<IClientHandler> handlerList)
	{
		bool result = false;
		if (handlers.TryGetValue(opcode, out handlerList))
		{
			result = true;
		}
		return result;
	}

	public void AddOpcodeType(ushort opcode, Type t)
	{
		opcodeTypes.Add(opcode, t);
	}

	public ushort GetOpcode(Type type)
	{
		return opcodeTypes.GetKeyByValue(type);
	}

	public Type GetOpcodeType(ushort opcode)
	{
		return opcodeTypes.GetValueByKey(opcode);
	}
}
