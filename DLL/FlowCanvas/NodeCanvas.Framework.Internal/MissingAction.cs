using System.Linq;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;

namespace NodeCanvas.Framework.Internal;

[DoNotList]
[Description("Please resolve the MissingTask issue by either replacing the task or importing the missing task type in the project")]
public class MissingAction : ActionTask, IMissingRecoverable
{
	[fsProperty]
	public string missingType { get; set; }

	[fsProperty]
	public string recoveryState { get; set; }

	protected override string info => $"<color=#ff6457>* {missingType.Split('.').Last()} *</color>";
}
