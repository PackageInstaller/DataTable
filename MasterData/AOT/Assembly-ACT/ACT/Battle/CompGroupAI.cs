using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CompGroupAI : EcsComponent
{
	public int id;

	private GameObject _node;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		id = -1;
		if (!(_node == null))
		{
			Object.Destroy(_node);
			_node = null;
		}
	}

	public List<Entity> GetChildrenEntity()
	{
		return Singleton<GroupAIManager>.instance.groups[id];
	}

	public GameObject CreateNode()
	{
		return _node ?? (_node = new GameObject($"[{id}]GroupAI", typeof(ActBehaviorTree)));
	}
}
