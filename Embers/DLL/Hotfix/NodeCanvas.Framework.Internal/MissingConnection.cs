using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[DoNotList]
[Description("Please resolve the MissingConnection issue by either replacing the connection, importing the missing connection type, or refactoring the type in GraphRefactor.")]
public sealed class MissingConnection : Connection, IMissingRecoverable
{
	[SerializeField]
	private string _missingType;

	[SerializeField]
	private string _recoveryState;

	string IMissingRecoverable.missingType
	{
		get
		{
			return _missingType;
		}
		set
		{
			_missingType = value;
		}
	}

	string IMissingRecoverable.recoveryState
	{
		get
		{
			return _recoveryState;
		}
		set
		{
			_recoveryState = value;
		}
	}
}
