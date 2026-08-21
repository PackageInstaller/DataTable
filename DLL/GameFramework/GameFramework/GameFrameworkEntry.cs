using System;
using System.Collections.Generic;

namespace GameFramework;

public static class GameFrameworkEntry
{
	private static readonly GameFrameworkLinkedList<GameFrameworkModule> s_GameFrameworkModules = new GameFrameworkLinkedList<GameFrameworkModule>();

	public static void Update(float elapseSeconds, float realElapseSeconds)
	{
		foreach (GameFrameworkModule s_GameFrameworkModule in s_GameFrameworkModules)
		{
			s_GameFrameworkModule.Update(elapseSeconds, realElapseSeconds);
		}
	}

	public static void Shutdown()
	{
		for (LinkedListNode<GameFrameworkModule> linkedListNode = s_GameFrameworkModules.Last; linkedListNode != null; linkedListNode = linkedListNode.Previous)
		{
			linkedListNode.Value.Shutdown();
		}
		s_GameFrameworkModules.Clear();
		ReferencePool.ClearAll();
		Utility.Marshal.FreeCachedHGlobal();
		GameFrameworkLog.SetLogHelper(null);
	}

	public static T GetModule<T>() where T : class
	{
		Type typeFromHandle = typeof(T);
		if (!typeFromHandle.FullName.StartsWith("GameFramework.", StringComparison.Ordinal))
		{
			throw new GameFrameworkException(Utility.Text.Format("You must get a Game Framework module, but '{0}' is not.", typeFromHandle.FullName));
		}
		string typeName = Utility.Text.Format("{0}.{1}", typeFromHandle.Namespace, typeFromHandle.Name.Substring(1));
		Type type = Type.GetType(typeName);
		if (type == null)
		{
			typeName = Utility.Text.Format("{0}.{1}", typeFromHandle.Namespace, typeFromHandle.Name);
			type = Type.GetType(typeName);
			if (type == null)
			{
				throw new GameFrameworkException(Utility.Text.Format("Can not find Game Framework module type '{0}'.", typeName));
			}
		}
		return GetModule(type) as T;
	}

	private static GameFrameworkModule GetModule(Type moduleType)
	{
		foreach (GameFrameworkModule s_GameFrameworkModule in s_GameFrameworkModules)
		{
			if (s_GameFrameworkModule.GetType() == moduleType)
			{
				return s_GameFrameworkModule;
			}
		}
		return CreateModule(moduleType);
	}

	private static GameFrameworkModule CreateModule(Type moduleType)
	{
		GameFrameworkModule gameFrameworkModule = (GameFrameworkModule)Activator.CreateInstance(moduleType);
		if (gameFrameworkModule == null)
		{
			throw new GameFrameworkException(Utility.Text.Format("Can not create module '{0}'.", moduleType.FullName));
		}
		LinkedListNode<GameFrameworkModule> linkedListNode = s_GameFrameworkModules.First;
		while (linkedListNode != null && gameFrameworkModule.Priority <= linkedListNode.Value.Priority)
		{
			linkedListNode = linkedListNode.Next;
		}
		if (linkedListNode != null)
		{
			s_GameFrameworkModules.AddBefore(linkedListNode, gameFrameworkModule);
		}
		else
		{
			s_GameFrameworkModules.AddLast(gameFrameworkModule);
		}
		return gameFrameworkModule;
	}
}
