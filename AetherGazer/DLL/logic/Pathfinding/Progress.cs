namespace Pathfinding;

public struct Progress(float p, string d)
{
	public readonly float progress = p;

	public readonly string description = d;

	public override string ToString()
	{
		float num = progress;
		return num.ToString("0.0") + " " + description;
	}
}
