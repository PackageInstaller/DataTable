namespace Cinemachine;

public class RuntimeNode<T> where T : class, ITimelineClipLength
{
	public T clip;

	public float normalized;

	public float time;

	public void ResetData()
	{
		clip = null;
		normalized = 0f;
		time = 0f;
	}
}
