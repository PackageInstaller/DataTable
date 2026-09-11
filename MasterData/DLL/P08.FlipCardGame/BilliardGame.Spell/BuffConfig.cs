using System;
using System.Collections.Generic;
using UnityEngine;

namespace BilliardGame.Spell;

[Serializable]
public class BuffConfig : ScriptableObject, IRuntimeAIConfig
{
	public int effectId;

	public string Desc;

	public float Duration;

	public float TickTime;

	public BuffExecuteMode buffExecuteMode;

	public BuffTriggerMode buffDisposeMode;

	public BuffTriggerMode buffResetMode;

	public int turn;

	public int maxLevel;

	[SerializeReference]
	[SerializeField]
	private List<BNode> nodes;

	public string Name => effectId.ToString();

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
}
