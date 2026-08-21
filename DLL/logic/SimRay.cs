public struct SimRay
{
	public Int3 direction;

	public Int3 origin;

	public Int3 GetPoint(Int distance)
	{
		return origin += direction * (VFactor)distance;
	}

	public SimRay(Int3 orgin, Int3 direction)
	{
		origin = orgin;
		this.direction = direction;
	}

	public override string ToString()
	{
		return string.Concat("[SimRay] origin: ", origin, ", direction: ", direction);
	}
}
