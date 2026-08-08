public class BuffCameraRadialBlurEffect : IFramePooledObject
{
	public int BuffID;

	public float RadialBlurScale;

	public void OnEnterPool()
	{
		BuffID = 0;
		RadialBlurScale = 0f;
	}
}
