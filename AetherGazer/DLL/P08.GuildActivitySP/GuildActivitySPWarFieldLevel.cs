using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class GuildActivitySPWarFieldLevel : MonoBehaviour
{
	[SerializeField]
	public int map_id = 1;

	[SerializeField]
	public List<GuildActivitySPWarFieldNode> nodes;

	private void Awake()
	{
	}

	private void Start()
	{
	}
}
