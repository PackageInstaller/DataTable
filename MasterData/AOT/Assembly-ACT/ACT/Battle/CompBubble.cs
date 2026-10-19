using System.Collections.Generic;
using ACT.Model;
using ACT.Model.ChatBubbleModel;
using ACT.NPC.ChatBubble;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.Battle;

public class CompBubble : EcsComponent, IBubbleObject
{
	private IReadOnlyList<IBubbleData> _bubbleDatas;

	private readonly List<NpcChatBubbleRuntime> _bubbleRuntimes = new List<NpcChatBubbleRuntime>();

	private Transform _parent;

	public IReadOnlyList<NpcChatBubbleRuntime> BubbleRuntimes => _bubbleRuntimes;

	public IReadOnlyList<IBubbleData> BubbleDatas
	{
		get
		{
			return _bubbleDatas;
		}
		set
		{
			if (_bubbleDatas != value)
			{
				this.StopBubbleGroup();
				ClearBubbleDatasRuntime();
				_bubbleDatas = value;
				BuildBubbleDatasRuntime(value);
			}
		}
	}

	public Transform Parent
	{
		get
		{
			return _parent;
		}
		set
		{
			if (!(_parent == value))
			{
				_parent = value;
				RebindPlayingBubble();
			}
		}
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		BubbleDatas = null;
		Parent = null;
	}

	public void BindParentFromInteract(CompInteract compInteract)
	{
		if (compInteract == null)
		{
			return;
		}
		if (compInteract.CommonInteractTip != null)
		{
			Parent = compInteract.CommonInteractTip.BubbleRoot;
			return;
		}
		InstanceHandle interactLoader = compInteract.InteractLoader;
		if (interactLoader == null)
		{
			return;
		}
		interactLoader.Completed += (InstanceHandle _) =>
		{
			if (compInteract.CommonInteractTip != null)
			{
				Parent = compInteract.CommonInteractTip.BubbleRoot;
			}
		};
	}

	private void RebindPlayingBubble()
	{
		if ((bool)_parent && Model<ChatBubbleModel>.HasInstance())
		{
			Model<ChatBubbleModel>.Interface.RebindPlayingBubbleObject(this);
		}
	}

	public Vector3 GetBubbleRootPosition()
	{
		if ((bool)_parent)
		{
			return _parent.position;
		}
		return Vector3.zero;
	}

	public Transform GetBubbleRootTransform()
	{
		return _parent;
	}

	private void BuildBubbleDatasRuntime(IReadOnlyList<IBubbleData> bubbleDatas)
	{
		if (bubbleDatas == null)
		{
			return;
		}
		for (int i = 0; i < bubbleDatas.Count; i++)
		{
			if (bubbleDatas[i] is NpcChatBubbleCollection npcChatBubbleCollection)
			{
				_bubbleRuntimes.Add(npcChatBubbleCollection.CreateRuntime());
			}
		}
	}

	private void ClearBubbleDatasRuntime()
	{
		for (int i = 0; i < _bubbleRuntimes.Count; i++)
		{
			_bubbleRuntimes[i].Clear();
		}
		_bubbleRuntimes.Clear();
	}
}
