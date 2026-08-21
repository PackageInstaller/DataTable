using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttachPointSetup : MonoBehaviour
{
	public const string LEFT_HAND = "gua_L_hand";

	public const string RIGHT_HAND = "gua_R_hand";

	public const string HP_POINT = "gua_Hp";

	public const string BUFF_BOTTOM = "gua_Buff_bottom";

	public const string BUFF_TOP = "gua_Buff_top";

	public const string HIT_POINT = "gua_Hit";

	public const string AUTO_TOP_POINT = "auto_top_point";

	public const string AUTO_BOTTOM_POINT = "auto_bottom_point";

	public const string AUTO_HP_POINT = "auto_hp_point";

	public const string AUTO_GROUND_POINT = "auto_ground_point";

	public const string COMMON_ROOT_POINT = "root";

	public const string HUMAN_BIP_POINT = "Bip001";

	public const string NON_HUMAN_DUMMY_POINT = "Dummy002";

	public const string AUTO_DOT_POINT = "auto_dot_point";

	public const string AUTO_BIP_POINT = "auto_bip_point";

	public const string AUTO_WEDDING_RING = "auto_wedding_ring";

	private string[] BaseAttachPoints = new string[15]
	{
		"gua_L_hand", "gua_R_hand", "gua_Hp", "gua_Buff_bottom", "gua_Buff_top", "gua_Hit", "auto_top_point", "auto_bottom_point", "auto_hp_point", "auto_ground_point",
		"root", "Bip001", "Dummy002", "auto_dot_point", "auto_bip_point"
	};

	public List<Transform> m_CustomExposedTransform = new List<Transform>();

	public List<Transform> m_AutoEffectAttachPoint = new List<Transform>();

	public List<Transform> m_ExposedTransform = new List<Transform>();

	public List<string> m_ExposedTransformPath = new List<string>();

	public Dictionary<string, Transform> m_dictAttachPoint = new Dictionary<string, Transform>();

	public Dictionary<string, string> m_dictAttachPointPath = new Dictionary<string, string>();

	public Transform m_performPoint;

	public int m_roleID;

	private void Awake()
	{
		if (m_dictAttachPoint.Count != m_dictAttachPointPath.Count)
		{
			return;
		}
		for (int i = 0; i < m_ExposedTransform.Count; i++)
		{
			Transform transform = m_ExposedTransform[i];
			string key = transform.name;
			string value = m_ExposedTransformPath[i];
			if (m_dictAttachPoint.ContainsKey(key))
			{
				m_dictAttachPoint[key] = transform;
				m_dictAttachPointPath[key] = value;
			}
			else
			{
				m_dictAttachPoint.Add(key, transform);
				m_dictAttachPointPath.Add(key, value);
			}
		}
	}

	public void UpdateAttachPointList(string name)
	{
		Transform transform = null;
		string empty = string.Empty;
		if (name.IndexOf('/') != -1)
		{
			transform = base.transform.Find(name);
			if (transform == null)
			{
				transform = base.transform;
				empty = string.Empty;
			}
			else
			{
				empty = name;
			}
		}
		else
		{
			transform = FindDeep(base.transform, name);
			if (transform == null)
			{
				transform = base.transform;
			}
			empty = CalculateTransformPath(transform, base.transform);
		}
		if (m_dictAttachPoint.ContainsKey(name))
		{
			m_dictAttachPoint[name] = transform;
			m_dictAttachPointPath[name] = empty;
		}
		else
		{
			m_dictAttachPoint.Add(name, transform);
			m_dictAttachPointPath.Add(name, empty);
		}
	}

	public string GetAttachPointPath(string name, bool toFind = true)
	{
		if (m_dictAttachPointPath.TryGetValue(name, out var value))
		{
			return value;
		}
		if (!toFind)
		{
			return string.Empty;
		}
		UpdateAttachPointList(name);
		if (m_dictAttachPointPath.TryGetValue(name, out value))
		{
			return value;
		}
		return string.Empty;
	}

	public string GetAttachPointPath(En_BaseAttachPointType en_BaseAttachPointType)
	{
		string attachPointNameOfEnum = GetAttachPointNameOfEnum(en_BaseAttachPointType);
		return GetAttachPointPath(attachPointNameOfEnum);
	}

	public Transform GetAttachPoint(string name, bool toFind = true)
	{
		Transform value = null;
		if (m_dictAttachPoint.TryGetValue(name, out value))
		{
			return value;
		}
		if (toFind)
		{
			UpdateAttachPointList(name);
		}
		if (m_dictAttachPoint.TryGetValue(name, out value))
		{
			return value;
		}
		return null;
	}

	public Transform GetAttachPoint(En_BaseAttachPointType en_AttachPointType)
	{
		string attachPointNameOfEnum = GetAttachPointNameOfEnum(en_AttachPointType);
		return GetAttachPoint(attachPointNameOfEnum);
	}

	public string GetAttachPointNameOfEnum(En_BaseAttachPointType pEn_BaseAttachPointType)
	{
		return pEn_BaseAttachPointType switch
		{
			En_BaseAttachPointType.LeftHand => "gua_L_hand", 
			En_BaseAttachPointType.RightHand => "gua_R_hand", 
			En_BaseAttachPointType.HpPoint => "gua_Hp", 
			En_BaseAttachPointType.BuffBottom => "gua_Buff_bottom", 
			En_BaseAttachPointType.BuffTop => "gua_Buff_top", 
			En_BaseAttachPointType.HitPoint => "gua_Hit", 
			En_BaseAttachPointType.AutoTopPoint => "auto_top_point", 
			En_BaseAttachPointType.AutoBottomPoint => "auto_bottom_point", 
			En_BaseAttachPointType.AutoHpPoint => "auto_hp_point", 
			_ => string.Empty, 
		};
	}

	public Transform FindDeep(Transform root, string childName)
	{
		Transform transform = root.Find(childName);
		if (transform != null)
		{
			return transform;
		}
		IEnumerator enumerator = root.GetEnumerator();
		while (enumerator.MoveNext())
		{
			transform = ((Transform)enumerator.Current).FindChildDeep(childName);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}

	private string CalculateTransformPath(Transform targetTransform, Transform root)
	{
		if (root == targetTransform || null == targetTransform)
		{
			return string.Empty;
		}
		string text = targetTransform.name;
		Transform parent = targetTransform.parent;
		while (null != parent && parent != root)
		{
			text = parent.name + "/" + text;
			parent = parent.parent;
		}
		return text;
	}

	public Vector3 GetPerformPosition()
	{
		if (m_performPoint == null)
		{
			return base.transform.position;
		}
		return m_performPoint.position;
	}
}
