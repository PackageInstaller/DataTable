using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[聚怪]聚怪", 0)]
[Category("Logic/游戏具体功能")]
[Description("具体聚性的行为逻辑\n可以通过移除Buff(创建ID)移除对应的聚怪Buff来提前结束聚怪效果")]
public class Gather : FlowNode
{
	public const int BUFF_CLASS = 309;

	public const int BUFF_EFFECTIVE_LEVEL = 901;

	private ValueInput<int> _entityIDInput;

	private ValueInput<Int3> _centerInput;

	private ValueInput<Int3> _centerOffsetInput;

	private ValueInput<Int3> _forwardInput;

	private ValueInput<RangeType> _rangeTypeInput;

	private ValueInput<int> _radiusInput;

	private ValueInput<int> _angleInput;

	private ValueInput<int> _lengthInput;

	private ValueInput<int> _widthInput;

	private ValueInput<int> _heightInput;

	private ValueInput<int> _speedInput;

	private ValueInput<int> _keepTimeInput;

	private int _buffID;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		base.mSimContext.GetService().mFCBuffService.AddBuffEventHandler(LogicBuffUpdate, isOnce: true);
	}

	private static void LogicBuffUpdate(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife, bool isTimeout)
	{
		SimEntity entityWithEntityID = AbilitiesProcessor.mSimContext.GetEntityWithEntityID(ownerID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
		{
			_ = entityWithEntityID.entityBuff.mBuffParamsArray[buffIndex];
			if (buffClass == 309)
			{
				Impl(entityWithEntityID, buffIndex);
			}
		}
	}

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID");
		_centerInput = AddValueInput<Int3>("中心点");
		_centerOffsetInput = AddValueInput<Int3>("中心偏移");
		_forwardInput = AddValueInput<Int3>("朝向");
		_rangeTypeInput = AddValueInput<RangeType>("范围类型");
		_radiusInput = AddValueInput<int>("半径");
		_angleInput = AddValueInput<int>("角度");
		_lengthInput = AddValueInput<int>("长");
		_widthInput = AddValueInput<int>("宽");
		_heightInput = AddValueInput<int>("高");
		_speedInput = AddValueInput<int>("绝对速度(毫米)");
		_keepTimeInput = AddValueInput<int>("持续时间");
		AddValueOutput("buffID", () => _buffID);
		FlowOutput output = AddFlowOutput("OUT");
		AddFlowInput("IN", delegate(Flow f)
		{
			Int3 @int = IntMath.Transform(_centerOffsetInput.value, _forwardInput.value, _centerInput.value);
			switch (_rangeTypeInput.value)
			{
			case RangeType.Sector:
			case RangeType.Roundness:
			{
				SimVar param2 = new Int3((int)_rangeTypeInput.value, _radiusInput.value, _angleInput.value);
				BuffProcessor.TryAddBuff(_entityIDInput.value, _entityIDInput.value, 309, 0, _keepTimeInput.value, 33, isOnce: false, isLoop: false, isOverride: false, @int, _forwardInput.value, param2, _speedInput.value, 0, 0, out _buffID);
				break;
			}
			case RangeType.Rectangle:
			{
				SimVar param = new Int3((int)_rangeTypeInput.value, _speedInput.value, 0);
				BuffProcessor.TryAddBuff(_entityIDInput.value, _entityIDInput.value, 309, 0, _keepTimeInput.value, 33, isOnce: false, isLoop: false, isOverride: false, @int, _forwardInput.value, param, new Int3(_lengthInput.value, _widthInput.value, _heightInput.value), 0, 0, out _buffID);
				break;
			}
			}
			output.Call(f);
		});
	}

	private static void ProcessGather(List<int> collisions, int speed, Int3 center)
	{
		for (int i = 0; i < collisions.Count; i++)
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
			if (!CommonProcessor.IsAliveRole(simEntityByMultiColliders) || !simEntityByMultiColliders.hasEntityConfig || !ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(simEntityByMultiColliders.ENTITY_CONFIG_ID, out var config) || !config.CanMove)
			{
				continue;
			}
			if (simEntityByMultiColliders.hasEntityBuff)
			{
				BuffRelationShipType relationShip = BuffRelationShip.GetRelationShip(simEntityByMultiColliders, 901);
				if (relationShip == BuffRelationShipType.RemoveSelf || relationShip == BuffRelationShipType.RemoveTogether)
				{
					continue;
				}
			}
			Int3 mPosition = simEntityByMultiColliders.entityPositon.mPosition;
			Int3 @int = center - mPosition;
			Int3 delta = ((speed < 0 || @int.sqrMagnitudeLong2D >= speed * speed) ? @int.NormalizeTo(speed) : @int);
			MovementProcessor.PathfindingMove(simEntityByMultiColliders, delta);
		}
	}

	private static void Impl(SimEntity simEntity, int buffIndex)
	{
		List<int> list = FrameListPool<int>.Claim();
		BuffParams buffParams = simEntity.entityBuff.mBuffParamsArray[buffIndex];
		Int3 int3Var = buffParams.v1.int3Var;
		Int3 int3Var2 = buffParams.v2.int3Var;
		Int3 int3Var3 = buffParams.v3.int3Var;
		RangeType x = (RangeType)int3Var3.x;
		if (((x == RangeType.Sector || x == RangeType.Roundness) && buffParams.v4.int3Var.y != 0) || (x == RangeType.Rectangle && int3Var3.z != 0))
		{
			return;
		}
		int speed = 0;
		uint num = 0u;
		InterestConfig config = ConfigHelper.GetInstance().GetConfig<InterestConfig>((int)simEntity.entityCamp.mRoleTypeCamp);
		for (int i = 0; i < config.Group.Count; i++)
		{
			if (config.Group.get_Item(i) != RoleType.Bunker)
			{
				num |= (uint)config.Group.get_Item(i);
			}
		}
		switch (x)
		{
		case RangeType.Sector:
		{
			int y2 = int3Var3.y;
			int z = int3Var3.z;
			SimPhysics.OverlapSector(int3Var, y2, z, int3Var2, list, num);
			speed = buffParams.v4.intVar;
			break;
		}
		case RangeType.Roundness:
		{
			int y = int3Var3.y;
			SimPhysics.Overlap(int3Var, y, list, num);
			speed = buffParams.v4.intVar;
			break;
		}
		case RangeType.Rectangle:
			SimPhysics.OverlapBox(int3Var, int3Var2, Int3.zero, buffParams.v4.int3Var, list, num);
			speed = int3Var3.y;
			break;
		}
		ProcessGather(list, speed, int3Var);
		FrameListPool<int>.Release(list);
	}
}
