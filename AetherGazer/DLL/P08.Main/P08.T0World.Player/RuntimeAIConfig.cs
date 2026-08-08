using System.Collections.Generic;
using BilliardGame.Spell;
using Sirenix.OdinInspector;
using UnityEngine;

namespace P08.T0World.Player;

public class RuntimeAIConfig : SerializedScriptableObject, IRuntimeAIConfig
{
	[SerializeReference]
	[SerializeField]
	private List<BNode> nodes;

	public List<BNode> Nodes
	{
		get
		{
			return nodes;
		}
		set
		{
			nodes = value;
		}
	}

	public string Name => "RuntimeAIConfig: " + base.name;
}
