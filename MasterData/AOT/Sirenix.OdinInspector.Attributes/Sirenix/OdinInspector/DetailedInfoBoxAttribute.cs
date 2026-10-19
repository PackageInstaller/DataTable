using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public class DetailedInfoBoxAttribute : Attribute
{
	public string Message;

	public string Details;

	public InfoMessageType InfoMessageType;

	public string VisibleIf;

	public DetailedInfoBoxAttribute(string message, string details, InfoMessageType infoMessageType = InfoMessageType.Info, string visibleIf = null)
	{
		Message = message;
		Details = details;
		InfoMessageType = infoMessageType;
		VisibleIf = visibleIf;
	}
}
