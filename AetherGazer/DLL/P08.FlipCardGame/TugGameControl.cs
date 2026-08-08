using UnityEngine;

public class TugGameControl : MonoBehaviour
{
	public enum GameStatus
	{
		Start,
		Playing,
		Paused,
		GameOver
	}

	public Transform maomaoTrans;

	public Transform selfTrans;

	public Transform enemyTrans;

	public float distanceSpeed = 10f;

	public float time;

	public int rowCount;

	private TugEnemy enemyTug;

	private TugSelf selfTug;

	private TugMaoMao maomaoTug;

	public GameStatus state;

	private TugInfo info1;

	private TugInfo info2;

	private TugSkillInfo[] skillInfo;

	private string ButtonName = "开始游戏";

	private string ButtonName1 = "重置游戏";

	public static TugGameControl Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
	}

	private void Start()
	{
		state = GameStatus.Start;
	}

	public void StartGame()
	{
		time = 0f;
		SetData();
		state = GameStatus.Playing;
	}

	public void RestartGame()
	{
		maomaoTug.ResetState();
		StartGame();
	}

	private void Update()
	{
	}

	public void CaculateSpeed()
	{
		float enemySpeed = enemyTug.GetEnemySpeed();
		float selfSpeed = selfTug.GetSelfSpeed();
		float x = maomaoTrans.position.x;
		float num = 0f;
		num = ((!(x > 0f)) ? ((0f - x) / distanceSpeed) : (x / distanceSpeed));
		float speed = 0f - enemySpeed + selfSpeed + num;
		Debug.Log("CaculateSpeed " + num + " " + enemySpeed + " " + selfSpeed + " " + speed);
		maomaoTug.SetSpeed(speed);
	}

	public bool IsCollision(Transform otherObj)
	{
		return Vector3.Distance(base.transform.position, otherObj.position) <= 0.5f;
	}

	public float GetNowTime()
	{
		return time;
	}

	public void SetSkil1()
	{
	}

	public void CheckGameEnd()
	{
		float x = maomaoTrans.position.x;
		float x2 = enemyTrans.position.x;
		float x3 = selfTrans.position.x;
		if (x <= x2 || x > x3)
		{
			maomaoTug.Speed = 0f;
			state = GameStatus.GameOver;
			Debug.Log("GameEnd");
		}
	}

	public void SetData()
	{
		if (selfTug != null)
		{
			selfTug.SetData(info1, skillInfo);
			enemyTug.SetData(info2);
		}
	}

	public void SetSpeed(float speed)
	{
		selfTug.SetSpeed(speed);
	}

	public TugGameData LoadAsset(string fileFullName)
	{
		string text = "Map/TugGame/" + fileFullName;
		TugGameData tugGameData = Object.Instantiate(Asset.Load<TugGameData>(text));
		if (tugGameData != null)
		{
			distanceSpeed = tugGameData.offset;
			info1 = tugGameData.info1;
			info2 = tugGameData.info2;
			skillInfo = tugGameData.skillInfo.ToArray();
			Debug.Log("Asset loaded successfully: " + tugGameData.name);
		}
		else
		{
			Debug.LogError("Failed to load asset at path: " + text);
		}
		return tugGameData;
	}
}
