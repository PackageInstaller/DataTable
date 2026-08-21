using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("打开爬塔天赋强化界面", 0)]
[Description("打开爬塔天赋强化界面。")]
[Category("✫ DragonLost/Interactive")]
public class OpenTowerStrengthAction : ActionTaskBase
{
	[Name("是否等待界面关闭", 0)]
	[Description("是否等待界面关闭")]
	public BBParameter<bool> IsWaitWindowClose = false;

	protected override async void OnExecute()
	{
		base.OnExecute();
		await GetOwnerEntity().GetSystem<ClimbTowerSystem>().OpenTalentStrengthWindow(IsWaitWindowClose.value ? new Action(CloseMenu) : null);
		if (!IsWaitWindowClose.value)
		{
			OnActionFinish();
		}
	}

	private void CloseMenu()
	{
		OnActionFinish();
	}
}
