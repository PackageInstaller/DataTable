#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("更新交互物黑板数据并保存存档", 0)]
[Description("更新交互物黑板数据并更新、保存存档。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateMapItemParadoxDataActione : ActionTaskBase
{
	[RequiredField]
	[Name("黑板参数", 0)]
	[Description("要设置的交互物的行为树黑板参数。")]
	public BBParameter<string> BlackKey;

	[Name("是否保存存档", 0)]
	[Description("是否保存交互物的存档数据。")]
	public bool IsSaveData;

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
			Variable variable = base.blackboard.GetVariable(BlackKey.value);
			if (variable == null)
			{
				Log.Error($"交互物体{GetOwnerEntity().EntityId}:黑板参数不存在：");
				OnActionFinish();
				return;
			}
			MapDataNodeParadoxParameter mapDataNodeParadoxParameter = MapDataNodeParadoxParameter.CreateParameter(variable);
			int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxData(levelId, data.Uid, BlackKey.value, mapDataNodeParadoxParameter);
			data.SendParadoxMessage(BlackKey.value, mapDataNodeParadoxParameter);
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteMapItemUpdateAction(levelId, data.Uid);
			if (IsSaveData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
			}
		}
		OnActionFinish();
	}
}
