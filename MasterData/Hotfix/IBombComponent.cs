using TrueSync;

public interface IBombComponent
{
	bool KeepAlive { get; set; }

	void Setup();

	void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP));

	void Finish();
}
