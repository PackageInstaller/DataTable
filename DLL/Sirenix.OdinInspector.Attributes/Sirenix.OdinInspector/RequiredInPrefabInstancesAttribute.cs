using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
[EditorBrowsable(EditorBrowsableState.Never)]
[Obsolete("Use [RequiredIn(PrefabKind.PrefabInstance)] instead.", true)]
public sealed class RequiredInPrefabInstancesAttribute : Attribute
{
	public string ErrorMessage;

	public InfoMessageType MessageType;

	public RequiredInPrefabInstancesAttribute()
	{
		MessageType = InfoMessageType.Error;
	}

	public RequiredInPrefabInstancesAttribute(string errorMessage, InfoMessageType messageType)
	{
		ErrorMessage = errorMessage;
		MessageType = messageType;
	}

	public RequiredInPrefabInstancesAttribute(string errorMessage)
	{
		ErrorMessage = errorMessage;
		MessageType = InfoMessageType.Error;
	}

	public RequiredInPrefabInstancesAttribute(InfoMessageType messageType)
	{
		MessageType = messageType;
	}
}
