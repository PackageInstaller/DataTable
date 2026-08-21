using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("取消救援", 0)]
[Description("根据是否成功开始救援，设置救援者ID。")]
[Category("✫ DragonLost/Entity")]
public class CancelResuceAction : ActionTaskBase
{
	[Name("是否成功开始救援", 0)]
	[Description("指示是否成功开始救援")]
	public BBParameter<bool> IsStartRescue;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().GetComponent<NearDeathRescueComponent>().GetIsInRescuse())
		{
			GetOwnerEntity().GetComponent<NearDeathRescueComponent>().CancaleRescuse();
		}
		EndAction();
	}
}
