#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace GameFramework.Runtime;

public static class GameEntryRuntime
{
	private static readonly GameFrameworkLinkedList<GameFrameworkComponent> s_GameFrameworkComponents = new GameFrameworkLinkedList<GameFrameworkComponent>();

	internal const int GameFrameworkSceneId = 0;

	public static T GetComponent<T>() where T : GameFrameworkComponent
	{
		return (T)GetComponent(typeof(T));
	}

	public static GameFrameworkComponent GetComponent(Type type)
	{
		for (LinkedListNode<GameFrameworkComponent> linkedListNode = s_GameFrameworkComponents.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			if (linkedListNode.Value.GetType() == type)
			{
				return linkedListNode.Value;
			}
		}
		return null;
	}

	public static GameFrameworkComponent GetComponent(string typeName)
	{
		for (LinkedListNode<GameFrameworkComponent> linkedListNode = s_GameFrameworkComponents.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			Type type = linkedListNode.Value.GetType();
			if (type.FullName == typeName || type.Name == typeName)
			{
				return linkedListNode.Value;
			}
		}
		return null;
	}

	public static void Shutdown(ShutdownType shutdownType)
	{
		Utility.Unity.Release();
		BaseComponent component = GetComponent<BaseComponent>();
		if (component != null)
		{
			component.Shutdown();
			component = null;
		}
		for (LinkedListNode<GameFrameworkComponent> linkedListNode = s_GameFrameworkComponents.Last; linkedListNode != null; linkedListNode = linkedListNode.Previous)
		{
			linkedListNode.Value.Shutdown();
		}
		s_GameFrameworkComponents.Clear();
		switch (shutdownType)
		{
		case ShutdownType.Restart:
			SceneManager.LoadScene(0);
			break;
		case ShutdownType.Quit:
			Application.Quit();
			break;
		}
	}

	internal static void RegisterComponent(GameFrameworkComponent gameFrameworkComponent)
	{
		if (gameFrameworkComponent == null)
		{
			Log.Error("Game Framework component is invalid.");
			return;
		}
		Type type = gameFrameworkComponent.GetType();
		for (LinkedListNode<GameFrameworkComponent> linkedListNode = s_GameFrameworkComponents.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			if (linkedListNode.Value.GetType() == type)
			{
				Log.Error("Game Framework component type '{0}' is already exist.", type.FullName);
				return;
			}
		}
		s_GameFrameworkComponents.AddLast(gameFrameworkComponent);
	}
}
