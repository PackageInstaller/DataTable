using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("屏蔽玩家输入", 0)]
[Description("根据提供的设置，屏蔽或解除屏蔽玩家的移动和旋转输入。")]
[Category("✫ DragonLost/Movement")]
public class ShieldPlayerInput : ActionTaskBase
{
	[Name("屏蔽位移", 0)]
	[Description("指示是否屏蔽玩家的位移输入。")]
	public BBParameter<bool> IsShieldMove;

	[Name("屏蔽旋转", 0)]
	[Description("指示是否屏蔽玩家的旋转输入。")]
	public BBParameter<bool> IsShieldRotate;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
