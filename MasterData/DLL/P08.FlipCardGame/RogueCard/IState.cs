namespace RogueCard;

public interface IState
{
	void Enter();

	void Update();

	void Exit();

	int GetIndex();

	bool GetIsEnterAni();
}
