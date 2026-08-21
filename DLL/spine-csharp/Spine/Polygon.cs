namespace Spine;

public class Polygon
{
	public float[] Vertices { get; set; }

	public int Count { get; set; }

	public Polygon()
	{
		Vertices = new float[16];
	}
}
