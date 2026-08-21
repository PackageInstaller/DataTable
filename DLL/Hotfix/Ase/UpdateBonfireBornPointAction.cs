using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("更新出生点", 0)]
[Description("更新指定篝火的出生点。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateBonfireBornPointAction : ActionTaskBase
{
	[Name("传送点ID", 0)]
	[Description("要更新出生点的篝火的Id。")]
	public BBParameter<int> bonfireId;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetSystem<SceneSystem>().UpdateBonfireBornPoint(bonfireId.value.ToString());
		OnActionFinish();
	}
}
