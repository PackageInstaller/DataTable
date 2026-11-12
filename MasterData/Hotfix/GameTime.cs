using TMPro;
using UnityEngine;

public class GameTime : MonoBehaviour
{
	private TMP_Text timeTips;

	private void Start()
	{
		timeTips = GetComponent<TMP_Text>();
	}

	private void Update()
	{
		if (timeTips != null)
		{
			timeTips.text = LockStepManager.time.ToString();
		}
	}
}
