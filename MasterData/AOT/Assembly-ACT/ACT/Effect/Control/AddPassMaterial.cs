using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Effect.Control;

[ExecuteAlways]
public class AddPassMaterial : LuminSerializedMonoBehaviour
{
	public ScreenEffectBase[] screenEffectBases;

	private void GetMat()
	{
		screenEffectBases = GetComponentsInChildren<ScreenEffectBase>();
	}

	private void Update()
	{
		UltimetaSkillEffectPass.materials.Clear();
		for (int i = 0; i < screenEffectBases.Length; i++)
		{
			screenEffectBases[i].AddMat();
		}
	}

	private void OnDestroy()
	{
		UltimetaSkillEffectPass.materials.Clear();
	}
}
