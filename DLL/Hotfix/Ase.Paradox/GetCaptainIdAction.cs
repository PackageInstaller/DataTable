using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取队长ID", 0)]
[Description("获取玩家操控的角色实体的ID。")]
[Category("✫ DragonLost/Target")]
public class GetCaptainIdAction : ActionTaskBase
{
	[Name("队长ID", 0)]
	[Description("存储获取到的队长实体的ID。")]
	public BBParameter<int> CaptainId;

	protected override void OnExecute()
	{
		base.OnExecute();
		CaptainId.value = ownerEntity.GetWorld().ActorId;
		EndAction();
	}
}
