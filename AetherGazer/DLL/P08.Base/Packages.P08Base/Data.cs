using System;

namespace Packages.P08Base;

internal class Data<T> : CommonData where T : class
{
	public new Action<string, T> destroyAction;

	public new T target;

	public override Type type => typeof(T);

	public override void Reset()
	{
		if (destroyAction != null)
		{
			destroyAction(key, target);
		}
		key = null;
		node = null;
		target = null;
		destroyAction = null;
	}

	public override string ToString()
	{
		string format = "action.name = {0}\ntype.name = {1}\ntarget.name = {2}\nkey = {3}\nnode.hash = {4}\n";
		string text = ((destroyAction == null || destroyAction.Method == null) ? "null" : destroyAction.Method.Name);
		string name = type.Name;
		string text2 = ((target == null) ? "null" : target.ToString());
		string text3 = ((node == null) ? "null" : node.GetHashCode().ToString());
		return GetHashCode() + ", " + string.Format(format, text, name, text2, key, text3);
	}
}
