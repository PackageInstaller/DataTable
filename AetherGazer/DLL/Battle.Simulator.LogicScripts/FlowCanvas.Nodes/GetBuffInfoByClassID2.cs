using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff信息(类型(处理逻辑)ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("获取buff信息, 找到他身上第一个这个ID的buff信息")]
public class GetBuffInfoByClassID2 : FlowControlNodeOfLogic
{
	private int _buffID;

	private int _buffRuntime;

	private int _buffCasterID;

	private int _during;

	private int _tick;

	private int _configID;

	private int _floor;

	private int _keepTime;

	private SimVar[] _buffParams = new SimVar[4];

	private int _index;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> classIDInput = AddValueInput<int>("类型(处理逻辑)ID", "BuffID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput falseOutput = AddFlowOutput("没有信息", "false");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = classIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOutput.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				falseOutput.Call(f);
			}
			else
			{
				EntityBuff entityBuff = entityWithEntityID.entityBuff;
				_index = AddBuff.GetBuffClassIDIndex(value, entityWithEntityID);
				if (_index == -1)
				{
					falseOutput.Call(f);
				}
				else
				{
					_buffID = entityBuff.mBuffID[_index];
					_buffRuntime = entityBuff.mBuffRuntime[_index];
					_buffCasterID = entityBuff.mBuffCasterArray[_index];
					_during = entityBuff.mDuringArray[_index];
					_tick = entityBuff.mTickArray[_index];
					_configID = entityBuff.mBuffConfigID[_index];
					_floor = entityBuff.mBuffFloor[_index];
					_keepTime = entityBuff.mBuffKeepTimeArray[_index];
					BuffParams buffParams = entityBuff.mBuffParamsArray[_index];
					_buffParams[0] = buffParams.v1;
					_buffParams[1] = buffParams.v2;
					_buffParams[2] = buffParams.v3;
					_buffParams[3] = buffParams.v4;
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("数组下标", "listIdnex", () => _index);
		AddValueOutput("创建ID", "buffID", () => _buffID);
		AddValueOutput("类型(处理逻辑)ID", "classID", () => classIDInput.value);
		AddValueOutput("下次调用剩余时长", "buffRuntime", () => _buffRuntime);
		AddValueOutput("释放者实体ID", "casterID", () => _buffCasterID);
		AddValueOutput("存活时长(毫秒)", "during", () => _during);
		AddValueOutput("触发间隔时长(毫秒)", "tick", () => _tick);
		AddValueOutput("配置ID", "buffConfigID", () => _configID);
		AddValueOutput("Buff层数", "floor", () => _floor);
		AddValueOutput("持续总长", "keepTime", () => _keepTime);
		AddValueOutput("参数1", "param1", () => _buffParams[0]);
		AddValueOutput("参数2", "param2", () => _buffParams[1]);
		AddValueOutput("参数3", "param3", () => _buffParams[2]);
		AddValueOutput("参数4", "param4", () => _buffParams[3]);
	}
}
