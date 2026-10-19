using System.Collections;
using UnityEngine.Scripting;

namespace Unity.VisualScripting;

public sealed class AotList : ArrayList
{
	public AotList()
	{
	}

	public AotList(int capacity)
		: base(capacity)
	{
	}

	public AotList(ICollection c)
		: base(c)
	{
	}

	[Preserve]
	public static void AotStubs()
	{
		AotList aotList = new AotList();
		aotList.Add(null);
		aotList.Remove(null);
		_ = aotList[0];
		aotList[0] = null;
		aotList.Contains(null);
		aotList.Clear();
		_ = aotList.Count;
	}
}
