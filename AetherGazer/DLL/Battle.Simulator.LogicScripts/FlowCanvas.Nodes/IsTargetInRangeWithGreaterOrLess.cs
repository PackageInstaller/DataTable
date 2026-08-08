using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("简单判断实体间距离", 0)]
[Category("Logic/PosAndRot")]
[Description("判断实体间距离，不考虑多碰撞盒的情况")]
public class IsTargetInRangeWithGreaterOrLess : IsTargetInRangeWithGreaterOrLessBase
{
	protected override void Check(Flow f, SimEntity entity, SimEntity aimEntity, int range)
	{
		long num = MovementProcessor.SqrDistance(entity, aimEntity);
		int num2 = range * range;
		if (num < num2)
		{
			_lessOut.Call(f);
		}
		else if (num == num2)
		{
			_equalsOut.Call(f);
		}
		else
		{
			_greaterOut.Call(f);
		}
	}
}
