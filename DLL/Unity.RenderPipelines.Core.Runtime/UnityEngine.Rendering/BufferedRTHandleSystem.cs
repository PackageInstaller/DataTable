using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

public class BufferedRTHandleSystem : IDisposable
{
	private Dictionary<int, RTHandle[]> m_RTHandles = new Dictionary<int, RTHandle[]>();

	private RTHandleSystem m_RTHandleSystem = new RTHandleSystem();

	private bool m_DisposedValue;

	public int maxWidth => m_RTHandleSystem.GetMaxWidth();

	public int maxHeight => m_RTHandleSystem.GetMaxHeight();

	public RTHandleProperties rtHandleProperties => m_RTHandleSystem.rtHandleProperties;

	public RTHandle GetFrameRT(int bufferId, int frameIndex)
	{
		if (!m_RTHandles.ContainsKey(bufferId))
		{
			return null;
		}
		return m_RTHandles[bufferId][frameIndex];
	}

	public void AllocBuffer(int bufferId, Func<RTHandleSystem, int, RTHandle> allocator, int bufferCount)
	{
		RTHandle[] array = new RTHandle[bufferCount];
		m_RTHandles.Add(bufferId, array);
		array[0] = allocator(m_RTHandleSystem, 0);
		int i = 1;
		for (int num = array.Length; i < num; i++)
		{
			array[i] = allocator(m_RTHandleSystem, i);
			m_RTHandleSystem.SwitchResizeMode(array[i], RTHandleSystem.ResizeMode.OnDemand);
		}
	}

	public void ReleaseBuffer(int bufferId)
	{
		if (m_RTHandles.TryGetValue(bufferId, out var value))
		{
			RTHandle[] array = value;
			foreach (RTHandle rth in array)
			{
				m_RTHandleSystem.Release(rth);
			}
		}
		m_RTHandles.Remove(bufferId);
	}

	public void SwapAndSetReferenceSize(int width, int height)
	{
		Swap();
		m_RTHandleSystem.SetReferenceSize(width, height);
	}

	public void ResetReferenceSize(int width, int height)
	{
		m_RTHandleSystem.ResetReferenceSize(width, height);
	}

	public int GetNumFramesAllocated(int bufferId)
	{
		if (!m_RTHandles.ContainsKey(bufferId))
		{
			return 0;
		}
		return m_RTHandles[bufferId].Length;
	}

	public Vector2 CalculateRatioAgainstMaxSize(int width, int height)
	{
		return m_RTHandleSystem.CalculateRatioAgainstMaxSize(new Vector2Int(width, height));
	}

	private void Swap()
	{
		foreach (KeyValuePair<int, RTHandle[]> rTHandle2 in m_RTHandles)
		{
			if (rTHandle2.Value.Length > 1)
			{
				RTHandle rTHandle = rTHandle2.Value[rTHandle2.Value.Length - 1];
				int i = 0;
				for (int num = rTHandle2.Value.Length - 1; i < num; i++)
				{
					rTHandle2.Value[i + 1] = rTHandle2.Value[i];
				}
				rTHandle2.Value[0] = rTHandle;
				m_RTHandleSystem.SwitchResizeMode(rTHandle2.Value[0], RTHandleSystem.ResizeMode.Auto);
				m_RTHandleSystem.SwitchResizeMode(rTHandle2.Value[1], RTHandleSystem.ResizeMode.OnDemand);
			}
			else
			{
				m_RTHandleSystem.SwitchResizeMode(rTHandle2.Value[0], RTHandleSystem.ResizeMode.Auto);
			}
		}
	}

	private void Dispose(bool disposing)
	{
		if (!m_DisposedValue)
		{
			if (disposing)
			{
				ReleaseAll();
				m_RTHandleSystem.Dispose();
				m_RTHandleSystem = null;
			}
			m_DisposedValue = true;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	public void ReleaseAll()
	{
		foreach (KeyValuePair<int, RTHandle[]> rTHandle in m_RTHandles)
		{
			int i = 0;
			for (int num = rTHandle.Value.Length; i < num; i++)
			{
				m_RTHandleSystem.Release(rTHandle.Value[i]);
			}
		}
		m_RTHandles.Clear();
	}
}
