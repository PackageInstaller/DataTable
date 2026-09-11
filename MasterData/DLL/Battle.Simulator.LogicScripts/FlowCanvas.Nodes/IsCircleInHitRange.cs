using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("是否和判定范围相交", 0)]
[Category("Logic/AI")]
[Description("是否和判定范围相交")]
public class IsCircleInHitRange : FlowNode
{
	private SimSphere target = new SimSphere();

	private SimBox simBox = new SimBox();

	private SimCylinderSector cylinderSector = new SimCylinderSector();

	public bool IsPointInRect(Int3 center, Int3 fwd, int width, int length, Int3 point)
	{
		Matrix4x4 identity = Matrix4x4.identity;
		Quaternion q = Quaternion.FromToRotation(Vector3.forward, (Vector3)fwd);
		identity.SetTRS((Vector3)center, q, new Vector3((float)width / 1000f, 1f, (float)length / 1000f));
		identity = identity.inverse;
		Vector4 vector = (Vector3)point;
		vector.w = 1f;
		vector = identity * vector;
		if ((double)vector.x > -0.5 && (double)vector.x < 0.5)
		{
			return ((double)vector.z > -0.5) & ((double)vector.z < 0.5);
		}
		return false;
	}

	public bool IsPointInRect(Int3 center, Int3 fwd, int width, int length, Int3 point, int r)
	{
		SimSphere simSphere = target;
		simSphere.Pos = point;
		simSphere.Radius = r;
		simSphere.UpdateWorldShape(point, Int3.forward);
		SimBox simBox = this.simBox;
		simBox.Center = center;
		simBox.Size = new Int3(width, 1000, length);
		simBox.UpdateWorldShape(center, fwd);
		return simSphere.Intersects(simBox);
	}

	public bool IsPointInSector(Int3 center, int r, int degree, Int3 castDirection, Int3 point, int r2)
	{
		SimCylinderSector simCylinderSector = cylinderSector;
		simCylinderSector.WorldPos = center;
		simCylinderSector.Radius = r;
		simCylinderSector.Degree = degree;
		simCylinderSector.Rotation = IntMath.AngleOfVector(castDirection).i;
		simCylinderSector.UpdateWorldShape(center, castDirection);
		SimSphere simSphere = target;
		simSphere.Pos = point;
		simSphere.Radius = r2;
		simSphere.UpdateWorldShape(point, Int3.forward);
		return simSphere.Intersects(simCylinderSector);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<Int3> posInput = AddValueInput<Int3>("位置");
		ValueInput<int> distanceInput = AddValueInput<int>("半径");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (entityWithEntityID.entityActionAbility.mHitIndex >= 0 && entityWithEntityID.entityActionAbility.mHitIndex < config.HitTimeList.Count)
				{
					HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(entityWithEntityID.entityActionAbility.mHitIndex);
					if (RangeType.Sector == hitCheckInfo.RangeType)
					{
						Int3 center = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
						if (IsPointInSector(center, hitCheckInfo.Radius, hitCheckInfo.Angle, entityWithEntityID.entityPositon.mForward, posInput.value, distanceInput.value))
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
						if ((IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition) - posInput.value).sqrMagnitudeLong < (distanceInput.value + hitCheckInfo.Radius) * (distanceInput.value + hitCheckInfo.Radius))
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
						Int3 center2 = IntMath.Transform(new Int3(hitCheckInfo.CenterOffset.X, 0, hitCheckInfo.CenterOffset.Z), entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
						if (IsPointInRect(center2, entityWithEntityID.entityPositon.mForward, hitCheckInfo.Width, hitCheckInfo.Length, posInput.value, distanceInput.value))
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
