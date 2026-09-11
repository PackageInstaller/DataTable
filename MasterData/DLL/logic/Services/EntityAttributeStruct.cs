namespace Services;

public struct EntityAttributeStruct(long x, long y, long z)
{
	public long baseValue = x;

	public long plusValue = y;

	public long tempPlusValue = z;
}
