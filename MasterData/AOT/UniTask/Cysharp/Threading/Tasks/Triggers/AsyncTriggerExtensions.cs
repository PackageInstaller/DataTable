using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public static class AsyncTriggerExtensions
{
	public static AsyncDestroyTrigger GetAsyncDestroyTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDestroyTrigger>(gameObject);
	}

	public static AsyncDestroyTrigger GetAsyncDestroyTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDestroyTrigger();
	}

	private static T GetOrAddComponent<T>(GameObject gameObject) where T : Component
	{
		if (!gameObject.TryGetComponent<T>(out var component))
		{
			return gameObject.AddComponent<T>();
		}
		return component;
	}
}
