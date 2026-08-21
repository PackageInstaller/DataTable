using System;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[DoNotList]
[Description("Please resolve the MissingNode issue by either replacing the node, importing the missing node type, or refactoring the type in GraphRefactor.")]
public sealed class MissingNode : Node, IMissingRecoverable
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

	public override string name => "Missing Node".FormatError();

	public override Type outConnectionType => null;

	public override int maxInConnections => 0;

	public override int maxOutConnections => 0;

	public override bool allowAsPrime => false;

	public override bool canSelfConnect => false;

	public override Alignment2x2 commentsAlignment => Alignment2x2.Right;

	public override Alignment2x2 iconAlignment => Alignment2x2.Default;
}
