using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("更新NPC存档数据", 0)]
[Description("根据指定条件更新NPC的存档数据。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateNpcDataAction : ActionTaskBase
{
	[Name("改变显示状态", 0)]
	[Description("指示是否改变NPC的显示状态。")]
	public bool changeActive;

	[HideIf("changeActive", 0)]
	[Name("显示状态", 0)]
	[Description("要设置的NPC的显示状态。")]
	public bool active;

	[Name("改变开场白", 0)]
	[Description("指示是否改变NPC的开场白对话。")]
	public bool changeDialogPrologue;

	[HideIf("changeDialogPrologue", 0)]
	[Name("开场白", 0)]
	[Description("要设置的NPC的开场白对话ID列表。")]
	public List<int> dialogPrologue;

	[Name("改变按钮组配置", 0)]
	[Description("指示是否改变NPC的对话按钮组配置。")]
	public bool changeDialogButtonGroup;

	[HideIf("changeDialogButtonGroup", 0)]
	[Name("按钮组配置", 0)]
	[Description("要设置的NPC的对话按钮组配置列表。")]
	public List<DialogueChainConfig.DialogueButtonConfig> dialogButtonGroup;

	protected override void OnExecute()
	{
		base.OnExecute();
		NPCNode data = GetOwnerEntity().GetData<NPCNode>("MAPDATANODEKEY");
		if ((Object)(object)data == null)
		{
			OnActionFinish();
			return;
		}
		int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
		if (changeActive)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcActiveState(levelId, data.Uid, active);
		}
		if (changeDialogPrologue)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcDialogPrologue(levelId, data.Uid, dialogPrologue);
		}
		if (changeDialogButtonGroup)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcData(levelId, data.Uid, dialogButtonGroup);
		}
		if (changeActive || changeDialogPrologue || changeDialogButtonGroup)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteNpcUpdateAction(levelId, data.Uid);
		}
		OnActionFinish();
	}
}
