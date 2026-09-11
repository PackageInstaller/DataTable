namespace BilliardGame.Runtime;

public interface IMechanismTrigger
{
	void BeCollision(BilliardGameEntityBase other);

	void OnRoundStart();
}
