using UnityEngine;

public class LeanAudioStream
{
	public int position;

	public AudioClip audioClip;

	public float[] audioArr;

	public LeanAudioStream(float[] audioArr)
	{
		this.audioArr = audioArr;
	}

	public void OnAudioRead(float[] data)
	{
		for (int i = 0; i < data.Length; i++)
		{
			data[i] = audioArr[position];
			position++;
		}
	}

	public void OnAudioSetPosition(int newPosition)
	{
		position = newPosition;
	}
}
