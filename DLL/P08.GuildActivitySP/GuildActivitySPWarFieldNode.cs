using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
[RequireComponent(typeof(BoxCollider2D))]
public class GuildActivitySPWarFieldNode : MonoBehaviour
{
	[SerializeField]
	public int id;

	[SerializeField]
	public int map_id;

	[SerializeField]
	public int activity_id;

	[SerializeField]
	public int stageId;

	[SerializeField]
	public int vitality_cost;

	[SerializeField]
	public int level;

	[SerializeField]
	public int token_get;

	[SerializeField]
	public GuildActivitySPWarFieldNodeType nodeType = GuildActivitySPWarFieldNodeType.Normal;

	[SerializeField]
	public List<int> attribute_factor = new List<int>();

	[HideInInspector]
	[SerializeField]
	public List<GuildActivitySPWarFieldNode> neighbours = new List<GuildActivitySPWarFieldNode>();

	[HideInInspector]
	[SerializeField]
	public int special_level;

	[HideInInspector]
	[SerializeField]
	public int bose_score;

	[HideInInspector]
	[SerializeField]
	public int boss_stage_hp;

	[HideInInspector]
	[SerializeField]
	public string boss_id;

	[SerializeField]
	public string boss_reward_exchange;

	[HideInInspector]
	[SerializeField]
	private Color _gizmosColor;

	private void Awake()
	{
	}

	public void SetSelected(bool value)
	{
		IUIController[] components = GetComponents<IUIController>();
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i].GetName() == "select")
			{
				components[i].SetSelectedState(value ? "on" : "off");
				break;
			}
		}
	}

	public void SetGizmosColor(Color c)
	{
		_gizmosColor = c;
	}
}
