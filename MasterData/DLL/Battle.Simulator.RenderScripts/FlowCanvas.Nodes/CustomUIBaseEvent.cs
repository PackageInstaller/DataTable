using System;
using System.Collections.Generic;
using UnityEngine;

namespace FlowCanvas.Nodes;

public abstract class CustomUIBaseEvent : EffectCreateBaseNode
{
	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private FlowOutput _Init;

	private FlowOutput _Bind;

	private FlowOutput _Tick;

	private FlowOutput _Leave;

	private ValueInput<int> _RoleID;

	private ValueInput<string> _ChildPanelPathInput;

	private ValueInput<int> _AgentIDInput;

	private ValueInput<int> _BuffClassIDInput;

	private bool _EventInited;

	private GameObject _ChildPanel;

	private BuffManager _BuffManager;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		_EventInited = false;
		if (base.mSimContext.SimToPresentationEventSystem != null)
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntitySpawnedEvent>(OnEventHandler);
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			_BuffManager = battleScene.GetBuffManager();
			if (_BuffManager != null)
			{
				BuffManager buffManager = _BuffManager;
				buffManager.mBuffAddedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(buffManager.mBuffAddedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffAddedEventHandler));
				BuffManager buffManager2 = _BuffManager;
				buffManager2.mBuffRemovedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(buffManager2.mBuffRemovedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffRemovedEventHandler));
				BuffManager buffManager3 = _BuffManager;
				buffManager3.mBuffTickHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Combine(buffManager3.mBuffTickHandler, new OnVoidRefHandler<BuffState, int>(OnBuffTickEventHandler));
			}
		}
	}

	public override void OnGraphStoped()
	{
		_EventInited = false;
		if (_BuffManager != null)
		{
			BuffManager buffManager = _BuffManager;
			buffManager.mBuffAddedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Remove(buffManager.mBuffAddedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffAddedEventHandler));
			BuffManager buffManager2 = _BuffManager;
			buffManager2.mBuffRemovedHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Remove(buffManager2.mBuffRemovedHandler, new OnVoidRefHandler<BuffState, int>(OnBuffRemovedEventHandler));
			BuffManager buffManager3 = _BuffManager;
			buffManager3.mBuffTickHandler = (OnVoidRefHandler<BuffState, int>)Delegate.Remove(buffManager3.mBuffTickHandler, new OnVoidRefHandler<BuffState, int>(OnBuffTickEventHandler));
		}
		base.OnGraphStoped();
	}

	private void OnEventHandler(EntitySpawnedEvent eventReceived)
	{
		if (eventReceived.mIsPlayer && eventReceived.mConfigId == _RoleID.GetValue())
		{
			_EventInited = true;
			OnAgentInit(eventReceived);
		}
	}

	private void OnBuffAddedEventHandler(ref BuffState pBuffState, int EffectID)
	{
		if (!_EventInited)
		{
			return;
		}
		if (_ChildPanel == null)
		{
			if (string.IsNullOrEmpty(_ChildPanelPathInput.GetValue()))
			{
				_ChildPanel = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel");
			}
			else
			{
				_ChildPanel = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel/" + _ChildPanelPathInput.GetValue());
			}
		}
		if (!(_ChildPanel == null) && pBuffState.mBuffClassID == _BuffClassIDInput.GetValue())
		{
			OnBind(_ChildPanel, GetAssetPath(), ref pBuffState);
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			_Bind.Call(f);
		}
	}

	private void OnBuffTickEventHandler(ref BuffState pBuffState, int effectID)
	{
		if (_EventInited && pBuffState.mBuffClassID == _BuffClassIDInput.GetValue())
		{
			OnTick(ref pBuffState);
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			_Tick.Call(f);
		}
	}

	private void OnBuffRemovedEventHandler(ref BuffState pBuffState, int effectID)
	{
		if (_EventInited && pBuffState.mBuffClassID == _BuffClassIDInput.GetValue())
		{
			OnLeave(ref pBuffState);
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			_Leave.Call(f);
		}
	}

	protected abstract void AddCustomValueInput();

	protected abstract void OnAgentInit(EntitySpawnedEvent pEventReceived);

	protected abstract void OnBind(GameObject pPanel, string pPrefabPath, ref BuffState pBuffState);

	protected abstract void OnTick(ref BuffState pBuffState);

	protected abstract void OnLeave(ref BuffState pBuffState);

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_Init = AddFlowOutput("初始化", "init");
		_Bind = AddFlowOutput("增加", "Bind");
		_Tick = AddFlowOutput("触发", "Tick");
		_Leave = AddFlowOutput("移除", "Leave");
		_RoleID = AddValueInput<int>("实体类型ID", "roleID");
		_ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel");
		_BuffClassIDInput = AddValueInput<int>("类型(处理逻辑)ID", "buffClassID");
		AddCustomValueInput();
	}
}
