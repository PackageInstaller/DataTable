using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class GoldBodySettings : ScriptableObject
{
	public List<float> showList = new List<float>();

	public int attackPower = 10;

	public float GoldTime = 0.1f;

	public float GoldBodySize = 1f;

	public float GoldBodyOriData = 0.1125f;

	public float GoldBodyDelta = 0.0375f;

	public float GoldDisappearTime = 1f;

	private void UpdateList()
	{
		showList.Clear();
		for (int i = 0; i <= attackPower; i++)
		{
			showList.Add(GetEdgeFloat(i));
		}
	}

	private float GetEdgeFloat(int attackPower)
	{
		attackPower = ((attackPower >= 0) ? attackPower : 0);
		attackPower = ((attackPower > 10) ? 10 : attackPower);
		return (float)((attackPower > 0) ? 1 : 0) * GoldBodyOriData + (float)((attackPower - 1 >= 0) ? (attackPower - 1) : 0) * GoldBodyDelta;
	}
}
