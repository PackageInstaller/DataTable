using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class CardData
{
	public int id;

	public int needPoint;

	public Vector2 pos;

	public string name = "";

	public string desc = "";

	public int type;

	public int power;

	public List<Vector2> controllEffects;

	public List<Effect> effects;

	public string icon = "";

	public int limit;

	public BloodCardEnum.CardRarity rare;
}
