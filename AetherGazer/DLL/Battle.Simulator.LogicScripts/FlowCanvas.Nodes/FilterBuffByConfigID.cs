using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("筛选Buff(数值)", 0)]
[Category("Logic/Buff/通用")]
[Description("不可用于判断buff是否存在。根据节点输入信息，筛选指定实体身上的所有buff，并输出符合筛选条件的buff相关配置信息。本节点查表。\n<color=red>大量查询和比较，慎用</color>")]
public class FilterBuffByConfigID : FlowControlNode
{
	private int m_entityId;

	private int m_casterId;

	private int m_buffClassID;

	private int m_buffID;

	private int m_buffConfigID;

	private int m_buffIndex;

	private string m_subType;

	protected override void RegisterPorts()
	{
		FlowOutput DoOrTrue = AddFlowOutput("Do/True");
		FlowOutput DoneOrFalse = AddFlowOutput("Done/Flase");
		FlowOutput ErrorOut = AddFlowOutput("Error");
		ValueInput<int> EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> CasterIDInput = AddValueInput<int>("释放者ID", "casterID");
		ValueInput<int> BuffClassIDInput = AddValueInput<int>("Buff类型ID", "buffClassID");
		ValueInput<int> BuffIDInput = AddValueInput<int>("创建ID", "buffID");
		ValueInput<int> BuffConfigIDInput = AddValueInput<int>("配置ID", "buffConfigID").SetDefaultAndSerializedValue(-1);
		ValueInput<string> BuffSubTypeInput = AddValueInput<string>("子类型", "buffSubType");
		AddValueOutput("实体ID", () => m_entityId);
		AddValueOutput("释放者ID", () => m_casterId);
		AddValueOutput("Buff类型ID", () => m_buffClassID);
		AddValueOutput("创建ID", () => m_buffID);
		AddValueOutput("Buff配置ID", () => m_buffConfigID);
		AddValueOutput("子类型", () => m_subType);
		AddValueOutput("数组下标", () => m_buffIndex);
		AddFlowInput("开始遍历", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(EntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				ErrorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				DoneOrFalse.Call(f);
			}
			else
			{
				m_entityId = EntityIDInput.value;
				m_buffIndex = -1;
				int count = entityWithEntityID.entityBuff.mBuffID.Count;
				EntityBuff entityBuff = entityWithEntityID.entityBuff;
				for (int i = 0; i < count; i++)
				{
					if ((CasterIDInput.value == 0 || CasterIDInput.value == entityBuff.mBuffCasterArray[i]) && (BuffClassIDInput.value == 0 || BuffClassIDInput.value == entityBuff.mBuffClassIDArray[i]) && (BuffIDInput.value == 0 || BuffIDInput.value == entityBuff.mBuffID[i]) && (BuffConfigIDInput.value == -1 || BuffConfigIDInput.value == entityBuff.mBuffConfigID[i]))
					{
						int id = entityBuff.mBuffConfigID[i];
						if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(id, out var config) && (string.IsNullOrEmpty(BuffSubTypeInput.value) || BuffSubTypeComparer.ContainsAny(BuffSubTypeInput.value, config.SubType)))
						{
							m_casterId = entityBuff.mBuffCasterArray[i];
							m_buffClassID = entityBuff.mBuffClassIDArray[i];
							m_buffID = entityBuff.mBuffID[i];
							m_buffConfigID = entityBuff.mBuffConfigID[i];
							m_buffIndex = i;
							m_subType = config.SubType;
							DoOrTrue.Call(f);
						}
					}
				}
				DoneOrFalse.Call(f);
			}
		});
		AddFlowInput("查找首个", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(EntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				ErrorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				DoneOrFalse.Call(f);
			}
			else
			{
				m_entityId = EntityIDInput.value;
				m_buffIndex = -1;
				int count = entityWithEntityID.entityBuff.mBuffID.Count;
				EntityBuff entityBuff = entityWithEntityID.entityBuff;
				bool flag = false;
				for (int i = 0; i < count; i++)
				{
					if ((CasterIDInput.value == 0 || CasterIDInput.value == entityBuff.mBuffCasterArray[i]) && (BuffClassIDInput.value == 0 || BuffClassIDInput.value == entityBuff.mBuffClassIDArray[i]) && (BuffIDInput.value == 0 || BuffIDInput.value == entityBuff.mBuffID[i]) && (BuffConfigIDInput.value == -1 || BuffConfigIDInput.value == entityBuff.mBuffConfigID[i]))
					{
						int id = entityBuff.mBuffConfigID[i];
						if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(id, out var config) && (string.IsNullOrEmpty(BuffSubTypeInput.value) || BuffSubTypeComparer.ContainsAny(BuffSubTypeInput.value, config.SubType)))
						{
							m_casterId = entityBuff.mBuffCasterArray[i];
							m_buffClassID = entityBuff.mBuffClassIDArray[i];
							m_buffID = entityBuff.mBuffID[i];
							m_buffConfigID = entityBuff.mBuffConfigID[i];
							m_buffIndex = i;
							m_subType = config.SubType;
							flag = true;
							DoOrTrue.Call(f);
							break;
						}
					}
				}
				if (!flag)
				{
					DoneOrFalse.Call(f);
				}
			}
		});
	}
}
