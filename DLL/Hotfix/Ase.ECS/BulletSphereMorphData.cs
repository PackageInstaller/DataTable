using System.Collections.Generic;

namespace Ase.ECS;

public class BulletSphereMorphData : BulletMorphData
{
	public float r;

	protected override void OnInit(List<float> targetValues)
	{
		if (targetValues.Count == 1)
		{
			r = targetValues[0];
		}
	}

	protected override List<float> OnGetMorphedValues(List<float> curValues, float timeScale)
	{
		if (curValues == null || curValues.Count != 1)
		{
			return null;
		}
		List<float> list = new List<float>();
		float num = curValues[0];
		float item = num + (r - num) * timeScale;
		list.Add(item);
		return list;
	}
}
