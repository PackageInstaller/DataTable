using UnityEngine;

public class StopAudioBeforeExit : MonoBehaviour
{
	[Tooltip("中断背景音乐")]
	public bool isStopMusic;

	[Tooltip("中断音效")]
	public bool isStopEffect;

	[Tooltip("中断语音")]
	public bool isStopVoice;

	private void OnDisable()
	{
		StopAudio();
	}

	public void StopAudio()
	{
		if (isStopMusic)
		{
			AudioManager.Instance.Stop("music");
		}
		if (isStopEffect)
		{
			AudioManager.Instance.Stop("effect");
		}
		if (isStopVoice)
		{
			AudioManager.Instance.Stop("voice");
		}
	}
}
