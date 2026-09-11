using System.Collections.Generic;
using UnityEngine;

namespace Qworld.Runtime.SceneDither;

public class MortonChunk<T> where T : IMortonTreeObject
{
	protected Bounds m_Bounds;

	private float m_DeltaWidth;

	private float m_DeltaHeight;

	protected int m_Cols;

	protected int m_MaxDepth;

	public Dictionary<uint, MortonTreeLeafNode> m_nodes;

	public MortonChunk(Vector3 center, Vector3 size, int maxDepth)
	{
		m_MaxDepth = maxDepth;
		m_Bounds = new Bounds(center, size);
		m_Cols = (int)Mathf.Pow(2f, maxDepth);
		m_nodes = new Dictionary<uint, MortonTreeLeafNode>();
		m_DeltaHeight = m_Bounds.size.z / (float)m_Cols;
		m_DeltaWidth = m_Bounds.size.x / (float)m_Cols;
	}

	public void Bounds(ref Bounds bounds)
	{
		bounds = m_Bounds;
	}

	public MortonTreeLeafNode GetMortonChunk(Vector3 pos)
	{
		uint key = Morton2FromWorldPos(pos.x, pos.z);
		if (!m_nodes.ContainsKey(key))
		{
			return null;
		}
		return m_nodes[key];
	}

	public void Add(T item)
	{
		if (item == null || item.GetComponentVersion() == 0 || !m_Bounds.Intersects(item.Bounds))
		{
			return;
		}
		if (m_MaxDepth == 0)
		{
			if (!m_nodes.ContainsKey(0u))
			{
				m_nodes[0u] = new MortonTreeLeafNode();
			}
			m_nodes[0u].Insert(item).SetNodeLeaf(0u, m_nodes[0u]);
		}
		else
		{
			InsertToNode(item, 0, m_Bounds.center.x, m_Bounds.center.z, m_Bounds.size.x, m_Bounds.size.z);
		}
	}

	private bool InsertToNode(T obj, int depth, float centerx, float centerz, float sizex, float sizez)
	{
		if (depth == m_MaxDepth)
		{
			uint num = Morton2FromWorldPos(centerx, centerz);
			if (!m_nodes.ContainsKey(num))
			{
				m_nodes[num] = new MortonTreeLeafNode();
			}
			m_nodes[num].Insert(obj);
			MortonTreeLeafNode node = m_nodes[num];
			obj.SetNodeLeaf(num, node);
			obj.SetMortonCode(num);
			return true;
		}
		int num2 = 0;
		float x = obj.Bounds.min.x;
		float z = obj.Bounds.min.z;
		float x2 = obj.Bounds.max.x;
		float z2 = obj.Bounds.max.z;
		if (x <= centerx && z <= centerz)
		{
			num2 |= 1;
		}
		if (x <= centerx && z2 >= centerz)
		{
			num2 |= 2;
		}
		if (x2 >= centerx && z <= centerz)
		{
			num2 |= 4;
		}
		if (x2 >= centerx && z2 >= centerz)
		{
			num2 |= 8;
		}
		float num3 = sizex * 0.5f;
		float num4 = sizez * 0.5f;
		bool flag = false;
		if ((num2 & 1) != 0)
		{
			flag = flag || InsertToNode(obj, depth + 1, centerx - num3 * 0.5f, centerz - num4 * 0.5f, num3, num4);
		}
		if ((num2 & 2) != 0)
		{
			flag = flag || InsertToNode(obj, depth + 1, centerx - num3 * 0.5f, centerz + num4 * 0.5f, num3, num4);
		}
		if ((num2 & 4) != 0)
		{
			flag = flag || InsertToNode(obj, depth + 1, centerx + num3 * 0.5f, centerz - num4 * 0.5f, num3, num4);
		}
		if ((num2 & 8) != 0)
		{
			flag = flag || InsertToNode(obj, depth + 1, centerx + num3 * 0.5f, centerz + num4 * 0.5f, num3, num4);
		}
		return flag;
	}

	private uint Morton2FromWorldPos(float x, float z)
	{
		uint x2 = (uint)Mathf.FloorToInt((x - m_Bounds.min.x) / m_DeltaWidth);
		uint y = (uint)Mathf.FloorToInt((z - m_Bounds.min.z) / m_DeltaHeight);
		return Morton2(x2, y);
	}

	private uint Morton2(uint x, uint y)
	{
		return (Part1By1(y) << 1) + Part1By1(x);
	}

	private uint Part1By1(uint n)
	{
		n = (n ^ (n << 8)) & 0xFF00FF;
		n = (n ^ (n << 4)) & 0xF0F0F0F;
		n = (n ^ (n << 2)) & 0x33333333;
		n = (n ^ (n << 1)) & 0x55555555;
		return n;
	}

	public void Remove(T item)
	{
		if (item != null && item.GetComponentVersion() != 0 && m_nodes != null)
		{
			item.getNodes()?.Remove(item);
		}
	}
}
