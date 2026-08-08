using UnityEngine;

public class BlendShapeHeroModel : MonoBehaviour
{
	public SkinnedMeshRenderer skinnedMeshRenderers;

	private string[] m_bsNameAll;

	public string showStr;

	private void Start()
	{
		if (m_bsNameAll == null || m_bsNameAll.Length == 0)
		{
			skinnedMeshRenderers = GetComponent<SkinnedMeshRenderer>();
			m_bsNameAll = new string[skinnedMeshRenderers.sharedMesh.blendShapeCount];
			for (int i = 0; i < skinnedMeshRenderers.sharedMesh.blendShapeCount; i++)
			{
				ref string reference = ref m_bsNameAll[i];
				reference = reference + skinnedMeshRenderers.sharedMesh.GetBlendShapeName(i) + ",";
			}
		}
	}

	public void SetBlendShapeValue(float value)
	{
		for (int i = 0; i < m_bsNameAll.Length; i++)
		{
			if (m_bsNameAll[i].Contains(showStr))
			{
				m_bsNameAll[i].IndexOf(showStr);
				skinnedMeshRenderers.SetBlendShapeWeight(i, value * 100f);
			}
		}
	}
}
