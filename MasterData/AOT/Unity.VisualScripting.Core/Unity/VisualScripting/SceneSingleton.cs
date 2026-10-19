using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

public static class SceneSingleton<T> where T : MonoBehaviour, ISingleton
{
	private static Dictionary<Scene, T> instances;

	private static readonly SingletonAttribute attribute;

	private static bool persistent => attribute.Persistent;

	private static bool automatic => attribute.Automatic;

	private static string name => attribute.Name;

	private static HideFlags hideFlags => attribute.HideFlags;

	static SceneSingleton()
	{
		instances = new Dictionary<Scene, T>();
		attribute = typeof(T).GetAttribute<SingletonAttribute>();
		if (attribute == null)
		{
			throw new InvalidImplementationException($"Missing singleton attribute for '{typeof(T)}'.");
		}
	}

	private static void EnsureSceneValid(Scene scene)
	{
		if (!scene.IsValid())
		{
			throw new InvalidOperationException("Scene '" + scene.name + "' is invalid and cannot be used in singleton operations.");
		}
	}

	public static bool InstantiatedIn(Scene scene)
	{
		EnsureSceneValid(scene);
		if (Application.isPlaying)
		{
			return instances.ContainsKey(scene);
		}
		return FindInstances(scene).Length == 1;
	}

	public static T InstanceIn(Scene scene)
	{
		EnsureSceneValid(scene);
		if (Application.isPlaying)
		{
			if (instances.ContainsKey(scene))
			{
				return instances[scene];
			}
			return FindOrCreateInstance(scene);
		}
		return FindOrCreateInstance(scene);
	}

	private static T[] FindObjectsOfType()
	{
		return UnityEngine.Object.FindObjectsOfType<T>();
	}

	private static T[] FindInstances(Scene scene)
	{
		EnsureSceneValid(scene);
		return (from o in FindObjectsOfType()
			where o.gameObject.scene == scene
			select o).ToArray();
	}

	private static T FindOrCreateInstance(Scene scene)
	{
		Scene scene2 = scene;
		EnsureSceneValid(scene2);
		T[] array = FindInstances(scene2);
		if (array.Length == 1)
		{
			return array[0];
		}
		if (array.Length == 0)
		{
			if (automatic)
			{
				if (persistent)
				{
					throw new UnityException("Scene singletons cannot be persistent.");
				}
				GameObject gameObject = new GameObject(name ?? typeof(T).Name)
				{
					hideFlags = hideFlags
				};
				SceneManager.MoveGameObjectToScene(gameObject, scene2);
				T val = gameObject.AddComponent<T>();
				val.hideFlags = hideFlags;
				return val;
			}
			throw new UnityException($"Missing '{typeof(T)}' singleton in scene '{scene.name}'.");
		}
		throw new UnityException($"More than one '{typeof(T)}' singleton in scene '{scene.name}'.");
	}

	public static void Awake(T instance)
	{
		Ensure.That("instance").IsNotNull(instance);
		Scene scene = instance.gameObject.scene;
		EnsureSceneValid(scene);
		if (instances.ContainsKey(scene))
		{
			throw new UnityException($"More than one '{typeof(T)}' singleton in scene '{scene.name}'.");
		}
		instances.Add(scene, instance);
	}

	public static void OnDestroy(T instance)
	{
		Ensure.That("instance").IsNotNull(instance);
		Scene scene = instance.gameObject.scene;
		if (!scene.IsValid())
		{
			foreach (KeyValuePair<Scene, T> instance2 in instances)
			{
				if (instance2.Value == instance)
				{
					instances.Remove(instance2.Key);
					break;
				}
			}
			return;
		}
		if (instances.ContainsKey(scene) && instances[scene] == instance)
		{
			instances.Remove(scene);
		}
	}
}
