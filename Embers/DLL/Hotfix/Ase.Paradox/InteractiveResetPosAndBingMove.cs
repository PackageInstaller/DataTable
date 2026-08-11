using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("交互物位置绑定状态重置", 0)]
[Description("重置交互物的位置和绑定状态。")]
[Category("✫ DragonLost/Entity")]
public class InteractiveResetPosAndBingMove : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		MapItemNode data = GetOwnerEntity().GetData<MapItemNode>("MAPDATANODEKEY");
		if ((Object)(object)data != null)
		{
			data.ResetPosAndBingMove();
		}
		OnActionFinish();
	}
}
