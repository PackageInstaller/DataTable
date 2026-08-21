using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class KnapsackItemQualityEffect : MonoBehaviour
{
	[SerializeField]
	private GameObject bgEffectGo;

	[SerializeField]
	private GameObject iconEffectGo;

	public async UniTask MountAsync(Transform bgParent, Transform iconParent, float bgScale, float iconScale)
	{
		if (bgEffectGo != null && bgParent != null)
		{
			bgEffectGo.transform.SetParent(bgParent, worldPositionStays: false);
			bgEffectGo.transform.SetSiblingIndex(0);
			ApplyScale(bgEffectGo.transform, bgScale);
			bgEffectGo.SetActive(value: true);
		}
		if (iconEffectGo != null && iconParent != null)
		{
			iconEffectGo.transform.SetParent(iconParent, worldPositionStays: false);
			ApplyScale(iconEffectGo.transform, iconScale);
			iconEffectGo.SetActive(value: true);
		}
		await UniTask.CompletedTask;
	}

	public void HideEffects()
	{
		if (bgEffectGo != null)
		{
			bgEffectGo.SetActive(value: false);
		}
		if (iconEffectGo != null)
		{
			iconEffectGo.SetActive(value: false);
		}
	}

	public void DestroyEffects()
	{
		if (bgEffectGo != null)
		{
			Object.Destroy(bgEffectGo);
			bgEffectGo = null;
		}
		if (iconEffectGo != null)
		{
			Object.Destroy(iconEffectGo);
			iconEffectGo = null;
		}
	}

	private static void ApplyScale(Transform tf, float scale)
	{
		if (!(tf == null))
		{
			tf.localScale = new Vector3(scale, scale, tf.localScale.z);
		}
	}
}
