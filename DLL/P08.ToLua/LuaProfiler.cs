using System.Collections.Generic;

public static class LuaProfiler
{
	public static List<string> list = new List<string>();

	public static void Clear()
	{
		list.Clear();
	}

	public static int GetID(string name)
	{
		int count = list.Count;
		list.Add(name);
		return count;
	}

	public static void BeginSample(int id)
	{
		_ = list[id];
	}

	public static void EndSample()
	{
	}
}
