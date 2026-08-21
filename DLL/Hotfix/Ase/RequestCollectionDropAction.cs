using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("采集物掉落", 0)]
[Description("执行采集物品掉落的行为。")]
[Category("✫ DragonLost/Interactive")]
public class RequestCollectionDropAction : ActionTaskBase
{
	[Name("出生位置绑点名", 0)]
	[Description("指定采集物品掉落的出生位置绑点名。")]
	public BBParameter<string> _BornPointName = new BBParameter<string>();

	[Name("拾取人实体ID", 0)]
	[Description("拾取物品的实体ID。")]
	public BBParameter<int> _targetID = new BBParameter<int>();

	[Name("拾取人实体绑点名", 0)]
	[Description("拾取物品的实体绑点名。")]
	public BBParameter<string> _pointName = new BBParameter<string>();

	[Name("使用自定义掉落Id", 0)]
	[Description("是否使用自定义的掉落ID。")]
	public bool useOtherDropId;

	[Name("自定义掉落Id", 0)]
	[Description("自定义的掉落ID。")]
	public BBParameter<int> _dropId = new BBParameter<int>();

	[Name("开启掉落表现", 0)]
	[Description("是否开启掉落的视觉效果。")]
	public bool openDropPerformance;

	[Name("背包满采集失败", 0)]
	[Description("背包满采集失败。")]
	public BBParameter<bool> CollectResult = false;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().GetEntityType() != EntityType.INTERACTIVE)
		{
			return;
		}
		int dropId = _dropId.value;
		if (!useOtherDropId)
		{
			dropId = GetOwnerEntity().GetData<int>(Constant.InteractiveConstant.INTERACTIVE_DROP_KEY);
		}
		string text = ((_BornPointName.value == null) ? string.Empty : _BornPointName.value);
		string pointName = ((_pointName.value == null) ? string.Empty : _pointName.value);
		if (string.IsNullOrEmpty(pointName))
		{
			pointName = "center";
		}
		Vector3 bornPosition = GetOwnerEntity().GetComponent<EntityBoneComponent>().GetBonePosition(text);
		SceneSystem system = GetOwnerEntity().GetSystem<SceneSystem>();
		if (system == null)
		{
			return;
		}
		int levelId = system.GetLevelId();
		int uid = GetOwnerEntity().GetData<int>(MapItemNode.MAPITEMUID);
		if (string.IsNullOrEmpty(text))
		{
			bornPosition = GetOwnerEntity().transform.position + new Vector3(0f, 0.5f, 0f);
		}
		for (int count = 0; count < 5; count++)
		{
			(bool, int) tuple = await GetOwnerEntity().GetSystem<DropSystem>().DropCollectionTask(_targetID.value, pointName, dropId, bornPosition, GetOwnerEntity().transform.rotation.eulerAngles, levelId, uid, openDropPerformance);
			var (flag, _) = tuple;
			CollectResult.value = tuple.Item2 == 200158;
			if (!flag)
			{
				continue;
			}
			MapItemNode data = GetOwnerEntity().GetData<MapItemNode>("MAPDATANODEKEY");
			if ((Object)(object)data != null)
			{
				int mapItemId = data.mapItemId;
				DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemId);
				if (dataRow != null && dataRow.MarkType == MapItemNode.TreasureMaskType)
				{
					data.OpenChestReport(data);
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().OpenTreasureSave(levelId, uid);
				}
			}
			OnActionFinish();
			break;
		}
	}
}
