using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[Obsolete("Use [RequiredIn(PrefabKind.PrefabAsset)] instead.", true)]
[EditorBrowsable(EditorBrowsableState.Never)]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class RequiredInPrefabAssetsAttribute : Attribute
{
	public string ErrorMessage;

	public InfoMessageType MessageType;

	public RequiredInPrefabAssetsAttribute()
	{
		MessageType = InfoMessageType.Error;
	}

	public RequiredInPrefabAssetsAttribute(string errorMessage, InfoMessageType messageType)
	{
		ErrorMessage = errorMessage;
		MessageType = messageType;
	}

	public RequiredInPrefabAssetsAttribute(string errorMessage)
	{
		ErrorMessage = errorMessage;
		MessageType = InfoMessageType.Error;
	}

	public RequiredInPrefabAssetsAttribute(InfoMessageType messageType)
	{
		MessageType = messageType;
	}
}
