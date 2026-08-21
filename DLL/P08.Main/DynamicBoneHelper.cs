using MagicaCloth2;
using UnityEngine;

public class DynamicBoneHelper : MonoBehaviour
{
	private DynamicBone[] m_dynamicBones;

	private MagicaCloth[] m_magicClothes;

	private bool m_onlyByGlobal;

	public void EnableDynamicBoneGlobal(bool enable, bool onlyByGlobal)
	{
		m_onlyByGlobal = false;
		EnableDynamicBone(enable);
		m_onlyByGlobal = onlyByGlobal;
	}

	public void EnableDynamicBone(bool enable)
	{
		if (m_onlyByGlobal)
		{
			return;
		}
		if (m_dynamicBones == null)
		{
			m_dynamicBones = GetComponentsInChildren<DynamicBone>(includeInactive: true);
		}
		if (m_dynamicBones != null && m_dynamicBones.Length != 0)
		{
			for (int i = 0; i < m_dynamicBones.Length; i++)
			{
				m_dynamicBones[i].enabled = enable;
			}
		}
		if (m_magicClothes == null)
		{
			m_magicClothes = GetComponentsInChildren<MagicaCloth>(includeInactive: true);
		}
		if (m_magicClothes != null && m_magicClothes.Length != 0)
		{
			for (int j = 0; j < m_magicClothes.Length; j++)
			{
				m_magicClothes[j].enabled = enable;
			}
		}
	}
}
