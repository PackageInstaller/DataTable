using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("绘制实体事件", 0)]
[Category("Common/事件")]
[Description("创建实体事件 包含该逻辑创建和渲染创建")]
public class SpawnMonsterEvent : EventNode
{
	private FlowOutput spawnOutput;

	private uint mAgentCamp;

	private int mConfigId;

	private int mGuid;

	private bool mIsPlayer;

	private bool mLockWhenNotMoving;

	private bool mNeedRVO;

	private Int3 mSpawnForward;

	private Int3 mSpawnPoint;

	private Int3 mSpawnSize;

	private E_SpawnType mSpawnType;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		spawnOutput = AddFlowOutput("输出");
		AddValueOutput("实体阵营：", () => mAgentCamp);
		AddValueOutput("实体配置信息：", () => mConfigId);
		AddValueOutput("实体唯一ID：", () => mGuid);
		AddValueOutput("是否玩家：", () => mIsPlayer);
		AddValueOutput("不移动实时是否锁定：", () => mLockWhenNotMoving);
		AddValueOutput("是否需要RVO：", () => mNeedRVO);
		AddValueOutput("初始出生朝向：", () => mSpawnForward);
		AddValueOutput("初始出生点：", () => mSpawnPoint);
		AddValueOutput("初始出生尺寸：", () => mSpawnSize);
		AddValueOutput("单位类型：", () => mSpawnType);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.GetValue())
		{
			base.mSimContext.SimEventSystem.AddHandler<EntitySpawnedEvent>(OnSpawnUnitEventHandler);
		}
		else if (base.mSimContext.SimToPresentationEventSystem != null)
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler);
		}
	}

	private void SetData(EntitySpawnedEvent triggerEvent)
	{
		mAgentCamp = triggerEvent.mAgentCamp;
		mConfigId = triggerEvent.mConfigId;
		mGuid = triggerEvent.NewEntity;
		mIsPlayer = triggerEvent.mIsPlayer;
		mLockWhenNotMoving = triggerEvent.mLockWhenNotMoving;
		mNeedRVO = triggerEvent.mNeedRVO;
		mSpawnForward = triggerEvent.mSpawnForward;
		mSpawnPoint = triggerEvent.mSpawnPoint;
		mSpawnSize = triggerEvent.mSpawnSize;
	}

	private void OnSpawnUnitEventHandler(EntitySpawnedEvent triggerEvent)
	{
		if (triggerEvent.mSpawnType == E_SpawnType.ROLE)
		{
			SetData(triggerEvent);
			Flow f = new Flow
			{
				returnData = returnData
			};
			spawnOutput.Call(f);
		}
	}

	private void OnSpawnUnitRenderEventHandler(EntitySpawnedEvent triggerEvent)
	{
		if (triggerEvent.mSpawnType == E_SpawnType.ROLE)
		{
			SetData(triggerEvent);
			Flow f = new Flow
			{
				returnData = returnData
			};
			spawnOutput.Call(f);
		}
	}
}
