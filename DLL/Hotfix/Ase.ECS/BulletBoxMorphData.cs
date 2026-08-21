using System.Collections.Generic;

namespace Ase.ECS;

public class BulletBoxMorphData : BulletMorphData
{
	private float l;

	private float w;

	private float h;

	protected override void OnInit(List<float> targetValues)
	{
		if (targetValues.Count == 3)
		{
			l = targetValues[0];
			w = targetValues[1];
			h = targetValues[2];
		}
	}

	protected override List<float> OnGetMorphedValues(List<float> curValues, float timeScale)
	{
		if (curValues == null || curValues.Count != 3)
		{
			return null;
		}
		List<float> list = new List<float>();
		float num = curValues[0];
		float num2 = curValues[1];
		float num3 = curValues[2];
		float item = num + (l - num) * timeScale;
		float item2 = num2 + (w - num2) * timeScale;
		float item3 = num3 + (h - num3) * timeScale;
		list.Add(item);
		list.Add(item2);
		list.Add(item3);
		return list;
	}
}
