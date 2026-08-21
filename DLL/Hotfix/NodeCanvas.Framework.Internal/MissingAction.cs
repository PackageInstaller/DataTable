using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[DoNotList]
[Description("Please resolve the MissingAction issue by either replacing the action, importing the missing action type, or refactoring the type in GraphRefactor.")]
public class MissingAction : ActionTask, IMissingRecoverable
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

	protected override string info => ReflectionTools.FriendlyTypeName(_missingType).FormatError();
}
