using System.Diagnostics;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(System.Collections.Generic.ICollectionDebugView<>))]
public class SortedSet<T> : ISet<T>, ICollection<T>, IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>, ISerializable, IDeserializationCallback
{
	[Serializable]
	internal sealed class TreeSubSet : SortedSet<T>, ISerializable, IDeserializationCallback
	{
		private SortedSet<T> _underlying;

		private T _min;

		private T _max;

		private bool _lBoundActive;

		private bool _uBoundActive;

		internal override T MinInternal
		{
			get
			{
				Node node = root;
				T result = default(T);
				while (node != null)
				{
					int num = (_lBoundActive ? base.Comparer.Compare(_min, node.Item) : (-1));
					if (num == 1)
					{
						node = node.Right;
						continue;
					}
					result = node.Item;
					if (num == 0)
					{
						break;
					}
					node = node.Left;
				}
				return result;
			}
		}

		internal override T MaxInternal
		{
			get
			{
				Node node = root;
				T result = default(T);
				while (node != null)
				{
					int num = ((!_uBoundActive) ? 1 : base.Comparer.Compare(_max, node.Item));
					if (num == -1)
					{
						node = node.Left;
						continue;
					}
					result = node.Item;
					if (num == 0)
					{
						break;
					}
					node = node.Right;
				}
				return result;
			}
		}

		public TreeSubSet(SortedSet<T> Underlying, T Min, T Max, bool lowerBoundActive, bool upperBoundActive)
			: base(Underlying.Comparer)
		{
			_underlying = Underlying;
			_min = Min;
			_max = Max;
			_lBoundActive = lowerBoundActive;
			_uBoundActive = upperBoundActive;
			root = _underlying.FindRange(_min, _max, _lBoundActive, _uBoundActive);
			count = 0;
			version = -1;
			VersionCheckImpl();
		}

		internal override bool AddIfNotPresent(T item)
		{
			if (!IsWithinRange(item))
			{
				throw new ArgumentOutOfRangeException("item");
			}
			bool result = _underlying.AddIfNotPresent(item);
			VersionCheck();
			return result;
		}

		public override bool Contains(T item)
		{
			VersionCheck();
			return base.Contains(item);
		}

		internal override bool DoRemove(T item)
		{
			if (!IsWithinRange(item))
			{
				return false;
			}
			bool result = _underlying.Remove(item);
			VersionCheck();
			return result;
		}

		public override void Clear()
		{
			if (count != 0)
			{
				List<T> toRemove = new List<T>();
				BreadthFirstTreeWalk(delegate(Node n)
				{
					toRemove.Add(n.Item);
					return true;
				});
				while (toRemove.Count != 0)
				{
					_underlying.Remove(toRemove[toRemove.Count - 1]);
					toRemove.RemoveAt(toRemove.Count - 1);
				}
				root = null;
				count = 0;
				version = _underlying.version;
			}
		}

		internal override bool IsWithinRange(T item)
		{
			if ((_lBoundActive ? base.Comparer.Compare(_min, item) : (-1)) > 0)
			{
				return false;
			}
			return ((!_uBoundActive || base.Comparer.Compare(_max, item) != 0) ? 1 : 0) >= (false ? 1 : 0);
		}

		internal override bool InOrderTreeWalk(TreeWalkPredicate<T> action)
		{
			VersionCheck();
			if (root == null)
			{
				return true;
			}
			Stack<Node> stack = new Stack<Node>(2 * Log2(count + 1));
			Node node = root;
			while (node != null)
			{
				if (IsWithinRange(node.Item))
				{
					stack.Push(node);
					node = node.Left;
				}
				else
				{
					node = ((!_lBoundActive || base.Comparer.Compare(_min, node.Item) <= 0) ? node.Left : node.Right);
				}
			}
			while (stack.Count != 0)
			{
				node = stack.Pop();
				if (!action(node))
				{
					return false;
				}
				Node node2 = node.Right;
				while (node2 != null)
				{
					if (IsWithinRange(node2.Item))
					{
						stack.Push(node2);
						node2 = node2.Left;
					}
					else
					{
						node2 = ((!_lBoundActive || base.Comparer.Compare(_min, node2.Item) <= 0) ? node2.Left : node2.Right);
					}
				}
			}
			return true;
		}

		internal override bool BreadthFirstTreeWalk(TreeWalkPredicate<T> action)
		{
			VersionCheck();
			if (root == null)
			{
				return true;
			}
			Queue<Node> queue = new Queue<Node>();
			queue.Enqueue(root);
			while (queue.Count != 0)
			{
				Node node = queue.Dequeue();
				if (IsWithinRange(node.Item) && !action(node))
				{
					return false;
				}
				if (node.Left != null && (!_lBoundActive || base.Comparer.Compare(_min, node.Item) < 0))
				{
					queue.Enqueue(node.Left);
				}
				if (node.Right != null && (!_uBoundActive || base.Comparer.Compare(_max, node.Item) > 0))
				{
					queue.Enqueue(node.Right);
				}
			}
			return true;
		}

		internal override Node FindNode(T item)
		{
			if (!IsWithinRange(item))
			{
				return null;
			}
			VersionCheck();
			return base.FindNode(item);
		}

		internal override int InternalIndexOf(T item)
		{
			int num = -1;
			using (Enumerator enumerator = GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					T current = enumerator.Current;
					num++;
					if (base.Comparer.Compare(item, current) == 0)
					{
						return num;
					}
				}
			}
			return -1;
		}

		internal override void VersionCheck()
		{
			VersionCheckImpl();
		}

		private void VersionCheckImpl()
		{
			if (version != _underlying.version)
			{
				root = _underlying.FindRange(_min, _max, _lBoundActive, _uBoundActive);
				version = _underlying.version;
				count = 0;
				InOrderTreeWalk(delegate
				{
					count++;
					return true;
				});
			}
		}

		public override SortedSet<T> GetViewBetween(T lowerValue, T upperValue)
		{
			if (_lBoundActive && base.Comparer.Compare(_min, lowerValue) > 0)
			{
				throw new ArgumentOutOfRangeException("lowerValue");
			}
			if (_uBoundActive && base.Comparer.Compare(_max, upperValue) < 0)
			{
				throw new ArgumentOutOfRangeException("upperValue");
			}
			return (TreeSubSet)_underlying.GetViewBetween(lowerValue, upperValue);
		}

		void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
		{
			GetObjectData(info, context);
		}

		protected override void GetObjectData(SerializationInfo info, StreamingContext context)
		{
			throw new PlatformNotSupportedException();
		}

		void IDeserializationCallback.OnDeserialization(object sender)
		{
			throw new PlatformNotSupportedException();
		}

		protected override void OnDeserialization(object sender)
		{
			throw new PlatformNotSupportedException();
		}
	}

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

		public Node DeepClone(int count)
		{
			Stack<Node> stack = new Stack<Node>(2 * SortedSet<T>.Log2(count) + 2);
			Stack<Node> stack2 = new Stack<Node>(2 * SortedSet<T>.Log2(count) + 2);
			Node node = ShallowClone();
			Node node2 = this;
			Node node3 = node;
			while (node2 != null)
			{
				stack.Push(node2);
				stack2.Push(node3);
				node3.Left = node2.Left?.ShallowClone();
				node2 = node2.Left;
				node3 = node3.Left;
			}
			while (stack.Count != 0)
			{
				node2 = stack.Pop();
				node3 = stack2.Pop();
				Node node4 = node2.Right;
				Node node5 = (node3.Right = node4?.ShallowClone());
				while (node4 != null)
				{
					stack.Push(node4);
					stack2.Push(node5);
					node5.Left = node4.Left?.ShallowClone();
					node4 = node4.Left;
					node5 = node5.Left;
				}
			}
			return node;
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

		public Node ShallowClone()
		{
			return new Node(Item, Color);
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
		private static readonly Node s_dummyNode = new Node(default(T), NodeColor.Red);

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
				return default(T);
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

	internal struct ElementCount
	{
		internal int UniqueCount;

		internal int UnfoundCount;
	}

	private Node root;

	private IComparer<T> comparer;

	private int count;

	private int version;

	[NonSerialized]
	private object _syncRoot;

	private SerializationInfo siInfo;

	private const string ComparerName = "Comparer";

	private const string CountName = "Count";

	private const string ItemsName = "Items";

	private const string VersionName = "Version";

	private const string TreeName = "Tree";

	private const string NodeValueName = "Item";

	private const string EnumStartName = "EnumStarted";

	private const string ReverseName = "Reverse";

	private const string EnumVersionName = "EnumVersion";

	private const string MinName = "Min";

	private const string MaxName = "Max";

	private const string LowerBoundActiveName = "lBoundActive";

	private const string UpperBoundActiveName = "uBoundActive";

	internal const int StackAllocThreshold = 100;

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

	public T Min => MinInternal;

	internal virtual T MinInternal
	{
		get
		{
			if (root == null)
			{
				return default(T);
			}
			Node left = root;
			while (left.Left != null)
			{
				left = left.Left;
			}
			return left.Item;
		}
	}

	public T Max => MaxInternal;

	internal virtual T MaxInternal
	{
		get
		{
			if (root == null)
			{
				return default(T);
			}
			Node right = root;
			while (right.Right != null)
			{
				right = right.Right;
			}
			return right.Item;
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

	public SortedSet(IEnumerable<T> collection)
		: this(collection, (IComparer<T>)Comparer<T>.Default)
	{
	}

	public SortedSet(IEnumerable<T> collection, IComparer<T> comparer)
		: this(comparer)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		if (collection is SortedSet<T> sortedSet && !(sortedSet is TreeSubSet) && HasEqualComparer(sortedSet))
		{
			if (sortedSet.Count > 0)
			{
				count = sortedSet.count;
				root = sortedSet.root.DeepClone(count);
			}
			return;
		}
		T[] array = EnumerableHelpers.ToArray(collection, out var length);
		if (length <= 0)
		{
			return;
		}
		comparer = this.comparer;
		Array.Sort(array, 0, length, comparer);
		int num = 1;
		for (int i = 1; i < length; i++)
		{
			if (comparer.Compare(array[i], array[i - 1]) != 0)
			{
				array[num++] = array[i];
			}
		}
		length = num;
		root = ConstructRootFromSortedArray(array, 0, length - 1, null);
		count = length;
	}

	protected SortedSet(SerializationInfo info, StreamingContext context)
	{
		siInfo = info;
	}

	private void AddAllElements(IEnumerable<T> collection)
	{
		foreach (T item in collection)
		{
			if (!Contains(item))
			{
				Add(item);
			}
		}
	}

	private void RemoveAllElements(IEnumerable<T> collection)
	{
		T min = Min;
		T max = Max;
		foreach (T item in collection)
		{
			if (comparer.Compare(item, min) >= 0 && comparer.Compare(item, max) <= 0 && Contains(item))
			{
				Remove(item);
			}
		}
	}

	private bool ContainsAllElements(IEnumerable<T> collection)
	{
		foreach (T item in collection)
		{
			if (!Contains(item))
			{
				return false;
			}
		}
		return true;
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

	internal virtual bool BreadthFirstTreeWalk(TreeWalkPredicate<T> action)
	{
		if (root == null)
		{
			return true;
		}
		Queue<Node> queue = new Queue<Node>();
		queue.Enqueue(root);
		while (queue.Count != 0)
		{
			Node node = queue.Dequeue();
			if (!action(node))
			{
				return false;
			}
			if (node.Left != null)
			{
				queue.Enqueue(node.Left);
			}
			if (node.Right != null)
			{
				queue.Enqueue(node.Right);
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

	public void CopyTo(T[] array)
	{
		CopyTo(array, 0, Count);
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
		InOrderTreeWalk(delegate(Node node)
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
			InOrderTreeWalk(delegate(Node node)
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
		bool num = grandParent.Right == parent;
		bool flag = parent.Right == current;
		Node node;
		if (num == flag)
		{
			node = (flag ? grandParent.RotateLeft() : grandParent.RotateRight());
		}
		else
		{
			node = (flag ? grandParent.RotateLeftRight() : grandParent.RotateRightLeft());
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

	internal virtual int InternalIndexOf(T item)
	{
		Node node = root;
		int num = 0;
		while (node != null)
		{
			int num2 = comparer.Compare(item, node.Item);
			if (num2 == 0)
			{
				return num;
			}
			node = ((num2 < 0) ? node.Left : node.Right);
			num = ((num2 < 0) ? (2 * num + 1) : (2 * num + 2));
		}
		return -1;
	}

	internal Node FindRange(T from, T to)
	{
		return FindRange(from, to, lowerBoundActive: true, upperBoundActive: true);
	}

	internal Node FindRange(T from, T to, bool lowerBoundActive, bool upperBoundActive)
	{
		Node node = root;
		while (node != null)
		{
			if (lowerBoundActive && comparer.Compare(from, node.Item) > 0)
			{
				node = node.Right;
				continue;
			}
			if (upperBoundActive && comparer.Compare(to, node.Item) < 0)
			{
				node = node.Left;
				continue;
			}
			return node;
		}
		return null;
	}

	internal void UpdateVersion()
	{
		version++;
	}

	public static IEqualityComparer<SortedSet<T>> CreateSetComparer()
	{
		return CreateSetComparer(null);
	}

	public static IEqualityComparer<SortedSet<T>> CreateSetComparer(IEqualityComparer<T> memberEqualityComparer)
	{
		return new SortedSetEqualityComparer<T>(memberEqualityComparer);
	}

	internal static bool SortedSetEquals(SortedSet<T> set1, SortedSet<T> set2, IComparer<T> comparer)
	{
		if (set1 == null)
		{
			return set2 == null;
		}
		if (set2 == null)
		{
			return false;
		}
		if (set1.HasEqualComparer(set2))
		{
			if (set1.Count == set2.Count)
			{
				return set1.SetEquals(set2);
			}
			return false;
		}
		bool flag = false;
		foreach (T item in set1)
		{
			flag = false;
			foreach (T item2 in set2)
			{
				if (comparer.Compare(item, item2) == 0)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	private bool HasEqualComparer(SortedSet<T> other)
	{
		if (Comparer != other.Comparer)
		{
			return Comparer.Equals(other.Comparer);
		}
		return true;
	}

	public void UnionWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		SortedSet<T> sortedSet = other as SortedSet<T>;
		TreeSubSet treeSubSet = this as TreeSubSet;
		if (treeSubSet != null)
		{
			VersionCheck();
		}
		if (sortedSet != null && treeSubSet == null && count == 0)
		{
			SortedSet<T> sortedSet2 = new SortedSet<T>(sortedSet, comparer);
			root = sortedSet2.root;
			count = sortedSet2.count;
			version++;
		}
		else if (sortedSet != null && treeSubSet == null && HasEqualComparer(sortedSet) && sortedSet.Count > Count / 2)
		{
			T[] array = new T[sortedSet.Count + Count];
			int num = 0;
			Enumerator enumerator = GetEnumerator();
			Enumerator enumerator2 = sortedSet.GetEnumerator();
			bool flag = !enumerator.MoveNext();
			bool flag2 = !enumerator2.MoveNext();
			while (!flag && !flag2)
			{
				int num2 = Comparer.Compare(enumerator.Current, enumerator2.Current);
				if (num2 < 0)
				{
					array[num++] = enumerator.Current;
					flag = !enumerator.MoveNext();
				}
				else if (num2 == 0)
				{
					array[num++] = enumerator2.Current;
					flag = !enumerator.MoveNext();
					flag2 = !enumerator2.MoveNext();
				}
				else
				{
					array[num++] = enumerator2.Current;
					flag2 = !enumerator2.MoveNext();
				}
			}
			if (!flag || !flag2)
			{
				Enumerator enumerator3 = (flag ? enumerator2 : enumerator);
				do
				{
					array[num++] = enumerator3.Current;
				}
				while (enumerator3.MoveNext());
			}
			root = null;
			root = ConstructRootFromSortedArray(array, 0, num - 1, null);
			count = num;
			version++;
		}
		else
		{
			AddAllElements(other);
		}
	}

	private static Node ConstructRootFromSortedArray(T[] arr, int startIndex, int endIndex, Node redNode)
	{
		int num = endIndex - startIndex + 1;
		Node node;
		switch (num)
		{
		case 0:
			return null;
		case 1:
			node = new Node(arr[startIndex], NodeColor.Black);
			if (redNode != null)
			{
				node.Left = redNode;
			}
			break;
		case 2:
			node = new Node(arr[startIndex], NodeColor.Black);
			node.Right = new Node(arr[endIndex], NodeColor.Black);
			node.Right.ColorRed();
			if (redNode != null)
			{
				node.Left = redNode;
			}
			break;
		case 3:
			node = new Node(arr[startIndex + 1], NodeColor.Black);
			node.Left = new Node(arr[startIndex], NodeColor.Black);
			node.Right = new Node(arr[endIndex], NodeColor.Black);
			if (redNode != null)
			{
				node.Left.Left = redNode;
			}
			break;
		default:
		{
			int num2 = (startIndex + endIndex) / 2;
			node = new Node(arr[num2], NodeColor.Black);
			node.Left = ConstructRootFromSortedArray(arr, startIndex, num2 - 1, redNode);
			node.Right = ((num % 2 == 0) ? ConstructRootFromSortedArray(arr, num2 + 2, endIndex, new Node(arr[num2 + 1], NodeColor.Red)) : ConstructRootFromSortedArray(arr, num2 + 1, endIndex, null));
			break;
		}
		}
		return node;
	}

	public virtual void IntersectWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (Count == 0 || other == this)
		{
			return;
		}
		SortedSet<T> sortedSet = other as SortedSet<T>;
		TreeSubSet treeSubSet = this as TreeSubSet;
		if (treeSubSet != null)
		{
			VersionCheck();
		}
		if (sortedSet != null && treeSubSet == null && HasEqualComparer(sortedSet))
		{
			T[] array = new T[Count];
			int num = 0;
			Enumerator enumerator = GetEnumerator();
			Enumerator enumerator2 = sortedSet.GetEnumerator();
			bool flag = !enumerator.MoveNext();
			bool flag2 = !enumerator2.MoveNext();
			T max = Max;
			_ = Min;
			while (!flag && !flag2 && Comparer.Compare(enumerator2.Current, max) <= 0)
			{
				int num2 = Comparer.Compare(enumerator.Current, enumerator2.Current);
				if (num2 < 0)
				{
					flag = !enumerator.MoveNext();
				}
				else if (num2 == 0)
				{
					array[num++] = enumerator2.Current;
					flag = !enumerator.MoveNext();
					flag2 = !enumerator2.MoveNext();
				}
				else
				{
					flag2 = !enumerator2.MoveNext();
				}
			}
			root = null;
			root = ConstructRootFromSortedArray(array, 0, num - 1, null);
			count = num;
			version++;
		}
		else
		{
			IntersectWithEnumerable(other);
		}
	}

	internal virtual void IntersectWithEnumerable(IEnumerable<T> other)
	{
		List<T> list = new List<T>(Count);
		foreach (T item in other)
		{
			if (Contains(item))
			{
				list.Add(item);
			}
		}
		Clear();
		foreach (T item2 in list)
		{
			Add(item2);
		}
	}

	public void ExceptWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (count == 0)
		{
			return;
		}
		if (other == this)
		{
			Clear();
		}
		else
		{
			if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet))
			{
				if (comparer.Compare(sortedSet.Max, Min) < 0 || comparer.Compare(sortedSet.Min, Max) > 0)
				{
					return;
				}
				T min = Min;
				T max = Max;
				{
					foreach (T item in other)
					{
						if (comparer.Compare(item, min) >= 0)
						{
							if (comparer.Compare(item, max) > 0)
							{
								break;
							}
							Remove(item);
						}
					}
					return;
				}
			}
			RemoveAllElements(other);
		}
	}

	public void SymmetricExceptWith(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (Count == 0)
		{
			UnionWith(other);
			return;
		}
		if (other == this)
		{
			Clear();
			return;
		}
		if (other is SortedSet<T> other2 && HasEqualComparer(other2))
		{
			SymmetricExceptWithSameComparer(other2);
			return;
		}
		T[] array = EnumerableHelpers.ToArray(other, out var length);
		Array.Sort(array, 0, length, Comparer);
		SymmetricExceptWithSameComparer(array, length);
	}

	private void SymmetricExceptWithSameComparer(SortedSet<T> other)
	{
		foreach (T item in other)
		{
			if (!Contains(item))
			{
				Add(item);
			}
			else
			{
				Remove(item);
			}
		}
	}

	private void SymmetricExceptWithSameComparer(T[] other, int count)
	{
		if (count == 0)
		{
			return;
		}
		T y = other[0];
		for (int i = 0; i < count; i++)
		{
			for (; i < count && i != 0 && comparer.Compare(other[i], y) == 0; i++)
			{
			}
			if (i < count)
			{
				T val = other[i];
				if (!Contains(val))
				{
					Add(val);
				}
				else
				{
					Remove(val);
				}
				y = val;
				continue;
			}
			break;
		}
	}

	public bool IsSubsetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (Count == 0)
		{
			return true;
		}
		if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet))
		{
			if (Count > sortedSet.Count)
			{
				return false;
			}
			return IsSubsetOfSortedSetWithSameComparer(sortedSet);
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: false);
		if (elementCount.UniqueCount == Count)
		{
			return elementCount.UnfoundCount >= 0;
		}
		return false;
	}

	private bool IsSubsetOfSortedSetWithSameComparer(SortedSet<T> asSorted)
	{
		SortedSet<T> viewBetween = asSorted.GetViewBetween(Min, Max);
		using (Enumerator enumerator = GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				T current = enumerator.Current;
				if (!viewBetween.Contains(current))
				{
					return false;
				}
			}
		}
		return true;
	}

	public bool IsProperSubsetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other is ICollection && Count == 0)
		{
			return (other as ICollection).Count > 0;
		}
		if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet))
		{
			if (Count >= sortedSet.Count)
			{
				return false;
			}
			return IsSubsetOfSortedSetWithSameComparer(sortedSet);
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: false);
		if (elementCount.UniqueCount == Count)
		{
			return elementCount.UnfoundCount > 0;
		}
		return false;
	}

	public bool IsSupersetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other is ICollection && (other as ICollection).Count == 0)
		{
			return true;
		}
		if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet))
		{
			if (Count < sortedSet.Count)
			{
				return false;
			}
			SortedSet<T> viewBetween = GetViewBetween(sortedSet.Min, sortedSet.Max);
			foreach (T item in sortedSet)
			{
				if (!viewBetween.Contains(item))
				{
					return false;
				}
			}
			return true;
		}
		return ContainsAllElements(other);
	}

	public bool IsProperSupersetOf(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (Count == 0)
		{
			return false;
		}
		if (other is ICollection && (other as ICollection).Count == 0)
		{
			return true;
		}
		if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet))
		{
			if (sortedSet.Count >= Count)
			{
				return false;
			}
			SortedSet<T> viewBetween = GetViewBetween(sortedSet.Min, sortedSet.Max);
			foreach (T item in sortedSet)
			{
				if (!viewBetween.Contains(item))
				{
					return false;
				}
			}
			return true;
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: true);
		if (elementCount.UniqueCount < Count)
		{
			return elementCount.UnfoundCount == 0;
		}
		return false;
	}

	public bool SetEquals(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet))
		{
			Enumerator enumerator = GetEnumerator();
			Enumerator enumerator2 = sortedSet.GetEnumerator();
			bool flag = !enumerator.MoveNext();
			bool flag2 = !enumerator2.MoveNext();
			while (!flag && !flag2)
			{
				if (Comparer.Compare(enumerator.Current, enumerator2.Current) != 0)
				{
					return false;
				}
				flag = !enumerator.MoveNext();
				flag2 = !enumerator2.MoveNext();
			}
			return flag & flag2;
		}
		ElementCount elementCount = CheckUniqueAndUnfoundElements(other, returnIfUnfound: true);
		if (elementCount.UniqueCount == Count)
		{
			return elementCount.UnfoundCount == 0;
		}
		return false;
	}

	public bool Overlaps(IEnumerable<T> other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (Count == 0)
		{
			return false;
		}
		if (other is ICollection<T> && (other as ICollection<T>).Count == 0)
		{
			return false;
		}
		if (other is SortedSet<T> sortedSet && HasEqualComparer(sortedSet) && (comparer.Compare(Min, sortedSet.Max) > 0 || comparer.Compare(Max, sortedSet.Min) < 0))
		{
			return false;
		}
		foreach (T item in other)
		{
			if (Contains(item))
			{
				return true;
			}
		}
		return false;
	}

	private unsafe ElementCount CheckUniqueAndUnfoundElements(IEnumerable<T> other, bool returnIfUnfound)
	{
		ElementCount result = default(ElementCount);
		if (Count == 0)
		{
			int num = 0;
			using (IEnumerator<T> enumerator = other.GetEnumerator())
			{
				if (enumerator.MoveNext())
				{
					_ = enumerator.Current;
					num++;
				}
			}
			result.UniqueCount = 0;
			result.UnfoundCount = num;
			return result;
		}
		int num2 = System.Collections.Generic.BitHelper.ToIntArrayLength(Count);
		System.Collections.Generic.BitHelper bitHelper = ((num2 > 100) ? new System.Collections.Generic.BitHelper(new int[num2], num2) : new System.Collections.Generic.BitHelper(stackalloc int[num2], num2));
		int num3 = 0;
		int num4 = 0;
		foreach (T item in other)
		{
			int num5 = InternalIndexOf(item);
			if (num5 >= 0)
			{
				if (!bitHelper.IsMarked(num5))
				{
					bitHelper.MarkBit(num5);
					num4++;
				}
			}
			else
			{
				num3++;
				if (returnIfUnfound)
				{
					break;
				}
			}
		}
		result.UniqueCount = num4;
		result.UnfoundCount = num3;
		return result;
	}

	public int RemoveWhere(Predicate<T> match)
	{
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
		List<T> matches = new List<T>(Count);
		BreadthFirstTreeWalk(delegate(Node n)
		{
			if (match(n.Item))
			{
				matches.Add(n.Item);
			}
			return true;
		});
		int num = 0;
		for (int num2 = matches.Count - 1; num2 >= 0; num2--)
		{
			if (Remove(matches[num2]))
			{
				num++;
			}
		}
		return num;
	}

	public IEnumerable<T> Reverse()
	{
		Enumerator e = new Enumerator(this, reverse: true);
		while (e.MoveNext())
		{
			yield return e.Current;
		}
	}

	public virtual SortedSet<T> GetViewBetween(T lowerValue, T upperValue)
	{
		if (Comparer.Compare(lowerValue, upperValue) > 0)
		{
			throw new ArgumentException("Must be less than or equal to upperValue.", "lowerValue");
		}
		return new TreeSubSet(this, lowerValue, upperValue, lowerBoundActive: true, upperBoundActive: true);
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

	public bool TryGetValue(T equalValue, out T actualValue)
	{
		Node node = FindNode(equalValue);
		if (node != null)
		{
			actualValue = node.Item;
			return true;
		}
		actualValue = default(T);
		return false;
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
