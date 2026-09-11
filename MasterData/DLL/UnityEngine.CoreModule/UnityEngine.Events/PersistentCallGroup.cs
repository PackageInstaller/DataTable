using System;
using System.Collections.Generic;
using UnityEngine.Serialization;

namespace UnityEngine.Events;

[Serializable]
internal class PersistentCallGroup
{
	[FormerlySerializedAs("m_Listeners")]
	[SerializeField]
	private List<PersistentCall> m_Calls;

	public int Count => m_Calls.Count;

	public PersistentCallGroup()
	{
		m_Calls = new List<PersistentCall>();
	}

	public PersistentCall GetListener(int index)
	{
		return m_Calls[index];
	}

	public void Initialize(InvokableCallList invokableList, UnityEventBase unityEventBase)
	{
		foreach (PersistentCall call in m_Calls)
		{
			if (call.IsValid())
			{
				BaseInvokableCall runtimeCall = call.GetRuntimeCall(unityEventBase);
				if (runtimeCall != null)
				{
					invokableList.AddPersistentInvokableCall(runtimeCall);
				}
			}
		}
	}
}
