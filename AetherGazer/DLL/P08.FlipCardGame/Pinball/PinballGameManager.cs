using System;
using System.Collections.Generic;
using System.Linq;
using Pinball.Runtime;
using UnityEngine;

namespace Pinball;

public class PinballGameManager : MonoBehaviour
{
	private enum GameState
	{
		Motion,
		Shoot,
		Static
	}

	public struct UniqueBlockInfo(int uniqueBlockID, BallPolygon data)
	{
		public int uniqueBlockID = uniqueBlockID;

		public BallPolygon data = data;
	}

	private class HiddenBlockInfo
	{
		public int blockID;

		public PolygonType originalType;

		public PolygonType convertType;

		public int remainingRounds;

		public bool isShielded;

		public BlockPathData pathData;

		public HiddenBlockInfo(int id, PolygonType type, int rounds, bool shielded, BlockPathData pathData, PolygonType convertType)
		{
			blockID = id;
			originalType = type;
			remainingRounds = rounds;
			isShielded = shielded;
			this.pathData = pathData;
			this.convertType = convertType;
		}
	}

	public static PinballGameManager Instance;

	private bool _insThis;

	[Header("绑定配置和模板")]
	[SerializeField]
	public List<GameObject> ballTemplate;

	[SerializeField]
	public List<GameObject> blockTemplate;

	[SerializeField]
	public Transform ballRootTrs;

	[SerializeField]
	public Transform blockRootTrs;

	[SerializeField]
	private PinballAimTrigger shootEvent;

	[SerializeField]
	private GameObject aimLineGo;

	[SerializeField]
	private Transform aimTargetTrs;

	[SerializeField]
	private Transform aimLineTrs;

	[SerializeField]
	private Transform aimRfLineTrs;

	[SerializeField]
	private SpriteRenderer aimTargetSp;

	[SerializeField]
	private SpriteRenderer aimLineSp;

	[SerializeField]
	private SpriteRenderer aimRfLineSp;

	[SerializeField]
	private Transform aimRayTrs;

	[SerializeField]
	public GameObject panelArrowGo;

	[SerializeField]
	public List<ParticleSystem> PlayAreaEffectList;

	[SerializeField]
	private float ballSpeed = 1f;

	private Color lineRed = new Color(0.65f, 0f, 0f);

	private Color targetRed = new Color(0.915f, 0f, 0f);

	private PinballMapGenerateData mapData;

	private StageData stageData;

	private StageData debateStageData;

	private StageData originStageData;

	private Dictionary<int, Vector2> cachePositionMap = new Dictionary<int, Vector2>();

	public bool isDebateStage;

	private int curGainBallItemCount;

	public const int WidthSize = 10;

	public const int HeightSize = 10;

	public int currentStageIndex;

	private const float ballRadius = 0.2f;

	public const float RSETPOSX = 5f;

	public const float RSETPOSY = 0f;

	private static readonly HashSet<int> specialItemValues = new HashSet<int>(Enum.GetValues(typeof(SpecialItemType)).Cast<int>());

	private float shootTime;

	private int shootIdx;

	private float intervalTime = 0.25f;

	private Vector2 shootVel = Vector2.zero;

	private Vector3 aimTarget = Vector3.zero;

	private int aimLineHideTimer;

	private bool isAiming;

	private CanvasGroup uiRayCast;

	[HideInInspector]
	public bool GMDoubleSpeed;

	[HideInInspector]
	public bool GMPause;

	public float currentStartTime;

	private GameState state = GameState.Static;

	public Vector2 ResetPos = new Vector2(5f, 0f);

	private bool hasChangedResetPos;

	public int startShootBallCount;

	public int shootBallCount;

	public int collsionCount;

	public int resetCollsionCount;

	public int affectHitDamage;

	private int stopBallCount;

	public List<Ball> BallList = new List<Ball>();

	private int uniqueBlockID;

	private int cacheUniqueBlockID;

	private Dictionary<int, BallPolygon> PolygonMap = new Dictionary<int, BallPolygon>();

	public Dictionary<int, BallPolygon> activeBlocks = new Dictionary<int, BallPolygon>();

	public Dictionary<int, PathNodeManager> activePointManager = new Dictionary<int, PathNodeManager>();

	public Dictionary<int, PathNodeManager> cacheActivePointManager = new Dictionary<int, PathNodeManager>();

	public Dictionary<int, float> portalCDDic = new Dictionary<int, float>();

	private Dictionary<int, BallPolygon> cachePolygonMap = new Dictionary<int, BallPolygon>();

	private List<int> removeUIDList = new List<int>();

	private List<UniqueBlockInfo> cacheTempUIDList = new List<UniqueBlockInfo>();

	private List<UniqueBlockInfo> addUIDList = new List<UniqueBlockInfo>();

	private List<UniqueBlockInfo> tempUIDList = new List<UniqueBlockInfo>();

	private List<Ball> cacheTempBallList = new List<Ball>();

	private StageData cacheStageData;

	private PinballDataForExchange oriPinballData;

	private Dictionary<int, Vector2> hiddenBlockPositions = new Dictionary<int, Vector2>();

	public PinballTurnBasedGame turnBasedGame;

	public bool isSupplmentFrame;

	public bool isSupplmenting;

	public bool isExplosionFrame;

	private Vector2 ballExplosionTriggerPos;

	private float ballExplosionTriggerLength;

	public int explosionBuffRemainCount;

	public float explosionBuffRange = 3f;

	public int arrowBuffRemainCount;

	private int breakblocktimes;

	public bool CanPlayGuide;

	private List<HiddenBlockInfo> hiddenByEnemyBlocks = new List<HiddenBlockInfo>();

	private bool needUpdateAimTarget;

	public int BreakBlockTimes
	{
		get
		{
			return breakblocktimes;
		}
		set
		{
			if (value != breakblocktimes)
			{
				breakblocktimes = value;
				turnBasedGame.SetUIBreakNumberText(value);
			}
		}
	}

	public PinballMapGenerateData MapData
	{
		get
		{
			return mapData;
		}
		set
		{
			mapData = value;
		}
	}

	private void Awake()
	{
		if (Instance == null)
		{
			Instance = this;
			_insThis = true;
			if (blockTemplate != null && blockRootTrs != null)
			{
				BlockPool.Instance.Initialize(blockTemplate, blockRootTrs);
			}
			else
			{
				Debug.LogWarning("BlockPool initialization failed: templates or root transform not set");
			}
		}
		else
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	private void OnDestroy()
	{
		if (uiRayCast != null)
		{
			uiRayCast.blocksRaycasts = true;
		}
		if (_insThis)
		{
			Instance = null;
			_insThis = false;
		}
	}

	private void Start()
	{
		shootEvent.SetClickCallBack(delegate(Vector3 p)
		{
			ClickShootBall(p);
		});
		shootEvent.SetDragBeginCallBack(delegate(Vector3 p)
		{
			DragBeginAim(p);
		});
		shootEvent.SetDragCallBack(delegate(Vector3 p)
		{
			DragAim(p);
		});
		shootEvent.SetDragEndCallBack(delegate(Vector3 p)
		{
			DragShootBall(p);
		});
	}

	private void Update()
	{
		if (GMPause)
		{
			return;
		}
		activeBlocks.Clear();
		foreach (KeyValuePair<int, BallPolygon> item in PolygonMap)
		{
			if (!removeUIDList.Contains(item.Key) && item.Value.HasGameObject())
			{
				activeBlocks.Add(item.Key, item.Value);
			}
		}
		foreach (UniqueBlockInfo tempUID in tempUIDList)
		{
			if (!removeUIDList.Contains(tempUID.uniqueBlockID))
			{
				activeBlocks.Add(tempUID.uniqueBlockID, tempUID.data);
			}
		}
		float num = (GMDoubleSpeed ? (Time.deltaTime * 2f) : Time.deltaTime);
		foreach (KeyValuePair<int, PathNodeManager> item2 in activePointManager)
		{
			if (item2.Value.GetPathData() != null)
			{
				item2.Value.UpdateMove(num);
			}
		}
		foreach (BallPolygon value in activeBlocks.Values)
		{
			if (value is NormalBlock normalBlock && normalBlock.HasGameObject())
			{
				normalBlock.AdjustVerticesAndNormals();
			}
		}
		if (state == GameState.Static)
		{
			if (portalCDDic.Count > 0)
			{
				portalCDDic.Clear();
			}
			if (turnBasedGame != null && turnBasedGame.State == PinballTurnBasedGame.TurnGameState.RoundBeginPhase)
			{
				needUpdateAimTarget = true;
			}
		}
		else if (state == GameState.Shoot)
		{
			if (shootTime < intervalTime)
			{
				shootTime += num;
			}
			else
			{
				if (shootIdx < startShootBallCount)
				{
					BallList[shootIdx].JustShow(show: true);
				}
				BallList[shootIdx].ActiveBall(shootVel);
				shootIdx++;
				shootBallCount++;
				shootTime = 0f;
				AudioManager.Instance.Play("effect", "minigame_activity_4_6", "minigame_activity_4_6_marble_shoot", useStream: false);
			}
			for (int i = 0; i < shootIdx; i++)
			{
				BallList[i].KinematicsUpdate(num);
			}
			if (shootIdx == shootBallCount)
			{
				state = GameState.Motion;
			}
		}
		else if (state == GameState.Motion)
		{
			for (int j = 0; j < shootBallCount; j++)
			{
				if (BallList[j] != null)
				{
					BallList[j].KinematicsUpdate(num);
				}
			}
			foreach (int item3 in portalCDDic.Keys.ToList())
			{
				if (portalCDDic[item3] > 0f)
				{
					portalCDDic[item3] -= num;
				}
			}
		}
		if (isExplosionFrame)
		{
			ExplosionInCircle(ballExplosionTriggerPos, ballExplosionTriggerLength);
			isExplosionFrame = false;
		}
		UpdateRemoveBlocks(needTriggerBlock: true);
		if (isSupplmentFrame)
		{
			SupplementBlocksAtRandomPoints();
		}
		isSupplmentFrame = false;
		if (addUIDList.Count > 0)
		{
			int k;
			for (k = addUIDList.Count - 1; k >= 0; k--)
			{
				bool num2 = PolygonMap.Count > 0 && PolygonMap.ContainsKey(addUIDList[k].uniqueBlockID);
				bool flag = tempUIDList.Exists((UniqueBlockInfo item) => item.uniqueBlockID == addUIDList[k].uniqueBlockID);
				if (!num2 && !flag)
				{
					PolygonMap.Add(addUIDList[k].uniqueBlockID, addUIDList[k].data);
				}
			}
			addUIDList.Clear();
		}
		if (state == GameState.Motion && turnBasedGame.State == PinballTurnBasedGame.TurnGameState.PlayerShootPhase && (stopBallCount == shootBallCount || (isDebateStage && turnBasedGame.CanExitDebateStage())))
		{
			RoundOver(forceBreak: true);
		}
		if (needUpdateAimTarget)
		{
			UpdateAimLineTarget();
			needUpdateAimTarget = false;
		}
	}

	public void UpdateRemoveBlocks(bool needTriggerBlock = false)
	{
		if (removeUIDList.Count <= 0 || !needTriggerBlock)
		{
			return;
		}
		while (removeUIDList.Count > 0)
		{
			int i = removeUIDList.Count - 1;
			if (PolygonMap.Count > 0 && PolygonMap.ContainsKey(removeUIDList[i]))
			{
				_ = PolygonMap[removeUIDList[i]];
				PolygonMap.Remove(removeUIDList[i]);
			}
			if (tempUIDList.Count > 0)
			{
				List<UniqueBlockInfo> list = tempUIDList.FindAll((UniqueBlockInfo uniqueBlockInfo) => uniqueBlockInfo.uniqueBlockID == removeUIDList[i]);
				if (list.Count > 0)
				{
					tempUIDList.Remove(list[0]);
				}
			}
			if (activeBlocks.Count > 0)
			{
				BallPolygon item = activeBlocks.Values.FirstOrDefault((BallPolygon ballPolygon) => ballPolygon.GetUniqueId() == removeUIDList[i]);
				if (item != null)
				{
					activeBlocks.Remove(removeUIDList[i]);
					foreach (int item2 in (from pair in activePointManager
						where pair.Value.GetMountedBlock() == item
						select pair.Key).ToList())
					{
						activePointManager[item2].UnmountBlock();
					}
					item.TriggerPolygonCallBackEffect();
				}
			}
			removeUIDList.RemoveAt(i);
		}
	}

	public void ClearAllItem()
	{
		foreach (PathNodeManager value in activePointManager.Values)
		{
			value.Release();
		}
		foreach (BallPolygon value2 in PolygonMap.Values)
		{
			(value2 as NormalBlock).Release();
		}
		foreach (BallPolygon value3 in activeBlocks.Values)
		{
			(value3 as NormalBlock).Release();
		}
		foreach (Ball ball in BallList)
		{
			ball.Release();
		}
		foreach (Ball cacheTempBall in cacheTempBallList)
		{
			cacheTempBall.Release();
		}
		BallList.Clear();
		PolygonMap.Clear();
		activeBlocks.Clear();
		addUIDList.Clear();
		removeUIDList.Clear();
		tempUIDList.Clear();
		activePointManager.Clear();
		cacheTempBallList.Clear();
		foreach (BallPolygon item in from x in cacheTempUIDList.Concat(tempUIDList)
			select x.data)
		{
			item.Release();
		}
		if (ballRootTrs.childCount > 0)
		{
			for (int num = ballRootTrs.childCount - 1; num >= 0; num--)
			{
				UnityEngine.Object.Destroy(ballRootTrs.GetChild(num).gameObject);
			}
		}
	}

	public void InitTurnBasedPinballGame(GameObject turnBasedGameGo, PinballDataForExchange data)
	{
		GMPause = false;
		CanPlayGuide = false;
		collsionCount = 0;
		resetCollsionCount = 0;
		affectHitDamage = 0;
		isSupplmenting = false;
		isSupplmentFrame = false;
		isExplosionFrame = false;
		MapData = data.mapData;
		stageData = data.mapData.stageData;
		originStageData = stageData;
		oriPinballData = data;
		currentStageIndex = Array.IndexOf(MapData.stageIDList, stageData.stageId);
		turnBasedGame = turnBasedGameGo.GetComponent<PinballTurnBasedGame>();
		ClearAllItem();
		turnBasedGame.StopTimer();
		turnBasedGame.InitRoleBattleData(data);
		if (currentStageIndex == -1)
		{
			Debug.LogError("加载关卡和生成的配置第一关ID对应不上,需要重新检查配置");
		}
		turnBasedGame.GameRestart();
		InitPlayAreaEffect();
		panelArrowGo.SetActive(value: false);
		aimLineGo.SetActive(value: false);
		PlayAreaEffectList[0].transform.parent.SetActive(bActive: true);
		PlayAreaEffectList[0].Play();
		MapStartGeneration();
		currentStartTime = Time.time;
		uiRayCast = GameObject.Find("UICamera/Canvas").GetComponent<CanvasGroup>();
		ResetPos = new Vector2(5f, 0f);
		isAiming = false;
		explosionBuffRemainCount = 0;
		arrowBuffRemainCount = 0;
		state = GameState.Static;
	}

	public void InitPlayAreaEffect()
	{
		foreach (ParticleSystem playAreaEffect in PlayAreaEffectList)
		{
			if (playAreaEffect != null)
			{
				playAreaEffect.transform.parent.SetActive(bActive: false);
			}
		}
	}

	public void DebateInitGame(StageData data)
	{
		turnBasedGame.SaveCurrRoundInfo();
		turnBasedGame.SaveDebateStartStageInfo();
		LuaHelper.CallFunction("PinballBridge.UpgradeStageParamsFromCfg", data);
		cacheStageData = MapData.stageData;
		MapData.stageData = data;
		SavePolygonMap();
		PlayAreaEffectList[1].transform.parent.SetActive(bActive: true);
		PlayAreaEffectList[1].Play();
		MapStartGeneration();
		ResetPos = new Vector2(5f, 0f);
	}

	private void MapStartGeneration()
	{
		if (MapData == null || MapData.stageData == null || MapData.stageData.polygonBlocks == null)
		{
			Debug.LogError("没有传入地图生成数据或数据为空");
			return;
		}
		isDebateStage = MapData.stageData.isDebateStage;
		uniqueBlockID = 0;
		ClearAllItem();
		if (blockRootTrs.childCount > 0)
		{
			for (int num = blockRootTrs.childCount - 1; num >= 0; num--)
			{
				Transform child = blockRootTrs.GetChild(num);
				BlockPool.Instance.ReturnBlock(child.gameObject);
			}
		}
		float num2 = 0f;
		foreach (RandomPolygon excludePolygonBlock in stageData.excludePolygonBlocks)
		{
			if (excludePolygonBlock.weight > 0f)
			{
				num2 += excludePolygonBlock.weight;
			}
		}
		foreach (PolygonBlockData polygonBlock in MapData.stageData.polygonBlocks)
		{
			Vector3 localPosition = new Vector3(polygonBlock.localPos.x, polygonBlock.localPos.y, 0f);
			PolygonType type = polygonBlock.type;
			PolygonType polygonType = polygonBlock.convertType;
			BlockPathData pathData = polygonBlock.pathData;
			if (polygonType == PolygonType.None)
			{
				polygonType = type;
			}
			if (type == PolygonType.randomSpawnPoint)
			{
				float num3 = UnityEngine.Random.Range(0f, num2);
				float num4 = 0f;
				foreach (RandomPolygon excludePolygonBlock2 in MapData.stageData.excludePolygonBlocks)
				{
					num4 += excludePolygonBlock2.weight;
					if (num3 <= num4)
					{
						type = excludePolygonBlock2.type;
					}
				}
			}
			int remain = MapData.stageData.baseremainHp;
			if (Enum.IsDefined(typeof(StaticItemType), (int)type))
			{
				remain = turnBasedGame.GetRandomStaticItemHpValue();
			}
			GameObject block = BlockPool.Instance.GetBlock(type);
			if (block == null)
			{
				Debug.LogError($"Failed to get block from pool: {type}");
				continue;
			}
			block.transform.localPosition = localPosition;
			block.name = $"[{localPosition.x},{localPosition.y}] {type}";
			NormalBlock normalBlock = new NormalBlock(runtimePos: new Vector2(localPosition.x, localPosition.y), uniqueId: uniqueBlockID, go: block, remain: remain, pType: type, pathData: pathData, convertType: type);
			float[] param = new float[4] { 0f, 0f, 0f, 1f };
			if (polygonType == PolygonType.protect)
			{
				normalBlock.SetBuffWithCount(BlockBuffType.protect, param);
			}
			if (pathData != null && pathData.pathPoints.Count >= 2)
			{
				GameObject block2 = BlockPool.Instance.GetBlock(PolygonType.pathNode);
				if (block2 == null)
				{
					Debug.LogError("Failed to get path node from pool");
					continue;
				}
				block2.transform.localPosition = localPosition;
				block2.name = $"[{localPosition.x},{localPosition.y}] {type}";
				int num5 = MapData.stageData.polygonBlocks.IndexOf(polygonBlock);
				PathNodeManager pathNodeManager = new PathNodeManager(num5, block2, pathData);
				pathNodeManager.MountBlock(normalBlock);
				activePointManager.Add(num5, pathNodeManager);
			}
			AddUIDToAddList(uniqueBlockID, normalBlock);
			uniqueBlockID++;
		}
	}

	public void GMToNextWave()
	{
		turnBasedGame.GMToNextWave();
	}

	public void NextStage()
	{
		turnBasedGame.SaveCurrRoundInfo();
		stageData = AssetManager.Load<StageData>("PinballGame/StageData/PinBallGameStage_" + MapData.stageIDList[currentStageIndex + 1] + ".asset");
		LuaHelper.CallFunction("PinballBridge.UpgradeStageParamsFromCfg", stageData);
		MapData.stageData = stageData;
		currentStageIndex++;
		PlayAreaEffectList[1].transform.parent.SetActive(bActive: true);
		PlayAreaEffectList[1].Play();
		turnBasedGame.NextStage();
		CanPlayGuide = false;
		MapStartGeneration();
	}

	public void AwakeAimLine()
	{
		panelArrowGo.transform.localPosition = new Vector3(ResetPos.x, 0f, 0f);
		panelArrowGo.SetActive(value: true);
		if (BallList.Count == 0)
		{
			AddNewBall(show: true, BallType.normalBall);
		}
		else
		{
			BallList[0].JustShow(show: true);
			BallList[0].ResetBall(onlyStatic: false);
		}
		aimTarget = new Vector3(ResetPos.x, ResetPos.y + 1f, 0f);
		aimLineGo.SetActive(value: true);
		aimLineSp.color = Color.white;
		aimTargetSp.color = Color.white;
		needUpdateAimTarget = true;
		turnBasedGame.OnStopAimingTipsShow(show: true);
	}

	private void UpdateAimLineTarget()
	{
		Vector2 normalized = new Vector2(aimTarget.x - ResetPos.x, aimTarget.y - ResetPos.y).normalized;
		Vector2 vector = Vector2.zero;
		int num = -1;
		float num2 = 560000f;
		foreach (int key in activeBlocks.Keys)
		{
			if (activeBlocks[key].HasGameObject())
			{
				activeBlocks[key].ShowSelectEffect(show: false);
				Vector2 newPosition = Vector2.zero;
				Vector2 newVelocity = Vector2.zero;
				float num3 = activeBlocks[key].CheckCollision(ResetPos, normalized, 0.2f, out newPosition, out newVelocity);
				if (num3 < num2)
				{
					num2 = num3;
					vector = newPosition;
					num = key;
				}
			}
		}
		if (num != -1 && activeBlocks[num].HasGameObject())
		{
			activeBlocks[num].ShowSelectEffect(show: true);
			aimRfLineTrs.gameObject.SetActive(value: false);
			aimTargetTrs.localPosition = new Vector3(vector.x, vector.y, 0f);
			aimLineTrs.localPosition = new Vector3((vector.x + ResetPos.x) / 2f, (vector.y + ResetPos.y) / 2f, 0f);
			float num4 = Mathf.Atan((vector.y - ResetPos.y) / (vector.x - ResetPos.x)) * 57.29578f;
			if (num4 > 180f)
			{
				num4 -= 180f;
			}
			if (num4 < 0f)
			{
				num4 += 180f;
			}
			aimLineTrs.localEulerAngles = new Vector3(0f, 0f, num4);
			aimTargetTrs.localEulerAngles = new Vector3(0f, 0f, num4 + 90f);
			float num5 = Vector2.Distance(vector, ResetPos) - 0.4f;
			aimLineSp.size = new Vector2(num5, aimLineSp.size.y);
			float num6 = Mathf.Min(num5 / 4f, 1f);
			float num7 = num5 / 2f - 1.23f * num6 + 0.2f;
			aimRayTrs.localScale = new Vector3(num6, num6, num6);
			aimRayTrs.localPosition = new Vector3(0f - num7, 0f, 0f);
			return;
		}
		Vector2 vector2 = Vector2.zero;
		Vector2 vector3 = Vector2.zero;
		float num8 = ((normalized.x < -1E-05f) ? ((0.2f - ResetPos.x) / normalized.x) : 560000f);
		if (num8 < num2)
		{
			num2 = num8;
			vector2 = ResetPos + num2 * normalized;
			vector3 = new Vector2(0f - normalized.x, normalized.y);
		}
		float num9 = ((normalized.y > 1E-05f) ? ((9.8f - ResetPos.y) / normalized.y) : 560000f);
		if (num9 < num2)
		{
			num2 = num9;
			vector2 = ResetPos + num2 * normalized;
			vector3 = new Vector2(normalized.x, 0f - normalized.y);
		}
		float num10 = ((normalized.x > 1E-05f) ? ((9.8f - ResetPos.x) / normalized.x) : 560000f);
		if (num10 < num2)
		{
			num2 = num10;
			vector2 = ResetPos + num2 * normalized;
			vector3 = new Vector2(0f - normalized.x, normalized.y);
		}
		aimRfLineTrs.gameObject.SetActive(value: true);
		aimLineTrs.localPosition = new Vector3((vector2.x + ResetPos.x) / 2f, (vector2.y + ResetPos.y) / 2f, 0f);
		float num11 = Mathf.Atan((vector2.y - ResetPos.y) / (vector2.x - ResetPos.x)) * 57.29578f;
		if (num11 > 180f)
		{
			num11 -= 180f;
		}
		if (num11 < 0f)
		{
			num11 += 180f;
		}
		aimLineTrs.localEulerAngles = new Vector3(0f, 0f, num11);
		float num12 = Vector2.Distance(vector2, ResetPos);
		aimLineSp.size = new Vector2(num12, aimLineSp.size.y);
		float num13 = Mathf.Min(num12 / 4f, 1f);
		float num14 = num12 / 2f - 1.23f * num13 + 0.2f;
		aimRayTrs.localScale = new Vector3(num13, num13, num13);
		aimRayTrs.localPosition = new Vector3(0f - num14, 0f, 0f);
		num2 = 560000f;
		foreach (int key2 in activeBlocks.Keys)
		{
			Vector2 newPosition2 = Vector2.zero;
			Vector2 newVelocity2 = Vector2.zero;
			float num15 = activeBlocks[key2].CheckCollision(vector2, vector3, 0.2f, out newPosition2, out newVelocity2);
			if (num15 < num2)
			{
				num2 = num15;
				vector = newPosition2;
				num = key2;
			}
		}
		if (num != -1)
		{
			activeBlocks[num].ShowSelectEffect(show: true);
		}
		num8 = ((vector3.x < -1E-05f) ? ((0.2f - vector2.x) / vector3.x) : 560000f);
		if (num8 < num2)
		{
			num2 = num8;
			vector = vector2 + num2 * vector3;
		}
		num9 = ((vector3.y > 1E-05f) ? ((9.8f - vector2.y) / vector3.y) : 560000f);
		if (num9 < num2)
		{
			num2 = num9;
			vector = vector2 + num2 * vector3;
		}
		num10 = ((vector3.x > 1E-05f) ? ((9.8f - vector2.x) / vector3.x) : 560000f);
		if (num10 < num2)
		{
			num2 = num10;
			vector = vector2 + num2 * vector3;
		}
		float num16 = ((vector3.y < -1E-05f) ? ((-0.2f - vector2.y) / vector3.y) : 560000f);
		if (num16 < num2)
		{
			num2 = num16;
			vector = vector2 + num2 * vector3;
		}
		aimTargetTrs.localPosition = new Vector3(vector.x, vector.y, 0f);
		Vector2 a = vector - 0.2f * vector3;
		float num17 = Mathf.Atan((a.y - vector2.y) / (a.x - vector2.x)) * 57.29578f;
		aimRfLineTrs.localPosition = new Vector3((a.x + vector2.x) / 2f, (a.y + vector2.y) / 2f, 0f);
		aimRfLineTrs.localEulerAngles = new Vector3(0f, 0f, num17);
		aimTargetTrs.localEulerAngles = new Vector3(0f, 0f, (num17 < 0f) ? (num17 - 90f + (float)((vector3.y < 0f) ? 180 : 0)) : (num17 + 90f + (float)((vector3.y < 0f) ? 180 : 0)));
		aimRfLineSp.size = new Vector2(Vector2.Distance(a, vector2), aimRfLineSp.size.y);
	}

	public void ShootBall()
	{
		if (state == GameState.Static)
		{
			hasChangedResetPos = false;
			startShootBallCount = 1;
			shootBallCount = 0;
			shootIdx = 0;
			shootTime = intervalTime;
			stopBallCount = 0;
			shootVel = new Vector2(aimTarget.x - ResetPos.x, aimTarget.y - ResetPos.y).normalized * ballSpeed;
			state = GameState.Shoot;
			turnBasedGame.ProcessToNextState();
		}
	}

	public void RoundOver(bool forceBreak)
	{
		if (state == GameState.Static)
		{
			return;
		}
		state = GameState.Static;
		if (forceBreak)
		{
			for (int num = BallList.Count - 1; num >= 0; num--)
			{
				BallList[num].OnRoundAfter();
			}
			foreach (BallPolygon value in activeBlocks.Values)
			{
				value.OnRoundAfter();
			}
		}
		foreach (Ball ball in BallList)
		{
			ball.Release();
		}
		BallList.Clear();
		shootBallCount = 0;
		turnBasedGame.ProcessToNextState();
		explosionBuffRemainCount = 0;
		arrowBuffRemainCount = 0;
	}

	public void GameRestart()
	{
		MapData.stageData = originStageData;
		stageData = originStageData;
		GMPause = false;
		CanPlayGuide = false;
		collsionCount = 0;
		resetCollsionCount = 0;
		affectHitDamage = 0;
		ClearAllItem();
		currentStageIndex = Array.IndexOf(MapData.stageIDList, stageData.stageId);
		turnBasedGame.StopTimer();
		turnBasedGame.InitRoleBattleData(oriPinballData);
		if (currentStageIndex == -1)
		{
			Debug.LogError("加载关卡和生成的配置第一关ID对应不上,需要重新检查配置");
		}
		turnBasedGame.GameRestart();
		InitPlayAreaEffect();
		PlayAreaEffectList[0].transform.parent.SetActive(bActive: true);
		PlayAreaEffectList[0].Play();
		MapStartGeneration();
		currentStartTime = Time.time;
		uiRayCast = GameObject.Find("UICamera/Canvas").GetComponent<CanvasGroup>();
		ResetPos = new Vector2(5f, 0f);
		isAiming = false;
		explosionBuffRemainCount = 0;
		arrowBuffRemainCount = 0;
		state = GameState.Static;
	}

	public void InterruptExitGame()
	{
		state = GameState.Static;
		needUpdateAimTarget = false;
		turnBasedGame.GameSendData(interrupt: true);
		turnBasedGame.OnGameInterruptExit();
		StopTimer();
		panelArrowGo.SetActive(value: false);
		aimLineGo.SetActive(value: false);
		curGainBallItemCount = 0;
		ResetPos = new Vector2(5f, 0f);
		isAiming = false;
		explosionBuffRemainCount = 0;
		arrowBuffRemainCount = 0;
		currentStageIndex = Array.IndexOf(MapData.stageIDList, stageData.stageId);
		uniqueBlockID = 0;
		ClearAllItem();
		for (int num = blockRootTrs.childCount - 1; num >= 0; num--)
		{
			Transform child = blockRootTrs.GetChild(num);
			BlockPool.Instance.ReturnBlock(child.gameObject);
		}
		GMPause = true;
	}

	public void StopABall(Vector2 newResetPos, bool onGround)
	{
		stopBallCount++;
		if (onGround && !hasChangedResetPos)
		{
			hasChangedResetPos = true;
		}
	}

	private void ClickShootBall(Vector3 pointer)
	{
		if (turnBasedGame == null || !turnBasedGame.CheckStateToShootBall())
		{
			return;
		}
		Vector3 vector = ballRootTrs.InverseTransformPoint(pointer);
		if (vector.y <= -0.5f || vector.y >= 10.5f || vector.x <= 0f || (double)vector.x >= 10.5)
		{
			return;
		}
		panelArrowGo.SetActive(value: false);
		aimTarget = ballRootTrs.InverseTransformPoint(pointer);
		aimTarget.y = Mathf.Clamp(aimTarget.y, 0f, 10f);
		aimTarget.x = Mathf.Clamp(aimTarget.x, 0f, 10f);
		UpdateAimLineTarget();
		aimLineHideTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (aimLineGo != null)
			{
				foreach (int key in activeBlocks.Keys)
				{
					activeBlocks[key].ShowSelectEffect(show: false);
				}
				aimLineGo.SetActive(value: false);
				ShootBall();
			}
			FuncTimerManager.inst.RemoveFuncTimer(aimLineHideTimer);
		}, 0.2f, 1);
	}

	private void DragBeginAim(Vector3 pointer)
	{
		if (turnBasedGame.CheckStateToShootBall())
		{
			panelArrowGo.SetActive(value: false);
			turnBasedGame.OnAimingTipsShow(show: true);
			turnBasedGame.OnStopAimingTipsShow(show: false);
			uiRayCast.blocksRaycasts = false;
			isAiming = true;
		}
	}

	private void DragAim(Vector3 pointer)
	{
		if (turnBasedGame.CheckStateToShootBall() && isAiming)
		{
			Vector3 vector = ballRootTrs.InverseTransformPoint(pointer);
			if (vector.y <= -0.5f || vector.y >= 10.5f || vector.x <= 0f || (double)vector.x >= 10.5)
			{
				aimTarget = new Vector3(ResetPos.x, ResetPos.y + 1f, 0f);
				aimLineSp.color = lineRed;
				aimTargetSp.color = targetRed;
			}
			else
			{
				aimTarget.y = Mathf.Clamp(vector.y, 0f, 10f);
				aimTarget.x = vector.x;
				aimLineSp.color = Color.white;
				aimTargetSp.color = Color.white;
			}
			UpdateAimLineTarget();
		}
	}

	private void DragShootBall(Vector3 pointer)
	{
		uiRayCast.blocksRaycasts = true;
		turnBasedGame.OnAimingTipsShow(show: false);
		if (!turnBasedGame.CheckStateToShootBall())
		{
			if (turnBasedGame.State == PinballTurnBasedGame.TurnGameState.RoundBeginPhase)
			{
				turnBasedGame.OnStopAimingTipsShow(show: true);
			}
			return;
		}
		if (!isAiming)
		{
			turnBasedGame.OnStopAimingTipsShow(show: true);
			return;
		}
		isAiming = false;
		Vector3 vector = ballRootTrs.InverseTransformPoint(pointer);
		if (vector.y <= -0.5f || vector.y >= 10.5f || vector.x <= 0f || (double)vector.x >= 10.5)
		{
			panelArrowGo.SetActive(value: true);
			aimLineSp.color = Color.white;
			aimTargetSp.color = Color.white;
			return;
		}
		foreach (int key in activeBlocks.Keys)
		{
			if (activeBlocks[key].HasGameObject())
			{
				activeBlocks[key].ShowSelectEffect(show: false);
			}
		}
		aimLineGo.SetActive(value: false);
		ShootBall();
	}

	public void OnResetBlockBreak()
	{
		isSupplmentFrame = true;
		resetCollsionCount++;
	}

	public void OnAffectBlockTriger(Vector2 blockPos, float[] param)
	{
		AffectAroundBlock(blockPos, param);
	}

	public Ball AddNewBall(bool show, BallType type, float posX = 5f, float posY = 0f)
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(ballTemplate[(int)(type - 1)], ballRootTrs);
		if (!show)
		{
			gameObject.SetActive(value: false);
		}
		gameObject.transform.localPosition = new Vector3(posX, posY, 0f);
		Ball ball = new Ball(0.2f, gameObject.transform, type);
		ball.ResetBall(onlyStatic: false);
		BallList.Add(ball);
		Debug.Log("共有" + BallList.Count + "个球");
		return ball;
	}

	private PolygonType GetRandomBlockTypeByWeightExcluding(List<RandomPolygon> allowedTypes)
	{
		if (allowedTypes == null || allowedTypes.Count == 0)
		{
			return PolygonType.damageBlock;
		}
		float num = 0f;
		foreach (RandomPolygon allowedType in allowedTypes)
		{
			if (allowedType.weight > 0f)
			{
				num += allowedType.weight;
			}
		}
		if (num <= 0f)
		{
			return allowedTypes[0].type;
		}
		float num2 = UnityEngine.Random.Range(0f, num);
		float num3 = 0f;
		foreach (RandomPolygon allowedType2 in allowedTypes)
		{
			num3 += allowedType2.weight;
			if (num2 <= num3)
			{
				return allowedType2.type;
			}
		}
		return allowedTypes[allowedTypes.Count - 1].type;
	}

	public void SupplementBlocksAtRandomPoints()
	{
		if (MapData == null || PolygonMap == null || isSupplmenting)
		{
			return;
		}
		StageData stageData = MapData.stageData;
		if (stageData == null)
		{
			return;
		}
		isSupplmenting = true;
		HashSet<Vector2> existingPositions = new HashSet<Vector2>(activeBlocks.Values.Select((BallPolygon ballPolygon) => ballPolygon.GetLocalPosition()));
		int num = activeBlocks.Values.Count((BallPolygon ballPolygon) => ballPolygon.GetPType() == PolygonType.resetBlock && ballPolygon.HasGameObject());
		int num2 = Mathf.Max(0, stageData.resBlockNum - num);
		if (stageData.resBlockNum != 0 && num2 == 0)
		{
			Debug.Log("未生成重置砖块,配置砖块数量" + stageData.resBlockNum + "当前砖块数量" + num);
		}
		List<PolygonBlockData> list = stageData.polygonBlocks.Where((PolygonBlockData polygonBlockData) => ((polygonBlockData.pathData == null || polygonBlockData.pathData.pathPoints.Count < 2) && !existingPositions.Contains(polygonBlockData.localPos)) || (polygonBlockData.pathData != null && polygonBlockData.pathData.pathPoints.Count >= 2 && activePointManager.Values.Any((PathNodeManager manager) => manager.GetUniqueId() == stageData.polygonBlocks.IndexOf(polygonBlockData) && manager.GetMountedBlock() == null))).ToList();
		Shuffle(list);
		int num3 = activeBlocks.Values.Count((BallPolygon ballPolygon) => specialItemValues.Contains((int)ballPolygon.GetPType()));
		bool flag = num3 < stageData.supplementTriggerNumber;
		foreach (PolygonBlockData item in list)
		{
			PolygonType polygonType;
			if (item.type != PolygonType.randomSpawnPoint && !item.canRamdon)
			{
				polygonType = item.type;
			}
			else if (num2 > 0)
			{
				polygonType = PolygonType.resetBlock;
				num2--;
			}
			else if (!flag || num3 >= stageData.supplementMaxNumber)
			{
				polygonType = PolygonType.damageBlock;
			}
			else
			{
				polygonType = GetRandomBlockTypeByWeightExcluding(stageData.excludePolygonBlocks);
				num3++;
			}
			if (blockTemplate[(int)(polygonType - 1)] == null)
			{
				Debug.LogWarning($"未找到类型 {polygonType} 的预制体");
				continue;
			}
			GameObject block = BlockPool.Instance.GetBlock(polygonType);
			if (block == null)
			{
				Debug.LogError("Failed to get block from pool Type:" + polygonType);
				continue;
			}
			Vector2 localPos = item.localPos;
			block.transform.localPosition = new Vector3(localPos.x, localPos.y, 0f);
			block.name = $"[{item.localPos.x},{item.localPos.y}] {polygonType}";
			int baseremainHp = stageData.baseremainHp;
			BlockPathData pathData = item.pathData;
			NormalBlock normalBlock = new NormalBlock(uniqueBlockID, block, item.localPos, baseremainHp, polygonType, pathData, polygonType);
			float[] param = new float[4] { 0f, 0f, 0f, 2f };
			if (polygonType == PolygonType.protect)
			{
				normalBlock.SetBuffWithCount(BlockBuffType.protect, param);
			}
			if (pathData != null && pathData.pathPoints.Count >= 2)
			{
				int index = stageData.polygonBlocks.IndexOf(item);
				activePointManager.Values.First((PathNodeManager manager) => index == manager.GetUniqueId()).MountBlock(normalBlock);
			}
			AddUIDToAddList(uniqueBlockID, normalBlock);
			uniqueBlockID++;
			existingPositions.Add(item.localPos);
		}
		isSupplmenting = false;
		if (needUpdateAimTarget)
		{
			UpdateAimLineTarget();
			needUpdateAimTarget = false;
		}
	}

	private static void Shuffle<T>(IList<T> list)
	{
		for (int num = list.Count - 1; num > 0; num--)
		{
			int num2 = UnityEngine.Random.Range(0, num + 1);
			int index = num;
			int index2 = num2;
			T val = list[num2];
			T val2 = list[num];
			T val3 = (list[index] = val);
			val3 = (list[index2] = val2);
		}
	}

	public void BallExplosionInCircle(Vector2 blockPos, float length = 0f)
	{
		isExplosionFrame = true;
		ballExplosionTriggerPos = blockPos;
		ballExplosionTriggerLength = length;
	}

	public void ExplosionInCircle(Vector2 blockPos, float length = 0f)
	{
		float num = ((length == 0f) ? ((float)MapData.stageData.baseExplosionLength) : length);
		foreach (KeyValuePair<int, BallPolygon> activeBlock in activeBlocks)
		{
			NormalBlock normalBlock = (NormalBlock)activeBlock.Value;
			if (normalBlock != null)
			{
				Vector2 localPosition = normalBlock.GetLocalPosition();
				if ((double)Mathf.Abs(localPosition.x - blockPos.x) <= (double)(num / 2f) - 0.2 && (double)Mathf.Abs(localPosition.y - blockPos.y) <= (double)(num / 2f) - 0.2 && !Enum.IsDefined(typeof(StaticItemType), (int)normalBlock.GetPType()))
				{
					normalBlock.ExplosionTriggerWithoutBall();
				}
			}
		}
	}

	public void EnterPortal(Vector2 blockPos, Ball ball)
	{
		List<BallPolygon> list = activeBlocks.Values.Where((BallPolygon p) => p.GetPosition() != blockPos && p.GetPType() == PolygonType.portal && (!portalCDDic.ContainsKey(p.GetUniqueId()) || portalCDDic[p.GetUniqueId()] <= 0f)).ToList();
		if (list.Count > 0 && MapData.stageData != null)
		{
			NormalBlock normalBlock = (NormalBlock)list[UnityEngine.Random.Range(0, list.Count - 1)];
			Vector3 vector = ballRootTrs.InverseTransformPoint(normalBlock.GetPosition());
			ball.SetPosition(vector);
			if (portalCDDic.ContainsKey(normalBlock.GetUniqueId()))
			{
				portalCDDic[normalBlock.GetUniqueId()] = MapData.stageData.baseExitPortalCD;
			}
			else
			{
				portalCDDic.Add(normalBlock.GetUniqueId(), MapData.stageData.baseExitPortalCD);
			}
		}
	}

	private void StopTimer()
	{
		FuncTimerManager.inst.StopFuncTimer(aimLineHideTimer);
		FuncTimerManager.inst.RemoveFuncTimer(aimLineHideTimer);
	}

	public int GetRecoveryBlockValue()
	{
		return turnBasedGame.GetRecoveryBlockValue();
	}

	public int GetBaseOverTimes()
	{
		return MapData.stageData.baseOverTimes + turnBasedGame.extraOverTimes;
	}

	public void SetAllBallTypeForSkill(int bType, int time, float[] param)
	{
		if (state != GameState.Static)
		{
			return;
		}
		foreach (Ball ball in BallList)
		{
			ball.ConvertBallType((BallType)bType, time, param);
		}
	}

	public void SetBallBuffWithCount(int buffType, int time, float[] param)
	{
		if (state != GameState.Static)
		{
			return;
		}
		foreach (Ball ball in BallList)
		{
			ball.SetBuffWithCount((BallBuffType)buffType, time, param);
		}
	}

	public void ChangeAllBlockRemainHpForSkill(int detla)
	{
		if (state != GameState.Static)
		{
			return;
		}
		foreach (int key in activeBlocks.Keys)
		{
			if (activeBlocks[key] is NormalBlock)
			{
				((NormalBlock)activeBlocks[key]).ChangeRemainHp(detla);
			}
		}
	}

	public void ChangeAllBlockTypeForSkill(int blkType, int time)
	{
		if (state != GameState.Static)
		{
			return;
		}
		foreach (int key in activeBlocks.Keys)
		{
			if (activeBlocks[key] is NormalBlock)
			{
				((NormalBlock)activeBlocks[key]).ConvertBlkType((PolygonType)blkType, time);
			}
		}
	}

	public void ChangeBlockTypeForSkill(int blkType, int count, int time, float[] param = null)
	{
		if (state != GameState.Static)
		{
			return;
		}
		List<int> list = new List<int>();
		foreach (int key in activeBlocks.Keys)
		{
			if (activeBlocks[key] is NormalBlock && !Enum.IsDefined(typeof(StaticItemType), (int)((NormalBlock)activeBlocks[key]).GetConvertType()))
			{
				list.Add(key);
			}
		}
		for (int i = 0; i < count && i < list.Count; i++)
		{
			int index = UnityEngine.Random.Range(0, list.Count);
			((NormalBlock)activeBlocks[list[index]]).ConvertBlkType((PolygonType)blkType, time, param);
			list[index] = list[list.Count - 1];
			list.RemoveAt(list.Count - 1);
		}
	}

	public void AddBuffToRandomBlocks(BlockBuffType buffType, int buffCount, float[] param)
	{
		if (state != GameState.Static)
		{
			return;
		}
		List<int> list = new List<int>();
		foreach (int key2 in activeBlocks.Keys)
		{
			if (!removeUIDList.Contains(key2))
			{
				BallPolygon ballPolygon = activeBlocks[key2];
				if (!Enum.IsDefined(typeof(StaticItemType), (int)ballPolygon.GetConvertType()) && ballPolygon.GetPType() != PolygonType.resetBlock)
				{
					list.Add(key2);
				}
			}
		}
		if (list.Count <= 0 || buffCount <= 0)
		{
			return;
		}
		buffCount = Mathf.Min(buffCount, list.Count);
		for (int i = 0; i < buffCount; i++)
		{
			int index = UnityEngine.Random.Range(0, list.Count);
			int key = list[index];
			if (activeBlocks[key] is NormalBlock normalBlock && normalBlock.HasGameObject())
			{
				bool flag = true;
				if (normalBlock.HasBuff(buffType))
				{
					flag = false;
				}
				if ((buffType == BlockBuffType.affect || buffType == BlockBuffType.affect) && (normalBlock.HasBuff(BlockBuffType.affect) || normalBlock.HasBuff(BlockBuffType.affected)))
				{
					flag = false;
				}
				if (flag)
				{
					normalBlock.SetBuffWithCount(buffType, param);
				}
			}
			list.RemoveAt(index);
		}
	}

	public void SupplementBlocksAtEmptySpace(int num, PolygonType targeType = PolygonType.None, float[] param = null)
	{
		isSupplmenting = true;
		HashSet<Vector2> hashSet = new HashSet<Vector2>(activeBlocks.Values.Select((BallPolygon block) => block.GetLocalPosition()));
		List<Vector2> list = new List<Vector2>();
		for (float num2 = 0.5f; num2 < 10f; num2++)
		{
			for (float num3 = 1.5f; num3 < 10f; num3++)
			{
				Vector2 item = new Vector2(num2, num3);
				if (!hashSet.Contains(item))
				{
					list.Add(item);
				}
			}
		}
		Shuffle(list);
		int num4 = 0;
		foreach (Vector2 item2 in list)
		{
			if (num4 >= num)
			{
				break;
			}
			PolygonType polygonType = ((targeType != PolygonType.None) ? targeType : GetRandomBlockTypeByWeightExcluding(stageData.excludePolygonBlocks));
			PolygonType polygonType2 = polygonType;
			num4++;
			GameObject gameObject = blockTemplate[(int)(polygonType2 - 1)];
			if (gameObject == null)
			{
				Debug.LogWarning($"未找到类型 {polygonType} 的预制体");
				continue;
			}
			GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, blockRootTrs);
			Vector2 vector = item2;
			gameObject2.transform.localPosition = new Vector3(vector.x, vector.y, 0f);
			gameObject2.name = $"[{item2.x},{item2.y}] {polygonType}";
			int baseremainHp = stageData.baseremainHp;
			NormalBlock normalBlock = new NormalBlock(uniqueBlockID, gameObject2, item2, baseremainHp, polygonType, null, polygonType2);
			if (polygonType2 == PolygonType.protect)
			{
				normalBlock.SetBuffWithCount(BlockBuffType.protect, param);
			}
			AddUIDToAddList(uniqueBlockID, normalBlock);
			uniqueBlockID++;
			gameObject2.transform.SetAsFirstSibling();
		}
		isSupplmenting = false;
		if (needUpdateAimTarget)
		{
			UpdateAimLineTarget();
		}
	}

	public void UpdatePlayerHitNumber(int changeHp, bool isDamageType)
	{
		turnBasedGame.SetUIHitNumberTextOnCollision(changeHp, isDamageType);
	}

	public void SpareBall(Vector2 blockPos, int num = 0, bool isBallTrigger = false)
	{
		int num2 = ((num == 0) ? MapData.stageData.baseSpareTimes : num);
		for (int i = 0; i < num2; i++)
		{
			Vector2 position = blockPos;
			if (!isBallTrigger)
			{
				position = ballRootTrs.InverseTransformPoint(blockPos);
			}
			Ball freeTempBall = GetFreeTempBall();
			freeTempBall.SetPosition(position);
			float f = UnityEngine.Random.Range(0f, 360f) * (MathF.PI / 180f);
			Vector2 velocity = new Vector2(Mathf.Cos(f), Mathf.Sin(f)).normalized * ballSpeed;
			freeTempBall.ActiveBall(velocity);
			shootBallCount++;
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_6", "minigame_activity_4_6_marble_shoot", useStream: false);
	}

	public void AffectAroundBlock(Vector2 pos, float[] param)
	{
		List<NormalBlock> list = new List<NormalBlock>();
		foreach (BallPolygon value in activeBlocks.Values)
		{
			if (!Enum.IsDefined(typeof(StaticItemType), (int)value.GetPType()) && value.GetPType() != PolygonType.resetBlock && ((Mathf.Abs(value.GetLocalPosition().x - pos.x) == 1f && Mathf.Abs(value.GetLocalPosition().y - pos.y) == 0f) || (Mathf.Abs(value.GetLocalPosition().x - pos.x) == 0f && Mathf.Abs(value.GetLocalPosition().y - pos.y) == 1f)))
			{
				NormalBlock normalBlock = value as NormalBlock;
				if (!normalBlock.HasBuff(BlockBuffType.affect) && !normalBlock.HasBuff(BlockBuffType.affected) && normalBlock.HasGameObject())
				{
					list.Add(normalBlock);
				}
			}
		}
		if (list.Count > 0)
		{
			int index = UnityEngine.Random.Range(0, list.Count - 1);
			list[index].SetBuffWithCount(BlockBuffType.affect, param, notTriggerThisRound: true);
		}
	}

	public void SavePolygonMap()
	{
		cacheUniqueBlockID = uniqueBlockID;
		isSupplmenting = false;
		isSupplmentFrame = false;
		isExplosionFrame = false;
		cacheTempUIDList = tempUIDList.ToList();
		cachePositionMap.Clear();
		removeUIDList.Clear();
		tempUIDList.Clear();
		addUIDList.Clear();
		foreach (PathNodeManager value in cacheActivePointManager.Values)
		{
			value.Release();
		}
		cacheActivePointManager.Clear();
		foreach (BallPolygon value2 in cachePolygonMap.Values)
		{
			value2.Release();
		}
		cachePolygonMap = activeBlocks.Where((KeyValuePair<int, BallPolygon> kv) => !tempUIDList.Exists((UniqueBlockInfo item) => item.uniqueBlockID == kv.Key)).ToDictionary((KeyValuePair<int, BallPolygon> kv) => kv.Key, (KeyValuePair<int, BallPolygon> kv) => kv.Value.Clone());
		foreach (KeyValuePair<int, PathNodeManager> item in activePointManager)
		{
			if (item.Value.GetMountedBlock() != null)
			{
				item.Value.SetCacheMountedBlockUID(item.Value.GetMountedBlock().GetUniqueId());
			}
			cacheActivePointManager.Add(item.Key, item.Value.Clone() as PathNodeManager);
		}
		foreach (BallPolygon value3 in activeBlocks.Values)
		{
			cachePositionMap.Add(value3.GetUniqueId(), value3.GetLocalPosition());
		}
		foreach (PathNodeManager value4 in activePointManager.Values)
		{
			value4.Release();
		}
		activePointManager.Clear();
		foreach (BallPolygon value5 in PolygonMap.Values)
		{
			value5.Release();
		}
		addUIDList.Clear();
		removeUIDList.Clear();
	}

	public void LoadPolygonMap()
	{
		isDebateStage = false;
		CanPlayGuide = false;
		MapData.stageData = cacheStageData;
		ClearAllItem();
		PolygonMap = cachePolygonMap.ToDictionary((KeyValuePair<int, BallPolygon> kv) => kv.Key, (KeyValuePair<int, BallPolygon> kv) => kv.Value.Clone());
		for (int num = blockRootTrs.childCount - 1; num >= 0; num--)
		{
			Transform child = blockRootTrs.GetChild(num);
			BlockPool.Instance.ReturnBlock(child.gameObject);
		}
		uniqueBlockID = cacheUniqueBlockID + 1;
		List<KeyValuePair<int, NormalBlock>> list = new List<KeyValuePair<int, NormalBlock>>();
		foreach (BallPolygon block in PolygonMap.Values.ToList())
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(blockTemplate[(int)(block.GetPType() - 1)], blockRootTrs);
			Vector2 runtimePos = cachePositionMap[block.GetUniqueId()];
			gameObject.transform.localPosition = new Vector3(runtimePos.x, runtimePos.y, 0f);
			gameObject.name = $"[{runtimePos.x},{runtimePos.y}] {block.GetPType()}";
			NormalBlock normalBlock = new NormalBlock(uniqueBlockID, gameObject, runtimePos, block.GetRemainHp(), block.GetPType(), block.GetPathData(), block.GetPType());
			PathNodeManager pathNodeManager = cacheActivePointManager.Values.FirstOrDefault((PathNodeManager manager) => manager.GetCacheMountedBlockUID() == block.GetUniqueId());
			if (pathNodeManager != null && pathNodeManager.GetPathData() != null && pathNodeManager.GetPathData().pathPoints.Count >= 2)
			{
				pathNodeManager.MountBlock(normalBlock);
			}
			NormalBlock normalBlock2 = block as NormalBlock;
			if (normalBlock2 != null && normalBlock2.protectedTriggerCount > 0)
			{
				normalBlock.SetBuffWithCount(BlockBuffType.protect, new float[4] { 0f, 0f, 0f, normalBlock2.protectedTriggerCount });
			}
			if (normalBlock2 != null && normalBlock2.affectTriggerCount > 0)
			{
				normalBlock.SetBuffWithCount(BlockBuffType.affect, new float[4] { 0f, 0f, normalBlock2.protectedTriggerCount, normalBlock2.affectTriggerDamage }, notTriggerThisRound: true);
			}
			list.Add(new KeyValuePair<int, NormalBlock>(uniqueBlockID, normalBlock));
			uniqueBlockID++;
		}
		cacheTempUIDList.Clear();
		cachePolygonMap.Clear();
		foreach (KeyValuePair<int, NormalBlock> item in list)
		{
			AddUIDToAddList(item.Key, item.Value);
		}
		foreach (KeyValuePair<int, PathNodeManager> item2 in cacheActivePointManager)
		{
			if (item2.Value != null && item2.Value.GetPathData() != null && item2.Value.GetPathData().pathPoints.Count >= 2)
			{
				_ = blockTemplate[16];
				GameObject block2 = BlockPool.Instance.GetBlock(PolygonType.pathNode);
				if (block2 == null)
				{
					Debug.LogError("Failed to get path node from pool");
					continue;
				}
				block2.transform.localPosition = item2.Value.GetLocalPosition();
				block2.name = $"[{item2.Value.GetPosition().x},{item2.Value.GetPosition().y}] {PolygonType.pathNode}";
				PathNodeManager pathNodeManager2 = new PathNodeManager(item2.Key, block2, item2.Value.GetPathData());
				pathNodeManager2.MountBlock(item2.Value.GetMountedBlock());
				activePointManager.Add(item2.Key, pathNodeManager2);
			}
			item2.Value.Release();
		}
		cacheActivePointManager.Clear();
	}

	public void AddUIDToRemoveList(int uniqueID)
	{
		if (!removeUIDList.Contains(uniqueID))
		{
			removeUIDList.Add(uniqueID);
		}
	}

	public void AddUIDToAddList(int uniqueID, BallPolygon data)
	{
		UniqueBlockInfo item = new UniqueBlockInfo(uniqueID, data);
		if (!addUIDList.Contains(item))
		{
			addUIDList.Add(item);
		}
	}

	public void AddUIDToTempList(int uniqueID, BallPolygon data)
	{
		UniqueBlockInfo item = new UniqueBlockInfo(uniqueID, data);
		if (!tempUIDList.Contains(item))
		{
			tempUIDList.Add(item);
		}
	}

	public bool IsRemovedUID(int uniqueID)
	{
		return removeUIDList.IndexOf(uniqueBlockID) > 0;
	}

	public Ball GetFreeTempBall()
	{
		Ball ball;
		if (cacheTempBallList.Count > 0)
		{
			ball = cacheTempBallList[cacheTempBallList.Count - 1];
			cacheTempBallList.Remove(ball);
			ball.mTransform.gameObject.SetActive(value: true);
			ball.mTransform.localPosition = ResetPos;
			ball.UpdateBuffEffect();
		}
		else
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(ballTemplate[3], ballRootTrs);
			ball = new Ball(0.2f, gameObject.transform, BallType.tempBall);
		}
		BallList.Add(ball);
		return ball;
	}

	public void FreeTempBall(Ball ball)
	{
		if (ball != null && !cacheTempBallList.Contains(ball))
		{
			cacheTempBallList.Add(ball);
			BallList.Remove(ball);
			ball.mTransform.gameObject.SetActive(value: false);
			ball.mTransform.localPosition = ResetPos;
			ball.ResetBuff();
		}
	}

	public void HideBlocks(int hiddenCount, int hiddenRound, bool isEnemySkill = false)
	{
	}

	public void UpdateHiddenBlocks()
	{
		for (int num = hiddenByEnemyBlocks.Count - 1; num >= 0; num--)
		{
			hiddenByEnemyBlocks[num].remainingRounds--;
		}
		if (hiddenByEnemyBlocks.Exists((HiddenBlockInfo h) => h.remainingRounds <= 0))
		{
			RestoreHiddenBlocks();
		}
	}

	public bool IsBlockHiddenByEnemy(int blockID)
	{
		return hiddenByEnemyBlocks.Exists((HiddenBlockInfo h) => h.blockID == blockID);
	}

	public void RestoreHiddenBlocks()
	{
		if (state != GameState.Static)
		{
			return;
		}
		List<HiddenBlockInfo> list = new List<HiddenBlockInfo>();
		foreach (HiddenBlockInfo hiddenByEnemyBlock in hiddenByEnemyBlocks)
		{
			if (hiddenByEnemyBlock.remainingRounds > 0)
			{
				continue;
			}
			if (hiddenBlockPositions.TryGetValue(hiddenByEnemyBlock.blockID, out var value))
			{
				int baseremainHp = MapData.stageData.baseremainHp;
				GameObject gameObject = UnityEngine.Object.Instantiate(blockTemplate[(int)(hiddenByEnemyBlock.originalType - 1)], blockRootTrs);
				gameObject.transform.localPosition = new Vector3(value.x, value.y, 0f);
				gameObject.name = $"[{value.x},{value.y}] {hiddenByEnemyBlock.originalType}";
				NormalBlock normalBlock = new NormalBlock(uniqueBlockID, gameObject, value, baseremainHp, hiddenByEnemyBlock.originalType, hiddenByEnemyBlock.pathData, hiddenByEnemyBlock.convertType);
				if (hiddenByEnemyBlock.convertType == PolygonType.protect)
				{
					normalBlock.SetBuffWithCount(BlockBuffType.protect);
				}
				AddUIDToAddList(uniqueBlockID, normalBlock);
				uniqueBlockID++;
				hiddenBlockPositions.Remove(hiddenByEnemyBlock.blockID);
			}
			list.Add(hiddenByEnemyBlock);
		}
		foreach (HiddenBlockInfo item in list)
		{
			hiddenByEnemyBlocks.Remove(item);
		}
		if (list.Count > 0)
		{
			turnBasedGame.ShowHideBlockText(0, 0, "隐藏色块效果结束，色块恢复");
		}
	}
}
