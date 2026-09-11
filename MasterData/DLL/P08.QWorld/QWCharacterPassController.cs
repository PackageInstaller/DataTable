using System.Collections.Generic;
using UnityEngine;

public class QWCharacterPassController : MonoBehaviour
{
	private List<Material> mats;

	private bool isInit;

	public void InitMats(List<Renderer> renderers)
	{
		if (isInit)
		{
			return;
		}
		if (mats == null)
		{
			mats = new List<Material>();
		}
		else
		{
			mats.Clear();
		}
		int num = 0;
		for (int i = 0; i < renderers.Count; i++)
		{
			Renderer renderer = renderers[i];
			if ((bool)renderer && (renderer is MeshRenderer || renderer is SkinnedMeshRenderer))
			{
				for (int j = 0; j < renderer.materials.Length; j++)
				{
					mats.Add(renderer.materials[j]);
				}
				num++;
			}
		}
		if (num > 0)
		{
			isInit = true;
		}
	}

	public void ClearMats()
	{
		if (mats != null && mats.Count > 0)
		{
			foreach (Material mat in mats)
			{
				_ = (bool)mat;
			}
			mats.Clear();
		}
		isInit = false;
	}

	public void SwitchFaceShadowPass(bool state)
	{
		if (!isInit)
		{
			return;
		}
		for (int i = 0; i < mats.Count; i++)
		{
			Material material = mats[i];
			if ((bool)material)
			{
				material.SetShaderPassEnabled("CharFaceShadow", state && material.IsKeywordEnabled("FACE_MODE"));
			}
		}
	}

	public void SwitchHairShadowPass(bool state)
	{
		if (!isInit)
		{
			return;
		}
		for (int i = 0; i < mats.Count; i++)
		{
			Material material = mats[i];
			if ((bool)material)
			{
				material.SetShaderPassEnabled("CharHairShadow", state && material.IsKeywordEnabled("HAIR_MODE"));
			}
		}
	}

	public void SwitchOutlinePass(bool state)
	{
		if (!isInit)
		{
			return;
		}
		for (int i = 0; i < mats.Count; i++)
		{
			Material material = mats[i];
			if ((bool)material)
			{
				material.SetShaderPassEnabled("Always", state);
			}
		}
	}

	public void SwitchShadowCasterPass(bool state)
	{
		if (!isInit)
		{
			return;
		}
		for (int i = 0; i < mats.Count; i++)
		{
			Material material = mats[i];
			if ((bool)material)
			{
				material.SetShaderPassEnabled("ShadowCaster", state);
			}
		}
	}
}
