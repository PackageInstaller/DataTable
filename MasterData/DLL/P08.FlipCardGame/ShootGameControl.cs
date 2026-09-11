using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Sirenix.OdinInspector;
using UnityEngine;

public class ShootGameControl : SerializedMonoBehaviour
{
	public enum GameStatus
	{
		Start,
		Playing,
		Paused,
		GameOver
	}

	public int addScore;

	public int superScore;

	public int reduceScore;

	private int score;

	public int MaxGameTime;

	private float time;

	private float nowCd;

	public float cd;

	[SerializeField]
	public float[] campRate;

	[HideInInspector]
	public int hitNum1;

	[HideInInspector]
	public int hitNum2;

	[HideInInspector]
	public int hitNum3;

	public GameStatus state;

	private Transform[] posArray;

	private List<ShootGameTarget> bulletObjectList;

	private List<ShootGameTarget> tarObjectList;

	[HideInInspector]
	public GameObject tarObj;

	[HideInInspector]
	public GameObject bulletObj;

	public float spawnInterval;

	private Dictionary<string, List<ShootGameTarget>> resPool;

	private Transform gameParent;

	public Transform shoot;

	[SerializeField]
	public Dictionary<float, ShootGameSetting> timeSplitDic;

	public float[] randomRange;

	private int stateIndex;

	private float selftimeKey;

	private List<Coroutine> coroutines;

	public float bulletSpeed;

	[SerializeField]
	private float[] skillRange;

	[HideInInspector]
	[SerializeField]
	private int superAnger;

	[SerializeField]
	private int angerCost;

	[SerializeField]
	private int angerMax;

	private System.Random rand;

	private string ButtonName;

	private string ButtonName2;

	private string ButtonName1;

	private string ButtonName3;

	public static ShootGameControl Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
		if (tarObj == null)
		{
			tarObj = base.transform.Find("game/TargetObj").gameObject;
		}
		bulletObjectList = new List<ShootGameTarget>();
		tarObjectList = new List<ShootGameTarget>();
		score = 0;
		posArray = new Transform[3];
		for (int i = 1; i <= 3; i++)
		{
			Transform transform = base.transform.Find("game/layer/" + i);
			posArray[i - 1] = transform;
		}
		gameParent = base.transform.Find("game");
		resPool = new Dictionary<string, List<ShootGameTarget>>();
		int seed = (int)DateTime.Now.Ticks % int.MaxValue;
		rand = new System.Random(seed);
	}

	private IEnumerator SpawnObjects(int pos)
	{
		while (true)
		{
			float num = (float)Math.Round((float)(new System.Random().NextDouble() * (double)(randomRange[0] - randomRange[0]) + (double)randomRange[0]), 1);
			int num2 = 1;
			foreach (float key in timeSplitDic.Keys)
			{
				if (time >= key)
				{
					selftimeKey = key;
					num2++;
				}
			}
			List<float> settingList = timeSplitDic[selftimeKey].settingList;
			List<float> moveSpeed = timeSplitDic[selftimeKey].moveSpeed;
			float moveSpeed2 = settingList[pos] * num;
			float num3 = moveSpeed[pos] * num;
			if (Instance.state == GameStatus.Playing)
			{
				SpawnObject(pos, moveSpeed2, num2);
			}
			float a = ((Application.targetFrameRate < 30) ? (Time.deltaTime / 0.016f) : 1f);
			a = Mathf.Min(a, 2.5f);
			yield return new WaitForSeconds(num3 * a);
		}
	}

	private void StopObjAllCoroutines()
	{
		foreach (Coroutine coroutine in coroutines)
		{
			if (coroutine != null)
			{
				StopCoroutine(coroutine);
			}
		}
		coroutines.Clear();
	}

	private void SpawnObject(int randPos1, float moveSpeed, int phaseNum)
	{
		GenerateRandomNumber(1, 3);
		int num = GenerateRandomNumber(1, 4);
		int num2 = GenerateRandomNumber(1, 101, randPos1);
		int num3 = 0;
		float num4 = 0f;
		for (int i = 0; i < campRate.Length; i++)
		{
			if ((float)num2 >= num4)
			{
				num3 = i;
			}
			num4 += campRate[i] * 10f;
		}
		ShootGameTarget shootGameTarget = RemoveFromDictionary("target");
		Transform transform = posArray[randPos1].Find("pos2");
		Transform endPos = posArray[randPos1].Find("pos1");
		shootGameTarget.transform.localPosition = new Vector3(transform.position.x, 0f, transform.position.z);
		shootGameTarget.Direction = 4;
		ShootTarget shootTarget = shootGameTarget as ShootTarget;
		shootTarget.endPos = endPos;
		shootTarget.IsSameCamp = num3 != 0 && num3 != 1 && phaseNum <= 2;
		GameObject gameObject = shootTarget.transform.Find("tarShow2").gameObject;
		GameObject obj = shootTarget.transform.Find("tarShow1").gameObject;
		ShootTarget obj2 = shootGameTarget as ShootTarget;
		obj2.SetModelShow((num3 == 1) ? 4 : num);
		obj2.IsSuper = num3 == 1;
		obj2.Speed = moveSpeed;
		obj2.ResetEffect();
		gameObject.SetActive(shootTarget.IsSameCamp);
		obj.SetActive(!shootTarget.IsSameCamp);
		tarObjectList.Add(shootGameTarget);
	}

	private void Start()
	{
		InitResPool();
		state = GameStatus.Start;
	}

	public void StartGame()
	{
		time = 0f;
		hitNum1 = 0;
		hitNum2 = 0;
		hitNum3 = 0;
		selftimeKey = 0f;
		superAnger = 0;
		state = GameStatus.Playing;
		for (int i = 0; i < 3; i++)
		{
			coroutines.Add(StartCoroutine(SpawnObjects(i)));
		}
	}

	public void PlaySkill()
	{
		if (angerCost > superAnger)
		{
			return;
		}
		int num = 0;
		superAnger -= angerCost;
		ShootGameTarget[] array = tarObjectList.ToArray();
		foreach (ShootGameTarget shootGameTarget in array)
		{
			Vector3 localPosition = shootGameTarget.transform.localPosition;
			if (localPosition.x >= skillRange[0] && localPosition.x <= skillRange[1])
			{
				RemoveShootGameTarget("target", shootGameTarget);
				ShootTarget shootTarget = shootGameTarget as ShootTarget;
				num += (shootTarget.IsSameCamp ? reduceScore : (shootTarget.IsSuper ? superScore : addScore));
				if (shootTarget.IsSameCamp)
				{
					hitNum2++;
				}
				else if (shootTarget.IsSuper)
				{
					hitNum3++;
				}
				else
				{
					hitNum1++;
				}
			}
		}
		AddScore(num);
	}

	public void RestartGame()
	{
		ShootGameTarget[] array = bulletObjectList.ToArray();
		foreach (ShootGameTarget obj in array)
		{
			RemoveShootGameTarget("bullet", obj);
		}
		array = tarObjectList.ToArray();
		foreach (ShootGameTarget obj2 in array)
		{
			RemoveShootGameTarget("target", obj2);
		}
		bulletObjectList.Clear();
		tarObjectList.Clear();
		StartGame();
	}

	private int GenerateRandomNumber(int min, int max)
	{
		return rand.Next(min, max);
	}

	private int GenerateRandomNumber(int min, int max, int num)
	{
		return rand.Next(min, max);
	}

	public void InitResPool()
	{
		for (int i = 0; i <= 8; i++)
		{
			ShootGameTarget value = RemoveFromDictionary("bullet");
			AddToDictionary("bullet", value);
		}
		for (int j = 0; j <= 8; j++)
		{
			ShootGameTarget value2 = RemoveFromDictionary("target");
			AddToDictionary("target", value2);
		}
	}

	public void RemoveShootGameTarget(string key, ShootGameTarget obj)
	{
		List<ShootGameTarget> list = ((key == "bullet") ? bulletObjectList : tarObjectList);
		int num = list.FindIndex((ShootGameTarget node1) => node1.gameObject.name == obj.gameObject.name);
		if (num != -1)
		{
			ShootGameTarget value = list[num];
			list.RemoveAt(num);
			AddToDictionary(key, value);
		}
	}

	private void Update()
	{
		if (Instance.state == GameStatus.Playing)
		{
			time += Time.deltaTime;
			nowCd = Mathf.Clamp(nowCd - Time.deltaTime, 0f, cd);
			UpdateGameLogic();
			CheckGameEnd();
		}
	}

	private void CheckGameEnd()
	{
		if (time > (float)MaxGameTime)
		{
			state = GameStatus.GameOver;
			LuaHelper.CallFunction("SpShootGameBridge.OpenResultUI", score, hitNum1, hitNum2, hitNum3);
			StopObjAllCoroutines();
			ShootGameTarget[] array = bulletObjectList.ToArray();
			foreach (ShootGameTarget obj in array)
			{
				RemoveShootGameTarget("bullet", obj);
			}
		}
	}

	public void Shoot()
	{
		if (nowCd == 0f)
		{
			ShootGameTarget shootGameTarget = RemoveFromDictionary("bullet");
			bulletObjectList.Add(shootGameTarget);
			shootGameTarget.transform.position = shoot.transform.position;
			shootGameTarget.Direction = 9;
			shootGameTarget.Speed = bulletSpeed;
			nowCd = cd;
		}
	}

	public ShootGameTarget RemoveFromDictionary(string key)
	{
		List<ShootGameTarget> value = new List<ShootGameTarget>();
		if (!resPool.ContainsKey(key))
		{
			resPool.Add(key, value);
		}
		value = GetValueFromResDictionary(key);
		if (value.Count > 0)
		{
			ShootGameTarget result = value[0];
			value.RemoveAt(0);
			return result;
		}
		ShootGameTarget shootGameTarget = null;
		if (key == "target")
		{
			GameObject obj = UnityEngine.Object.Instantiate(tarObj, gameParent);
			obj.transform.localPosition = new Vector3(1000f, 0f, 0f);
			obj.name = "target" + tarObjectList.Count;
			shootGameTarget = obj.AddComponent<ShootTarget>();
			shootGameTarget.Direction = 8;
		}
		else if (key == "bullet")
		{
			GameObject obj2 = UnityEngine.Object.Instantiate(bulletObj, gameParent);
			obj2.transform.localPosition = new Vector3(1000f, 0f, 0f);
			obj2.name = "bullet" + bulletObjectList.Count;
			shootGameTarget = obj2.AddComponent<ShootGameBullet>();
		}
		return shootGameTarget;
	}

	public List<ShootGameTarget> GetValueFromResDictionary(string key)
	{
		if (resPool.ContainsKey(key))
		{
			return resPool[key];
		}
		return null;
	}

	public void AddToDictionary(string key, ShootGameTarget value)
	{
		if (key == "target")
		{
			(value as ShootTarget).ShowEffect();
		}
		else if (key == "bullet")
		{
			value.transform.localPosition = new Vector3(1000f, 0f, 0f);
		}
		List<ShootGameTarget> valueFromResDictionary = GetValueFromResDictionary(key);
		if (valueFromResDictionary != null)
		{
			valueFromResDictionary.Add(value);
			resPool[key] = valueFromResDictionary;
		}
		else
		{
			valueFromResDictionary = new List<ShootGameTarget>();
			valueFromResDictionary.Add(value);
			resPool.Add(key, valueFromResDictionary);
		}
	}

	public void UpdateGameLogic()
	{
		ShootGameTarget[] array = bulletObjectList.ToArray();
		foreach (ShootGameTarget shootGameTarget in array)
		{
			ShootGameTarget[] array2 = tarObjectList.ToArray();
			foreach (ShootGameTarget shootGameTarget2 in array2)
			{
				if (shootGameTarget.OnCollision(shootGameTarget2))
				{
					DealTar(shootGameTarget2);
					if (!(shootGameTarget2 as ShootTarget).IsSameCamp)
					{
						superAnger = Mathf.Clamp(superAnger + 1, 0, angerMax);
					}
				}
			}
		}
	}

	public void DealTar(ShootGameTarget tar)
	{
		ShootTarget shootTarget = tar as ShootTarget;
		AddScore(shootTarget.IsSameCamp ? reduceScore : (shootTarget.IsSuper ? superScore : addScore));
		if (shootTarget.IsSameCamp)
		{
			hitNum2++;
		}
		else if (shootTarget.IsSuper)
		{
			hitNum3++;
		}
		else
		{
			hitNum1++;
		}
	}

	public void AddScore(int value)
	{
		LuaHelper.CallFunction("SpShootGameBridge.UpdateScore", score, value);
		score = Mathf.Clamp(score + value, 0, 9999999);
	}

	public void PauseGame()
	{
		if (Instance.state == GameStatus.Paused)
		{
			Instance.state = GameStatus.Playing;
		}
		else
		{
			Instance.state = GameStatus.Paused;
		}
	}

	public float GetScore()
	{
		return score;
	}

	public float GetNowLeftTime()
	{
		return Mathf.Clamp((float)MaxGameTime - time, 0f, MaxGameTime);
	}

	public float GetNowCd()
	{
		return nowCd;
	}

	public float GetMaxCd()
	{
		return cd;
	}

	public int GetAnger()
	{
		return superAnger;
	}

	public int GetCostAnger()
	{
		return angerCost;
	}

	public int GetMaxAnger()
	{
		return angerMax;
	}

	public ShootGameControl()
	{
		//IL_0041: Field data (rva=0x4e0) could not be found in any section!
		//IL_0041: Field data (rva=0x4e0) could not be found in any section!
		addScore = 300;
		superScore = 100;
		reduceScore = -300;
		MaxGameTime = 300;
		cd = 1f;
		float[] array = new float[3];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		campRate = array;
		spawnInterval = 6f;
		stateIndex = 1;
		coroutines = new List<Coroutine>();
		bulletSpeed = 2f;
		skillRange = new float[2] { -1.8f, 1.8f };
		angerCost = 10;
		angerMax = 10;
		ButtonName = "开始游戏";
		ButtonName2 = "大招";
		ButtonName1 = "重置游戏";
		ButtonName3 = "射击";
		base._002Ector();
	}
}
