using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否和判定范围相交(矩形)", 0)]
[Category("Logic/AI")]
[Description("是否和判定范围相交")]
public class IsRectInHitRange : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<Int3> posStartInput = AddValueInput<Int3>("起点");
		ValueInput<Int3> posEndInput = AddValueInput<Int3>("终点");
		ValueInput<int> distanceInput = AddValueInput<int>("宽度");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		SimBox target = new SimBox();
		SimCylinderSector selector = new SimCylinderSector();
		SimSphere sp = new SimSphere();
		SimBox rect = new SimBox();
		AddFlowInput("", delegate(Flow f)
		{
			Int3 forward = (-posStartInput.value + posEndInput.value).NormalizeTo(1000);
			Int3 worldPosition = (posStartInput.value + posEndInput.value) / 2f;
			target.Center = posStartInput.value;
			target.Size = new Int3(distanceInput.value, 1000, (posStartInput.value - posEndInput.value).magnitude2D);
			target.UpdateWorldShape(worldPosition, forward);
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (entityWithEntityID.entityActionAbility.mHitIndex >= 0 && entityWithEntityID.entityActionAbility.mHitIndex < config.HitTimeList.Count)
				{
					HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(entityWithEntityID.entityActionAbility.mHitIndex);
					if (entityWithEntityID.entityActionAbility.mLogicTime < hitCheckInfo.Start || entityWithEntityID.entityActionAbility.mLogicTime > hitCheckInfo.Start + hitCheckInfo.Duration)
					{
						f.Call(falseOut);
					}
					else if (RangeType.Sector == hitCheckInfo.RangeType)
					{
						Int3 @int = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
						selector.WorldPos = @int;
						selector.Radius = hitCheckInfo.Radius;
						selector.Degree = hitCheckInfo.Angle;
						selector.Rotation = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward).i;
						selector.UpdateWorldShape(@int, entityWithEntityID.entityPositon.mForward);
						if (selector.Intersects(target))
						{
							f.Call(trueOut);
						}
						else
						{
							f.Call(falseOut);
						}
					}
					else if (RangeType.Roundness == hitCheckInfo.RangeType)
					{
						Int3 int2 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
						sp.Pos = int2;
						sp.Radius = hitCheckInfo.Radius;
						sp.UpdateWorldShape(int2, Int3.forward);
						if (sp.Intersects(target))
						{
							f.Call(trueOut);
						}
						else
						{
							f.Call(falseOut);
						}
					}
					else if (RangeType.Rectangle == hitCheckInfo.RangeType)
					{
						Int3 int3 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
						rect.Center = int3;
						rect.Size = new Int3(hitCheckInfo.Width, 1000, hitCheckInfo.Length);
						rect.UpdateWorldShape(int3, entityWithEntityID.entityPositon.mForward);
						if (rect.Intersects(target))
						{
							f.Call(trueOut);
						}
						else
						{
							f.Call(falseOut);
						}
					}
				}
				else
				{
					f.Call(falseOut);
				}
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
