using System.Collections.Generic;
using UnityEngine;

public class CharacterRenderController : MonoBehaviour
{
	public enum ActiveState
	{
		AllDisabled,
		AllEnabled,
		Mixed
	}

	public const int ALL_RENDER_GROUP_INDEX = 0;

	public const string ALL_RENDER_GROUP_NAME = "全部";

	public List<Renderer> m_Renders = new List<Renderer>();

	public List<string> m_CategoryNames = new List<string>();

	public List<uint> m_Enables = new List<uint>();

	public uint m_baseActive = uint.MaxValue;

	private int[] _RenderActiveCount;

	public uint CalcRendererStatus()
	{
		uint num = 0u;
		for (int i = 0; i < m_Renders.Count; i++)
		{
			if (m_Renders[i].enabled)
			{
				num ^= (uint)(1 << i);
			}
		}
		return num;
	}

	public void InitRenderActiveCount()
	{
		if (!InitRenderActiveCount(ref _RenderActiveCount, m_Renders))
		{
			Debug.LogError("=====>>>>> " + base.transform.root.name + " CharacterRenderController 组件需要重新配置!!!! https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=69992583");
		}
	}

	public static bool InitRenderActiveCount(ref int[] pRenderActiveCount, List<Renderer> pRenders)
	{
		if (pRenderActiveCount == null)
		{
			pRenderActiveCount = new int[pRenders.Count];
		}
		for (int i = 0; i < pRenders.Count; i++)
		{
			if (pRenders[i] == null)
			{
				Debug.LogError("=====>>>>> CharacterRenderController 组件需要重新配置!!!! https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=69992583");
				return false;
			}
			if (!pRenders[i].enabled)
			{
				pRenderActiveCount[i] = -1;
			}
		}
		return true;
	}

	public void SetRendersActive(int pIndex, bool pEnable, bool force = false)
	{
		if (!SetRendersActive(m_Enables, ref _RenderActiveCount, m_Renders, pIndex, pEnable, force))
		{
			Debug.LogError("=====>>>>> " + base.transform.root.name + " CharacterRenderController 组件需要重新配置!!!! https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=69992583", base.transform.root.gameObject);
		}
	}

	public void SetRendersActive(int pIndex, uint pEnable, bool force = false)
	{
		if (!SetRendersActive(m_Enables, ref _RenderActiveCount, m_Renders, pIndex, pEnable, force))
		{
			Debug.LogError("=====>>>>> " + base.transform.root.name + " CharacterRenderController 组件需要重新配置!!!! https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=69992583", base.transform.root.gameObject);
		}
	}

	private static bool GetBoolFromBit(uint bits, int i)
	{
		return ((bits >> i) & 1) == 1;
	}

	private static bool UpdateRenderersState(List<Renderer> pRenders, int[] pRenderActiveCount)
	{
		for (int i = 0; i < pRenders.Count; i++)
		{
			if (pRenders[i] == null)
			{
				return false;
			}
			pRenders[i].enabled = pRenderActiveCount[i] >= 0;
		}
		return true;
	}

	public static bool SetRendersActive(List<uint> pEnables, ref int[] pRenderActiveCount, List<Renderer> pRenders, int pIndex, uint pEnableRaw, bool force = false)
	{
		if (pIndex >= pEnables.Count)
		{
			return true;
		}
		if (pRenderActiveCount == null)
		{
			InitRenderActiveCount(ref pRenderActiveCount, pRenders);
		}
		uint bits = pEnables[pIndex];
		for (int i = 0; i < pRenders.Count; i++)
		{
			if (GetBoolFromBit(bits, i))
			{
				bool boolFromBit = GetBoolFromBit(pEnableRaw, i);
				if (force)
				{
					pRenderActiveCount[i] = ((!boolFromBit) ? (-1) : 0);
				}
				else
				{
					pRenderActiveCount[i] += (boolFromBit ? 1 : (-1));
				}
			}
		}
		return UpdateRenderersState(pRenders, pRenderActiveCount);
	}

	public static bool SetRendersActive(List<uint> pEnables, ref int[] pRenderActiveCount, List<Renderer> pRenders, int pIndex, bool pEnable, bool force = false)
	{
		if (pIndex >= pEnables.Count)
		{
			return true;
		}
		if (pRenderActiveCount == null)
		{
			InitRenderActiveCount(ref pRenderActiveCount, pRenders);
		}
		uint bits = pEnables[pIndex];
		for (int i = 0; i < pRenders.Count; i++)
		{
			if (GetBoolFromBit(bits, i))
			{
				if (force)
				{
					pRenderActiveCount[i] = ((!pEnable) ? (-1) : 0);
				}
				else
				{
					pRenderActiveCount[i] += (pEnable ? 1 : (-1));
				}
			}
		}
		return UpdateRenderersState(pRenders, pRenderActiveCount);
	}

	public static void SetRendersActiveDirectly(List<Renderer> pRenders, uint pControlMask, uint pEnableRaw)
	{
		for (int i = 0; i < pRenders.Count; i++)
		{
			if (GetBoolFromBit(pControlMask, i))
			{
				bool boolFromBit = GetBoolFromBit(pEnableRaw, i);
				pRenders[i].enabled = boolFromBit;
			}
		}
	}

	public void SetAllRendersActive(bool pEnble)
	{
		SetRendersActive(0, pEnble);
	}

	public void SetAllRendersActiveDirectly(uint pEnbleRaw, int cfg = 0)
	{
		uint pControlMask = m_Enables[cfg];
		SetRendersActiveDirectly(m_Renders, pControlMask, pEnbleRaw);
	}

	public void RecoverToFirstState()
	{
		uint baseActive = m_baseActive;
		for (int i = 0; i < m_Renders.Count; i++)
		{
			if (m_Renders[i] == null)
			{
				Debug.LogError("=====>>>>> CharacterRenderController 组件需要重新配置!!!! https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=69992583");
			}
			else
			{
				m_Renders[i].enabled = ((baseActive >> i) & 1) == 1;
			}
		}
		_RenderActiveCount = null;
	}

	public void SetRendersActiveForceUnsafe(int pIndex, bool pEnable)
	{
		if (!SetRendersActive(m_Enables, ref _RenderActiveCount, m_Renders, pIndex, pEnable, force: true))
		{
			Debug.LogError("=====>>>>> " + base.transform.root.name + " CharacterRenderController 组件需要重新配置!!!! https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=69992583");
		}
	}
}
