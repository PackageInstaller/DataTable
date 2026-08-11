#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("更新交互物节点行为树参数", 0)]
[Description("更新交互物行为树参数。Node上面的参数")]
[Category("✫ DragonLost/Interactive")]
public class UpdateMapItemNodeParadoxDataAction : ActionTaskBase
{
	[RequiredField]
	[Name("黑板参数", 0)]
	[Description("要设置的交互物的行为树黑板参数。")]
	public BBParameter<string> BlackKey;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().GetEntityType() != EntityType.INTERACTIVE)
		{
			return;
		}
		MapItemNode data = GetOwnerEntity().GetData<MapItemNode>("MAPDATANODEKEY");
		if ((Object)(object)data == null)
		{
			OnActionFinish();
			return;
		}
		Variable variable = base.blackboard.GetVariable(BlackKey.value);
		if (variable == null)
		{
			Log.Error($"交互物体{GetOwnerEntity().EntityId}:黑板参数不存在：");
			OnActionFinish();
		}
		else
		{
			MapDataNodeParadoxParameter messageValue = MapDataNodeParadoxParameter.CreateParameter(variable);
			data.SendParadoxMessage(BlackKey.value, messageValue);
			OnActionFinish();
		}
	}
}
