using System.Collections.Generic;
using UnityEngine;

namespace P08Main.Loading;

public class CustomRandomShow : MonoBehaviour
{
	public List<GameObject> randomShowObjects;

	public void OnEnable()
	{
		if (randomShowObjects == null || randomShowObjects.Count == 0)
		{
			Debug.LogWarning("No objects to show randomly.");
			return;
		}
		int num = Random.Range(0, randomShowObjects.Count);
		for (int i = 0; i < randomShowObjects.Count; i++)
		{
			randomShowObjects[i].SetActive(i == num);
		}
	}
}
