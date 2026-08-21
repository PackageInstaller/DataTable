#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("更新NPC黑板数据并保存存档", 0)]
[Description("更新NPC黑板数据并更新、保存存档。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateNPCParadoxDataAction : ActionTaskBase
{
	[RequiredField]
	[Name("黑板参数", 0)]
	[Description("要设置的NPC的行为树黑板参数。")]
	public BBParameter<string> BlackKey;

	[Name("是否保存存档", 0)]
	[Description("是否执行保存存档。")]
	public bool IsSaveData;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().GetEntityType() == EntityType.NPC)
		{
			NPCNode data = GetOwnerEntity().GetData<NPCNode>("MAPDATANODEKEY");
			if ((Object)(object)data == null)
			{
				OnActionFinish();
				return;
			}
			Variable variable = base.blackboard.GetVariable(BlackKey.value);
			if (variable == null)
			{
				Log.Error($"NPC物体{GetOwnerEntity().EntityId}:黑板参数不存在：");
				OnActionFinish();
				return;
			}
			MapDataNodeParadoxParameter mapDataNodeParadoxParameter = MapDataNodeParadoxParameter.CreateParameter(variable);
			int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcParadoxData(levelId, data.Uid, BlackKey.value, mapDataNodeParadoxParameter);
			data.SendParadoxMessage(BlackKey.value, mapDataNodeParadoxParameter);
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteNpcUpdateAction(levelId, data.Uid);
			if (IsSaveData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
			}
		}
		OnActionFinish();
	}
}
