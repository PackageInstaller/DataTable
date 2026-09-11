using System;

public class RandomEx
{
	private Random rd;

	public RandomEx(int seed)
	{
		rd = new Random(seed);
	}

	public int NextInt(int range)
	{
		return rd.Next(range);
	}

	public int NextIntRange(int begin, int end)
	{
		return rd.Next(begin, end);
	}

	public int Next(int begin, int end)
	{
		return NextIntRange(begin, end);
	}

	public double NextDouble()
	{
		return rd.NextDouble();
	}
}
