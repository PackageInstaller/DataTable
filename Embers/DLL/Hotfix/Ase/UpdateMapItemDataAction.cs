using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("更新交互物存档数据", 0)]
[Description("根据指定条件更新交互物的存档数据。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateMapItemDataAction : ActionTaskBase
{
	[Name("是否修改激活状态", 0)]
	[Description("指示是否修改交互物的激活状态。")]
	public bool changeActiveState;

	[Name("激活状态", 0)]
	[Description("要设置的交互物激活状态。")]
	[HideIf("changeActiveState", 0)]
	public BBParameter<bool> activeState;

	[Name("是否修改状态图标", 0)]
	[Description("指示是否修改交互物的状态图标。")]
	public bool changeIconType;

	[Name("状态图标", 0)]
	[Description("要设置的交互物的状态图标。")]
	[HideIf("changeIconType", 0)]
	public BBParameter<int> iconType;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().GetEntityType() == EntityType.INTERACTIVE)
		{
			MapItemNode data = GetOwnerEntity().GetData<MapItemNode>("MAPDATANODEKEY");
			if ((Object)(object)data == null)
			{
				OnActionFinish();
				return;
			}
			int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
			if (changeActiveState)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemActiveState(levelId, data.Uid, (!activeState.value) ? 1 : 0);
			}
			if (changeIconType)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataIconType(levelId, data.Uid, iconType.value);
			}
			if (changeActiveState || changeIconType)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteMapItemUpdateAction(levelId, data.Uid);
			}
		}
		OnActionFinish();
	}
}
