using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(高级筛选)(渲染)", 0)]
[Category("Render/事件")]
[Description("以实体类型ID，Buff配置Id，BuffClassId筛选。0为忽略该项条件\n\n配置Id：public_buff表中的id列\n特效Id：public_buff表中的effect_id列")]
public class BuffRenderEventRoleAndConfig : EventNode
{
	private FlowOutput fBuffAdd;

	private FlowOutput fBuffRemove;

	private FlowOutput fBuffTick;

	private ValueInput<int> vInBuffConfigId;

	private ValueInput<int> vInRoleId;

	private ValueInput<int> vInBuffClass;

	private BuffManager buffManager;

	private int nOwner;

	private int nCaster;

	private int nBuffId;

	private int nBuffClass;

	private int nBuffConfig;

	private int nFloor;

	private int nEffectId;

	private SimVar mParam1;

	private SimVar mParam2;

	private SimVar mParam3;

	private SimVar mParam4;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && (buffManager = battleScene.GetBuffManager()) != null)
		{
			BuffManager obj = buffManager;
			obj.mBuffAddedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(obj.mBuffAddedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffAddedEventHandler));
			BuffManager obj2 = buffManager;
			obj2.mBuffRemovedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(obj2.mBuffRemovedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffRemovedEventHandler));
			BuffManager obj3 = buffManager;
			obj3.mBuffTickHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(obj3.mBuffTickHandler, new OnVoidRefHandler<BuffState, int>(OnBuffTickEventHandler));
		}
	}

	private void ApplyData(ref BuffState buffState)
	{
		nOwner = buffState.mBuffOwnerID;
		nCaster = buffState.mBuffCasterID;
		nBuffId = buffState.mBuffID;
		nBuffClass = buffState.mBuffClassID;
		nBuffConfig = buffState.mBuffConfigID;
		nFloor = buffState.mFloor;
		mParam1 = buffState.mBuffParams.v1;
		mParam2 = buffState.mBuffParams.v2;
		mParam3 = buffState.mBuffParams.v3;
		mParam4 = buffState.mBuffParams.v4;
	}

	private bool IsValidTarget(ref BuffState buffState)
	{
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(buffState.mBuffOwnerID);
		if (agent != null)
		{
			int value = vInRoleId.value;
			int value2 = vInBuffConfigId.value;
			int value3 = vInBuffClass.value;
			if ((value == 0 || agent.AgentConfigID == value) && (value3 == 0 || buffState.mBuffClassID == value3))
			{
				if (value2 != 0)
				{
					return buffState.mBuffConfigID == value2;
				}
				return true;
			}
			return false;
		}
		return false;
	}

	private void OnBuffTickEventHandler(ref BuffState buffState, int effectID)
	{
		if (IsValidTarget(ref buffState))
		{
			ApplyData(ref buffState);
			nEffectId = effectID;
			Flow flow = default(Flow);
			flow.returnData = returnData;
			flow.Call(fBuffTick);
		}
	}

	private void OnBuffAddedEventHandler(ref BuffState buffState, int effectID)
	{
		if (IsValidTarget(ref buffState))
		{
			ApplyData(ref buffState);
			nEffectId = effectID;
			Flow flow = default(Flow);
			flow.returnData = returnData;
			flow.Call(fBuffAdd);
		}
	}

	private void OnBuffRemovedEventHandler(ref BuffState buffState, int effectID)
	{
		if (IsValidTarget(ref buffState))
		{
			ApplyData(ref buffState);
			nEffectId = effectID;
			Flow flow = default(Flow);
			flow.returnData = returnData;
			flow.Call(fBuffRemove);
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		buffManager = null;
	}

	protected override void RegisterPorts()
	{
		fBuffAdd = AddFlowOutput("增加", "Buff添加");
		fBuffTick = AddFlowOutput("触发", "Buff触发");
		fBuffRemove = AddFlowOutput("移除", "Buff移除");
		vInBuffConfigId = AddValueInput<int>("配置ID", "config");
		vInRoleId = AddValueInput<int>("实体类型ID", "role");
		vInBuffClass = AddValueInput<int>("类型(处理逻辑)ID", "class");
		AddValueOutput("持有者实体ID", "owner", () => nOwner);
		AddValueOutput("释放者实体ID", "caster", () => nCaster);
		AddValueOutput("配置ID", "outConfig", () => nBuffConfig);
		AddValueOutput("类型(处理逻辑)ID", "outClass", () => nBuffClass);
		AddValueOutput("Buff特效Id", "renderId", () => nEffectId);
		AddValueOutput("Buff层数", "floor", () => nFloor);
		AddValueOutput("创建ID", "buffid", () => nBuffId);
		AddValueOutput("参数1", "param1", () => mParam1);
		AddValueOutput("参数2", "param2", () => mParam2);
		AddValueOutput("参数3", "param3", () => mParam3);
		AddValueOutput("参数4", "param4", () => mParam4);
	}
}
