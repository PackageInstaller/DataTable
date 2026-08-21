using UnityEngine;

public class BuffCharacterRimLightEffect : IFramePooledObject
{
	public int BuffID;

	public float Ratio;

	public float Soft;

	public Color Outer;

	public Color Inner;

	public int Order = 1;

	public void OnEnterPool()
	{
		BuffID = 0;
		Ratio = 0f;
		Order = 1;
	}
}
