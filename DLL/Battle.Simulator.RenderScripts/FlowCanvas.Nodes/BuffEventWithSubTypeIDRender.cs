using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(渲染)(子类型)", 0)]
[Category("Render/事件")]
[Description("渲染层绘制buff")]
public class BuffEventWithSubTypeIDRender : EventNode
{
	private BuffState mBuffState;

	private FlowOutput m_add;

	private FlowOutput m_tick;

	private FlowOutput m_remove;

	private ValueInput<string> m_subTypeInput;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public static bool ContainsAny(string subType, string configSubType)
	{
		if (string.IsNullOrEmpty(subType) || string.IsNullOrEmpty(configSubType))
		{
			return false;
		}
		if (!configSubType.Contains('$'))
		{
			return subType.Equals(configSubType, StringComparison.Ordinal);
		}
		string[] array = configSubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		string[] array2 = array;
		foreach (string value in array2)
		{
			if (subType.Equals(value, StringComparison.Ordinal))
			{
				return true;
			}
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		m_add = AddFlowOutput("增加", "进入");
		m_tick = AddFlowOutput("触发", "触发");
		m_remove = AddFlowOutput("移除", "结束");
		m_subTypeInput = AddValueInput<string>("子类型", "expectationSubType");
		AddValueOutput("持有者实体ID", "ownerID", () => mBuffState.mBuffOwnerID);
		AddValueOutput("释放者实体ID", "casterID", () => mBuffState.mBuffCasterID);
		AddValueOutput("类型(处理逻辑)ID", "buffClassID", () => mBuffState.mBuffClassID);
		AddValueOutput("参数1", "buffParam1", () => mBuffState.mBuffParams.v1);
		AddValueOutput("参数2", "buffParam2", () => mBuffState.mBuffParams.v2);
		AddValueOutput("参数3", "buffParam3", () => mBuffState.mBuffParams.v3);
		AddValueOutput("参数4", "buffParam4", () => mBuffState.mBuffParams.v4);
	}

	public override void OnGraphStarted()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene == null))
		{
			BuffManager buffManager = battleScene.GetBuffManager();
			if (buffManager != null)
			{
				buffManager.mBuffAddedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(buffManager.mBuffAddedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffAddedEventHandler));
				buffManager.mBuffRemovedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(buffManager.mBuffRemovedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffRemovedEventHandler));
				buffManager.mBuffTickHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(buffManager.mBuffTickHandler, new OnVoidRefHandler<BuffState, int>(OnBuffTickEventHandler));
			}
		}
	}

	private void OnBuffTickEventHandler(ref BuffState buffState, int effectID)
	{
		int mBuffConfigID = buffState.mBuffConfigID;
		if (mBuffConfigID != 0 && ConfigHelper.GetInstance().TryGetConfig<public_buff>(mBuffConfigID, out var config) && ContainsAny(m_subTypeInput.value, config.SubType))
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			m_tick.Call(f);
		}
	}

	private void OnBuffRemovedEventHandler(ref BuffState buffState, int param2)
	{
		int mBuffConfigID = buffState.mBuffConfigID;
		if (mBuffConfigID != 0 && ConfigHelper.GetInstance().TryGetConfig<public_buff>(mBuffConfigID, out var config) && ContainsAny(m_subTypeInput.value, config.SubType))
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			m_remove.Call(f);
		}
	}

	private void OnBuffAddedEventHandler(ref BuffState buffState, int param2)
	{
		int mBuffConfigID = buffState.mBuffConfigID;
		if (mBuffConfigID != 0 && ConfigHelper.GetInstance().TryGetConfig<public_buff>(mBuffConfigID, out var config) && ContainsAny(m_subTypeInput.value, config.SubType))
		{
			mBuffState = buffState;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			m_add.Call(f);
		}
	}
}
