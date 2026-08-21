using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class Gravel : MonoBehaviour
{
	protected AnimationCurve Curve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 0f));

	protected float startTime;

	protected bool vanish;

	private List<Material> materials = new List<Material>();

	private void Update()
	{
		if (!vanish)
		{
			return;
		}
		float num = Curve.Evaluate(Time.time - startTime);
		if (num >= 1f)
		{
			Object.Destroy(base.gameObject);
			return;
		}
		materials.Clear();
		base.gameObject.GetComponent<MeshRenderer>().GetMaterials(materials);
		foreach (Material material in materials)
		{
			material.SetFloat("_Melt", num);
		}
	}

	public void StartVanish(AnimationCurve inCurve)
	{
		Curve = inCurve;
		vanish = true;
		startTime = Time.time;
	}
}
