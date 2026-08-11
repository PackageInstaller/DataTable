using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

namespace Ase;

public class CGAnimation : MonoBehaviour
{
	[Serializable]
	public class AnimationEndEvent : UnityEvent
	{
	}

	[FormerlySerializedAs("End")]
	[SerializeField]
	private AnimationEndEvent m_End = new AnimationEndEvent();

	public AnimationEndEvent End
	{
		get
		{
			return m_End;
		}
		set
		{
			m_End = value;
		}
	}

	public void OnEnd()
	{
		m_End.Invoke();
	}
}
