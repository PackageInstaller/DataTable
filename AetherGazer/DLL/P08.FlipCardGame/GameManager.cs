using UnityEngine;

public class GameManager : MonoBehaviour
{
	private DeterministicRandom _random;

	private DeterministicRandom _enemyRandom;

	private void Start()
	{
		int num = PlayerPrefs.GetInt("GameSeed", 12345);
		_random = new DeterministicRandom(num);
		_enemyRandom = new DeterministicRandom(num + 1000);
		GenerateWorld();
	}

	private void GenerateWorld()
	{
		int num = _random.Range(50, 100);
		int num2 = _random.Range(50, 100);
		int num3 = _enemyRandom.Range(10, 30);
		Debug.Log($"生成世界: {num}x{num2}, 敌人数量: {num3}");
	}
}
