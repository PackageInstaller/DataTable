using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class Effect
{
	public int id;

	public List<Vector2> effectPosList;

	public Effect(int id, List<Vector2> effectPosList)
	{
		this.id = id;
		this.effectPosList = effectPosList;
	}
}
