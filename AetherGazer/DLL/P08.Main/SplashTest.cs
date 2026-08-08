using UnityEngine;

public class SplashTest : MonoBehaviour
{
	private float _curTime;

	private void Start()
	{
	}

	private void Update()
	{
		_curTime += Time.deltaTime;
		if (_curTime > 1f)
		{
			NScene.Load<MainScene>();
		}
	}
}
