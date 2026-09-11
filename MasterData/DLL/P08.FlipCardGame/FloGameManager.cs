using UnityEngine;

public class FloGameManager : MonoBehaviour
{
	public FloLoopScroller loopScroller1;

	public FloLoopScroller loopScroller2;

	public FloBlurPlay blurPlay;

	public FloSpinPlay spinPlay;

	private static FloGameManager _instance;

	private FloGameData _gameData = new FloGameData();

	private bool _gameing;

	public FloGameData gameData => _gameData;

	public static FloGameManager instance => _instance;

	private void Awake()
	{
		if (_instance != null)
		{
			Debug.LogError("FloGameManager already has an instance!");
		}
		_instance = this;
	}

	private void OnDestroy()
	{
		if (_instance == this)
		{
			_instance = null;
		}
	}

	public void StartGame()
	{
		_gameing = true;
		loopScroller1.InitRandomValue();
		loopScroller2.InitRandomValue();
		FloGameType gameType = gameData.gameType;
		blurPlay.gameObject.SetActive(gameType == FloGameType.Focus);
		spinPlay.gameObject.SetActive(gameType == FloGameType.Stable);
		GetGameplay()?.StartGame(_gameData);
	}

	public void StopGame()
	{
		_gameing = false;
		GetGameplay()?.StopGame(_gameData);
	}

	private void Update()
	{
		if (_gameing)
		{
			CollectInput();
			UpdatePlay();
		}
	}

	private void CollectInput()
	{
		float num = Mathf.PingPong(loopScroller1.curValue * 2f, 1f);
		float num2 = Mathf.PingPong(loopScroller2.curValue * 2f, 1f);
		_gameData.value1 = 1f - num;
		_gameData.value2 = 1f - num2;
	}

	private IFloGameplay GetGameplay()
	{
		return _gameData.gameType switch
		{
			FloGameType.Stable => spinPlay, 
			FloGameType.Focus => blurPlay, 
			_ => null, 
		};
	}

	private void UpdatePlay()
	{
		GetGameplay()?.Tick(_gameData);
	}
}
