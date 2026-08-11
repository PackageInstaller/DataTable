using System;
using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[GraphInfo(packageName = "NodeCanvas", docsURL = "https://nodecanvas.paradoxnotion.com/documentation/", resourcesURL = "https://nodecanvas.paradoxnotion.com/downloads/", forumsURL = "https://nodecanvas.paradoxnotion.com/forums-page/")]
[CreateAssetMenu(menuName = "ParadoxNotion/NodeCanvas/Dialogue Tree Asset")]
public class DialogueTree : Graph
{
	[Serializable]
	private class DerivedSerializationData
	{
		public List<ActorParameter> actorParameters;
	}

	[Serializable]
	public class ActorParameter
	{
		[SerializeField]
		private string _keyName;

		[SerializeField]
		private string _id;

		[SerializeField]
		private UnityEngine.Object _actorObject;

		[NonSerialized]
		private IDialogueActor _actor;

		public string name
		{
			get
			{
				return _keyName;
			}
			set
			{
				_keyName = value;
			}
		}

		public string ID
		{
			get
			{
				if (!string.IsNullOrEmpty(_id))
				{
					return _id;
				}
				return _id = Guid.NewGuid().ToString();
			}
		}

		public IDialogueActor actor
		{
			get
			{
				if (_actor == null)
				{
					_actor = _actorObject as IDialogueActor;
				}
				return _actor;
			}
			set
			{
				_actor = value;
				_actorObject = value as UnityEngine.Object;
			}
		}

		public ActorParameter()
		{
		}

		public ActorParameter(string name)
		{
			this.name = name;
		}

		public ActorParameter(string name, IDialogueActor actor)
		{
			this.name = name;
			this.actor = actor;
		}

		public override string ToString()
		{
			return name;
		}
	}

	public const string INSTIGATOR_NAME = "SELF";

	[SerializeField]
	public List<ActorParameter> actorParameters = new List<ActorParameter>();

	public static DialogueTree currentDialogue { get; private set; }

	public static DialogueTree previousDialogue { get; private set; }

	public DTNode currentNode { get; private set; }

	public override Type baseNodeType => typeof(DTNode);

	public override bool requiresAgent => false;

	public override bool requiresPrimeNode => true;

	public override bool isTree => true;

	public override bool allowBlackboardOverrides => true;

	public sealed override bool canAcceptVariableDrops => false;

	public List<string> definedActorParameterNames
	{
		get
		{
			List<string> list = actorParameters.Select((ActorParameter r) => r.name).ToList();
			list.Insert(0, "SELF");
			return list;
		}
	}

	public static event Action<DialogueTree> OnDialogueStarted;

	public static event Action<DialogueTree> OnDialoguePaused;

	public static event Action<DialogueTree> OnDialogueFinished;

	public static event Action<SubtitlesRequestInfo> OnSubtitlesRequest;

	public static event Action<MultipleChoiceRequestInfo> OnMultipleChoiceRequest;

	public override object OnDerivedDataSerialization()
	{
		return new DerivedSerializationData
		{
			actorParameters = actorParameters
		};
	}

	public override void OnDerivedDataDeserialization(object data)
	{
		if (data is DerivedSerializationData)
		{
			actorParameters = ((DerivedSerializationData)data).actorParameters;
		}
	}

	public ActorParameter GetParameterByID(string id)
	{
		return actorParameters.Find((ActorParameter p) => p.ID == id);
	}

	public ActorParameter GetParameterByName(string paramName)
	{
		return actorParameters.Find((ActorParameter p) => p.name == paramName);
	}

	public IDialogueActor GetActorReferenceByID(string id)
	{
		ActorParameter parameterByID = GetParameterByID(id);
		if (parameterByID == null)
		{
			return null;
		}
		return GetActorReferenceByName(parameterByID.name);
	}

	public IDialogueActor GetActorReferenceByName(string paramName)
	{
		if (paramName == "SELF")
		{
			if (base.agent is IDialogueActor)
			{
				return (IDialogueActor)base.agent;
			}
			if (base.agent != null)
			{
				return new ProxyDialogueActor(base.agent.gameObject.name, base.agent.transform);
			}
			return new ProxyDialogueActor("NO ACTOR", null);
		}
		ActorParameter actorParameter = actorParameters.Find((ActorParameter r) => r.name == paramName);
		if (actorParameter != null && actorParameter.actor != null)
		{
			return actorParameter.actor;
		}
		return new ProxyDialogueActor(paramName, null);
	}

	public void SetActorReference(string paramName, IDialogueActor actor)
	{
		ActorParameter actorParameter = actorParameters.Find((ActorParameter p) => p.name == paramName);
		if (actorParameter != null)
		{
			actorParameter.actor = actor;
		}
	}

	public void SetActorReferences(Dictionary<string, IDialogueActor> actors)
	{
		foreach (KeyValuePair<string, IDialogueActor> pair in actors)
		{
			ActorParameter actorParameter = actorParameters.Find((ActorParameter p) => p.name == pair.Key);
			if (actorParameter != null)
			{
				actorParameter.actor = pair.Value;
			}
		}
	}

	public void Continue(int index = 0)
	{
		if (index < 0 || index > currentNode.outConnections.Count - 1)
		{
			Stop(success: false);
			return;
		}
		currentNode.outConnections[index].status = Status.Success;
		EnterNode((DTNode)currentNode.outConnections[index].targetNode);
	}

	public void EnterNode(DTNode node)
	{
		currentNode = node;
		currentNode.Reset(recursively: false);
		if (currentNode.Execute(base.agent, base.blackboard) == Status.Error)
		{
			Stop(success: false);
		}
	}

	public static void RequestSubtitles(SubtitlesRequestInfo info)
	{
		if (OnSubtitlesRequest != null)
		{
			OnSubtitlesRequest(info);
		}
	}

	public static void RequestMultipleChoices(MultipleChoiceRequestInfo info)
	{
		if (OnMultipleChoiceRequest != null)
		{
			OnMultipleChoiceRequest(info);
		}
	}

	protected override void OnGraphStarted()
	{
		previousDialogue = currentDialogue;
		currentDialogue = this;
		if (OnDialogueStarted != null)
		{
			OnDialogueStarted(this);
		}
		_ = base.agent is IDialogueActor;
		currentNode = ((currentNode != null) ? currentNode : ((DTNode)base.primeNode));
		EnterNode(currentNode);
	}

	protected override void OnGraphUpdate()
	{
		if (currentNode is IUpdatable)
		{
			(currentNode as IUpdatable).Update();
		}
	}

	protected override void OnGraphStopped(bool isExecuteStopLogic)
	{
		currentDialogue = previousDialogue;
		previousDialogue = null;
		currentNode = null;
		if (OnDialogueFinished != null)
		{
			OnDialogueFinished(this);
		}
	}

	protected override void OnGraphPaused()
	{
		if (OnDialoguePaused != null)
		{
			OnDialoguePaused(this);
		}
	}

	protected override void OnGraphUnpaused()
	{
		currentNode = ((currentNode != null) ? currentNode : ((DTNode)base.primeNode));
		EnterNode(currentNode);
		if (OnDialogueStarted != null)
		{
			OnDialogueStarted(this);
		}
	}
}
