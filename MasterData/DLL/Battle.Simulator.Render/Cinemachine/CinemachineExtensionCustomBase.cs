using System.Collections.Generic;

namespace Cinemachine;

public abstract class CinemachineExtensionCustomBase<T> : CinemachineExtension where T : class, ITimelineClipLength
{
	private Queue<RuntimeNode<T>> m_Pool = new Queue<RuntimeNode<T>>(5);

	protected List<RuntimeNode<T>> m_List = new List<RuntimeNode<T>>(5);

	public void AddClip(T pClip)
	{
		RuntimeNode<T> runtimeNode = null;
		runtimeNode = ((m_Pool.Count <= 0) ? new RuntimeNode<T>() : m_Pool.Dequeue());
		runtimeNode.clip = pClip;
		m_List.Add(runtimeNode);
	}

	private void RemoveClip(int pIndex)
	{
		if (pIndex < m_List.Count)
		{
			RuntimeNode<T> runtimeNode = m_List[pIndex];
			m_List.RemoveAt(pIndex);
			runtimeNode.ResetData();
			m_Pool.Enqueue(runtimeNode);
		}
	}

	public void RemoveClip(T pClip)
	{
		for (int num = m_List.Count - 1; num >= 0; num--)
		{
			if (m_List[num].clip == pClip)
			{
				RemoveClip(num);
				break;
			}
		}
	}

	public void RemoveClips(List<T> pClips)
	{
		RuntimeNode<T> runtimeNode = null;
		for (int num = m_List.Count - 1; num >= 0; num--)
		{
			runtimeNode = m_List[num];
			if (pClips.Contains(runtimeNode.clip))
			{
				RemoveClip(num);
			}
		}
	}

	public void RemoveAll()
	{
		for (int num = m_List.Count - 1; num >= 0; num--)
		{
			RemoveClip(num);
		}
	}

	public void TickClip(T pClip, float pDeltaTime)
	{
		RuntimeNode<T> runtimeNode = null;
		for (int i = 0; i < m_List.Count; i++)
		{
			runtimeNode = m_List[i];
			if (runtimeNode.clip == pClip)
			{
				runtimeNode.time += pDeltaTime;
				runtimeNode.normalized = runtimeNode.time / runtimeNode.clip.GetLength();
			}
		}
	}

	public void TickClipNormalized(T pClip, float normalized)
	{
		RuntimeNode<T> runtimeNode = null;
		for (int i = 0; i < m_List.Count; i++)
		{
			runtimeNode = m_List[i];
			if (runtimeNode.clip == pClip)
			{
				runtimeNode.normalized = normalized;
				runtimeNode.time = runtimeNode.normalized * runtimeNode.clip.GetLength();
			}
		}
	}

	public bool TryGetLastNode(out RuntimeNode<T> node)
	{
		if (m_List.Count <= 0)
		{
			node = null;
			return false;
		}
		node = m_List[m_List.Count - 1];
		return true;
	}
}
