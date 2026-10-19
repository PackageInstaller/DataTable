using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class RequiredAttribute : Attribute
{
	public string ErrorMessage;

	public InfoMessageType MessageType;

	public RequiredAttribute()
	{
		MessageType = InfoMessageType.Error;
	}

	public RequiredAttribute(string errorMessage, InfoMessageType messageType)
	{
		ErrorMessage = errorMessage;
		MessageType = messageType;
	}

	public RequiredAttribute(string errorMessage)
	{
		ErrorMessage = errorMessage;
		MessageType = InfoMessageType.Error;
	}

	public RequiredAttribute(InfoMessageType messageType)
	{
		MessageType = messageType;
	}
}
