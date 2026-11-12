using System;

[Serializable]
public class OutfiInfo
{
	public int Id;

	public int level;

	public int phase;

	public int star;

	public void LoadFrom(OutfiInfo other)
	{
		Id = other.Id;
		level = other.level;
		phase = other.phase;
		star = other.star;
	}
}
