namespace Packages.P08Base;

internal class NodeList
{
	private CommonNode head;

	public bool AddToFront(CommonNode node)
	{
		if (node == null)
		{
			Log.LogError("node 为空, 添加失败");
			return false;
		}
		if (node.before != null || node.next != null || node.list != null)
		{
			Log.LogError("node 不干净, 添加失败");
			return false;
		}
		if (head == null)
		{
			node.next = node;
			node.before = node;
			head = node;
		}
		else
		{
			node.next = head;
			node.before = head.before;
			head.before.next = node;
			head.before = node;
			head = node;
		}
		node.list = this;
		node.count++;
		return true;
	}

	public CommonNode RemoveNode(CommonNode node)
	{
		if (node == null || node.before == null || node.next == null)
		{
			Log.LogError("node 为空或者肯定不在列表里面, 移除失败");
			return node;
		}
		if (node.list != this)
		{
			Log.LogError("node 不在list里面, 移除失败");
			return node;
		}
		node.before.next = node.next;
		node.next.before = node.before;
		if (node == head)
		{
			head = node.next;
		}
		node.next = null;
		node.before = null;
		if (head == node)
		{
			head = null;
		}
		node.list = null;
		return node;
	}

	public CommonNode MoveToFront(CommonNode node)
	{
		CommonNode commonNode = RemoveNode(node);
		AddToFront(commonNode);
		return commonNode;
	}

	public CommonNode RemoveLast()
	{
		if (head == null)
		{
			return null;
		}
		do
		{
			head.before.count /= 2;
		}
		while (head.before.count > 0 && (head = head.before) != null);
		return RemoveNode(head.before);
	}

	public override string ToString()
	{
		string text = "head -> ";
		if (head == null)
		{
			return text;
		}
		CommonNode next = head;
		do
		{
			text += next.GetHashCode();
			if (next is Node<CommonData>)
			{
				text = text + "(" + (next as Node<CommonData>).data.key + ")";
			}
			text += " -> ";
			next = next.next;
		}
		while (next != head);
		return text;
	}
}
