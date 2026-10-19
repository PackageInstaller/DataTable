using System;
using System.Runtime.InteropServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
public sealed class AnimationEvent
{
	internal float m_Time;

	internal string m_FunctionName;

	internal string m_StringParameter;

	internal Object m_ObjectReferenceParameter;

	internal float m_FloatParameter;

	internal int m_IntParameter;

	internal int m_MessageOptions;

	internal AnimationEventSource m_Source;

	internal AnimationState m_StateSender;

	internal AnimatorStateInfo m_AnimatorStateInfo;

	internal AnimatorClipInfo m_AnimatorClipInfo;

	[Obsolete("Use stringParameter instead")]
	public string data
	{
		get
		{
			return m_StringParameter;
		}
		set
		{
			m_StringParameter = value;
		}
	}

	public string stringParameter
	{
		get
		{
			return m_StringParameter;
		}
		set
		{
			m_StringParameter = value;
		}
	}

	public float floatParameter
	{
		get
		{
			return m_FloatParameter;
		}
		set
		{
			m_FloatParameter = value;
		}
	}

	public int intParameter
	{
		get
		{
			return m_IntParameter;
		}
		set
		{
			m_IntParameter = value;
		}
	}

	public Object objectReferenceParameter
	{
		get
		{
			return m_ObjectReferenceParameter;
		}
		set
		{
			m_ObjectReferenceParameter = value;
		}
	}

	public string functionName
	{
		get
		{
			return m_FunctionName;
		}
		set
		{
			m_FunctionName = value;
		}
	}

	public float time
	{
		get
		{
			return m_Time;
		}
		set
		{
			m_Time = value;
		}
	}

	public SendMessageOptions messageOptions
	{
		get
		{
			return (SendMessageOptions)m_MessageOptions;
		}
		set
		{
			m_MessageOptions = (int)value;
		}
	}

	public bool isFiredByLegacy => m_Source == AnimationEventSource.Legacy;

	public bool isFiredByAnimator => m_Source == AnimationEventSource.Animator;

	public AnimationState animationState
	{
		get
		{
			if (!isFiredByLegacy)
			{
				Debug.LogError("AnimationEvent was not fired by Animation component, you shouldn't use AnimationEvent.animationState");
			}
			return m_StateSender;
		}
	}

	public AnimatorStateInfo animatorStateInfo
	{
		get
		{
			if (!isFiredByAnimator)
			{
				Debug.LogError("AnimationEvent was not fired by Animator component, you shouldn't use AnimationEvent.animatorStateInfo");
			}
			return m_AnimatorStateInfo;
		}
	}

	public AnimatorClipInfo animatorClipInfo
	{
		get
		{
			if (!isFiredByAnimator)
			{
				Debug.LogError("AnimationEvent was not fired by Animator component, you shouldn't use AnimationEvent.animatorClipInfo");
			}
			return m_AnimatorClipInfo;
		}
	}

	public AnimationEvent()
	{
		m_Time = 0f;
		m_FunctionName = "";
		m_StringParameter = "";
		m_ObjectReferenceParameter = null;
		m_FloatParameter = 0f;
		m_IntParameter = 0;
		m_MessageOptions = 0;
		m_Source = AnimationEventSource.NoSource;
		m_StateSender = null;
	}

	internal int GetHash()
	{
		int num = 0;
		num = functionName.GetHashCode();
		return 33 * num + time.GetHashCode();
	}
}
