using System.Collections.Generic;
using UnityEngine;

public class RandomSystemExample
{
	public void Demo()
	{
		DeterministicRandom deterministicRandom = new DeterministicRandom();
		Debug.Log($"整数随机: {deterministicRandom.Range(1, 100)}");
		Debug.Log($"浮点数随机: {deterministicRandom.Range(0f, 1f)}");
		Debug.Log($"布尔随机: {deterministicRandom.Boolean()}");
		Debug.Log(string.Format("敌人掉落: {0}", deterministicRandom.Range(1, 5, "enemy_drop")));
		Debug.Log(string.Format("地图生成: {0}", deterministicRandom.Range(1, 10, "map_generation")));
		string[] array = new string[4] { "剑", "盾", "药水", "金币" };
		string text = deterministicRandom.RandomChoice(array);
		Debug.Log("获得物品: " + text);
		List<int> list = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
		deterministicRandom.Shuffle(list);
		Debug.Log($"洗牌后第一张牌: {list[0]}");
		new Dictionary<string, float>
		{
			{ "普通物品", 60f },
			{ "稀有物品", 30f },
			{ "史诗物品", 9f },
			{ "传说物品", 1f }
		};
		deterministicRandom.SaveState("before_boss");
		deterministicRandom.LoadState("before_boss");
	}
}
