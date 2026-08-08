using System.Collections.Generic;
using UnityEngine;

public class RedPointMgr : MonoBehaviour
{
	private static RedPointMgr _inst;

	private static bool applicationQuit = false;

	private static List<UIRedPoint> m_RedPoints = new List<UIRedPoint>();

	private static Dictionary<UIRedPoint, int> exist = new Dictionary<UIRedPoint, int>();

	public static RedPointMgr Instance
	{
		get
		{
			if (applicationQuit)
			{
				return null;
			}
			if (_inst == null)
			{
				GameObject obj = new GameObject("RedPointMgr");
				Object.DontDestroyOnLoad(obj);
				_inst = obj.AddComponent<RedPointMgr>();
			}
			return _inst;
		}
	}

	public static UIRedPoint current
	{
		get
		{
			if (m_RedPoints.Count <= 0)
			{
				return null;
			}
			return m_RedPoints[0];
		}
		set
		{
			if (exist.TryGetValue(value, out var value2) && value2 >= 0)
			{
				m_RedPoints.RemoveAt(value2);
				m_RedPoints.Insert(0, value);
				exist.Remove(value);
			}
		}
	}

	public void Add(UIRedPoint red)
	{
		if (!exist.ContainsKey(red))
		{
			m_RedPoints.Add(red);
			exist.Add(red, m_RedPoints.Count - 1);
		}
	}

	public void Remove(UIRedPoint red)
	{
		if (exist.TryGetValue(red, out var _))
		{
			m_RedPoints.Remove(red);
			exist.Remove(red);
		}
	}

	public float GetTime()
	{
		if (null != current && null != current.Anim)
		{
			return current.Anim.GetCurrentAnimatorStateInfo(0).normalizedTime % 1f;
		}
		return 0f;
	}

	private void OnDestroy()
	{
		applicationQuit = true;
		_inst = null;
	}
}
