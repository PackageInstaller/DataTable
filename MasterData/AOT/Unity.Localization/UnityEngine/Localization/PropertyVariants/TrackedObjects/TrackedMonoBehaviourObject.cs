using System;
using UnityEngine.Events;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
[CustomTrackedObject(typeof(MonoBehaviour), true)]
public class TrackedMonoBehaviourObject : JsonSerializerTrackedObject
{
	[SerializeField]
	private UnityEvent m_Changed = new UnityEvent();

	public UnityEvent Changed => m_Changed;

	protected override void PostApplyTrackedProperties()
	{
		base.PostApplyTrackedProperties();
		m_Changed.Invoke();
	}
}
