using System;
using UnityEngine.Serialization;

namespace UnityEngine.Events;

[Serializable]
internal class ArgumentCache : ISerializationCallbackReceiver
{
	[SerializeField]
	[FormerlySerializedAs("objectArgument")]
	private Object m_ObjectArgument;

	[SerializeField]
	[FormerlySerializedAs("objectArgumentAssemblyTypeName")]
	private string m_ObjectArgumentAssemblyTypeName;

	[SerializeField]
	[FormerlySerializedAs("intArgument")]
	private int m_IntArgument;

	[FormerlySerializedAs("floatArgument")]
	[SerializeField]
	private float m_FloatArgument;

	[SerializeField]
	[FormerlySerializedAs("stringArgument")]
	private string m_StringArgument;

	[SerializeField]
	private bool m_BoolArgument;

	public Object unityObjectArgument => m_ObjectArgument;

	public string unityObjectArgumentAssemblyTypeName => m_ObjectArgumentAssemblyTypeName;

	public int intArgument => m_IntArgument;

	public float floatArgument => m_FloatArgument;

	public string stringArgument => m_StringArgument;

	public bool boolArgument => m_BoolArgument;

	public void OnBeforeSerialize()
	{
		m_ObjectArgumentAssemblyTypeName = UnityEventTools.TidyAssemblyTypeName(m_ObjectArgumentAssemblyTypeName);
	}

	public void OnAfterDeserialize()
	{
		m_ObjectArgumentAssemblyTypeName = UnityEventTools.TidyAssemblyTypeName(m_ObjectArgumentAssemblyTypeName);
	}
}
