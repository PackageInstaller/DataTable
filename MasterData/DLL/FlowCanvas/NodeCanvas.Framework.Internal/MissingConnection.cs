using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;

namespace NodeCanvas.Framework.Internal;

[DoNotList]
public sealed class MissingConnection : Connection, IMissingRecoverable
{
	[fsProperty]
	public string missingType { get; set; }

	[fsProperty]
	public string recoveryState { get; set; }
}
