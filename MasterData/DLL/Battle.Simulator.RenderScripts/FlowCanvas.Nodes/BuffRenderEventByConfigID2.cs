using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(Buff渲染ID)(渲染)SimVar", 0)]
[Category("Render/事件")]
[Description("Buff渲染ID对应【public_buff】中的【effect_id】字段;\n该方法用于处理buff表ID对应的Buff的处理逻辑")]
public class BuffRenderEventByConfigID2 : EventNode
{
	private FlowOutput mBuffAdded;

	private FlowOutput mBuffRemoved;

	private FlowOutput mBuffTick;

	private ValueInput<int> mBuffConfigID;

	private BuffState mBuffState;

	private BuffManager buffManager;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

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

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		buffManager = null;
	}

	private void OnBuffTickEventHandler(ref BuffState buffState, int effectID)
	{
		if (buffState.mBuffConfigID != 0 && effectID == mBuffConfigID.GetValue())
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mBuffTick.Call(f);
		}
	}

	private void OnBuffRemovedEventHandler(ref BuffState buffState, int effectID)
	{
		if (buffState.mBuffConfigID != 0 && effectID == mBuffConfigID.GetValue())
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mBuffRemoved.Call(f);
		}
	}

	private void OnBuffAddedEventHandler(ref BuffState buffState, int effectID)
	{
		if (buffState.mBuffConfigID != 0 && effectID == mBuffConfigID.GetValue())
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mBuffAdded.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		mBuffAdded = AddFlowOutput("增加", "buff添加");
		mBuffTick = AddFlowOutput("触发", "buff触发");
		mBuffRemoved = AddFlowOutput("移除", "buff移除");
		mBuffConfigID = AddValueInput<int>("Buff渲染ID", "特效ID");
		AddValueOutput("持有者实体ID", "实体ID", () => mBuffState.mBuffOwnerID);
		AddValueOutput("释放者实体ID", "添加者ID", () => mBuffState.mBuffCasterID);
		AddValueOutput("创建ID", "buff识别编号", () => mBuffState.mBuffID);
		AddValueOutput("配置ID", "buffID", () => mBuffState.mBuffConfigID);
		AddValueOutput("buff参数1", () => mBuffState.mBuffParams.v1);
		AddValueOutput("buff参数2", () => mBuffState.mBuffParams.v2);
		AddValueOutput("buff参数3", () => mBuffState.mBuffParams.v3);
		AddValueOutput("buff参数4", () => mBuffState.mBuffParams.v4);
	}
}
