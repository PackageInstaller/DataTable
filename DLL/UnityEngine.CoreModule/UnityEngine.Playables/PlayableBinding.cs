using System;
using System.ComponentModel;
using UnityEngine.Bindings;

namespace UnityEngine.Playables;

public struct PlayableBinding
{
	[VisibleToOtherModules]
	internal delegate PlayableOutput CreateOutputMethod(PlayableGraph graph, string name);

	private string m_StreamName;

	private Object m_SourceObject;

	private Type m_SourceBindingType;

	private CreateOutputMethod m_CreateOutputMethod;

	public static readonly PlayableBinding[] None = new PlayableBinding[0];

	public static readonly double DefaultDuration = double.PositiveInfinity;

	public string streamName
	{
		get
		{
			return m_StreamName;
		}
		set
		{
			m_StreamName = value;
		}
	}

	public Object sourceObject
	{
		get
		{
			return m_SourceObject;
		}
		set
		{
			m_SourceObject = value;
		}
	}

	public Type outputTargetType => m_SourceBindingType;

	[Obsolete("sourceBindingType is no longer supported on PlayableBinding. Use outputBindingType instead to get the required output target type, and the appropriate binding create method (e.g. AnimationPlayableBinding.Create(name, key)) to create PlayableBindings", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public Type sourceBindingType
	{
		get
		{
			return m_SourceBindingType;
		}
		set
		{
		}
	}

	[Obsolete("streamType is no longer supported on PlayableBinding. Use the appropriate binding create method (e.g. AnimationPlayableBinding.Create(name, key)) instead.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public DataStreamType streamType
	{
		get
		{
			return DataStreamType.None;
		}
		set
		{
		}
	}

	internal PlayableOutput CreateOutput(PlayableGraph graph)
	{
		if (m_CreateOutputMethod != null)
		{
			return m_CreateOutputMethod(graph, m_StreamName);
		}
		return PlayableOutput.Null;
	}

	[VisibleToOtherModules]
	internal static PlayableBinding CreateInternal(string name, Object sourceObject, Type sourceType, CreateOutputMethod createFunction)
	{
		return new PlayableBinding
		{
			m_StreamName = name,
			m_SourceObject = sourceObject,
			m_SourceBindingType = sourceType,
			m_CreateOutputMethod = createFunction
		};
	}
}
