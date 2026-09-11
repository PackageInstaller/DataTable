using System;
using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断buff覆盖逻辑", 0)]
[Category("Logic/Buff")]
[Description("判断buff覆盖逻辑,如果有移除现有的buff，会根据removeCurrentBuff 在这个节点里移除")]
public class BuffRelationShip : FlowNode
{
	private ValueInput<int> _ExcludeBuffListID;

	public bool removeCurrentBuff;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(removeCurrentBuff);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		removeCurrentBuff = reader.ReadBoolean();
	}

	public static BuffRelationShipType GetRelationShip(SimEntity entity, int classID)
	{
		if (!ConfigHelper.GetInstance().TryGetConfig<public_buff_relation>(classID, out var config))
		{
			return BuffRelationShipType.None;
		}
		BuffRelationShipType buffRelationShipType = BuffRelationShipType.None;
		for (int i = 0; i < entity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			int item = entity.entityBuff.mBuffClassIDArray[i];
			if (config.RemoveSelfList.Contains(item))
			{
				buffRelationShipType = BuffRelationShipType.RemoveSelf;
				break;
			}
			if (config.RemoveTogetherList.Contains(item))
			{
				buffRelationShipType = BuffRelationShipType.RemoveTogether;
			}
			if (config.OverWriteList.Contains(item))
			{
				buffRelationShipType = (BuffRelationShipType)Math.Max(1, (int)buffRelationShipType);
			}
		}
		return buffRelationShipType;
	}

	public static bool ProcessRelationShipByConfigID(SimEntity entity, int configID, bool remove = true)
	{
		public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(configID);
		bool result = true;
		int buffClassId = config.BuffClassId;
		switch (GetRelationShip(entity, buffClassId))
		{
		case BuffRelationShipType.None:
			result = true;
			break;
		case BuffRelationShipType.OverWrite:
			result = true;
			if (remove)
			{
				RemoveOverWriteList(entity, buffClassId, -1);
			}
			break;
		case BuffRelationShipType.RemoveTogether:
			result = false;
			if (remove)
			{
				RemoveTogetherList(entity, buffClassId, -1);
			}
			break;
		case BuffRelationShipType.RemoveSelf:
			result = false;
			break;
		}
		return result;
	}

	public static void RemoveOverWriteList(SimEntity entity, int classID, int pExcludeBuffListID)
	{
		public_buff_relation config = ConfigHelper.GetInstance().GetConfig<public_buff_relation>(classID);
		for (int i = 0; i < entity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			if (i != pExcludeBuffListID && !entity.entityBuff.IsInPendingRemoveArray(entity.entityBuff.mBuffID[i]))
			{
				int item = entity.entityBuff.mBuffClassIDArray[i];
				if (config.OverWriteList.Contains(item))
				{
					BuffProcessor.RemoveBuffByListIndex(entity, i);
				}
			}
		}
	}

	public static void RemoveTogetherList(SimEntity entity, int classID, int pExcludeBuffListID)
	{
		public_buff_relation config = ConfigHelper.GetInstance().GetConfig<public_buff_relation>(classID);
		for (int i = 0; i < entity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			if (i != pExcludeBuffListID && !entity.entityBuff.IsInPendingRemoveArray(entity.entityBuff.mBuffID[i]))
			{
				int item = entity.entityBuff.mBuffClassIDArray[i];
				if (config.RemoveTogetherList.Contains(item))
				{
					BuffProcessor.RemoveBuffByListIndex(entity, i);
				}
			}
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("作用对象ID");
		ValueInput<int> buffClassInput = AddValueInput<int>("类型(处理逻辑)ID", "处理逻辑");
		_ExcludeBuffListID = AddValueInput<int>("不移除的数组下标(可选)", "excludeBuffListID").SetDefaultAndSerializedValue(-1);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				if (!entityWithEntityID.hasEntityBuff)
				{
					f.Call(trueOut);
				}
				else
				{
					BuffRelationShipType relationShip = GetRelationShip(entityWithEntityID, buffClassInput.value);
					bool flag = false;
					switch (relationShip)
					{
					case BuffRelationShipType.None:
						flag = true;
						break;
					case BuffRelationShipType.OverWrite:
						flag = true;
						if (removeCurrentBuff)
						{
							RemoveOverWriteList(entityWithEntityID, buffClassInput.value, _ExcludeBuffListID.GetValue());
						}
						break;
					case BuffRelationShipType.RemoveTogether:
						flag = false;
						if (removeCurrentBuff)
						{
							RemoveTogetherList(entityWithEntityID, buffClassInput.value, _ExcludeBuffListID.GetValue());
						}
						break;
					case BuffRelationShipType.RemoveSelf:
						flag = false;
						break;
					}
					if (flag)
					{
						f.Call(trueOut);
					}
					else
					{
						f.Call(falseOut);
					}
				}
			}
		});
	}
}
