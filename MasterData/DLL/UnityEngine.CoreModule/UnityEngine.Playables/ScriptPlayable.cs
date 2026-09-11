using System;

namespace UnityEngine.Playables;

public struct ScriptPlayable<T> : IPlayable, IEquatable<ScriptPlayable<T>> where T : class, IPlayableBehaviour, new()
{
	private PlayableHandle m_Handle;

	private static readonly ScriptPlayable<T> m_NullPlayable = new ScriptPlayable<T>(PlayableHandle.Null);

	public static ScriptPlayable<T> Null => m_NullPlayable;

	public static ScriptPlayable<T> Create(PlayableGraph graph, int inputCount = 0)
	{
		PlayableHandle handle = CreateHandle(graph, null, inputCount);
		return new ScriptPlayable<T>(handle);
	}

	public static ScriptPlayable<T> Create(PlayableGraph graph, T template, int inputCount = 0)
	{
		PlayableHandle handle = CreateHandle(graph, template, inputCount);
		return new ScriptPlayable<T>(handle);
	}

	private static PlayableHandle CreateHandle(PlayableGraph graph, T template, int inputCount)
	{
		object obj = null;
		obj = ((template != null) ? CloneScriptInstance(template) : CreateScriptInstance());
		if (obj == null)
		{
			Debug.LogError("Could not create a ScriptPlayable of Type " + typeof(T));
			return PlayableHandle.Null;
		}
		PlayableHandle result = graph.CreatePlayableHandle();
		if (!result.IsValid())
		{
			return PlayableHandle.Null;
		}
		result.SetInputCount(inputCount);
		result.SetScriptInstance(obj);
		return result;
	}

	private static object CreateScriptInstance()
	{
		IPlayableBehaviour playableBehaviour = null;
		if (typeof(ScriptableObject).IsAssignableFrom(typeof(T)))
		{
			return ScriptableObject.CreateInstance(typeof(T)) as T;
		}
		return new T();
	}

	private static object CloneScriptInstance(IPlayableBehaviour source)
	{
		Object obj = source as Object;
		if (obj != null)
		{
			return CloneScriptInstanceFromEngineObject(obj);
		}
		if (source is ICloneable source2)
		{
			return CloneScriptInstanceFromIClonable(source2);
		}
		return null;
	}

	private static object CloneScriptInstanceFromEngineObject(Object source)
	{
		Object obj = Object.Instantiate(source);
		if (obj != null)
		{
			obj.hideFlags |= HideFlags.DontSave;
		}
		return obj;
	}

	private static object CloneScriptInstanceFromIClonable(ICloneable source)
	{
		return source.Clone();
	}

	internal ScriptPlayable(PlayableHandle handle)
	{
		if (handle.IsValid() && !typeof(T).IsAssignableFrom(handle.GetPlayableType()))
		{
			throw new InvalidCastException($"Incompatible handle: Trying to assign a playable data of type `{handle.GetPlayableType()}` that is not compatible with the PlayableBehaviour of type `{typeof(T)}`.");
		}
		m_Handle = handle;
	}

	public PlayableHandle GetHandle()
	{
		return m_Handle;
	}

	public T GetBehaviour()
	{
		return m_Handle.GetObject<T>();
	}

	public static implicit operator Playable(ScriptPlayable<T> playable)
	{
		return new Playable(playable.GetHandle());
	}

	public static explicit operator ScriptPlayable<T>(Playable playable)
	{
		return new ScriptPlayable<T>(playable.GetHandle());
	}

	public bool Equals(ScriptPlayable<T> other)
	{
		return GetHandle() == other.GetHandle();
	}
}
