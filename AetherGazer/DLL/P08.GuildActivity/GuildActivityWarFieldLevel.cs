using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class GuildActivityWarFieldLevel : MonoBehaviour
{
	[SerializeField]
	public int map_id = 1;

	[SerializeField]
	public List<GuildActivityWarFieldNode> nodes;
}
