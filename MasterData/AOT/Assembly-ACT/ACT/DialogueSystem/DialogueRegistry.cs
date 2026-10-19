using System;
using System.Collections.Generic;

namespace ACT.DialogueSystem;

public static class DialogueRegistry
{
	private static bool s_Initialized;

	private static Dictionary<Type, INodeFactory> s_NodeFactories;

	static DialogueRegistry()
	{
		Init();
	}

	private static void Init(bool force = false)
	{
		if (!s_Initialized || force)
		{
			if (s_NodeFactories == null)
			{
				s_NodeFactories = new Dictionary<Type, INodeFactory>();
			}
			else
			{
				s_NodeFactories.Clear();
			}
			RegisterProcessorFactory<SequenceNode>(new NodeFactory<SequenceNodeProcessor>());
			RegisterProcessorFactory<ParallelNode>(new NodeFactory<ParallelNodeProcessor>());
			RegisterProcessorFactory<DialogueRoot>(new NodeFactory<DialogueRootProcessor>());
			RegisterProcessorFactory<DialogueGroup>(new NodeFactory<DialogueGroupProcessor>());
			RegisterProcessorFactory<DialogueJump>(new NodeFactory<DialogueJumpProcessor>());
			RegisterProcessorFactory<DialogueStop>(new NodeFactory<DialogueStopProcessor>());
			s_Initialized = true;
		}
	}

	public static void RegisterProcessorFactory(Type dataType, INodeFactory factory)
	{
		s_NodeFactories.Add(dataType, factory);
	}

	public static void RegisterProcessorFactory<T>(INodeFactory factory)
	{
		Type typeFromHandle = typeof(T);
		s_NodeFactories.Add(typeFromHandle, factory);
	}

	public static INodeFactory GetNodeFactory(Type dataType)
	{
		while (dataType != null)
		{
			if (s_NodeFactories.TryGetValue(dataType, out var value))
			{
				return value;
			}
			dataType = dataType.BaseType;
		}
		return null;
	}
}
