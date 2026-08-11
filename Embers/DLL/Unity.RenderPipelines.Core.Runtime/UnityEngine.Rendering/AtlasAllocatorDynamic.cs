using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace UnityEngine.Rendering;

internal class AtlasAllocatorDynamic
{
	private class AtlasNodePool
	{
		internal AtlasNode[] m_Nodes;

		private short m_Next;

		private short m_FreelistHead;

		public AtlasNodePool(short capacity)
		{
			m_Nodes = new AtlasNode[capacity];
			m_Next = 0;
			m_FreelistHead = -1;
		}

		public void Dispose()
		{
			Clear();
			m_Nodes = null;
		}

		public void Clear()
		{
			m_Next = 0;
			m_FreelistHead = -1;
		}

		public short AtlasNodeCreate(short parent)
		{
			if (m_FreelistHead != -1)
			{
				short freelistNext = m_Nodes[m_FreelistHead].m_FreelistNext;
				m_Nodes[m_FreelistHead] = new AtlasNode(m_FreelistHead, parent);
				short freelistHead = m_FreelistHead;
				m_FreelistHead = freelistNext;
				return freelistHead;
			}
			m_Nodes[m_Next] = new AtlasNode(m_Next, parent);
			return m_Next++;
		}

		public void AtlasNodeFree(short index)
		{
			m_Nodes[index].m_FreelistNext = m_FreelistHead;
			m_FreelistHead = index;
		}
	}

	[StructLayout(LayoutKind.Explicit, Size = 32)]
	private struct AtlasNode(short self, short parent)
	{
		private enum AtlasNodeFlags : uint
		{
			IsOccupied = 1u
		}

		[FieldOffset(0)]
		public short m_Self = self;

		[FieldOffset(2)]
		public short m_Parent = parent;

		[FieldOffset(4)]
		public short m_LeftChild = -1;

		[FieldOffset(6)]
		public short m_RightChild = -1;

		[FieldOffset(8)]
		public short m_FreelistNext = -1;

		[FieldOffset(10)]
		public ushort m_Flags = 0;

		[FieldOffset(16)]
		public Vector4 m_Rect = Vector4.zero;

		public bool IsOccupied()
		{
			return (m_Flags & 1) > 0;
		}

		public void SetIsOccupied()
		{
			ushort num = 1;
			m_Flags |= num;
		}

		public void ClearIsOccupied()
		{
			ushort num = 1;
			m_Flags &= (ushort)(~num);
		}

		public bool IsLeafNode()
		{
			return m_LeftChild == -1;
		}

		public short Allocate(AtlasNodePool pool, int width, int height)
		{
			if (Mathf.Min(width, height) < 1)
			{
				return -1;
			}
			if (!IsLeafNode())
			{
				short num = pool.m_Nodes[m_LeftChild].Allocate(pool, width, height);
				if (num == -1)
				{
					num = pool.m_Nodes[m_RightChild].Allocate(pool, width, height);
				}
				return num;
			}
			if (IsOccupied())
			{
				return -1;
			}
			if ((float)width > m_Rect.x || (float)height > m_Rect.y)
			{
				return -1;
			}
			m_LeftChild = pool.AtlasNodeCreate(m_Self);
			m_RightChild = pool.AtlasNodeCreate(m_Self);
			float num2 = m_Rect.x - (float)width;
			float num3 = m_Rect.y - (float)height;
			if (num2 >= num3)
			{
				pool.m_Nodes[m_LeftChild].m_Rect.x = width;
				pool.m_Nodes[m_LeftChild].m_Rect.y = m_Rect.y;
				pool.m_Nodes[m_LeftChild].m_Rect.z = m_Rect.z;
				pool.m_Nodes[m_LeftChild].m_Rect.w = m_Rect.w;
				pool.m_Nodes[m_RightChild].m_Rect.x = num2;
				pool.m_Nodes[m_RightChild].m_Rect.y = m_Rect.y;
				pool.m_Nodes[m_RightChild].m_Rect.z = m_Rect.z + (float)width;
				pool.m_Nodes[m_RightChild].m_Rect.w = m_Rect.w;
				if (num3 < 1f)
				{
					pool.m_Nodes[m_LeftChild].SetIsOccupied();
					return m_LeftChild;
				}
				short num4 = pool.m_Nodes[m_LeftChild].Allocate(pool, width, height);
				if (num4 >= 0)
				{
					pool.m_Nodes[num4].SetIsOccupied();
				}
				return num4;
			}
			pool.m_Nodes[m_LeftChild].m_Rect.x = m_Rect.x;
			pool.m_Nodes[m_LeftChild].m_Rect.y = height;
			pool.m_Nodes[m_LeftChild].m_Rect.z = m_Rect.z;
			pool.m_Nodes[m_LeftChild].m_Rect.w = m_Rect.w;
			pool.m_Nodes[m_RightChild].m_Rect.x = m_Rect.x;
			pool.m_Nodes[m_RightChild].m_Rect.y = num3;
			pool.m_Nodes[m_RightChild].m_Rect.z = m_Rect.z;
			pool.m_Nodes[m_RightChild].m_Rect.w = m_Rect.w + (float)height;
			if (num2 < 1f)
			{
				pool.m_Nodes[m_LeftChild].SetIsOccupied();
				return m_LeftChild;
			}
			short num5 = pool.m_Nodes[m_LeftChild].Allocate(pool, width, height);
			if (num5 >= 0)
			{
				pool.m_Nodes[num5].SetIsOccupied();
			}
			return num5;
		}

		public void ReleaseChildren(AtlasNodePool pool)
		{
			if (!IsLeafNode())
			{
				pool.m_Nodes[m_LeftChild].ReleaseChildren(pool);
				pool.m_Nodes[m_RightChild].ReleaseChildren(pool);
				pool.AtlasNodeFree(m_LeftChild);
				pool.AtlasNodeFree(m_RightChild);
				m_LeftChild = -1;
				m_RightChild = -1;
			}
		}

		public void ReleaseAndMerge(AtlasNodePool pool)
		{
			short num = m_Self;
			do
			{
				pool.m_Nodes[num].ReleaseChildren(pool);
				pool.m_Nodes[num].ClearIsOccupied();
				num = pool.m_Nodes[num].m_Parent;
			}
			while (num >= 0 && pool.m_Nodes[num].IsMergeNeeded(pool));
		}

		public bool IsMergeNeeded(AtlasNodePool pool)
		{
			if (pool.m_Nodes[m_LeftChild].IsLeafNode() && !pool.m_Nodes[m_LeftChild].IsOccupied() && pool.m_Nodes[m_RightChild].IsLeafNode())
			{
				return !pool.m_Nodes[m_RightChild].IsOccupied();
			}
			return false;
		}
	}

	private int m_Width;

	private int m_Height;

	private AtlasNodePool m_Pool;

	private short m_Root;

	private Dictionary<int, short> m_NodeFromID;

	public AtlasAllocatorDynamic(int width, int height, int capacityAllocations)
	{
		int num = capacityAllocations * 2;
		m_Pool = new AtlasNodePool((short)num);
		m_NodeFromID = new Dictionary<int, short>(capacityAllocations);
		short parent = -1;
		m_Root = m_Pool.AtlasNodeCreate(parent);
		m_Pool.m_Nodes[m_Root].m_Rect.Set(width, height, 0f, 0f);
		m_Width = width;
		m_Height = height;
	}

	public bool Allocate(out Vector4 result, int key, int width, int height)
	{
		short num = m_Pool.m_Nodes[m_Root].Allocate(m_Pool, width, height);
		if (num >= 0)
		{
			result = m_Pool.m_Nodes[num].m_Rect;
			m_NodeFromID.Add(key, num);
			return true;
		}
		result = Vector4.zero;
		return false;
	}

	public void Release(int key)
	{
		if (m_NodeFromID.TryGetValue(key, out var value))
		{
			m_Pool.m_Nodes[value].ReleaseAndMerge(m_Pool);
			m_NodeFromID.Remove(key);
		}
	}

	public void Release()
	{
		m_Pool.Clear();
		m_Root = m_Pool.AtlasNodeCreate(-1);
		m_Pool.m_Nodes[m_Root].m_Rect.Set(m_Width, m_Height, 0f, 0f);
		m_NodeFromID.Clear();
	}

	public string DebugStringFromRoot(int depthMax = -1)
	{
		string res = "";
		DebugStringFromNode(ref res, m_Root, 0, depthMax);
		return res;
	}

	private void DebugStringFromNode(ref string res, short n, int depthCurrent = 0, int depthMax = -1)
	{
		res = res + "{[" + depthCurrent + "], isOccupied = " + (m_Pool.m_Nodes[n].IsOccupied() ? "true" : "false") + ", self = " + m_Pool.m_Nodes[n].m_Self + ", " + m_Pool.m_Nodes[n].m_Rect.x + "," + m_Pool.m_Nodes[n].m_Rect.y + ", " + m_Pool.m_Nodes[n].m_Rect.z + ", " + m_Pool.m_Nodes[n].m_Rect.w + "}\n";
		if (depthMax == -1 || depthCurrent < depthMax)
		{
			if (m_Pool.m_Nodes[n].m_LeftChild >= 0)
			{
				DebugStringFromNode(ref res, m_Pool.m_Nodes[n].m_LeftChild, depthCurrent + 1, depthMax);
			}
			if (m_Pool.m_Nodes[n].m_RightChild >= 0)
			{
				DebugStringFromNode(ref res, m_Pool.m_Nodes[n].m_RightChild, depthCurrent + 1, depthMax);
			}
		}
	}
}
