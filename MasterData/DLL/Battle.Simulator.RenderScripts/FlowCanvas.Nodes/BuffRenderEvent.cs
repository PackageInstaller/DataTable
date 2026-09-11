using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(渲染)", 0)]
[Category("Render/事件")]
[Description("渲染层绘制buff")]
public class BuffRenderEvent : EventNode
{
	protected FlowOutput mBuffAdded;

	protected FlowOutput mBuffRemoved;

	protected FlowOutput mBuffTick;

	protected ValueInput<int> mBuffClassID;

	protected BuffManager buffManager;

	protected BuffState mBuffState;

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
		if (mBuffTick != null && buffState.mBuffClassID == mBuffClassID.GetValue())
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mBuffTick.Call(f);
		}
	}

	private void OnBuffAddedEventHandler(ref BuffState buffState, int effectID)
	{
		if (mBuffAdded != null && buffState.mBuffClassID == mBuffClassID.GetValue())
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mBuffAdded.Call(f);
		}
	}

	private void OnBuffRemovedEventHandler(ref BuffState buffState, int effectID)
	{
		if (mBuffRemoved != null && buffState.mBuffClassID == mBuffClassID.GetValue())
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mBuffRemoved.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		mBuffAdded = AddFlowOutput("增加", "buff添加");
		mBuffTick = AddFlowOutput("触发", "buff触发");
		mBuffRemoved = AddFlowOutput("移除", "buff移除");
		mBuffClassID = AddValueInput<int>("类型(处理逻辑)ID", "期望表现的buff类型ID");
		AddValueOutput("持有者实体ID", "实体", () => mBuffState.mBuffOwnerID);
		AddValueOutput("释放者实体ID", "添加者ID", (ValueHandler<SimVar>)(() => mBuffState.mBuffCasterID));
		AddValueOutput("创建ID", "buffID", (ValueHandler<SimVar>)(() => mBuffState.mBuffID));
		AddValueOutput("类型(处理逻辑)ID", "buff类型", (ValueHandler<SimVar>)(() => mBuffState.mBuffClassID));
		AddValueOutput("剩余时长", () => mBuffState.mDuring);
		AddValueOutput("总时长", () => mBuffState.mBuffKeepTime);
		AddValueOutput("buff参数1", (ValueHandler<int>)(() => mBuffState.mBuffParams.v1), "");
		AddValueOutput("buff参数2", (ValueHandler<int>)(() => mBuffState.mBuffParams.v2), "");
		AddValueOutput("buff参数3", (ValueHandler<int>)(() => mBuffState.mBuffParams.v3), "");
		AddValueOutput("buff参数4", (ValueHandler<int>)(() => mBuffState.mBuffParams.v4), "");
	}
}
