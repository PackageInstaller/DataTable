using UnityEngine;

namespace ACT.UI;

public class BitMaskSwitcher : MonoBehaviour
{
	public GameObject[] objectArray;

	private int[] m_MaskArray;

	private int m_CurrentMask;

	private void Awake()
	{
		EnsureMaskArray();
	}

	private void EnsureMaskArray()
	{
		if (m_MaskArray == null)
		{
			m_MaskArray = new int[objectArray.Length];
			for (int i = 0; i < m_MaskArray.Length; i++)
			{
				m_MaskArray[i] = 1 << i;
			}
		}
	}

	public void SetActive(int bitMask)
	{
		EnsureMaskArray();
		m_CurrentMask = bitMask;
		for (int i = 0; i < m_MaskArray.Length; i++)
		{
			objectArray[i].SetActive((bitMask & m_MaskArray[i]) > 0);
		}
	}

	public int GetCurrentMask()
	{
		return m_CurrentMask;
	}
}
