using System.Collections;

namespace System.Text.RegularExpressions;

internal sealed class RegexTree
{
	public readonly RegexNode Root;

	public readonly Hashtable Caps;

	public readonly int[] CapNumList;

	public readonly int CapTop;

	public readonly Hashtable CapNames;

	public readonly string[] CapsList;

	public readonly RegexOptions Options;

	internal RegexTree(RegexNode root, Hashtable caps, int[] capNumList, int capTop, Hashtable capNames, string[] capsList, RegexOptions options)
	{
		Root = root;
		Caps = caps;
		CapNumList = capNumList;
		CapTop = capTop;
		CapNames = capNames;
		CapsList = capsList;
		Options = options;
	}
}
