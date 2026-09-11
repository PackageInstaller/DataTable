internal interface IFloGameplay
{
	void StartGame(FloGameData gameData);

	void StopGame(FloGameData gameData);

	void Tick(FloGameData gameData);
}
