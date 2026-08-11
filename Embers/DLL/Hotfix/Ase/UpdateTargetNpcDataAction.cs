using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("更新NPC存档数据", 0)]
[Description("根据指定条件更新目标NPC的存档数据。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateTargetNpcDataAction : ActionTaskBase
{
	[Name("目标NPC Uid", 0)]
	[Description("要更新存档数据的目标NPC的唯一标识符。")]
	public BBParameter<int> uid;

	[Name("改变显示状态", 0)]
	[Description("指示是否改变NPC的显示状态。")]
	public bool changeActive;

	[Name("改变开场白", 0)]
	[Description("指示是否改变NPC的开场白对话。")]
	public bool changeDialogPrologue;

	[Name("改变按钮组配置", 0)]
	[Description("指示是否改变NPC的对话按钮组配置。")]
	public bool changeDialogButtonGroup;

	[HideIf("changeActive", false)]
	[Name("显示状态", 0)]
	[Description("要设置的NPC的显示状态。")]
	public bool active;

	[HideIf("changeDialogPrologue", false)]
	[Name("开场白", 0)]
	[Description("要设置的NPC的开场白对话ID列表。")]
	public List<int> dialogPrologue;

	[HideIf("changeDialogButtonGroup", false)]
	[Name("按钮组配置", 0)]
	[Description("要设置的NPC的对话按钮组配置列表。")]
	public List<DialogueChainConfig.DialogueButtonConfig> dialogButtonGroup;

	protected override void OnExecute()
	{
		base.OnExecute();
		int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
		if (changeActive)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcActiveState(levelId, uid.value, active);
		}
		if (changeDialogPrologue)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcDialogPrologue(levelId, uid.value, dialogPrologue);
		}
		if (changeDialogButtonGroup)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcData(levelId, uid.value, dialogButtonGroup);
		}
		if (changeActive || changeDialogPrologue || changeDialogButtonGroup)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteNpcUpdateAction(levelId, uid.value);
		}
		OnActionFinish();
	}
}
