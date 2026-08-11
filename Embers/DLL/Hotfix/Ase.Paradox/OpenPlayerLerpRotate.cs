using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("玩家插值旋转", 0)]
[Description("根据指定的开启状态和插值速度控制玩家的插值旋转。")]
[Category("✫ DragonLost/Movement")]
public class OpenPlayerLerpRotate : ActionTaskBase
{
	[Name("开启状态", 0)]
	[Description("指示是否开启插值旋转。")]
	public bool Open;

	[Name("插值速度", 0)]
	[Description("插值旋转的速度。")]
	public BBParameter<float> Speed;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (Speed == null)
		{
			EndAction();
			return;
		}
		ownerEntity?.GetComponent<MoveComponent>()?.OpenLerpRotate(Open, Speed.value);
		EndAction();
	}
}
