using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[ExecuteAlways]
public class BlisterController : MonoBehaviour
{
	public enum GameStatus
	{
		Start,
		Perform,
		Waterring,
		Paused,
		GameOver
	}

	private int columnCount = 4;

	private int rowCount = 4;

	private const float padding = 2.15f;

	public Vector3 starPos = new Vector3(2f, -0.25f, 0f);

	private BlisterNode[,] blisterNodes;

	public BlisterMap mapData;

	public GameObject blisterPrefab;

	public GameObject blisterBoomPrefab;

	public GameObject blisterRainPrefab;

	public GameObject blisterEvaporationPrefab;

	public GameObject blisterBulletPrefab;

	public GameObject mapBg;

	public GameStatus gameState;

	private GameStatus lastState;

	private List<BlisterBullet> bullutList;

	private SortedDictionary<int, bool> sortedDic = new SortedDictionary<int, bool>();

	private bool isAnim;

	public float outBoard = 1f;

	private int nowNum;

	private int nowBlisterNum;

	private int ComboNum;

	private int comboRewardNum = 99999999;

	private Dictionary<string, List<BlisterEntity>> resPool;

	public string ButtonName = "开始游戏";

	public int ColumnCount
	{
		get
		{
			return columnCount;
		}
		set
		{
			columnCount = value;
		}
	}

	public int RowCount
	{
		get
		{
			return rowCount;
		}
		set
		{
			rowCount = value;
		}
	}

	public static BlisterController Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
		blisterNodes = new BlisterNode[ColumnCount, RowCount];
		bullutList = new List<BlisterBullet>();
		resPool = new Dictionary<string, List<BlisterEntity>>();
	}

	public void PauseGame()
	{
		if (gameState != GameStatus.Paused)
		{
			lastState = gameState;
		}
		gameState = ((gameState == GameStatus.Paused) ? lastState : GameStatus.Paused);
	}

	private void Update()
	{
		if (!isAnim && sortedDic.Count > 0)
		{
			PauseGame();
			ShowScreenAnim();
		}
		else if (gameState != GameStatus.Start && gameState != GameStatus.Paused && gameState != GameStatus.GameOver)
		{
			if (gameState == GameStatus.Waterring)
			{
				CheckWatering();
			}
			else
			{
				CheckGameEnd();
			}
		}
	}

	public void LateUpdate()
	{
		ResetComboNum();
	}

	public void StartGame()
	{
		gameState = GameStatus.Start;
		InitResPool();
		ComboNum = 0;
		nowNum = mapData.blisterNum;
		comboRewardNum = mapData.comboReward;
		CreateBlisters();
		LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateNum", nowNum);
	}

	public void ReStartGame()
	{
		if (gameState == GameStatus.Perform || gameState == GameStatus.GameOver)
		{
			bullutList.Clear();
			gameState = GameStatus.Start;
			ComboNum = 0;
			sortedDic.Clear();
			CreateBlisters();
			InitResPool();
			nowNum = mapData.blisterNum;
			comboRewardNum = mapData.comboReward;
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateNum", nowNum);
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateScore", 4, 0);
		}
	}

	private void ChangeGameStatus(GameStatus state)
	{
		gameState = state;
	}

	private void CreateBlisters()
	{
		if (mapBg.transform.childCount > 0)
		{
			for (int num = mapBg.transform.childCount; num >= 1; num--)
			{
				Object.DestroyImmediate(mapBg.transform.GetChild(num - 1).gameObject);
			}
		}
		resPool.Clear();
		if (mapData.mapData == null)
		{
			Debug.Log("请设置地图数据：mapData");
			return;
		}
		ColumnCount = mapData.mapData.GetLength(0);
		RowCount = mapData.mapData.GetLength(1);
		blisterNodes = new BlisterNode[ColumnCount, RowCount];
		nowBlisterNum = ColumnCount * RowCount;
		float x = starPos.x + 7.5250006f - 2.15f * (float)ColumnCount / 2f;
		float y = starPos.y + 6.4500003f - 2.15f * (float)RowCount / 2f;
		for (int i = 0; i < ColumnCount; i++)
		{
			for (int j = 0; j < RowCount; j++)
			{
				GameObject gameObject = ((mapData.mapData[i, j].blisterNodeType == BlisterNodeType.boom) ? Object.Instantiate(blisterBoomPrefab, mapBg.transform) : ((mapData.mapData[i, j].blisterNodeType == BlisterNodeType.rain) ? Object.Instantiate(blisterRainPrefab, mapBg.transform) : ((mapData.mapData[i, j].blisterNodeType != BlisterNodeType.evaporation) ? Object.Instantiate(blisterPrefab, mapBg.transform) : Object.Instantiate(blisterEvaporationPrefab, mapBg.transform))));
				gameObject.name = "node_" + i + "_" + j;
				gameObject.transform.position = new Vector3(x, y, starPos.z) + new Vector3(2.15f * (float)i, 2.15f * (float)j, 0f);
				blisterNodes[i, j] = gameObject.transform.GetComponent<BlisterNode>();
				if (mapData.mapData[i, j].blisterNodeState == BlisterNodeState.Node4)
				{
					nowBlisterNum--;
					blisterNodes[i, j].isHide = true;
				}
				blisterNodes[i, j].SetData(i, j, mapData.mapData[i, j]);
			}
		}
		ChangeGameStatus(GameStatus.Perform);
	}

	private void CheckWatering()
	{
		int length = blisterNodes.GetLength(0);
		int length2 = blisterNodes.GetLength(1);
		for (int i = 0; i < length; i++)
		{
			for (int j = 0; j < length2; j++)
			{
				if (blisterNodes[i, j] != null)
				{
					CheckCollision(blisterNodes[i, j]);
				}
			}
		}
		if (bullutList.Count == 0)
		{
			ChangeGameStatus(GameStatus.Perform);
		}
	}

	private void DefaultSizedButton()
	{
		StartGame();
	}

	public void AddBlisterBoom(BlisterNode node)
	{
		Vector3 localPosition = node.transform.localPosition;
		for (int i = 0; i <= 7; i++)
		{
			BlisterEntity blisterEntity = RemoveFromDictionary("bullet");
			blisterEntity.transform.localPosition = localPosition;
			blisterEntity.name = node.gameObject.name + "_bullet" + i;
			BlisterBullet component = blisterEntity.transform.GetComponent<BlisterBullet>();
			if (component != null)
			{
				component.Belong = node;
				component.Direction = i;
			}
			bullutList.Add(component);
		}
		ChangeGameStatus(GameStatus.Waterring);
		UpdateBlisterCombo();
		Vector3 position = node.transform.position;
		LuaHelper.CallFunction("BlisterToluaBridge.OnBlisterWaterring", position.x, position.y, position.z, ComboNum);
	}

	public void SpecialBlisterBoom()
	{
		ChangeGameStatus(GameStatus.Waterring);
		UpdateBlisterCombo();
	}

	public void InitResPool()
	{
		for (int i = 0; i <= 20; i++)
		{
			BlisterBullet component = RemoveFromDictionary("bullet").transform.GetComponent<BlisterBullet>();
			AddToDictionary("bullet", component);
		}
	}

	public void ClearAll()
	{
		foreach (BlisterBullet bullut in bullutList)
		{
			AddToDictionary("bullet", bullut);
		}
		bullutList.Clear();
	}

	public void AddBlisterBullet(BlisterNode node)
	{
		Vector3 localPosition = node.transform.localPosition;
		for (int i = 0; i <= 3; i++)
		{
			BlisterEntity blisterEntity = RemoveFromDictionary("bullet");
			blisterEntity.transform.localPosition = localPosition;
			blisterEntity.name = node.gameObject.name + "_bullet" + i;
			BlisterBullet component = blisterEntity.transform.GetComponent<BlisterBullet>();
			if (component != null)
			{
				component.Belong = node;
				component.Direction = 2 * i;
			}
			bullutList.Add(component);
		}
		ChangeGameStatus(GameStatus.Waterring);
		UpdateBlisterCombo();
		Vector3 position = node.transform.position;
		LuaHelper.CallFunction("BlisterToluaBridge.OnBlisterWaterring", position.x, position.y, position.z, ComboNum);
	}

	public void RemoveBlisterBullet(BlisterBullet node)
	{
		if (bullutList.Count <= 0)
		{
			Debug.LogError("RemoveBlisterBullet error");
		}
		int index = bullutList.FindIndex((BlisterBullet blisterBullet) => blisterBullet.gameObject.name == node.gameObject.name);
		BlisterBullet value = bullutList[index];
		bullutList.RemoveAt(index);
		AddToDictionary("bullet", value);
		if (bullutList.Count == 0)
		{
			ChangeGameStatus(GameStatus.Perform);
		}
	}

	public void CheckGameEnd()
	{
		if (nowNum <= 0 || nowBlisterNum <= 0)
		{
			ChangeGameStatus(GameStatus.GameOver);
			if (nowNum > 0)
			{
				LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateScore", 1, nowNum);
			}
			else
			{
				LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateScore", 1, 0);
			}
			LuaHelper.CallFunction("BlisterToluaBridge.OnGameEnd", nowBlisterNum <= 0);
		}
	}

	public void CheckCollision(BlisterEntity obj)
	{
		List<BlisterEntity> list = new List<BlisterEntity>();
		for (int i = 0; i < bullutList.Count; i++)
		{
			BlisterNode blisterNode = (BlisterNode)obj;
			if (bullutList[i] != null && bullutList[i].Belong.name != obj.name && !blisterNode.IsBeBoomed() && obj.IsCollision(bullutList[i]))
			{
				list.Add(bullutList[i]);
				break;
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j] != null)
			{
				list[j].OnCollision(obj);
			}
		}
		if (list.Count > 0)
		{
			obj.OnCollision(list[0]);
		}
	}

	public void AddToDictionary(string key, BlisterEntity value)
	{
		value.transform.localPosition = new Vector3(1000f, 0f, 0f);
		List<BlisterEntity> valueFromResDictionary = GetValueFromResDictionary(key);
		if (valueFromResDictionary != null)
		{
			valueFromResDictionary.Add(value);
			resPool[key] = valueFromResDictionary;
		}
		else
		{
			valueFromResDictionary = new List<BlisterEntity>();
			valueFromResDictionary.Add(value);
			resPool.Add(key, valueFromResDictionary);
		}
	}

	public BlisterEntity RemoveFromDictionary(string key)
	{
		List<BlisterEntity> value = new List<BlisterEntity>();
		if (!resPool.ContainsKey(key))
		{
			resPool.Add(key, value);
		}
		value = GetValueFromResDictionary(key);
		if (value.Count > 0)
		{
			BlisterEntity result = value[0];
			value.RemoveAt(0);
			return result;
		}
		GameObject obj = Object.Instantiate(blisterBulletPrefab, mapBg.transform);
		obj.transform.localPosition = new Vector3(1000f, 0f, 0f);
		return obj.transform.GetComponent<BlisterEntity>();
	}

	public List<BlisterEntity> GetValueFromResDictionary(string key)
	{
		if (resPool.ContainsKey(key))
		{
			return resPool[key];
		}
		return null;
	}

	public bool CheckNodeOutOfBund(BlisterBullet node)
	{
		if (node == null)
		{
			return false;
		}
		Vector3 localPosition = node.transform.localPosition;
		float num = starPos.x + 7.5250006f - 2.15f * (float)ColumnCount / 2f;
		float num2 = starPos.y + 6.4500003f - 2.15f * (float)RowCount / 2f;
		float num3 = (float)ColumnCount * 2.15f + outBoard + num;
		float num4 = (float)RowCount * 2.15f + outBoard + num2;
		float num5 = starPos.x - outBoard;
		float num6 = starPos.y - outBoard;
		if (localPosition.x > num3 || localPosition.x < num5 || localPosition.y > num4 || localPosition.y < num6)
		{
			return true;
		}
		return false;
	}

	public bool CheckNodeOutOfBund1(BlisterBullet node)
	{
		if (node == null)
		{
			return false;
		}
		float x = node.Belong.transform.localPosition.x;
		float y = node.Belong.transform.localPosition.y;
		Vector3 localPosition = node.transform.localPosition;
		float num = x + 2.15f;
		float num2 = y + 2.15f;
		float num3 = x - 2.15f;
		float num4 = y - 2.15f;
		if (localPosition.x > num || localPosition.x < num3 || localPosition.y > num2 || localPosition.y < num4)
		{
			return true;
		}
		return false;
	}

	public void AddWater()
	{
		nowNum--;
		LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateNum", nowNum);
	}

	public void ChangenowBlisterNum()
	{
		LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateScore", 2, 1);
		nowBlisterNum--;
	}

	public void UpdateBlisterCombo()
	{
		if (gameState == GameStatus.Waterring)
		{
			ComboNum++;
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateComboNum", ComboNum);
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateScore", 5, ComboNum);
		}
	}

	public void ResetComboNum()
	{
		if (gameState == GameStatus.Perform && ComboNum != 0)
		{
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateScore", 3, ComboNum);
			nowNum += ComboNum / comboRewardNum;
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateNum", nowNum);
			ComboNum = 0;
			LuaHelper.CallFunction("BlisterToluaBridge.OnUpdateComboNum", ComboNum);
		}
	}

	public void ChangeNodeWater(bool isAdd)
	{
		int length = blisterNodes.GetLength(0);
		int length2 = blisterNodes.GetLength(1);
		for (int i = 0; i < length; i++)
		{
			for (int j = 0; j < length2; j++)
			{
				if (blisterNodes[i, j] != null && !blisterNodes[i, j].isHide)
				{
					if (isAdd)
					{
						blisterNodes[i, j].AddWater();
					}
					else
					{
						blisterNodes[i, j].ReduceWater();
					}
				}
			}
		}
	}

	public void BigNode()
	{
		LuaHelper.CallFunction("BlisterToluaBridge.BigNode");
	}

	public void LoadMap(string mapName)
	{
		mapData.LoadAsset(mapName);
	}

	public bool IsGameOver()
	{
		return gameState == GameStatus.GameOver;
	}

	public bool IsPerform()
	{
		return gameState == GameStatus.Perform;
	}

	public void AddSortedList(int posNum, bool isAdd)
	{
		if (!sortedDic.ContainsKey(posNum))
		{
			sortedDic.Add(posNum, isAdd);
		}
	}

	public void ShowScreenAnim()
	{
		KeyValuePair<int, bool> keyValue = sortedDic.ElementAtOrDefault(0);
		sortedDic.Remove(keyValue.Key);
		StartCoroutine(ShowAnim(keyValue));
	}

	public bool IsInAnim()
	{
		return isAnim;
	}

	private IEnumerator ShowAnim(KeyValuePair<int, bool> keyValue)
	{
		isAnim = true;
		LuaHelper.CallFunction(keyValue.Value ? "BlisterToluaBridge.ShowAddAnim" : "BlisterToluaBridge.ShowReduceAnim");
		yield return new WaitForSeconds(1f);
		gameState = lastState;
		ChangeNodeWater(keyValue.Value);
		yield return null;
		isAnim = false;
	}
}
