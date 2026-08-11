using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

public sealed class VolumeStack : IDisposable
{
	internal readonly Dictionary<Type, VolumeComponent> components = new Dictionary<Type, VolumeComponent>();

	internal (VolumeParameter parameter, VolumeParameter defaultValue)[] defaultParameters;

	internal bool requiresReset = true;

	internal VolumeStack()
	{
	}

	internal void Reload(List<VolumeComponent> componentDefaultStates)
	{
		components.Clear();
		requiresReset = true;
		List<(VolumeParameter, VolumeParameter)> list = new List<(VolumeParameter, VolumeParameter)>();
		foreach (VolumeComponent componentDefaultState in componentDefaultStates)
		{
			Type type = componentDefaultState.GetType();
			VolumeComponent volumeComponent = (VolumeComponent)ScriptableObject.CreateInstance(type);
			components.Add(type, volumeComponent);
			int count = volumeComponent.parameters.Count;
			for (int i = 0; i < count; i++)
			{
				list.Add(new(VolumeParameter, VolumeParameter)
				{
					Item1 = volumeComponent.parameters[i],
					Item2 = componentDefaultState.parameters[i]
				});
			}
		}
		defaultParameters = list.ToArray();
	}

	public T GetComponent<T>() where T : VolumeComponent
	{
		return (T)GetComponent(typeof(T));
	}

	public VolumeComponent GetComponent(Type type)
	{
		components.TryGetValue(type, out var value);
		return value;
	}

	public void Dispose()
	{
		foreach (KeyValuePair<Type, VolumeComponent> component in components)
		{
			CoreUtils.Destroy(component.Value);
		}
		components.Clear();
	}
}
