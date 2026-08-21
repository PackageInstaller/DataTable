using System.Collections.Generic;
using System.Numerics;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("转换Vector3列表为Vector2列表", 0)]
[Category("✫ DragonLost/Operation")]
[Description("将Vector3列表转换为Vector2列表")]
public class Vector3ListToVector2List : ActionTaskBase
{
	[Name("Vector3列表", 0)]
	[Description("要转换的Vector3列表")]
	public BBParameter<List<Vector3>> v3List;

	[Name("Vector2列表", 0)]
	[Description("转换后的Vector2列表")]
	public BBParameter<List<Vector2>> v2List;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (v3List.value == null)
		{
			EndAction();
			return;
		}
		v2List.value = new List<Vector2>();
		for (int i = 0; i < v3List.value.Count; i++)
		{
			v2List.value.Add(new Vector2(v3List.value[i].X, v3List.value[i].Z));
		}
		EndAction();
	}
}
