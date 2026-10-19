using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改轨迹Life时间", "Action", new string[] { "change", "trajectory", "life", "time" })]
public class ActionChangeTrajectoryLifeTime : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is IBulletEvt bulletEvt)
		{
			CompTrajectory? compTrajectory = bulletEvt.Bullet.GetCompTrajectory();
			compTrajectory.overrideLifeTime = (int)value.Return(memory);
			compTrajectory.isOverrideLifeTime = true;
		}
	}
}
