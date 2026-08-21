using System;
using NodeCanvas.Framework;
using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

public abstract class DTNode : Node
{
	[SerializeField]
	private string _actorName = "SELF";

	[SerializeField]
	private string _actorParameterID;

	public override string name
	{
		get
		{
			if (requireActorSelection)
			{
				if (DLGTree.definedActorParameterNames.Contains(actorName))
				{
					return $"{actorName}";
				}
				return $"<color=#d63e3e>* {_actorName} *</color>";
			}
			return base.name;
		}
	}

	public virtual bool requireActorSelection => true;

	public override int maxInConnections => -1;

	public override int maxOutConnections => 1;

	public sealed override Type outConnectionType => typeof(DTConnection);

	public sealed override bool allowAsPrime => true;

	public sealed override bool canSelfConnect => false;

	public sealed override Alignment2x2 commentsAlignment => Alignment2x2.Right;

	public sealed override Alignment2x2 iconAlignment => Alignment2x2.Bottom;

	protected DialogueTree DLGTree => (DialogueTree)base.graph;

	public string actorName
	{
		get
		{
			DialogueTree.ActorParameter parameterByID = DLGTree.GetParameterByID(_actorParameterID);
			if (parameterByID == null)
			{
				return _actorName;
			}
			return parameterByID.name;
		}
		private set
		{
			if (_actorName != value && !string.IsNullOrEmpty(value))
			{
				_actorName = value;
				_actorParameterID = DLGTree.GetParameterByName(value)?.ID;
			}
		}
	}

	public IDialogueActor finalActor
	{
		get
		{
			IDialogueActor actorReferenceByID = DLGTree.GetActorReferenceByID(_actorParameterID);
			if (actorReferenceByID == null)
			{
				return DLGTree.GetActorReferenceByName(_actorName);
			}
			return actorReferenceByID;
		}
	}
}
