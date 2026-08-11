using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("获取SaveArgs", 0)]
[Description("获取保存的参数。")]
[Category("✫ DragonLost/Interactive")]
public class GetSaveArgsAction : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		MapItemNode data = GetOwnerEntity().GetData<MapItemNode>("MAPDATANODEKEY");
		if ((Object)(object)data == null)
		{
			OnActionFinish();
			return;
		}
		data.SetMapItemSaveData();
		OnActionFinish();
	}
}
