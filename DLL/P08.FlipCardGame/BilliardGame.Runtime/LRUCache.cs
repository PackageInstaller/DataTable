namespace BilliardGame.Runtime;

public class LRUCache
{
	private class DLinkedNode
	{
		public string Key { get; set; }

		public BilliardGameHud Value { get; set; }

		public DLinkedNode Pre { get; set; }

		public DLinkedNode Post { get; set; }
	}

	private int _count;

	private readonly int _capacity;

	private readonly DLinkedNode _head;

	private readonly DLinkedNode _tail;

	public LRUCache(int capacity)
	{
		_count = 0;
		_capacity = capacity;
		_head = new DLinkedNode();
		_head.Pre = null;
		_tail = new DLinkedNode();
		_tail.Post = null;
		_head.Post = _tail;
		_tail.Pre = _head;
	}

	public BilliardGameHud Get(string key)
	{
		DLinkedNode head = GetHead();
		if (head == null)
		{
			return null;
		}
		MoveToTail(head);
		return head.Value;
	}

	public void Set(string key, BilliardGameHud value)
	{
		DLinkedNode dLinkedNode = new DLinkedNode();
		dLinkedNode.Key = key;
		dLinkedNode.Value = value;
		AddNode(dLinkedNode);
		_count++;
		if (_count > _capacity)
		{
			PopTail();
			_count--;
		}
	}

	private void AddNode(DLinkedNode node)
	{
		node.Pre = _tail.Pre;
		node.Post = _tail;
		_tail.Pre.Post = node;
		_tail.Pre = node;
	}

	private void RemoveNode(DLinkedNode node)
	{
		DLinkedNode pre = node.Pre;
		DLinkedNode dLinkedNode = (pre.Post = node.Post);
		dLinkedNode.Pre = pre;
	}

	private void MoveToTail(DLinkedNode node)
	{
		RemoveNode(node);
		AddNode(node);
	}

	private DLinkedNode GetHead()
	{
		return _head.Post;
	}

	private DLinkedNode PopTail()
	{
		DLinkedNode pre = _tail.Pre;
		RemoveNode(pre);
		return pre;
	}
}
