using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断实体碰撞表面距离", 0)]
[Category("Logic/PosAndRot")]
[Description("判断实体间距离(关心多碰撞盒，大于等于小于)")]
public class IsTargetInRangeWithGreaterOrLessCareMoreConllision : IsTargetInRangeWithGreaterOrLessBase
{
	protected override void Check(Flow f, SimEntity entity, SimEntity aimEntity, int range)
	{
		AIProcessor.GetNearestCollisionData(entity, aimEntity, aimEntity.entityCamp.mRoleTypeCamp, out var minDistance);
		if (minDistance < range)
		{
			_lessOut.Call(f);
		}
		else if (minDistance == range)
		{
			_equalsOut.Call(f);
		}
		else
		{
			_greaterOut.Call(f);
		}
	}
}
