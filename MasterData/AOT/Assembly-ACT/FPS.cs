using TMPro;
using UnityEngine;

public class FPS : MonoBehaviour
{
	public TextMeshProUGUI FPSText;

	public float updateInterval = 0.2f;

	public float fps;

	private float framesCount;

	private float framesTime;

	private float lastRealTime;

	public Canvas fullMonitor;

	private void Start()
	{
		framesCount = 0f;
		framesTime = 0f;
		lastRealTime = Time.realtimeSinceStartup;
	}

	private void Update()
	{
		float num = Time.realtimeSinceStartup - lastRealTime;
		lastRealTime = Time.realtimeSinceStartup;
		framesCount++;
		framesTime += num;
		if (framesTime > updateInterval)
		{
			fps = framesCount / framesTime;
			if (fullMonitor.enabled)
			{
				FPSText.text = fps.ToString("F1");
			}
			framesCount = 0f;
			framesTime = 0f;
		}
	}
}
