using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using BilliardGame.Spell;
using Cinemachine;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Pool;

namespace BilliardGame.Runtime;

public class BilliardGameLogicManager : MonoBehaviour
{
	public float defaultMass;

	public float shootingMass;

	public int normalEnemyAtkNum;

	public int hardEnemyAtkNum;

	public List<int> enemyMustAtkIDList;

	[Header("碰撞时震屏配置")]
	[SerializeField]
	private float shakeDuration = 0.15f;

	[SerializeField]
	private float shakeAmplitude = 3f;

	[SerializeField]
	private float shakeFrequency = 1f;

	private const float SHOOT_MIN_FORCE = 1f;

	private const float SHOOT_MAX_FORCE = 3f;

	private const int MAX_FOOD = 6;

	private const int POT_ID = 40311;

	private const string StageDataPath = "BilliardGame/StageData/billiardGameStage_{0}";

	private const string MapBasePath = "BilliardGame/Map/billiardGameMap_{0}";

	private const string WallBasePath = "BilliardGame/Map/billiardWalls";

	private const string PlayerEntityPath = "BilliardGame/Player/billiardPlayer_{0}";

	private bool stateChangeLock;

	private LTDescr tween;

	public static BilliardGameLogicManager Instance;

	private bool _insThis;

	[Header("绑定组件")]
	[SerializeField]
	private GameObject shootTrigger;

	[SerializeField]
	private Transform playerRootTrs;

	[SerializeField]
	private Transform enemyRootTrs;

	[SerializeField]
	private Transform mechanismRootTrs;

	[SerializeField]
	private Transform mapRootTrs;

	[SerializeField]
	private Transform wallRootTrs;

	[SerializeField]
	private Transform stageRootTrs;

	[SerializeField]
	private Transform bulletRootTrs;

	[SerializeField]
	private Transform effectRootTrs;

	[SerializeField]
	private CinemachineVirtualCamera followCamera;

	[SerializeField]
	private CinemachineVirtualCamera mainCamera;

	private CinemachineBasicMultiChannelPerlin noiseProfile;

	private CanvasGroup uiRayCast;

	private int stageID;

	private StageData stageData;

	private GameObject baseMap;

	private GameObject magnifyMap;

	private GameObject wall;

	private GameObject normalSize;

	private GameObject magnifySize;

	private Vector3 dragBeginPos;

	private Vector3 dragEndPos;

	private bool dragLock;

	private EntityPlayer curShootPlayer;

	public BilliardGameExchangeData exchangeData;

	private WinType winType;

	private int gameDifficulty;

	private int winTarget;

	private int winTargetEnemyID;

	private int enemyDeathNum;

	private int curRound;

	private float enemyHpRatio;

	private float enemyAtkRatio;

	private int seconds;

	private bool isOver;

	private int curRoundHitNumber;

	private int totalDamage;

	private int foodAddNum;

	private int food;

	private float attackRoundTickTime;

	private List<EntityPlayer> entityPlayerList_ = new List<EntityPlayer>();

	private List<EntityEnemy> entityEnemyList_ = new List<EntityEnemy>();

	private List<EntityMechanism> entityMechanismList_ = new List<EntityMechanism>();

	private List<EntityBullet> entityBulletList_ = new List<EntityBullet>();

	private List<EntityPhysicalBullet> entityPhysicalBulletList_ = new List<EntityPhysicalBullet>();

	private Dictionary<int, int> waveRemain = new Dictionary<int, int>();

	private Dictionary<int, int> afterWaveTurn = new Dictionary<int, int>();

	private Dictionary<BilliardTurnType, HashSet<MonsterData>> eventEnemyList_ = new Dictionary<BilliardTurnType, HashSet<MonsterData>>();

	private HashSet<MonsterData> cacheDel = new HashSet<MonsterData>();

	private Dictionary<int, HashSet<MechanismData>> eventMechiemList_ = new Dictionary<int, HashSet<MechanismData>>();

	private HashSet<MechanismData> catchMeciem = new HashSet<MechanismData>();

	private int uniqueID;

	private int stateTimer = -1;

	private BilliardGameGuideInfo guideInfo;

	private bool isBallGame;

	private bool isSelectedBuff;

	private Dictionary<int, List<int>> buffConnectDic = new Dictionary<int, List<int>>();

	public Transform BulletRootTrs => bulletRootTrs;

	public CinemachineVirtualCamera FollowCamera => followCamera;

	public CinemachineVirtualCamera MainCamera => mainCamera;

	public CinemachineBasicMultiChannelPerlin NoiseProfile => noiseProfile;

	public TurnState turnState { get; private set; }

	public bool IsOver => isOver;

	public int CurRound
	{
		get
		{
			return curRound;
		}
		private set
		{
			curRound = value;
			BilliardGameUIManager.Instance.UpdateRound(curRound);
		}
	}

	public int Food
	{
		get
		{
			return food;
		}
		set
		{
			food = Mathf.Clamp(value, 0, 6);
			BilliardGameUIManager.Instance.UpdateFood(food);
			for (int i = 0; i < entityPlayerList_.Count; i++)
			{
				entityPlayerList_[i].RefreshUI();
			}
		}
	}

	public BilliardGameEffectManager effectMgr { get; private set; }

	private void Awake()
	{
		if (Instance == null)
		{
			Instance = this;
			_insThis = true;
		}
		else
		{
			UnityEngine.Object.Destroy(base.gameObject);
			Debug.LogError("已经存在一个弹球游戏管理器：" + Instance.gameObject.name);
		}
		Debug.Log("PinballGameDebugger: LogicManager:Init");
	}

	private void OnDestroy()
	{
		Dispose();
		if (_insThis)
		{
			Instance = null;
		}
	}

	public int CreatePlayer(GameObject go, int playerID, BilliardCharacterConfig cfg)
	{
		EntityPlayer item = new EntityPlayer(uniqueID, go, playerID, cfg);
		entityPlayerList_.Add(item);
		int result = uniqueID;
		uniqueID++;
		return result;
	}

	public int CreateEnemy(GameObject go, BilliardEntityConfig cfg, MonsterData data)
	{
		float num = BilliardGameDataManager.GetRoundHpRatio(data.turn);
		int num2 = uniqueID;
		EntityEnemy entityEnemy = new EntityEnemy(num2, go, cfg, enemyHpRatio * num, enemyAtkRatio);
		entityEnemy.dataIndex = data.index;
		go.transform.position = stageData.monsters[entityEnemy.dataIndex].position + new Vector3(0f, 0f, (float)num2 / 100f);
		go.transform.rotation = Quaternion.Euler(stageData.monsters[entityEnemy.dataIndex].rotation);
		go.transform.localScale = stageData.monsters[entityEnemy.dataIndex].scale;
		entityEnemyList_.Add(entityEnemy);
		uniqueID++;
		return num2;
	}

	public int CreateMechanism(GameObject go, BilliardEntityConfig cfg)
	{
		EntityMechanism item = new EntityMechanism(uniqueID, go, cfg);
		entityMechanismList_.Add(item);
		int result = uniqueID;
		uniqueID++;
		return result;
	}

	public int CreateMechanism(GameObject go)
	{
		EntityMechanism item = new EntityMechanism(uniqueID, go);
		entityMechanismList_.Add(item);
		int result = uniqueID;
		uniqueID++;
		return result;
	}

	public int CreateBullet(GameObject go, int atk, int colNum, int buffID, BilliardGameEntityBase owner, bool canColWall, string effectName = null, string dieAudio = null)
	{
		EntityBullet entityBullet = new EntityBullet(uniqueID, go, atk, colNum, buffID, owner, canColWall);
		if (effectName != null && effectName != "")
		{
			entityBullet.SetBoomEffect(effectName);
		}
		entityBulletList_.Add(entityBullet);
		int result = uniqueID;
		uniqueID++;
		return result;
	}

	public int CreatePhysicalBullet(GameObject go, int atk, int colNum, int buffID, int sourceBuffID, BilliardGameEntityBase owner, string effectName = null, string dieAudio = null)
	{
		EntityPhysicalBullet entityPhysicalBullet = new EntityPhysicalBullet(uniqueID, go, atk, colNum, buffID, owner, sourceBuffID);
		if (effectName != null && effectName != "")
		{
			entityPhysicalBullet.SetBoomEffect(effectName);
		}
		entityPhysicalBulletList_.Add(entityPhysicalBullet);
		int result = uniqueID;
		uniqueID++;
		return result;
	}

	public void CastSkill(int heroID)
	{
		entityPlayerList_.Find((EntityPlayer p) => p.playerID == heroID).UseSkill();
	}

	public void CastAllPlayerBuff(int buffID)
	{
		for (int i = 0; i < entityPlayerList_.Count; i++)
		{
			EntityPlayer caster = entityPlayerList_[i];
			BilliardGameSpellManager.Instance.CastBuff(buffID, caster);
		}
	}

	public void Start()
	{
		Init();
	}

	public void Update()
	{
		if (IsOver)
		{
			return;
		}
		for (int i = 0; i < entityPlayerList_.Count; i++)
		{
			entityPlayerList_[i].Tick();
		}
		for (int j = 0; j < entityEnemyList_.Count; j++)
		{
			EntityEnemy entityEnemy = entityEnemyList_[j];
			if (!entityEnemy.Dead)
			{
				entityEnemy.Tick();
			}
		}
		for (int num = entityBulletList_.Count - 1; num >= 0; num--)
		{
			EntityBullet entityBullet = entityBulletList_[num];
			if (!entityBullet.Dead)
			{
				entityBullet.Tick();
			}
		}
		for (int num2 = entityPhysicalBulletList_.Count - 1; num2 >= 0; num2--)
		{
			EntityPhysicalBullet entityPhysicalBullet = entityPhysicalBulletList_[num2];
			if (!entityPhysicalBullet.Dead)
			{
				entityPhysicalBullet.Tick();
			}
		}
	}

	public void FixedUpdate()
	{
		CheckRest();
	}

	public void CheckRest()
	{
		if (turnState == TurnState.PlayerAttackPhase)
		{
			attackRoundTickTime += Time.fixedDeltaTime;
			if ((CheckActiveBullet() && CheckPlayerRest()) || attackRoundTickTime > 15f)
			{
				ProcessToNextState();
			}
		}
	}

	private void Init()
	{
		uiRayCast = GameObject.Find("UICamera/Canvas").GetComponent<CanvasGroup>();
		Physics2D.velocityThreshold = 0.0001f;
		noiseProfile = mainCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		float num = (float)Screen.width / (float)Screen.height;
		mainCamera.m_Lens.OrthographicSize = 1.7777f / num * 6.74f;
		ResetStageData();
	}

	private void Dispose()
	{
		if (stateTimer != -1 && null != FuncTimerManager.inst)
		{
			FuncTimerManager.inst.RemoveFuncTimer(stateTimer);
		}
		StopCoroutine("EnemyTurnDelay");
		if (uiRayCast != null)
		{
			uiRayCast.blocksRaycasts = true;
		}
		if (tween != null)
		{
			tween.setOnUpdate((Action<float>)delegate
			{
			});
			LeanTween.cancel(tween.id);
			tween = null;
		}
	}

	private void ResetStageData()
	{
		isOver = false;
		stageID = BilliardGameScene.Context.StageId;
		stageData = Asset.Load<StageData>($"BilliardGame/StageData/billiardGameStage_{stageID}");
		turnState = TurnState.WaitingForInit;
		if (baseMap == null)
		{
			baseMap = Asset.Instantiate($"BilliardGame/Map/billiardGameMap_{stageID}");
			baseMap.transform.parent = mapRootTrs;
			baseMap.transform.position = Vector3.zero;
			baseMap.transform.rotation = Quaternion.identity;
			baseMap.transform.localScale = Vector3.one;
			if (stageData.initParams != null && stageData.initParams.Length >= 3)
			{
				mainCamera.transform.position = new Vector3(stageData.initParams[0], stageData.initParams[1], -10f);
				mainCamera.m_Lens.OrthographicSize = stageData.initParams[2];
			}
		}
		if (stageData.isMagnify)
		{
			mainCamera.transform.position = new Vector3(stageData.magnifyParams[0], stageData.magnifyParams[1], -10f);
			magnifyMap = Asset.Instantiate($"BilliardGame/Map/billiardGameMap_{stageData.magnifyMapStageId}");
			magnifyMap.transform.parent = mapRootTrs;
			magnifyMap.transform.position = Vector3.zero;
			magnifyMap.transform.rotation = Quaternion.identity;
			magnifyMap.transform.localScale = Vector3.one;
			magnifyMap.gameObject.SetActive(value: false);
			magnifyMap.transform.SetAsFirstSibling();
		}
		Camera.main.orthographic = true;
		wall = Asset.Instantiate("BilliardGame/Map/billiardWalls");
		wall.transform.parent = wallRootTrs;
		normalSize = wall.transform.Find("normalSize").gameObject;
		magnifySize = wall.transform.Find("magnifySize").gameObject;
		normalSize.SetActive(value: true);
		magnifySize.SetActive(value: false);
		stateTimer = -1;
		stateChangeLock = false;
		ResetGuideInfo();
	}

	public void InitTurnBasedGame(GameObject go)
	{
		BilliardGameUIManager.Instance = go.GetComponent<BilliardGameUIManager>();
		BilliardGameUIManager.Instance.InitUI();
		eventEnemyList_.Clear();
		eventEnemyList_.Add(BilliardTurnType.AfterPreTurn, new HashSet<MonsterData>());
		eventEnemyList_.Add(BilliardTurnType.FixedTurn, new HashSet<MonsterData>());
		effectMgr = new BilliardGameEffectManager(effectRootTrs);
		uniqueID = 0;
		CurRound = 0;
		enemyDeathNum = 0;
		Food = 0;
		winType = WinType.Uninit;
		EnterState(TurnState.WaitingForInit);
		BilliardStageConfig stageCfg = BilliardGameDataManager.GetStageCfg(stageID);
		gameDifficulty = stageCfg.stageType;
		winType = stageCfg.winType;
		winTarget = stageCfg.winCondition[0];
		if (stageCfg.winCondition.Length > 1)
		{
			winTargetEnemyID = stageCfg.winCondition[1];
		}
		else
		{
			winTargetEnemyID = -1;
		}
		foodAddNum = stageCfg.skillPoint;
		enemyHpRatio = (float)stageCfg.monsterAttribute[1] / 100f;
		enemyAtkRatio = (float)stageCfg.monsterAttribute[0] / 100f;
		exchangeData = new BilliardGameExchangeData(stageID, gameDifficulty);
		isBallGame = BilliardGameDataManager.IsBallGame();
		int num = ((!isBallGame) ? 1 : stageData.playerBornPos.Count);
		int[] array = new int[num];
		for (int i = 0; i < num; i++)
		{
			int num2 = (array[i] = BilliardGameScene.Context.GetPlayer(i));
			BilliardCharacterConfig playerCfg = BilliardGameDataManager.GetPlayerCfg(num2);
			GameObject gameObject = Asset.Instantiate($"BilliardGame/Player/billiardPlayer_{playerCfg.heroType}");
			gameObject.transform.parent = playerRootTrs;
			BilliardGameBall component = gameObject.GetComponent<BilliardGameBall>();
			int entityID = CreatePlayer(gameObject, num2, playerCfg);
			if (component != null)
			{
				component.SetEntityID(entityID);
				component.SetIcon(playerCfg.hero_ball_image);
			}
			gameObject.transform.position = stageData.playerBornPos[i];
		}
		InitHero(array);
		for (int j = 0; j < entityPlayerList_.Count; j++)
		{
			entityPlayerList_[j].RefreshUI(refreshSkill: true);
		}
		if (stageData.monsters != null)
		{
			for (int k = 0; k < stageData.monsters.Count; k++)
			{
				MonsterData monsterData = stageData.monsters[k];
				if (!waveRemain.ContainsKey(monsterData.wave))
				{
					waveRemain.Add(monsterData.wave, 0);
				}
				waveRemain[monsterData.wave] = waveRemain[monsterData.wave] + 1;
				monsterData.index = k;
				switch (monsterData.turnType)
				{
				case BilliardTurnType.None:
					LoadEnemy(monsterData);
					break;
				case BilliardTurnType.AfterPreTurn:
					if (monsterData.wave == 1)
					{
						LoadEnemy(monsterData);
					}
					else
					{
						eventEnemyList_[BilliardTurnType.AfterPreTurn].Add(monsterData);
					}
					break;
				case BilliardTurnType.FixedTurn:
					if (monsterData.turn == 1)
					{
						LoadEnemy(monsterData);
					}
					else
					{
						eventEnemyList_[BilliardTurnType.FixedTurn].Add(monsterData);
					}
					break;
				}
			}
		}
		if (stageData.mechanisms != null)
		{
			for (int l = 0; l < stageData.mechanisms.Count; l++)
			{
				MechanismData mechanismData = stageData.mechanisms[l];
				if (mechanismData.createWave == 1)
				{
					LoadMechanism(mechanismData);
					continue;
				}
				if (!eventMechiemList_.ContainsKey(mechanismData.createWave))
				{
					eventMechiemList_.Add(mechanismData.createWave, new HashSet<MechanismData>());
				}
				eventMechiemList_[mechanismData.createWave].Add(mechanismData);
			}
		}
		if (winType == WinType.Uninit)
		{
			winType = WinType.WipeOutEnemies;
		}
		BilliardGameUIManager.Instance.UpdateVictory(winType, (winType == WinType.WipeOutEnemies || winType == WinType.WipeOutTarget) ? enemyDeathNum : (curRound - 1), winTarget, isBallGame);
		ProcessToNextState();
	}

	public void LoadMechanism(MechanismData mechanismData)
	{
		GameObject gameObject = Asset.Instantiate(Regex.Replace(mechanismData.path, "Assets/(?:[^/]*/)?(?:ABResources|UI_AB|PrefabPending)/", ""));
		gameObject.transform.parent = mechanismRootTrs;
		BilliardGameMechanism component = gameObject.GetComponent<BilliardGameMechanism>();
		BilliardEntityConfig mechanismCfg = BilliardGameDataManager.GetMechanismCfg(component.GetMechainID());
		int num = 0;
		num = ((mechanismCfg == null) ? CreateMechanism(gameObject) : CreateMechanism(gameObject, mechanismCfg));
		if (component != null)
		{
			component.SetEntityID(num);
			component.SetHideWhenMagnify(mechanismData.hideWhenMagnify);
		}
		gameObject.transform.position = mechanismData.position;
		gameObject.transform.rotation = Quaternion.Euler(mechanismData.rotation);
		gameObject.transform.localScale = mechanismData.scale;
	}

	public void LoadMechanismByPath(string path, Vector3 pos, Vector3 scale)
	{
		GameObject gameObject = Asset.Instantiate(Regex.Replace(path, "Assets/(?:[^/]*/)?(?:ABResources|UI_AB|PrefabPending)/", ""));
		gameObject.transform.parent = mechanismRootTrs;
		BilliardGameMechanism component = gameObject.GetComponent<BilliardGameMechanism>();
		BilliardEntityConfig mechanismCfg = BilliardGameDataManager.GetMechanismCfg(component.GetMechainID());
		int num = 0;
		num = ((mechanismCfg == null) ? CreateMechanism(gameObject) : CreateMechanism(gameObject, mechanismCfg));
		if (component != null)
		{
			component.SetEntityID(num);
		}
		gameObject.transform.position = pos;
		gameObject.transform.localScale = scale;
	}

	private void LoadEnemy(MonsterData data)
	{
		GameObject gameObject = Asset.Instantiate(Regex.Replace(data.path, "Assets/(?:[^/]*/)?(?:ABResources|UI_AB|PrefabPending)/", ""));
		gameObject.transform.parent = enemyRootTrs;
		BilliardGameEnemy component = gameObject.GetComponent<BilliardGameEnemy>();
		BilliardEntityConfig monsterCfg = BilliardGameDataManager.GetMonsterCfg(component.enemyID);
		int entityID = CreateEnemy(gameObject, monsterCfg, data);
		if (component != null)
		{
			component.SetEntityID(entityID);
		}
		if (!isBallGame)
		{
			MakeEffectGo("GuaiWu/5_1/monster_spawn", gameObject.gameObject, gameObject.transform.localScale.x);
		}
	}

	public void LoadEnemyByPath(string enemypath, Vector3 pos, Vector3 scale)
	{
		GameObject gameObject = Asset.Instantiate(Regex.Replace(enemypath, "Assets/(?:[^/]*/)?(?:ABResources|UI_AB|PrefabPending)/", ""));
		gameObject.transform.parent = enemyRootTrs;
		BilliardGameEnemy component = gameObject.GetComponent<BilliardGameEnemy>();
		BilliardEntityConfig monsterCfg = BilliardGameDataManager.GetMonsterCfg(component.enemyID);
		float num = BilliardGameDataManager.GetRoundHpRatio(curRound);
		int entityID = uniqueID;
		EntityEnemy entityEnemy = new EntityEnemy(uniqueID, gameObject, monsterCfg, enemyHpRatio * num, enemyAtkRatio);
		entityEnemy.dataIndex = -1;
		gameObject.transform.position = pos + new Vector3(0f, 0f, (float)uniqueID / 100f);
		gameObject.transform.localScale = scale;
		entityEnemyList_.Add(entityEnemy);
		uniqueID++;
		entityEnemy.ShowBar(isShow: true);
		if (component != null)
		{
			component.SetEntityID(entityID);
		}
		if (!isBallGame)
		{
			MakeEffectGo("GuaiWu/5_1/monster_spawn", gameObject.gameObject, gameObject.transform.localScale.x);
		}
	}

	public void RoundBeginPhaseEnd()
	{
		foreach (EntityMechanism item in entityMechanismList_)
		{
			item.OnRoundBegin();
		}
		foreach (EntityPlayer item2 in entityPlayerList_)
		{
			item2.OnPlayerRoundBegin();
		}
		if (stageData.isMagnify && stageData.magnifyMapRound + 1 == CurRound)
		{
			MagnifyMap(ProcessToNextState);
		}
		else
		{
			ProcessToNextState();
		}
	}

	public void ProcessToNextState()
	{
		if (stateChangeLock)
		{
			return;
		}
		stateChangeLock = true;
		switch (turnState)
		{
		case TurnState.WaitingForInit:
			seconds = GetSecond();
			EnterState(TurnState.RoundBeginPhase);
			break;
		case TurnState.RoundBeginPhase:
			BilliardGame.Spell.ObjectPool<BTEnv>.ReleaseCache();
			SetSelectBuffOver(flag: false);
			BilliardGameUIManager.Instance.ChangeTurnType(TurnType.Player);
			if (stateTimer != -1)
			{
				FuncTimerManager.inst.RemoveFuncTimer(stateTimer);
				stateTimer = -1;
			}
			stateTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				BilliardGameUIManager.Instance.ChangeTurnType(TurnType.None);
				LuaHelper.CallFunction("OnBilliardGamePlayerRoundBegin");
				EnterState(TurnState.PlayerShootPhase);
				stateTimer = -1;
			}, 1f, 1);
			break;
		case TurnState.PlayerShootPhase:
			EnterState(TurnState.PlayerAttackPhase);
			break;
		case TurnState.PlayerAttackPhase:
			curShootPlayer.OnAttackEnd();
			foreach (EntityPlayer item in entityPlayerList_)
			{
				item.OnAnyAttackEnd();
			}
			curShootPlayer = null;
			if (entityEnemyList_.All((EntityEnemy e) => e.Dead) || entityPlayerList_.All((EntityPlayer p) => p.Dead))
			{
				EnterState(TurnState.RoundOverPhase);
			}
			else if (entityPlayerList_.All((EntityPlayer p) => p.Tired))
			{
				foreach (EntityPlayer item2 in entityPlayerList_)
				{
					item2.OnPlayerRoundEnd();
				}
				EnterState(TurnState.EnemyActionPhase);
			}
			else
			{
				EnterState(TurnState.PlayerShootPhase);
			}
			totalDamage = 0;
			attackRoundTickTime = 0f;
			break;
		case TurnState.EnemyActionPhase:
		{
			int count = entityEnemyList_.Count;
			for (int num2 = 0; num2 < count; num2++)
			{
				EntityEnemy entityEnemy = entityEnemyList_[num2];
				if (!entityEnemy.Dead)
				{
					entityEnemy.OnRoundEnd();
				}
			}
			EnterState(TurnState.RoundOverPhase);
			break;
		}
		case TurnState.RoundOverPhase:
		{
			List<EntityEnemy> list = new List<EntityEnemy>();
			foreach (EntityEnemy item3 in entityEnemyList_)
			{
				if (item3.Dead)
				{
					list.Add(item3);
					item3.Dispose();
				}
				else
				{
					item3.OnRoundEnd();
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].dataIndex != -1)
				{
					MonsterData monsterData = stageData.monsters[list[i].dataIndex];
					waveRemain[monsterData.wave] = waveRemain[monsterData.wave] - 1;
					if (waveRemain[monsterData.wave] == 0 && !afterWaveTurn.ContainsKey(monsterData.wave))
					{
						afterWaveTurn.Add(monsterData.wave, 0);
					}
				}
				entityEnemyList_.Remove(list[i]);
			}
			List<EntityPlayer> list2 = new List<EntityPlayer>();
			foreach (EntityPlayer item4 in entityPlayerList_)
			{
				if (item4.Dead)
				{
					list2.Add(item4);
					item4.Dispose();
				}
			}
			for (int j = 0; j < list2.Count; j++)
			{
				entityPlayerList_.Remove(list2[j]);
			}
			List<EntityBullet> list3 = new List<EntityBullet>();
			foreach (EntityBullet item5 in entityBulletList_)
			{
				if (item5.Dead)
				{
					list3.Add(item5);
					item5.Dispose();
				}
			}
			for (int k = 0; k < list3.Count; k++)
			{
				entityBulletList_.Remove(list3[k]);
			}
			List<EntityPhysicalBullet> list4 = new List<EntityPhysicalBullet>();
			foreach (EntityPhysicalBullet item6 in entityPhysicalBulletList_)
			{
				if (item6.Dead)
				{
					list4.Add(item6);
					item6.Dispose();
				}
			}
			for (int l = 0; l < list4.Count; l++)
			{
				entityPhysicalBulletList_.Remove(list4[l]);
			}
			List<EntityMechanism> list5 = new List<EntityMechanism>();
			foreach (EntityMechanism item7 in entityMechanismList_)
			{
				if (item7.Dead)
				{
					list5.Add(item7);
					item7.Dispose();
				}
			}
			for (int m = 0; m < list5.Count; m++)
			{
				entityMechanismList_.Remove(list5[m]);
			}
			List<int> list6 = CollectionPool<List<int>, int>.Get();
			foreach (int key in afterWaveTurn.Keys)
			{
				list6.Add(key);
			}
			foreach (int item8 in list6)
			{
				afterWaveTurn[item8] += 1;
			}
			cacheDel.Clear();
			int num = CurRound + 1;
			foreach (MonsterData item9 in eventEnemyList_[BilliardTurnType.FixedTurn])
			{
				if (num == item9.turn)
				{
					cacheDel.Add(item9);
					LoadEnemy(item9);
				}
			}
			foreach (MonsterData item10 in cacheDel)
			{
				eventEnemyList_[BilliardTurnType.FixedTurn].Remove(item10);
			}
			cacheDel.Clear();
			if (eventMechiemList_.ContainsKey(num))
			{
				catchMeciem.Clear();
				foreach (MechanismData item11 in eventMechiemList_[num])
				{
					if (num == item11.createWave)
					{
						catchMeciem.Add(item11);
						LoadMechanism(item11);
					}
				}
				foreach (MechanismData item12 in catchMeciem)
				{
					eventMechiemList_[num].Remove(item12);
				}
				catchMeciem.Clear();
			}
			if (entityPlayerList_.Count == 0)
			{
				if (eventEnemyList_[BilliardTurnType.AfterPreTurn].Count == 0)
				{
					OverGame(result: false);
				}
			}
			else if ((winType == WinType.WipeOutEnemies || winType == WinType.WipeOutTarget) && enemyDeathNum >= winTarget)
			{
				OverGame(result: true);
			}
			else
			{
				foreach (EntityPlayer item13 in entityPlayerList_)
				{
					item13.OnRoundEnd();
				}
				LuaHelper.CallFunction("OnStageConditionFinish", false);
				EnterState(TurnState.RoundBeginPhase);
			}
			if (eventEnemyList_[BilliardTurnType.AfterPreTurn].Count > 0)
			{
				cacheDel.Clear();
				foreach (MonsterData item14 in eventEnemyList_[BilliardTurnType.AfterPreTurn])
				{
					if (afterWaveTurn.ContainsKey(item14.afterWave) && afterWaveTurn[item14.afterWave] >= item14.turn)
					{
						LoadEnemy(item14);
						cacheDel.Add(item14);
					}
				}
				foreach (MonsterData item15 in cacheDel)
				{
					eventEnemyList_[BilliardTurnType.AfterPreTurn].Remove(item15);
				}
				cacheDel.Clear();
			}
			LuaHelper.CallFunction("OnBilliardGameRoundOver");
			break;
		}
		}
	}

	public void EnterState(TurnState turnState)
	{
		stateChangeLock = false;
		if (this.turnState == turnState)
		{
			return;
		}
		this.turnState = turnState;
		switch (this.turnState)
		{
		case TurnState.RoundBeginPhase:
		{
			int num = CurRound + 1;
			CurRound = num;
			if (winType == WinType.HoldOnForTurns && curRound > winTarget)
			{
				OverGame(result: true);
				break;
			}
			UpdateVictoryText();
			List<EntityEnemy> list = entityEnemyList_.FindAll((EntityEnemy e) => !e.Dead);
			for (int num2 = 0; num2 < list.Count; num2++)
			{
				EntityEnemy entityEnemy = list[num2];
				entityEnemy.OnRoundBegin();
				entityEnemy.ShowBar(isShow: true);
			}
			if (isBallGame)
			{
				int count = ((gameDifficulty == 1) ? normalEnemyAtkNum : hardEnemyAtkNum);
				List<EntityEnemy> randomChilds = GetRandomChilds(list, count);
				if (randomChilds.Find((EntityEnemy e) => e.enemyID == 40309) == null && list.Find((EntityEnemy e) => e.enemyID == 40309) != null)
				{
					randomChilds.RemoveAt(randomChilds.Count - 1);
					randomChilds.Add(list.Find((EntityEnemy e) => e.enemyID == 40309));
				}
				for (int num3 = 0; num3 < randomChilds.Count; num3++)
				{
					randomChilds[num3].ReadyAtk();
				}
				if (curRound > 1)
				{
					Food += foodAddNum;
				}
				else
				{
					Food = BilliardGameDataManager.GetInitFood();
				}
				RoundBeginPhaseEnd();
				break;
			}
			ChangeOtherLayer("Ignore Raycast");
			SetSelectBuffOver(flag: false);
			float num4 = 0f;
			foreach (EntityEnemy item in list)
			{
				item.ReduceChagedNum();
				if (item.GetIsMoving())
				{
					num4 = math.max(num4, item.GetMoveTime());
				}
			}
			if (num4 > 0f)
			{
				FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					RoundBeginPhaseEnd();
				}, num4, 1);
			}
			else
			{
				RoundBeginPhaseEnd();
			}
			break;
		}
		case TurnState.PlayerShootPhase:
		{
			bool flag = true;
			foreach (EntityPlayer item2 in entityPlayerList_)
			{
				if (!item2.Dead)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				OverGame(result: false);
				break;
			}
			dragLock = false;
			curRoundHitNumber = 0;
			{
				foreach (EntityPlayer item3 in entityPlayerList_)
				{
					item3.logic.HintBall(!item3.Tired);
				}
				break;
			}
		}
		case TurnState.PlayerAttackPhase:
			totalDamage = 0;
			attackRoundTickTime = 0f;
			ChangeOtherLayer("Default");
			{
				foreach (EntityPlayer item4 in entityPlayerList_)
				{
					item4.logic.HintBall(isHint: false);
				}
				break;
			}
		case TurnState.EnemyActionPhase:
			this.turnState = TurnState.RoundOverPhase;
			BilliardGameUIManager.Instance.ChangeTurnType(TurnType.Enemy);
			foreach (EntityPlayer item5 in entityPlayerList_)
			{
				if (!item5.Dead)
				{
					item5.OnEnemyTurnStart();
				}
			}
			if (stateTimer != -1)
			{
				FuncTimerManager.inst.RemoveFuncTimer(stateTimer);
				stateTimer = -1;
			}
			stateTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				stateTimer = -1;
				int count2 = entityEnemyList_.Count;
				for (int i = 0; i < count2; i++)
				{
					EntityEnemy entityEnemy2 = entityEnemyList_[i];
					if (!entityEnemy2.Dead)
					{
						entityEnemy2.OnEnemyState();
					}
				}
				BilliardGameUIManager.Instance.ChangeTurnType(TurnType.None);
				StartCoroutine(EnemyTurnDelay());
			}, 1f, 1);
			break;
		case TurnState.RoundOverPhase:
			ProcessToNextState();
			break;
		case TurnState.WaitingForInit:
			break;
		}
	}

	private void Swap<T>(List<T> list, int index1, int index2)
	{
		T value = list[index2];
		list[index2] = list[index1];
		list[index1] = value;
	}

	private List<T> SortRandom<T>(List<T> list)
	{
		for (int num = list.Count - 1; num > 0; num--)
		{
			int index = UnityEngine.Random.Range(0, num);
			Swap(list, index, num);
		}
		return list;
	}

	private List<T> GetRandomChilds<T>(List<T> list, int count)
	{
		List<T> list2 = new List<T>();
		list2.AddRange(list);
		if (count >= list.Count)
		{
			return list2;
		}
		SortRandom(list2);
		return list2.GetRange(0, count);
	}

	public void OverGame(bool result)
	{
		if (isOver)
		{
			return;
		}
		List<BilliardHeroOrMonsterData> list = new List<BilliardHeroOrMonsterData>();
		foreach (EntityPlayer item in entityPlayerList_)
		{
			BilliardHeroOrMonsterData billiardHeroOrMonsterData = new BilliardHeroOrMonsterData();
			billiardHeroOrMonsterData.id = item.playerID;
			billiardHeroOrMonsterData.startHp = item.maxHP;
			billiardHeroOrMonsterData.endHp = item.remainHP;
			list.Add(billiardHeroOrMonsterData);
		}
		List<BilliardHeroOrMonsterData> list2 = new List<BilliardHeroOrMonsterData>();
		foreach (EntityEnemy item2 in entityEnemyList_)
		{
			item2.ShowBar(isShow: false);
			BilliardHeroOrMonsterData billiardHeroOrMonsterData2 = new BilliardHeroOrMonsterData();
			billiardHeroOrMonsterData2.id = item2.enemyID;
			billiardHeroOrMonsterData2.startHp = item2.maxHP;
			billiardHeroOrMonsterData2.endHp = item2.remainHP;
			list2.Add(billiardHeroOrMonsterData2);
		}
		int second = GetSecond();
		exchangeData.OnGameOver(result ? 1 : 2, second, seconds, list, list2, CurRound);
		isOver = true;
		LuaHelper.CallFunction("OnBilliardGameOver", result, exchangeData);
	}

	public BilliardGameExchangeData FinishGame()
	{
		int second = GetSecond();
		List<BilliardHeroOrMonsterData> list = new List<BilliardHeroOrMonsterData>();
		foreach (EntityPlayer item in entityPlayerList_)
		{
			BilliardHeroOrMonsterData billiardHeroOrMonsterData = new BilliardHeroOrMonsterData();
			billiardHeroOrMonsterData.id = item.playerID;
			billiardHeroOrMonsterData.startHp = item.maxHP;
			billiardHeroOrMonsterData.endHp = item.remainHP;
			list.Add(billiardHeroOrMonsterData);
		}
		List<BilliardHeroOrMonsterData> list2 = new List<BilliardHeroOrMonsterData>();
		foreach (EntityEnemy item2 in entityEnemyList_)
		{
			BilliardHeroOrMonsterData billiardHeroOrMonsterData2 = new BilliardHeroOrMonsterData();
			billiardHeroOrMonsterData2.id = item2.enemyID;
			billiardHeroOrMonsterData2.startHp = item2.maxHP;
			billiardHeroOrMonsterData2.endHp = item2.remainHP;
			list2.Add(billiardHeroOrMonsterData2);
		}
		exchangeData.OnGameOver(3, second, seconds, list, list2, CurRound);
		isOver = true;
		return exchangeData;
	}

	public void UpdateEnemyDeadNum(int enemyID)
	{
		if (winTargetEnemyID == -1 || enemyID == winTargetEnemyID)
		{
			enemyDeathNum++;
		}
		if (winType != WinType.WipeOutEnemies && winType != WinType.WipeOutTarget)
		{
			return;
		}
		UpdateVictoryText();
		if (enemyDeathNum >= winTarget)
		{
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				OverGame(result: true);
			}, 2f, 1);
		}
	}

	public void UpdateVictoryText()
	{
		bool flag = false;
		int curNum;
		int allNum;
		if (winType == WinType.HoldOnForTurns)
		{
			curNum = curRound - 1;
			allNum = winTarget;
		}
		else
		{
			curNum = enemyDeathNum;
			allNum = winTarget;
			if (!isBallGame && winType == WinType.WipeOutTarget)
			{
				flag = curRound > winTarget;
				curNum = (flag ? enemyDeathNum : (curRound - 1));
				allNum = (flag ? 1 : winTarget);
				if (flag)
				{
					winTarget = 1;
				}
			}
		}
		BilliardGameUIManager.Instance.UpdateVictory(winType, curNum, allNum, flag);
	}

	private IEnumerator EnemyTurnDelay()
	{
		float tickNum = 0f;
		while ((!CheckActiveBullet() || !CheckPlayerRest()) && !(tickNum > 12f))
		{
			tickNum += Time.fixedDeltaTime;
			yield return new WaitForFixedUpdate();
		}
		ProcessToNextState();
	}

	public void OnClick(int entityID)
	{
		if (turnState == TurnState.PlayerShootPhase)
		{
			CheckUseSkill(entityID);
		}
	}

	public void OnBeginDrag(BilliardGameBall ball, Transform ballTrs, int entityID)
	{
		if (!CheckPlayerCanShoot(entityID))
		{
			ball.SelectBall(isSelect: false);
			dragLock = true;
			return;
		}
		foreach (EntityPlayer item in entityPlayerList_)
		{
			item.logic.HintBall(isHint: false);
		}
		ball.SelectBall(isSelect: true);
		uiRayCast.blocksRaycasts = false;
		dragLock = false;
		dragBeginPos = ballTrs.InverseTransformPoint(ballTrs.position);
		LuaHelper.CallFunction("OnBilliardGameDragStateChange", true);
	}

	public void OnDrag(Transform ballTrs, Vector3 pointer, bool isCancel, Action<Vector3, Vector3, bool, float> callback)
	{
		if (!dragLock)
		{
			Vector3 vector = ballTrs.InverseTransformPoint(pointer);
			dragEndPos.y = vector.y;
			dragEndPos.x = vector.x;
			Vector3 arg = dragBeginPos - dragEndPos;
			float magnitude = arg.magnitude;
			magnitude = Mathf.Clamp(magnitude, 1f, 3f);
			callback(arg, pointer, isCancel, magnitude / 3f);
		}
	}

	public void OnEndDrag(BilliardGameBall ball, int entityID, bool isCancel)
	{
		LuaHelper.CallFunction("OnBilliardGameDragStateChange", false);
		foreach (EntityPlayer item in entityPlayerList_)
		{
			if (turnState == TurnState.PlayerShootPhase)
			{
				item.logic.HintBall(!item.Tired);
			}
			else
			{
				item.logic.HintBall(isHint: false);
			}
		}
		uiRayCast.blocksRaycasts = true;
		ball.CancelBall(isCancel: false);
		ball.SelectBall(isSelect: false);
		if (isCancel || dragLock)
		{
			return;
		}
		Vector3 vector = dragBeginPos - dragEndPos;
		_ = vector.magnitude;
		vector.Normalize();
		if (guideInfo.isGuide)
		{
			Vector3 vector2 = new Vector3(guideInfo.x, guideInfo.y, 0f);
			if (Vector3.Angle(vector2, vector) > 30f)
			{
				ball.HideShootPre();
				return;
			}
			vector = vector2.normalized;
			guideInfo.FinishGuide();
		}
		SetSelectBuffOver(flag: false);
		if (turnState == TurnState.PlayerShootPhase)
		{
			EntityPlayer entityPlayer = (curShootPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityID));
			ProcessToNextState();
			entityPlayer.OnShoot(vector);
			ball.ShootBall(vector, 3f * entityPlayer.SPEED);
		}
		else
		{
			Debug.LogError("在不恰当的回合阶段拖动");
		}
	}

	public int GetComboNum()
	{
		return curRoundHitNumber;
	}

	public void AddCurRoundHitNumber(int addNum)
	{
		curRoundHitNumber += addNum;
		BilliardGameUIManager.Instance.UpdateCombo(curRoundHitNumber);
	}

	public void DoHitEnemy(int entityFromID, int entityToID)
	{
		AddCurRoundHitNumber(1);
		EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityFromID);
		EntityEnemy entityEnemy = entityEnemyList_.Find((EntityEnemy p) => p.entityID == entityToID && !p.Dead);
		entityPlayer?.OnCollisionEnemy(entityEnemy);
		entityEnemy?.BeCollision(entityPlayer);
	}

	public void DoPhysicalBulletHitEnemy(int entityFromID, int entityToID)
	{
		AddCurRoundHitNumber(1);
		EntityPhysicalBullet entityPhysicalBullet = entityPhysicalBulletList_.Find((EntityPhysicalBullet p) => p.entityID == entityFromID);
		EntityEnemy entityEnemy = entityEnemyList_.Find((EntityEnemy p) => p.entityID == entityToID && !p.Dead);
		entityPhysicalBullet?.OnCollisionEnemy(entityEnemy);
		entityEnemy?.BeCollision(entityPhysicalBullet);
	}

	public void DoPenetrateEnemy(int entityFromID, int entityToID)
	{
		AddCurRoundHitNumber(1);
		EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityFromID);
		EntityEnemy entityEnemy = entityEnemyList_.Find((EntityEnemy p) => p.entityID == entityToID && !p.Dead);
		entityPlayer?.OnPenetrate(entityEnemy);
		entityEnemy?.BePenetrate(entityPlayer);
	}

	public void DoPhysicalBulletPenetrateEnemy(int entityFromID, int entityToID)
	{
		AddCurRoundHitNumber(1);
		EntityPhysicalBullet entityPhysicalBullet = entityPhysicalBulletList_.Find((EntityPhysicalBullet p) => p.entityID == entityFromID);
		EntityEnemy entityEnemy = entityEnemyList_.Find((EntityEnemy p) => p.entityID == entityToID && !p.Dead);
		entityPhysicalBullet?.OnPenetrate(entityEnemy);
		entityEnemy?.BePenetrate(entityPhysicalBullet);
	}

	public void AddTotalDamage(int damage)
	{
		totalDamage += damage;
		BilliardGameUIManager.Instance.UpdateTotalDamage(totalDamage);
	}

	public void DoHitTeammate(int entityFromID, int entityToID)
	{
		EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityFromID);
		EntityPlayer entityPlayer2 = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityToID);
		entityPlayer.OnCollisionTeammate(entityPlayer2);
		entityPlayer2.BeCollision(entityPlayer);
	}

	public void DoHitMechanism(int entityFromID, int entityToID)
	{
		EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityFromID);
		EntityMechanism entityMechanism = entityMechanismList_.Find((EntityMechanism p) => p.entityID == entityToID);
		if (entityMechanism.mechanismType == MechanismType.Pot)
		{
			entityPlayer.OnCollisionPot(entityMechanism);
		}
		entityMechanism.BeCollision(entityPlayer);
	}

	public void DoPhysicalBulletHitMechanism(int entityFromID, int entityToID)
	{
		EntityPhysicalBullet entityPhysicalBullet = entityPhysicalBulletList_.Find((EntityPhysicalBullet p) => p.entityID == entityFromID);
		EntityMechanism entityMechanism = entityMechanismList_.Find((EntityMechanism p) => p.entityID == entityToID);
		if (entityMechanism.mechanismType == MechanismType.Pot)
		{
			entityPhysicalBullet.OnCollisionPot(entityMechanism);
		}
		entityMechanism.BeCollision(entityPhysicalBullet);
	}

	public void BulletCollisionPlayer(int entityFromID, int entityToID)
	{
		EntityBullet entityBullet = entityBulletList_.Find((EntityBullet p) => p.entityID == entityFromID);
		if (!(entityBullet.owner is EntityPlayer) && !(entityBullet.owner is EntityMechanism))
		{
			EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityToID);
			entityPlayer.BeCollision(entityBullet);
			entityBullet.OnCollision(entityPlayer);
		}
	}

	public void BulletCollisionEnemy(int entityFromID, int entityToID)
	{
		EntityBullet entityBullet = entityBulletList_.Find((EntityBullet p) => p.entityID == entityFromID);
		if (!(entityBullet.owner is EntityEnemy))
		{
			EntityEnemy entityEnemy = entityEnemyList_.Find((EntityEnemy p) => p.entityID == entityToID);
			entityEnemy.BeCollision(entityBullet);
			entityBullet.OnCollision(entityEnemy);
		}
	}

	public void BulletCollisionMech(int entityFromID, int entityToID)
	{
		EntityBullet entityBullet = entityBulletList_.Find((EntityBullet p) => p.entityID == entityFromID);
		if (!(entityBullet.owner is EntityEnemy) && entityBullet.canColWall)
		{
			entityBullet.OnCollision(null);
			return;
		}
		EntityMechanism entityMechanism = entityMechanismList_.Find((EntityMechanism p) => p.entityID == entityToID);
		if (entityMechanism.mechanismType != MechanismType.Pot)
		{
			if (entityBullet.canColWall)
			{
				entityBullet.OnCollision(null);
			}
			return;
		}
		if (entityBullet.owner is EntityEnemy)
		{
			entityMechanism.TakeDamage(entityBullet.ATK);
		}
		entityBullet.OnCollision(entityMechanism);
	}

	public void BulletCollisionBound(int bulletID)
	{
		entityBulletList_.Find((EntityBullet b) => b.entityID == bulletID).BeDestory();
	}

	public void BulletCollisionWall(int bulletID)
	{
		EntityBullet entityBullet = entityBulletList_.Find((EntityBullet b) => b.entityID == bulletID);
		if (entityBullet.canColWall)
		{
			entityBullet.OnCollision(null);
		}
	}

	public bool CheckPlayerCanShoot(int entityID)
	{
		if (turnState != TurnState.PlayerShootPhase)
		{
			return false;
		}
		if (!isBallGame && !isSelectedBuff)
		{
			return false;
		}
		EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => p.entityID == entityID);
		if (entityPlayer == null)
		{
			return false;
		}
		if (entityPlayer.Tired || entityPlayer.Dead)
		{
			return false;
		}
		return true;
	}

	public void SetSelectBuffOver(bool flag)
	{
		isSelectedBuff = flag;
	}

	public List<EntityPlayer> GetCirclePlayer(Vector3 pos, float radius)
	{
		List<EntityPlayer> list = new List<EntityPlayer>();
		GetCirclePlayer(pos, radius, list);
		return list;
	}

	public void GetCirclePlayer(Vector3 pos, float radius, List<EntityPlayer> outList)
	{
		outList.Clear();
		float num = radius * radius;
		foreach (EntityPlayer item in entityPlayerList_)
		{
			if ((item.position - pos).sqrMagnitude < num)
			{
				outList.Add(item);
			}
		}
	}

	public List<EntityEnemy> GetCircleEnemy(Vector3 pos, float radius)
	{
		List<EntityEnemy> list = new List<EntityEnemy>();
		GetCircleEnemy(pos, radius, list);
		return list;
	}

	public void GetCircleEnemy(Vector3 pos, float radius, List<EntityEnemy> outList)
	{
		outList.Clear();
		Vector2 vector = new Vector2(pos.x, pos.y);
		float num = radius * radius;
		foreach (EntityEnemy item in entityEnemyList_)
		{
			if (item.Dead)
			{
				continue;
			}
			Collider2D collider2D = item.logic?.GetEnemyCol();
			if (collider2D != null)
			{
				if ((collider2D.ClosestPoint(vector) - vector).sqrMagnitude <= num)
				{
					outList.Add(item);
				}
			}
			else if ((item.position - pos).sqrMagnitude <= num)
			{
				outList.Add(item);
			}
		}
	}

	public List<EntityEnemy> GetLineEnemy(Vector3 pos, float width, float dir)
	{
		bool flag = dir == -1f;
		bool flag2 = dir == 1f;
		List<EntityEnemy> list = new List<EntityEnemy>();
		foreach (EntityEnemy item in entityEnemyList_)
		{
			if (item.Dead)
			{
				continue;
			}
			if (flag)
			{
				if (math.abs(pos.x - item.position.x) <= width || math.abs(pos.y - item.position.y) <= width)
				{
					list.Add(item);
				}
			}
			else if (flag2)
			{
				if (math.abs(pos.x - item.position.x) <= width)
				{
					list.Add(item);
				}
			}
			else if (math.abs(pos.y - item.position.y) <= width)
			{
				list.Add(item);
			}
		}
		return list;
	}

	public bool GetCirclePot(Vector3 pos, float radius, out EntityMechanism target)
	{
		foreach (EntityMechanism item in entityMechanismList_)
		{
			if (item.mechanismType == MechanismType.Pot && (item.position - pos).sqrMagnitude < radius * radius)
			{
				target = item;
				return true;
			}
		}
		target = null;
		return false;
	}

	public EntityPlayer GetNearestPlayer(Vector3 pos)
	{
		EntityPlayer entityPlayer = null;
		float num = float.MaxValue;
		_ = Vector3.zero;
		foreach (EntityPlayer item in entityPlayerList_)
		{
			if (!item.Dead && (item.position - pos).sqrMagnitude < num * num)
			{
				entityPlayer = item;
				num = Vector3.Distance(item.position, pos);
				_ = entityPlayer.position;
			}
		}
		return entityPlayer;
	}

	public List<EntityEnemy> GetNearestEnemyList(Vector3 pos, int num, int tagetEntityID)
	{
		return (from e in entityEnemyList_
			where !e.Dead && e.entityID != tagetEntityID
			orderby (e.position - pos).sqrMagnitude
			select e).Take(num).ToList();
	}

	public EntityMechanism FindOtherPortal(int entityID, MechanismType mechanismType)
	{
		return entityMechanismList_.Find((EntityMechanism m) => m.mechanismType == mechanismType && m.entityID != entityID);
	}

	public BilliardGameEffect MakeEffectWorld(string effectName, Vector3 pos, float scale, Quaternion rotation = default(Quaternion), Action callBack = null)
	{
		return effectMgr.AddWorldEffect(effectName, pos, scale, rotation, callBack);
	}

	public BilliardGameEffect MakeEffectGo(string effectName, GameObject target, float scale, Action callBack = null)
	{
		return effectMgr.AddEffect(effectName, target, Vector3.zero, scale, callBack);
	}

	private bool CheckPlayerRest()
	{
		bool result = true;
		foreach (EntityPlayer item in entityPlayerList_)
		{
			if (!item.CheckRest())
			{
				result = false;
				break;
			}
		}
		return result;
	}

	private bool CheckActiveBullet()
	{
		bool result = true;
		foreach (EntityBullet item in entityBulletList_)
		{
			if (!item.Dead)
			{
				result = false;
				break;
			}
		}
		foreach (EntityPhysicalBullet item2 in entityPhysicalBulletList_)
		{
			if (!item2.Dead)
			{
				result = false;
				break;
			}
		}
		return result;
	}

	public void AddPlayerActiveTurn(EntityPlayer player, int turnNum)
	{
		player.LastTurnNum += turnNum;
	}

	public Transform GetPlayerTransByPos(int idx)
	{
		if (entityPlayerList_.Count > idx)
		{
			return entityPlayerList_[idx].logic.transform;
		}
		return null;
	}

	public void InitHero(int[] heroIDs)
	{
		BilliardGameUIManager.Instance.InitHero(heroIDs);
	}

	public void UpdateHero(int heroID, HeroHeadContext context)
	{
		BilliardGameUIManager.Instance.UpdateHero(heroID, context);
	}

	public void ShowHeroInfo(int index, List<int> buffList, List<int> timeList)
	{
		int player = BilliardGameScene.Context.GetPlayer(index);
		LuaHelper.CallFunction("OnBilliardGameShowHeroInfoUI", true, index, player, buffList, timeList);
	}

	public void CheckUseSkill(int entityID)
	{
		EntityPlayer entityPlayer = entityPlayerList_.Find((EntityPlayer p) => entityID == p.entityID);
		if (entityPlayer != null)
		{
			int playerID = entityPlayer.playerID;
			CastSkill(playerID);
		}
	}

	public void AddAllEnemyShield(int shield)
	{
		for (int i = 0; i < entityEnemyList_.Count; i++)
		{
			if (!entityEnemyList_[i].Dead)
			{
				entityEnemyList_[i].TakeShield(shield);
			}
		}
	}

	public void CameraShake()
	{
		if (noiseProfile != null)
		{
			noiseProfile.m_AmplitudeGain = shakeAmplitude;
			noiseProfile.m_FrequencyGain = shakeFrequency;
			Invoke("StopShaking", shakeDuration);
		}
	}

	private void StopShaking()
	{
		if (noiseProfile != null)
		{
			noiseProfile.m_AmplitudeGain = 0f;
			noiseProfile.m_FrequencyGain = 0f;
		}
	}

	private int GetSecond()
	{
		return (int)(double)LuaHelper.CallFunction("GetServerTime")[0];
	}

	public void ResetGuideInfo()
	{
		if (guideInfo == null)
		{
			guideInfo = new BilliardGameGuideInfo();
		}
		guideInfo.Reset();
	}

	public void SetGuideInfo(float x, float y)
	{
		ResetGuideInfo();
		guideInfo.SetData(x, y);
	}

	public bool CheckGuideInfo(float x, float y)
	{
		return guideInfo.isComplete;
	}

	public BilliardGameEventTrigger GetGuideTrigger()
	{
		return entityPlayerList_[0].logic.EventTrigger;
	}

	public void SetOver(bool isOver)
	{
		this.isOver = isOver;
	}

	public List<EntityPlayer> GetAllEntityPlayer()
	{
		return entityPlayerList_;
	}

	public List<EntityEnemy> GetAllEnemyEntityList()
	{
		return entityEnemyList_;
	}

	public List<EntityMechanism> GetAllMechanismEntityList()
	{
		return entityMechanismList_;
	}

	public List<EntityPhysicalBullet> GetAllPhysicalBulletEntityList()
	{
		return entityPhysicalBulletList_;
	}

	public EntityPhysicalBullet GetEntityPhysicalBullet(int entityID)
	{
		return entityPhysicalBulletList_.Find((EntityPhysicalBullet p) => p.entityID == entityID);
	}

	public List<Vector2> GetEmptySlot(float minX, float maxX, float minY, float maxY)
	{
		int num = Mathf.FloorToInt(maxX - minX) + 1;
		int num2 = Mathf.FloorToInt(maxY - minY) + 1;
		List<Vector2> list = new List<Vector2>();
		if (num <= 0 || num2 <= 0)
		{
			return list;
		}
		float num3 = 0.36f;
		for (int i = 0; i < num; i++)
		{
			float x = minX + (float)i;
			for (int j = 0; j < num2; j++)
			{
				float y = minY + (float)j;
				Vector2 vector = new Vector2(x, y);
				bool flag = true;
				foreach (EntityPlayer item in entityPlayerList_)
				{
					if (item.Dead)
					{
						continue;
					}
					Collider2D collider2D = item.logic?.GetPlayerCol();
					if (collider2D != null)
					{
						if ((collider2D.ClosestPoint(vector) - vector).sqrMagnitude <= num3)
						{
							flag = false;
							break;
						}
					}
					else if (Vector2.SqrMagnitude(new Vector2(item.position.x, item.position.y) - vector) <= num3)
					{
						flag = false;
						break;
					}
				}
				if (!flag)
				{
					continue;
				}
				foreach (EntityEnemy item2 in entityEnemyList_)
				{
					if (item2.Dead)
					{
						continue;
					}
					Collider2D collider2D2 = item2.logic?.GetEnemyCol();
					if (collider2D2 != null)
					{
						if ((collider2D2.ClosestPoint(vector) - vector).sqrMagnitude <= num3)
						{
							flag = false;
							break;
						}
					}
					else if (Vector2.SqrMagnitude(new Vector2(item2.position.x, item2.position.y) - vector) <= num3)
					{
						flag = false;
						break;
					}
				}
				if (!flag)
				{
					continue;
				}
				foreach (EntityMechanism item3 in entityMechanismList_)
				{
					if (item3 != null && !item3.Dead)
					{
						Collider2D component = item3.go.GetComponent<Collider2D>();
						if (component != null && (component.ClosestPoint(vector) - vector).sqrMagnitude <= num3)
						{
							flag = false;
							break;
						}
					}
				}
				if (flag)
				{
					list.Add(vector);
				}
			}
		}
		return list;
	}

	public void MagnifyMap(Action onMagnifyEnd)
	{
		LuaHelper.CallFunction("OnBilliardGameMapMagnify");
		float targetSize = stageData.magnifyParams[2];
		_ = stageData.magnifyMapStageId;
		baseMap.gameObject.SetActive(value: false);
		magnifyMap.gameObject.SetActive(value: true);
		foreach (EntityMechanism item in entityMechanismList_)
		{
			if (item.mechanismType == MechanismType.Wall && item.logic.hideWhenMagnify)
			{
				item.Dead = true;
				item.go.SetActive(value: false);
			}
		}
		normalSize.SetActive(value: false);
		magnifySize.SetActive(value: true);
		FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			float orthographicSize = mainCamera.m_Lens.OrthographicSize;
			tween = LeanTween.value(orthographicSize, targetSize, 2f).setOnUpdate(delegate(float value)
			{
				mainCamera.m_Lens.OrthographicSize = value;
			}).setOnComplete((Action)delegate
			{
				onMagnifyEnd();
			});
		}, 1.5f, 1);
	}

	public void AddMergeBuffGroup(int[] mergeBuffList, int playerId)
	{
		entityPlayerList_.Find((EntityPlayer p) => p.playerID == playerId).AddMergeBuffGroup(mergeBuffList);
	}

	public void ForceRemoveBuff(int buffId, int playerId)
	{
		entityPlayerList_.Find((EntityPlayer p) => p.playerID == playerId).ForceRemoveBuff(buffId);
	}

	public void AddBuff(int buffId, int playerId)
	{
		EntityPlayer caster = entityPlayerList_.Find((EntityPlayer p) => p.playerID == playerId);
		BilliardGameSpellManager.Instance.CastBuff(buffId, caster);
	}

	public List<int> GetBuffConnect(int buffId)
	{
		buffConnectDic.TryGetValue(buffId, out var value);
		if (value == null)
		{
			return new List<int>();
		}
		return value;
	}

	public void UpdateBuffConnect(int parentBuffId, int childBuffId)
	{
		buffConnectDic.TryGetValue(parentBuffId, out var value);
		if (value == null)
		{
			value = new List<int>();
			buffConnectDic[parentBuffId] = value;
		}
		value.Add(childBuffId);
	}

	public void ChangeOtherLayer(string targetLayer)
	{
		if (LayerMask.NameToLayer(targetLayer) == -1)
		{
			Debug.Log("Layer " + targetLayer + " does not exist!");
			return;
		}
		for (int i = 0; i < entityEnemyList_.Count; i++)
		{
			if (!entityEnemyList_[i].Dead)
			{
				entityEnemyList_[i].logic.gameObject.layer = LayerMask.NameToLayer(targetLayer);
			}
		}
		for (int j = 0; j < entityMechanismList_.Count; j++)
		{
			if (!entityMechanismList_[j].Dead && !(entityMechanismList_[j].logic == null))
			{
				entityMechanismList_[j].logic.gameObject.layer = LayerMask.NameToLayer(targetLayer);
			}
		}
	}
}
