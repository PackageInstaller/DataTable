using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改BUFF", 0)]
[Category("✫ DragonLost/Buff")]
[Description("用于修改指定实体身上的BUFF的层数和持续时间")]
public class ModifyBuff : ActionTaskBase
{
	[Name("BuffID", 0)]
	[RequiredField]
	[Description("要修改的BUFF的编号")]
	public BBParameter<int> buffId;

	[Name("是否修改层数", 0)]
	[RequiredField]
	[Description("是否修改BUFF的层数")]
	public BBParameter<bool> changeLayer;

	[Name("修改层数类型", 0)]
	[RequiredField]
	[Description("指定修改BUFF层数的方式")]
	public BBParameter<ChangeType> changeLayerType;

	[Name("是否修改时间", 0)]
	[RequiredField]
	[Description("是否修改BUFF的持续时间")]
	public BBParameter<bool> changeTime;

	[Name("修改时间类型", 0)]
	[RequiredField]
	[Description("指定修改BUFF持续时间的方式")]
	public BBParameter<ChangeType> changeTimeType;

	[Name("是否选择实体列表", 0)]
	[RequiredField]
	[Description("是否选择多个目标实体进行BUFF修改")]
	public BBParameter<bool> chooseList = false;

	[Name("找不到Buff是否需要创建", 0)]
	[RequiredField]
	[Description("当指定的BUFF不存在于目标实体身上时，是否需要创建该BUFF")]
	public BBParameter<bool> createBuff;

	[Name("层数", 0)]
	[RequiredField]
	[Description("要设置的BUFF层数，根据修改层数类型进行计算")]
	public BBParameter<int> layer;

	[Name("是否重置存活时间", 0)]
	[RequiredField]
	[Description("是否重置存活时间")]
	public BBParameter<bool> resetCooling;

	[Name("实体目标ID", 0)]
	[RequiredField]
	[Description("要修改BUFF的目标实体的ID")]
	public BBParameter<int> targetId;

	[Name("实体目标列表", 0)]
	[Description("用于选择多个目标实体的ID列表")]
	public BBParameter<List<int>> targetList;

	[Name("时间", 0)]
	[RequiredField]
	[Description("要设置的BUFF持续时间，根据修改时间类型进行计算")]
	public BBParameter<float> time;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BuffSystem system = ownerEntity.GetSystem<BuffSystem>();
		if (system == null)
		{
			OnActionFinish();
			return;
		}
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(buffId.value);
		if (dataRow == null)
		{
			OnActionFail();
			return;
		}
		if (dataRow.Operations.IsNullOrEmpty())
		{
			OnActionFail();
			return;
		}
		List<int> list;
		if (chooseList.value)
		{
			list = targetList.value;
		}
		else
		{
			list = new List<int>();
			list.Add(targetId.value);
		}
		if (list == null || list.Count == 0)
		{
			OnActionFinish();
			return;
		}
		foreach (int item in list)
		{
			if (!EntityAndTreeConsistency(item, out var baseEntity))
			{
				continue;
			}
			Buff buff = system.FindEntityBuff(baseEntity.Id, buffId.value);
			if (buff == null && !createBuff.value)
			{
				continue;
			}
			if (buff == null && createBuff.value)
			{
				int num = dataRow.InitLayer;
				float duration = dataRow.Duration;
				if (changeLayer.value)
				{
					num = layer.value;
				}
				if (changeTime.value)
				{
					duration = GetTime(changeTimeType.value, duration, time.value);
				}
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId($"创建Buff  发起方  ： {ownerEntity.Id}, 接受方 ： {baseEntity.Id}", ownerEntity);
				}
				system.AcquireBuffByModifyNode(ownerEntity, baseEntity, dataRow, duration, num);
				continue;
			}
			int curLayer = buff.GetLayer();
			float maxLifeTime = buff.MaxLifeTime;
			if (changeLayer.value)
			{
				curLayer = GetLayer(changeLayerType.value, curLayer, dataRow.MaxLayer, layer.value);
			}
			if (changeTime.value)
			{
				maxLifeTime = GetTime(changeTimeType.value, maxLifeTime, time.value);
			}
			buff.SetDuration(maxLifeTime);
			buff.SetLayer(curLayer);
			if (resetCooling.value)
			{
				buff.ResetLifeTime();
			}
		}
		OnActionFinish();
	}

	private int GetLayer(ChangeType changeType, int curLayer, int maxLayer, int layer)
	{
		if (changeType == ChangeType.Add || changeType == ChangeType.Dec)
		{
			layer = ((changeType == ChangeType.Add) ? layer : (-layer));
			return Mathf.Clamp(layer + curLayer, 0, maxLayer);
		}
		return Mathf.Clamp(layer, 0, maxLayer);
	}

	private float GetTime(ChangeType changeType, float curTime, float time)
	{
		if (changeType == ChangeType.Add || changeType == ChangeType.Dec)
		{
			time = ((changeType == ChangeType.Add) ? time : (0f - time));
			return time + curTime;
		}
		return time;
	}
}
