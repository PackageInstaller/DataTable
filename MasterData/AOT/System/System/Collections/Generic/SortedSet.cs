using System.Diagnostics;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(ICollectionDebugView<>))]
public class SortedSet<T> : ISet<T>, ICollection<T>, IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>, ISerializable, IDeserializationCallback
{
	[Serializable]
	internal sealed class Node
	{
		public T Item { get; set; }

		public Node Left { get; set; }

		public Node Right { get; set; }

		public NodeColor Color { get; set; }

		public bool IsBlack => Color == NodeColor.Black;

		public bool IsRed => Color == NodeColor.Red;

		public bool Is2Node
		{
			get
			{
				if (IsBlack && IsNullOrBlack(Left))
				{
					return IsNullOrBlack(Right);
				}
				return false;
			}
		}

		public bool Is4Node
		{
			get
			{
				if (IsNonNullRed(Left))
				{
					return IsNonNullRed(Right);
				}
				return false;
			}
		}

		public Node(T item, NodeColor color)
		{
			Item = item;
			Color = color;
		}

		public static bool IsNonNullRed(Node node)
		{
			return node?.IsRed ?? false;
		}

		public static bool IsNullOrBlack(Node node)
		{
			return node?.IsBlack ?? true;
		}

		public void ColorBlack()
		{
			Color = NodeColor.Black;
		}

		public void ColorRed()
		{
			Color = NodeColor.Red;
		}

		public TreeRotation GetRotation(Node current, Node sibling)
		{
			bool flag = Left == current;
			if (!IsNonNullRed(sibling.Left))
			{
				if (!flag)
				{
					return TreeRotation.LeftRight;
				}
				return TreeRotation.Left;
			}
			if (!flag)
			{
				return TreeRotation.Right;
			}
			return TreeRotation.RightLeft;
		}

		public Node GetSibling(Node node)
		{
			if (node != Left)
			{
				return Left;
			}
			return Right;
		}

		public void Split4Node()
		{
			ColorRed();
			Left.ColorBlack();
			Right.ColorBlack();
		}

		public Node Rotate(TreeRotation rotation)
		{
			switch (rotation)
			{
			case TreeRotation.Right:
				Left.Left.ColorBlack();
				return RotateRight();
			case TreeRotation.Left:
				Right.Right.ColorBlack();
				return RotateLeft();
			case TreeRotation.RightLeft:
				return RotateRightLeft();
			case TreeRotation.LeftRight:
				return RotateLeftRight();
			default:
				return null;
			}
		}

		public Node RotateLeft()
		{
			Node right = Right;
			Right = right.Left;
			right.Left = this;
			return right;
		}

		public Node RotateLeftRight()
		{
			Node left = Left;
			Node right = left.Right;
			Left = right.Right;
			right.Right = this;
			left.Right = right.Left;
			right.Left = left;
			return right;
		}

		public Node RotateRight()
		{
			Node left = Left;
			Left = left.Right;
			left.Right = this;
			return left;
		}

		public Node RotateRightLeft()
		{
			Node right = Right;
			Node left = right.Left;
			Right = left.Left;
			left.Left = this;
			right.Left = left.Right;
			left.Right = right;
			return left;
		}

		public void Merge2Nodes()
		{
			ColorBlack();
			Left.ColorRed();
			Right.ColorRed();
		}

		public void ReplaceChild(Node child, Node newChild)
		{
			if (Left == child)
			{
				Left = newChild;
			}
			else
			{
				Right = newChild;
			}
		}
	}

	[Serializable]
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator, ISerializable, IDeserializationCallback
	{
		private static readonly Node s_dummyNode = new Node(default, NodeColor.Red);

		private SortedSet<T> _tree;

		private int _version;

		private Stack<Node> _stack;

		private Node _current;

		private bool _reverse;

		public T Current
		{
			get
			{
				if (_current != null)
				{
					return _current.Item;
				}
				return default;
			}
		}

		object IEnumerator.Current
		{
			get
			{
				if (_current == null)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _current.Item;
			}
		}

		internal bool NotStartedOrEnded => _current == null;

		internal Enumerator(SortedSet<T> set)
			: this(set, reverse: false)
		{
		}

		internal Enumerator(SortedSet<T> set, bool reverse)
		{
			_tree = set;
			set.VersionCheck();
			_version = set.version;
			_stack = new Stack<Node>(2 * SortedSet<T>.Log2(set.Count + 1));
			_current = null;
			_reverse = reverse;
			Initialize();
		}

		void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
		{
			throw new PlatformNotSupportedException();
		}

		void IDeserializationCallback.OnDeserialization(object sender)
		{
			throw new PlatformNotSupportedException();
		}

		private void Initialize()
		{
			_current = null;
			Node node = _tree.root;
			Node node2 = null;
			Node node3 = null;
			while (node != null)
			{
				node2 = (_reverse ? node.Right : node.Left);
				node3 = (_reverse ? node.Left : node.Right);
				if (_tree.IsWithinRange(node.Item))
				{
					_stack.Push(node);
					node = node2;
				}
				else
				{
					node = ((node2 != null && _tree.IsWithinRange(node2.Item)) ? node2 : node3);
				}
			}
		}

		public bool MoveNext()
		{
			_tree.VersionCheck();
			if (_version != _tree.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_stack.Count == 0)
			{
				_current = null;
				return false;
			}
			_current = _stack.Pop();
			Node node = (_reverse ? _current.Left : _current.Right);
			Node node2 = null;
			Node node3 = null;
			while (node != null)
			{
				node2 = (_reverse ? node.Right : node.Left);
				node3 = (_reverse ? node.Left : node.Right);
				if (_tree.IsWithinRange(node.Item))
				{
					_stack.Push(node);
					node = node2;
				}
				else
				{
					node = ((node3 != null && _tree.IsWithinRange(node3.Item)) ? node3 : node2);
				}
			}
			return true;
		}

		public void Dispose()
		{
		}

		internal void Reset()
		{
			if (_version != _tree.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_stack.Clear();
			Initialize();
		}

		void IEnumerator.Reset()
		{
			Reset();
		}
	}

	private Node root;

	private IComparer<T> comparer;

	private int count;

	private int version;

	[NonSerialized]
	private object _syncRoot;

	private SerializationInfo siInfo;

	public int Count
	{
		get
		{
			VersionCheck();
			return count;
		}
	}

	public IComparer<T> Comparer => comparer;

	bool ICollection<T>.IsReadOnly => false;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			if (_syncRoot == null)
			{
				Interlocked.CompareExchange(ref _syncRoot, new object(), null);
			}
			return _syncRoot;
		}
	}

	public SortedSet()
	{
		comparer = Comparer<T>.Default;
	}

	public SortedSet(IComparer<T> comparer)
	{
		this.comparer = comparer ?? Comparer<T>.Default;
	}

	protected SortedSet(SerializationInfo info, StreamingContext context)
	{
		siInfo = info;
	}

	internal virtual bool InOrderTreeWalk(TreeWalkPredicate<T> action)
	{
		if (root == null)
		{
			return true;
		}
		Stack<Node> stack = new Stack<Node>(2 * Log2(Count + 1));
		for (Node left = root; left != null; left = left.Left)
		{
			stack.Push(left);
		}
		while (stack.Count != 0)
		{
			Node left = stack.Pop();
			if (!action(left))
			{
				return false;
			}
			for (Node node = left.Right; node != null; node = node.Left)
			{
				stack.Push(node);
			}
		}
		return true;
	}

	internal virtual void VersionCheck()
	{
	}

	internal virtual bool IsWithinRange(T item)
	{
		return true;
	}

	public bool Add(T item)
	{
		return AddIfNotPresent(item);
	}

	void ICollection<T>.Add(T item)
	{
		Add(item);
	}

	internal virtual bool AddIfNotPresent(T item)
	{
		if (root == null)
		{
			root = new Node(item, NodeColor.Black);
			count = 1;
			version++;
			return true;
		}
		Node node = root;
		Node parent = null;
		Node node2 = null;
		Node greatGrandParent = null;
		version++;
		int num = 0;
		while (node != null)
		{
			num = comparer.Compare(item, node.Item);
			if (num == 0)
			{
				root.ColorBlack();
				return false;
			}
			if (node.Is4Node)
			{
				node.Split4Node();
				if (Node.IsNonNullRed(parent))
				{
					InsertionBalance(node, ref parent, node2, greatGrandParent);
				}
			}
			greatGrandParent = node2;
			node2 = parent;
			parent = node;
			node = ((num < 0) ? node.Left : node.Right);
		}
		Node node3 = new Node(item, NodeColor.Red);
		if (num > 0)
		{
			parent.Right = node3;
		}
		else
		{
			parent.Left = node3;
		}
		if (parent.IsRed)
		{
			InsertionBalance(node3, ref parent, node2, greatGrandParent);
		}
		root.ColorBlack();
		count++;
		return true;
	}

	public bool Remove(T item)
	{
		return DoRemove(item);
	}

	internal virtual bool DoRemove(T item)
	{
		if (root == null)
		{
			return false;
		}
		version++;
		Node node = root;
		Node node2 = null;
		Node node3 = null;
		Node node4 = null;
		Node parentOfMatch = null;
		bool flag = false;
		while (node != null)
		{
			if (node.Is2Node)
			{
				if (node2 == null)
				{
					node.ColorRed();
				}
				else
				{
					Node sibling = node2.GetSibling(node);
					if (sibling.IsRed)
					{
						if (node2.Right == sibling)
						{
							node2.RotateLeft();
						}
						else
						{
							node2.RotateRight();
						}
						node2.ColorRed();
						sibling.ColorBlack();
						ReplaceChildOrRoot(node3, node2, sibling);
						node3 = sibling;
						if (node2 == node4)
						{
							parentOfMatch = sibling;
						}
						sibling = node2.GetSibling(node);
					}
					if (sibling.Is2Node)
					{
						node2.Merge2Nodes();
					}
					else
					{
						Node node5 = node2.Rotate(node2.GetRotation(node, sibling));
						node5.Color = node2.Color;
						node2.ColorBlack();
						node.ColorRed();
						ReplaceChildOrRoot(node3, node2, node5);
						if (node2 == node4)
						{
							parentOfMatch = node5;
						}
						node3 = node5;
					}
				}
			}
			int num = (flag ? (-1) : comparer.Compare(item, node.Item));
			if (num == 0)
			{
				flag = true;
				node4 = node;
				parentOfMatch = node2;
			}
			node3 = node2;
			node2 = node;
			node = ((num < 0) ? node.Left : node.Right);
		}
		if (node4 != null)
		{
			ReplaceNode(node4, parentOfMatch, node2, node3);
			count--;
		}
		root?.ColorBlack();
		return flag;
	}

	public virtual void Clear()
	{
		root = null;
		count = 0;
		version++;
	}

	public virtual bool Contains(T item)
	{
		return FindNode(item) != null;
	}

	public void CopyTo(T[] array, int index)
	{
		CopyTo(array, index, Count);
	}

	public void CopyTo(T[] array, int index, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", index, "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (count > array.Length - index)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		count += index;
		InOrderTreeWalk((Node node) =>
		{
			if (index >= count)
			{
				return false;
			}
			array[index++] = node.Item;
			return true;
		});
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
		}
		if (array.GetLowerBound(0) != 0)
		{
			throw new ArgumentException("The lower bound of target array must be zero.", "array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", index, "Non-negative number required.");
		}
		if (array.Length - index < Count)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		if (array is T[] array2)
		{
			CopyTo(array2, index);
			return;
		}
		object[] objects = array as object[];
		if (objects == null)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.", "array");
		}
		try
		{
			InOrderTreeWalk((Node node) =>
			{
				objects[index++] = node.Item;
				return true;
			});
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.", "array");
		}
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	private void InsertionBalance(Node current, ref Node parent, Node grandParent, Node greatGrandParent)
	{
		bool flag = grandParent.Right == parent;
		bool flag2 = parent.Right == current;
		Node node;
		if (flag == flag2)
		{
			node = (flag2 ? grandParent.RotateLeft() : grandParent.RotateRight());
		}
		else
		{
			node = (flag2 ? grandParent.RotateLeftRight() : grandParent.RotateRightLeft());
			parent = greatGrandParent;
		}
		grandParent.ColorRed();
		node.ColorBlack();
		ReplaceChildOrRoot(greatGrandParent, grandParent, node);
	}

	private void ReplaceChildOrRoot(Node parent, Node child, Node newChild)
	{
		if (parent != null)
		{
			parent.ReplaceChild(child, newChild);
		}
		else
		{
			root = newChild;
		}
	}

	private void ReplaceNode(Node match, Node parentOfMatch, Node successor, Node parentOfSuccessor)
	{
		if (successor == match)
		{
			successor = match.Left;
		}
		else
		{
			successor.Right?.ColorBlack();
			if (parentOfSuccessor != match)
			{
				parentOfSuccessor.Left = successor.Right;
				successor.Right = match.Right;
			}
			successor.Left = match.Left;
		}
		if (successor != null)
		{
			successor.Color = match.Color;
		}
		ReplaceChildOrRoot(parentOfMatch, match, successor);
	}

	internal virtual Node FindNode(T item)
	{
		Node node = root;
		while (node != null)
		{
			int num = comparer.Compare(item, node.Item);
			if (num == 0)
			{
				return node;
			}
			node = ((num < 0) ? node.Left : node.Right);
		}
		return null;
	}

	internal void UpdateVersion()
	{
		version++;
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		GetObjectData(info, context);
	}

	protected virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("Count", count);
		info.AddValue("Comparer", comparer, typeof(IComparer<T>));
		info.AddValue("Version", version);
		if (root != null)
		{
			T[] array = new T[Count];
			CopyTo(array, 0);
			info.AddValue("Items", array, typeof(T[]));
		}
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		OnDeserialization(sender);
	}

	protected virtual void OnDeserialization(object sender)
	{
		if (comparer != null)
		{
			return;
		}
		if (siInfo == null)
		{
			throw new SerializationException("OnDeserialization method was called while the object was not being deserialized.");
		}
		comparer = (IComparer<T>)siInfo.GetValue("Comparer", typeof(IComparer<T>));
		int @int = siInfo.GetInt32("Count");
		if (@int != 0)
		{
			T[] array = (T[])siInfo.GetValue("Items", typeof(T[]));
			if (array == null)
			{
				throw new SerializationException("The values for this dictionary are missing.");
			}
			for (int i = 0; i < array.Length; i++)
			{
				Add(array[i]);
			}
		}
		version = siInfo.GetInt32("Version");
		if (count != @int)
		{
			throw new SerializationException("The serialized Count information doesn't match the number of items.");
		}
		siInfo = null;
	}

	private static int Log2(int value)
	{
		int num = 0;
		while (value > 0)
		{
			num++;
			value >>= 1;
		}
		return num;
	}
}
