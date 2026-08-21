public interface IEntityComponent
{
	bool mIsEnable { get; set; }

	E_ComponentStatus mComponentStatus { get; set; }

	int mRunningTime { get; set; }

	int mTimeStep { get; set; }
}
