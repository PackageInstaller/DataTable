namespace Packages.P08Base;

internal class Node<T> : CommonNode
{
	public T data;

	public override string ToString()
	{
		string format = "next = {0}\nbefore = {1}\nlist = {2}\ndata = {3}\n";
		string text = ((next == null) ? "null" : next.GetHashCode().ToString());
		string text2 = ((before == null) ? "null" : before.GetHashCode().ToString());
		string text3 = ((list == null) ? "null" : list.GetHashCode().ToString());
		string text4 = ((data == null) ? "null" : data.GetHashCode().ToString());
		return GetHashCode() + ", " + string.Format(format, text, text2, text3, text4);
	}
}
