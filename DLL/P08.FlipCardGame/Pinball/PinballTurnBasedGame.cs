using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ControllerExSpace;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;
using UnityEngine.Timeline;
using UnityEngine.UI;

namespace Pinball;

public class PinballTurnBasedGame : MonoBehaviour
{
	public class ChargeState
	{
		public PinballRoleBattleData enemy;

		public int remainingRounds;

		public float requiredDamageToInterrupt;

		public bool isInterrupted;

		public int weaknessRounds;

		public float receivedDamage;

		public int damage;

		public int hideBlockCount;

		public int recoverHideBlockTime;

		public int weaknessCount;

		public ChargeState(PinballRoleBattleData enemy, int remainingRounds, int damage, int hideBlockCount, int recoverHideBlockTime, int requiredDamageToInterrupt, int weaknessCount)
		{
			this.enemy = enemy;
			this.remainingRounds = remainingRounds;
			isInterrupted = false;
			weaknessRounds = 0;
			receivedDamage = 0f;
			this.damage = damage;
			this.hideBlockCount = hideBlockCount;
			this.recoverHideBlockTime = recoverHideBlockTime;
			this.requiredDamageToInterrupt = requiredDamageToInterrupt;
			this.weaknessCount = weaknessCount;
		}

		public void Replace()
		{
			enemy = null;
		}
	}

	public enum TurnGameState
	{
		WaitingForInit,
		RoundBeginPhase,
		PlayerShootPhase,
		PlayerAttackPhase,
		EnemyActionPhase,
		RoundOverPhase,
		WaitingForDispose
	}

	private class AtkBuff
	{
		public int uid;

		public float value;

		public int remainTime;

		public AtkBuff(int uid, float value, int remainTime)
		{
			this.uid = uid;
			this.value = value;
			this.remainTime = remainTime;
		}
	}

	[Header("UI绑定部分")]
	[SerializeField]
	private Button uiBreakBtn;

	[SerializeField]
	private GameObject uiBreakBtnGo;

	[SerializeField]
	private Button uiDoubleBtn;

	[SerializeField]
	private GameObject uiDoubleTagOn;

	[SerializeField]
	private GameObject uiDoubleTagOff;

	[SerializeField]
	private Text uiRoundText;

	[SerializeField]
	private Text uiDebateLeftRoundCountText;

	[SerializeField]
	private Text uiChallengeLeftRoundCountText;

	[SerializeField]
	private Text uiChallengeScoreText;

	[SerializeField]
	private GameObject uiRoundGo;

	[SerializeField]
	private GameObject uiShootTipsGo;

	[SerializeField]
	private GameObject uiShootSecondTipsGo;

	[SerializeField]
	private Slider uiEnemyHpSlr;

	[SerializeField]
	private Text uiEnemyHpText;

	[SerializeField]
	private Image uiEnemyHpRedImg;

	[SerializeField]
	private Text uiEnemyAttackText;

	[SerializeField]
	private Slider uiPlayerHpSlr;

	[SerializeField]
	private Text uiPlayerHpText;

	[SerializeField]
	private Image uiPlayerHpRedImg;

	[SerializeField]
	private Text uiPlayerAttackText;

	[SerializeField]
	private Animator uiPlayerAttackAni;

	[SerializeField]
	private Animator uiDebateSliderAni;

	[SerializeField]
	private GameObject uiPlayerAttackFireEffect;

	[SerializeField]
	private Text uiBreakNumText;

	[SerializeField]
	private Text uiPlayerSpText;

	[SerializeField]
	private List<PinballAimTrigger> uiPlayerSkillTriggerList;

	[SerializeField]
	private List<Text> uiSkillTextList;

	[SerializeField]
	private List<GameObject> uiSkillCanUsageGoList;

	[SerializeField]
	private List<ControllerExCollection> uiSkillControllerExList;

	[SerializeField]
	private List<GameObject> uiSkillCantUsageGoList;

	[SerializeField]
	private List<Image> uiSkillIconList;

	[SerializeField]
	private List<GameObject> uiCountDownGoList;

	[SerializeField]
	private List<Text> uiCountDownTextList;

	[SerializeField]
	private GameObject uiPlayerRoundTipsGo;

	[SerializeField]
	private Text uiPlayerRoundTipsText;

	[SerializeField]
	private GameObject uiEnemyRoundTipsGo;

	[SerializeField]
	private Text uiEnemyRoundTipsText;

	[SerializeField]
	private GameObject uiDebeateRoundTipsGo;

	[SerializeField]
	private GameObject uiExitDebeateRoundTipsGo;

	[SerializeField]
	private GameObject uiNextRoundTipsGo;

	[SerializeField]
	private Text uiNextRoundTipsText;

	[SerializeField]
	private GameObject uiExitDebeateRoundFailTipsGo;

	[SerializeField]
	private Slider uiEnemyDebateSlider;

	[SerializeField]
	private Image uiDebateProgressImage;

	[SerializeField]
	private GameObject uiDebateProgressGo;

	[SerializeField]
	private Animator uiDebateBgAni;

	[SerializeField]
	private Text uiDebateText;

	[SerializeField]
	private Text uiDebateText2;

	[SerializeField]
	private Text uiSuccessDebateText;

	[SerializeField]
	private GameObject lightEffectPrefab;

	[SerializeField]
	private GameObject HighValueLightEffectPrefab;

	[SerializeField]
	private List<Text> uiJumpTextList;

	[SerializeField]
	private List<GameObject> uiJumpTextGoList;

	[SerializeField]
	private List<UITextTool> uiJumpTextColorList;

	[SerializeField]
	private GameObject uiGroupSkillActionBtn;

	[SerializeField]
	private List<ControllerExCollection> uiEnemySkillControllerExCollectionList;

	[SerializeField]
	private ControllerExCollection uiControllerCollectionEx;

	[SerializeField]
	private ControllerExCollection uiSliderControllerCollectionEx;

	[SerializeField]
	private ControllerExCollection uiTipsControllerCollectionEx;

	[SerializeField]
	private List<PinballAimTrigger> uiEnemySkillTriggerList;

	[SerializeField]
	private List<Image> uiEnemySkillImgList;

	[SerializeField]
	private List<Text> uiEnemySkillTextList;

	[SerializeField]
	private GameObject uiSkillTipsGo;

	[SerializeField]
	private Transform enemyTipsParentTrs;

	[SerializeField]
	private Transform playerTipsParentTrs;

	[SerializeField]
	private Text uiSkillTipsText;

	[SerializeField]
	private Text uiSkillTipsNameText;

	[SerializeField]
	private Text uiSkillTipsLevelText;

	private bool isPress;

	private bool isPressFlag;

	private float pressTime;

	private GameObject pressTipsGo;

	private GameObject playerModelGo;

	[SerializeField]
	private Button tipsMaskBtn;

	private Animator playerAnim;

	private List<GameObject> enemyModelGoList = new List<GameObject>();

	private List<Animator> enemyAnimList = new List<Animator>();

	private ParticleSystem[,] particleInScene = new ParticleSystem[5, 5];

	[SerializeField]
	private ParticleSystem bossPsEffect;

	[SerializeField]
	private List<GameObject> bubbleGoList;

	[SerializeField]
	private List<Text> bubbleTextList;

	[SerializeField]
	private List<Transform> headTrs;

	[SerializeField]
	private List<Transform> heartTrs;

	[SerializeField]
	private Text chargeRoundText;

	[SerializeField]
	private Text chargeInterruptedDamageText;

	private RoundInfo preRoundInfo = new RoundInfo();

	private RoundInfo startRoundInfo = new RoundInfo();

	private List<RoundInfo> roundInfos = new List<RoundInfo>();

	private int countDownTimer;

	private int countDownTick;

	private int playerAttackAnimTimer;

	private int nextStageAnimTimer;

	private int playerAttackAnimTick;

	private int nextStageAnimTick;

	private int enemyAttackAnimTimer;

	private int enemyAttackAnimTick;

	private int animShuiBeiTimer;

	private int shootWatingTimer;

	private int shootWatingTick;

	private float animShuiBeiTick;

	private int playerHpSlrAnimTimer;

	private int playerHpSlrAnimTick;

	private int enemyHpSlrAnimTimer;

	private int enemyHpSlrAnimTick;

	private int phaseEndTimer;

	private int gameOverTimer;

	private int playRoundTimer;

	private int playRoundTick;

	private int bubbleTriggerAnimTick;

	private int bubbleTriggerAnimTimer;

	private int useDiffSkillRound;

	public bool effectHitAniPlayed;

	private bool needPlayAni;

	private bool hasTriggerCallback;

	private bool isEnterDebateStage;

	private bool isBossTurnPhase;

	private int oldEnemyIndex = -1;

	private List<ChargeState> enemyChargeStates = new List<ChargeState>();

	[Header("局内公式所用系数")]
	[SerializeField]
	private float commonAttackRate = 0.1f;

	[SerializeField]
	private float damageBlockExtraRate = 2f;

	[SerializeField]
	private float healthBlockExtraRate = 0.02f;

	[SerializeField]
	private float skillBlockExtraRate = 0.02f;

	[SerializeField]
	private float enemyAttackFromBlockRate = 0.1f;

	[SerializeField]
	private float enemyAttackFromRoundRate = 0.3f;

	[SerializeField]
	private int blockHpBaseRate = 12;

	[SerializeField]
	private int blockHpNoiseRate = 10;

	[SerializeField]
	private int countDownNum = 1;

	[SerializeField]
	private int shootMaxTime = 8;

	private float startSP;

	private PinballRoleBattleData playerData;

	private int playerActiveSkillCount;

	private PinballRoleBattleData[][] enemyDataList;

	private List<PinballRoleBattleData> currentWaveEnemies;

	private List<PinballRoleBattleData> activeEnemies = new List<PinballRoleBattleData>();

	private float currentWaveTotalHp;

	private float currentWaveRemainingHp;

	private List<float> waveDeathThresholds = new List<float>();

	private List<int[]> activeEnemySkillIndex = new List<int[]>();

	private List<int> activePlayerSkillIndex = new List<int>();

	private TurnGameState state;

	private int curStage = 1;

	private int curRound;

	private int debateStartRound;

	private int hitDebateBlockCount;

	private int remainHitDebateBlockCount;

	private float curRoundHitNumber;

	private int[] activeUseSkillCount = new int[2];

	private int allSkillCount;

	private int allBlockDamage;

	private int challengeScore;

	private int allEnemyDamage;

	public int extraOverTimes;

	public float skillPointDiscount;

	public int skillPointRecovery;

	private int atkBuffID;

	private Dictionary<int, AtkBuff> playerAtkBuffList = new Dictionary<int, AtkBuff>();

	private Dictionary<PinballRoleBattleData, Dictionary<int, AtkBuff>> enemyAtkBuffLists = new Dictionary<PinballRoleBattleData, Dictionary<int, AtkBuff>>();

	private int enemyMultiActionCount;

	private float enemyActionIntervalTime = 3f;

	private float enemyTimelineActionTime = -999f;

	private float enemyEndActionIntervaltime = 2f;

	private float enemyEndActionTime = -999f;

	private float enemyActionTime = -999f;

	private bool hasAni;

	private float chargeAniTime = -999f;

	private bool hasPassDebate;

	private Dictionary<PinballRoleBattleData, int> enemiesActedThisPhase = new Dictionary<PinballRoleBattleData, int>();

	private float playerTotalAtk
	{
		get
		{
			float num = 0f;
			foreach (AtkBuff value in playerAtkBuffList.Values)
			{
				num += value.value;
			}
			return Mathf.Max(playerData.attack + num, 0f);
		}
	}

	public TurnGameState State
	{
		get
		{
			return state;
		}
		set
		{
			state = value;
		}
	}

	private int SelectSkillByWeight(PinballRoleBattleData enemy)
	{
		List<int> list = new List<int>();
		List<float> list2 = new List<float>();
		float num = 0f;
		for (int i = 0; i < enemy.skillList.Length; i++)
		{
			PinballRoleSkillData pinballRoleSkillData = enemy.skillList[i];
			if (pinballRoleSkillData.remainCD > 0)
			{
				continue;
			}
			float num2 = ((pinballRoleSkillData.weight > 0f) ? pinballRoleSkillData.weight : 1f);
			if (pinballRoleSkillData.sType == 14)
			{
				if (enemiesActedThisPhase[enemy] != enemy.actionTimes - 1)
				{
					continue;
				}
			}
			else if (pinballRoleSkillData.sType == 22 || pinballRoleSkillData.sType == 23)
			{
				if (PinballGameManager.Instance.activeBlocks.Count((KeyValuePair<int, BallPolygon> block) => (block.Value as NormalBlock).HasBuff(BlockBuffType.protect)) >= PinballGameManager.Instance.MapData.maxProtectBlocks)
				{
					continue;
				}
			}
			else if (pinballRoleSkillData.sType == 24 && PinballGameManager.Instance.activeBlocks.Count((KeyValuePair<int, BallPolygon> block) => (block.Value as NormalBlock).HasBuff(BlockBuffType.affect) || (block.Value as NormalBlock).HasBuff(BlockBuffType.affected)) >= PinballGameManager.Instance.MapData.maxAffectBlocks)
			{
				continue;
			}
			list.Add(i);
			list2.Add(num2);
			num += num2;
		}
		if (list.Count == 0)
		{
			return -1;
		}
		float num3 = UnityEngine.Random.Range(0f, num);
		float num4 = 0f;
		Debug.Log("可用技能权重列表:");
		for (int num5 = 0; num5 < list.Count; num5++)
		{
			Debug.Log($"技能索引: {list[num5]}, 权重: {list2[num5]}");
		}
		Debug.Log($"随机值: {num3}");
		for (int num6 = 0; num6 < list.Count; num6++)
		{
			num4 += list2[num6];
			if (num3 <= num4)
			{
				Debug.Log($"选中技能索引: {list[num6]}, 权重: {list2[num6]}");
				return list[num6];
			}
		}
		return list[0];
	}

	private void OnEnable()
	{
		AddBtnListener();
	}

	private void OnDisable()
	{
		RemoveBtnListener();
	}

	private void Update()
	{
		if (isPress)
		{
			pressTime += Time.deltaTime;
			if (pressTime > 0.5f && pressTipsGo != null)
			{
				pressTipsGo.SetActive(value: true);
				tipsMaskBtn.transform.gameObject.SetActive(value: true);
			}
		}
		if (state == TurnGameState.PlayerAttackPhase)
		{
			PinballGameManager.Instance.gameObject.transform.SetPositionEx(-30.4f, -30.4f, 100f);
			PinballGameManager.Instance.gameObject.transform.SetLocalScale(new Vector3(6.45f, 6.45f, 6.45f));
		}
		else if (state == TurnGameState.EnemyActionPhase)
		{
			PinballGameManager.Instance.gameObject.transform.SetPositionEx(-30.4f, -30.4f, 100f);
			PinballGameManager.Instance.gameObject.transform.SetLocalScale(new Vector3(6.45f, 6.45f, 6.45f));
			float num = Mathf.Clamp(Time.deltaTime, 0f, 0.1f);
			if (enemyActionTime < -99f)
			{
				activeEnemies = activeEnemies.OrderBy((PinballRoleBattleData e) => UnityEngine.Random.value).ToList();
				enemiesActedThisPhase.Clear();
				foreach (PinballRoleBattleData activeEnemy in activeEnemies)
				{
					enemiesActedThisPhase.Add(activeEnemy, 0);
				}
				enemyActionTime = 2f;
				chargeAniTime = -999f;
				enemyTimelineActionTime = -999f;
				hasAni = false;
				oldEnemyIndex = -1;
				return;
			}
			if (activeEnemies.Count == 0)
			{
				enemyActionTime = -999f;
				ProcessToNextState();
				return;
			}
			if (enemiesActedThisPhase.All((KeyValuePair<PinballRoleBattleData, int> pair) => pair.Value >= pair.Key.actionTimes))
			{
				if (enemyEndActionTime > 0f)
				{
					enemyEndActionTime -= num;
					return;
				}
				enemyActionTime = -999f;
				ProcessToNextState();
				return;
			}
			if (enemyActionTime > 0f)
			{
				enemyActionTime -= num;
				return;
			}
			if (chargeAniTime > 0f)
			{
				chargeAniTime -= Time.deltaTime;
				return;
			}
			PinballRoleBattleData currentEnemy = null;
			int num2 = -1;
			for (int num3 = 0; num3 < activeEnemies.Count; num3++)
			{
				if (enemiesActedThisPhase[activeEnemies[num3]] < activeEnemies[num3].actionTimes)
				{
					currentEnemy = activeEnemies[num3];
					num2 = currentWaveEnemies.IndexOf(currentEnemy);
					break;
				}
			}
			if (currentEnemy == null)
			{
				enemyActionTime = -999f;
				ProcessToNextState();
				return;
			}
			if (oldEnemyIndex == -1 || oldEnemyIndex != num2)
			{
				chargeAniTime = -999f;
				oldEnemyIndex = num2;
			}
			if (chargeAniTime < -99f)
			{
				bool isRecovery = false;
				hasAni = UpdateChargeStates(out isRecovery, currentEnemy);
				if (hasAni && enemiesActedThisPhase[currentEnemy] < activeEnemies[num2].actionTimes && !isRecovery)
				{
					enemiesActedThisPhase[currentEnemy]++;
				}
				chargeAniTime = -99f;
				if (hasAni)
				{
					chargeAniTime = enemyActionIntervalTime;
					hasAni = false;
				}
				if (isRecovery)
				{
					chargeAniTime = 1f;
				}
			}
			if (chargeAniTime > 0f)
			{
				chargeAniTime -= Time.deltaTime;
				return;
			}
			ChargeState chargeState = enemyChargeStates.Find((ChargeState s) => s.enemy == currentEnemy && !s.isInterrupted && s.weaknessRounds <= 0);
			ChargeState chargeState2 = enemyChargeStates.Find((ChargeState s) => s.enemy == currentEnemy && s.isInterrupted && s.weaknessRounds > 0);
			if (chargeState == null && chargeState2 == null && enemiesActedThisPhase[currentEnemy] < currentEnemy.actionTimes)
			{
				int num4 = SelectSkillByWeight(currentEnemy);
				if (num4 >= 0)
				{
					EnemyActionSkill(num2, num4);
					if (enemiesActedThisPhase[currentEnemy] >= currentEnemy.actionTimes)
					{
						Debug.Log($"敌人行动次数已达上限: {currentEnemy.actionTimes}");
						return;
					}
					enemiesActedThisPhase[currentEnemy]++;
				}
				if (enemyTimelineActionTime > -999f)
				{
					enemyActionTime = enemyTimelineActionTime;
					enemyTimelineActionTime = -999f;
				}
				else
				{
					enemyActionTime = enemyActionIntervalTime;
				}
				enemyEndActionTime = enemyEndActionIntervaltime;
			}
			else
			{
				enemiesActedThisPhase[currentEnemy] = activeEnemies[num2].actionTimes;
				if (chargeState2 != null)
				{
					chargeState2.weaknessRounds--;
				}
			}
		}
		else if (state == TurnGameState.RoundBeginPhase)
		{
			PinballGameManager.Instance.gameObject.transform.SetPositionEx(-4.7f, -3.6f, -11.1f);
			PinballGameManager.Instance.gameObject.transform.SetLocalScale(Vector3.one);
			if (PinballGameManager.Instance.BallList.Count > 0)
			{
				PinballGameManager.Instance.BallList[0].JustShow(show: true);
			}
		}
	}

	public void StopTimer()
	{
		StopAndRemoveTimer(playRoundTick);
		StopAndRemoveTimer(countDownTimer);
		StopAndRemoveTimer(playerAttackAnimTimer);
		StopAndRemoveTimer(nextStageAnimTimer);
		StopAndRemoveTimer(enemyAttackAnimTimer);
		StopAndRemoveTimer(animShuiBeiTimer);
		StopAndRemoveTimer(playerHpSlrAnimTimer);
		StopAndRemoveTimer(enemyHpSlrAnimTimer);
		StopAndRemoveTimer(phaseEndTimer);
		StopAndRemoveTimer(gameOverTimer);
		StopAndRemoveTimer(shootWatingTimer);
		StopAndRemoveTimer(playRoundTimer);
		StopAndRemoveTimer(bubbleTriggerAnimTimer);
	}

	private void StopAndRemoveTimer(int timer)
	{
		if (FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.StopFuncTimer(timer);
			FuncTimerManager.inst.RemoveFuncTimer(timer);
		}
	}

	private void OnDestroy()
	{
		StopTimer();
	}

	public void GameRestart()
	{
		state = TurnGameState.WaitingForInit;
		playerData.health = playerData.maxHealth;
		playerData.skillPoint = startSP;
		currentWaveRemainingHp = currentWaveTotalHp;
		preRoundInfo = new RoundInfo();
		hasPassDebate = false;
		curRoundHitNumber = 0f;
		curRound = 0;
		curStage = 1;
		allSkillCount = 0;
		allBlockDamage = 0;
		challengeScore = 0;
		allEnemyDamage = 0;
		atkBuffID = 0;
		playerAtkBuffList.Clear();
		enemyAtkBuffLists.Clear();
		foreach (ChargeState enemyChargeState in enemyChargeStates)
		{
			enemyChargeState.Replace();
		}
		enemyChargeStates.Clear();
		roundInfos.Clear();
		hasPassDebate = false;
		isBossTurnPhase = false;
		enemyMultiActionCount = 0;
		enemyActionIntervalTime = 3f;
		enemyActionTime = -999f;
		enemyEndActionIntervaltime = 2f;
		enemyEndActionTime = -999f;
		chargeAniTime = -999f;
		hasAni = false;
		isEnterDebateStage = false;
		PlayerAnimAndEffect("stand");
		foreach (GameObject uiJumpTextGo in uiJumpTextGoList)
		{
			if (!(uiJumpTextGo == null))
			{
				uiJumpTextGo.SetActive(value: false);
			}
		}
		UIViewSetup();
	}

	public void ProcessToNextState()
	{
		switch (state)
		{
		case TurnGameState.WaitingForInit:
			if (playerData != null && enemyDataList != null && enemyDataList.Length != 0)
			{
				state = TurnGameState.RoundBeginPhase;
				curRoundHitNumber = 0f;
				if (!PinballGameManager.Instance.MapData.stageData.isDebateStage || curRound != debateStartRound)
				{
					ChangePhaseLightState(playerPhase: true);
				}
				uiJumpTextGoList[2].SetActive(value: false);
				PinballGameManager.Instance.AwakeAimLine();
				UpdatePlayerSkillState();
				Debug.Log("进入回合开始阶段");
			}
			else
			{
				Debug.LogError("未传入双方数据，游戏不能进入开始阶段");
			}
			break;
		case TurnGameState.RoundBeginPhase:
			state = TurnGameState.PlayerShootPhase;
			effectHitAniPlayed = false;
			uiPlayerAttackText.text = "0";
			PinballGameManager.Instance.BreakBlockTimes = 0;
			if (!PinballGameManager.Instance.isDebateStage)
			{
				uiControllerCollectionEx.GetController("playerATK").SetSelectedState("show");
			}
			else
			{
				uiControllerCollectionEx.GetController("playerATK").SetSelectedState("hide");
			}
			uiPlayerAttackFireEffect.SetActive(value: false);
			PinballGameManager.Instance.InitPlayAreaEffect();
			shootWatingTick = 0;
			shootWatingTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				shootWatingTick++;
				if (shootWatingTick > shootMaxTime)
				{
					uiBreakBtnGo.SetActive(value: true);
					StopAndRemoveTimer(shootWatingTimer);
				}
			}, 1f);
			Debug.Log("进入等待弹球阶段");
			break;
		case TurnGameState.PlayerShootPhase:
			StopAndRemoveTimer(shootWatingTimer);
			curRound++;
			useDiffSkillRound = 0;
			UpdateChallengeLeftRoundText();
			uiBreakBtnGo.SetActive(value: false);
			if (PinballGameManager.Instance.MapData.stageData.isDebateStage)
			{
				FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					state = TurnGameState.PlayerAttackPhase;
					UpdateDebateLeftRoundText();
					if (CanExitDebateStage())
					{
						_ = curRound;
						_ = debateStartRound;
						_ = PinballGameManager.Instance.MapData.stageData.debateRoundLimit;
						if (hitDebateBlockCount >= PinballGameManager.Instance.MapData.stageData.debateFinishCount)
						{
							Debug.Log("辩论成功，进入玩家攻击演出阶段");
							playerAttackAnimTick = 0;
							curRoundHitNumber = 9999f;
							playerAttackAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
							{
								playerAttackAnimTick++;
								if (playerAttackAnimTick == 1)
								{
									CheckBubbleTrigger(2);
									uiDebateSliderAni.Play("Charge", -1, 0f);
								}
								if (playerAttackAnimTick == 2)
								{
									uiExitDebeateRoundTipsGo.SetActive(value: true);
								}
								if (playerAttackAnimTick == 8)
								{
									PlayerAnimAndEffect("skill_qte");
								}
								if (playerAttackAnimTick == 14)
								{
									HitEnemy(curRoundHitNumber, isDebateDamange: true, isSuccess: true);
									curRoundHitNumber = 0f;
									ExitDebateStage();
								}
								if (playerAttackAnimTick == 17)
								{
									uiExitDebeateRoundTipsGo.SetActive(value: false);
									uiControllerCollectionEx.GetController("bg").SetSelectedState("off");
									FuncTimerManager.inst.RemoveFuncTimer(playerAttackAnimTimer);
								}
							}, 0.33f);
						}
						else
						{
							Debug.Log("辩论失败进入玩家攻击演出阶段");
							playerAttackAnimTick = 0;
							curRoundHitNumber = (float)hitDebateBlockCount * playerData.attack * PinballGameManager.Instance.MapData.stageData.overflowDamageTransFac;
							playerAttackAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
							{
								playerAttackAnimTick++;
								if (playerAttackAnimTick == 1)
								{
									uiExitDebeateRoundFailTipsGo.SetActive(value: true);
								}
								if (playerAttackAnimTick == 5)
								{
									PlayerAnimAndEffect("skill1");
								}
								if (playerAttackAnimTick == 7)
								{
									HitEnemy(curRoundHitNumber, isDebateDamange: true);
									curRoundHitNumber = 0f;
									ExitDebateStage();
								}
								if (playerAttackAnimTick == 9)
								{
									PinballGameManager.Instance.LoadPolygonMap();
									uiControllerCollectionEx.GetController("bg").SetSelectedState("off");
									FuncTimerManager.inst.RemoveFuncTimer(playerAttackAnimTimer);
								}
							}, 0.33f);
						}
					}
					else
					{
						state = TurnGameState.RoundOverPhase;
						Debug.Log("进入下一阶段");
						CheckBubbleTrigger(4);
						SkillAndBuffReduceTime();
						ProcessToNextState();
						uiDebeateRoundTipsGo.SetActive(value: false);
					}
				}, 0.7f, 1);
				break;
			}
			state = TurnGameState.PlayerAttackPhase;
			uiBreakBtnGo.SetActive(value: false);
			Debug.Log("进入玩家攻击演出阶段");
			PlayerAnimAndEffect("attack1");
			playerAttackAnimTick = 0;
			playerAttackAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				playerAttackAnimTick++;
				if (playerAttackAnimTick == 2)
				{
					HitEnemy(curRoundHitNumber);
					curRoundHitNumber = 0f;
					FuncTimerManager.inst.RemoveFuncTimer(playerAttackAnimTimer);
				}
			}, 0.33f);
			break;
		case TurnGameState.PlayerAttackPhase:
			Debug.Log("进入怪物行动阶段");
			state = TurnGameState.EnemyActionPhase;
			if (isPress && uiSkillTipsGo.activeSelf)
			{
				isPress = false;
				pressTime = 0f;
				uiSkillTipsGo.SetActive(value: false);
			}
			enemyAttackAnimTick = 0;
			enemyAttackAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				enemyAttackAnimTick++;
				if (enemyAttackAnimTick == 2)
				{
					ChangePhaseLightState(playerPhase: false);
					uiControllerCollectionEx.GetController("playerATK").SetSelectedState("hide");
				}
				else if (enemyAttackAnimTick == 7)
				{
					FuncTimerManager.inst.RemoveFuncTimer(enemyAttackAnimTimer);
				}
			}, 0.5f);
			break;
		case TurnGameState.EnemyActionPhase:
			state = TurnGameState.RoundOverPhase;
			Debug.Log("进入回合结束阶段");
			phaseEndTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				SkillAndBuffReduceTime();
				ProcessToNextState();
				FuncTimerManager.inst.RemoveFuncTimer(phaseEndTimer);
			}, 1.5f, 1);
			break;
		case TurnGameState.RoundOverPhase:
			if (playerData.health <= 0f || currentWaveRemainingHp <= 0f || (!PinballGameManager.Instance.MapData.stageData.isDebateStage && PinballGameManager.Instance.MapData.challengeRound != 0 && curRound >= PinballGameManager.Instance.MapData.challengeRound))
			{
				state = TurnGameState.WaitingForDispose;
				GameSendData(interrupt: false);
				break;
			}
			state = TurnGameState.RoundBeginPhase;
			Debug.Log("开始下一回合");
			uiControllerCollectionEx.GetController("playerATK").SetSelectedState("hide");
			if (!isEnterDebateStage)
			{
				ChangePhaseLightState(playerPhase: true);
			}
			isEnterDebateStage = false;
			PinballGameManager.Instance.AwakeAimLine();
			UpdatePlayerSkillState();
			break;
		}
	}

	public void CheckBubbleTrigger(int bubbleType, int param = 0)
	{
		string text = LuaHelper.CallFunction("PinballBridge.CheckBubbleTigger", PinballGameManager.Instance.MapData.stageData.stageId, bubbleType, param)[0].ToString();
		if (!(text != ""))
		{
			return;
		}
		string[] array = text.Split(";");
		for (int i = 0; i < 3; i++)
		{
			string text2 = array[i];
			if (text2 != "" && i < activeEnemies.Count && activeEnemies[i] != null)
			{
				bubbleGoList[i].SetActive(value: true);
				bubbleTextList[i].text = text2;
			}
		}
		bubbleTriggerAnimTick = 0;
		bubbleTriggerAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			bubbleTriggerAnimTick++;
			if (bubbleTriggerAnimTick == 5)
			{
				for (int j = 0; j < 3; j++)
				{
					bubbleGoList[j].SetActive(value: false);
				}
			}
		}, 1f, 6);
	}

	public void RoundBreakToOverPhase(bool win)
	{
		state = TurnGameState.RoundOverPhase;
		float num = 0f;
		if (win)
		{
			PlayerAnimAndEffect("win");
			num = 2f;
		}
		else
		{
			PlayerAnimAndEffect("dead");
			num = 2f;
		}
		gameOverTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			ProcessToNextState();
			FuncTimerManager.inst.RemoveFuncTimer(gameOverTimer);
		}, num, 1);
	}

	public void GameSendData(bool interrupt)
	{
		if (!PinballGameManager.Instance.isDebateStage || interrupt)
		{
			SaveCurrRoundInfo();
		}
		if (LuaHelper.GetLuaState() == null)
		{
			return;
		}
		PinballGameManager.Instance.CanPlayGuide = false;
		string funcName = (interrupt ? "PinballBridge.GameInterrupt" : "PinballBridge.GameSettlement");
		int num = Mathf.FloorToInt(playerData.health / playerData.maxHealth * 100f);
		int num2 = 0;
		int num3 = 1;
		if (interrupt)
		{
			num3 = 3;
		}
		else
		{
			num3 = ((num > 0) ? 1 : 2);
			if (PinballGameManager.Instance.MapData.challengeRound != 0)
			{
				num3 = 1;
			}
		}
		float num4 = Time.time - PinballGameManager.Instance.currentStartTime;
		num2 = (int)currentWaveRemainingHp;
		object[] args = new object[12]
		{
			curRound, playerData.health, num2, allBlockDamage, allEnemyDamage, allSkillCount, num3, num4, curStage, activeUseSkillCount,
			roundInfos, challengeScore
		};
		LuaHelper.CallFunction(funcName, args);
	}

	public void OnGameInterruptExit()
	{
		if (playerModelGo != null)
		{
			Transform transform = playerModelGo.transform.Find("timeline");
			if (transform != null)
			{
				transform.gameObject.SetActive(value: false);
				foreach (Transform item in transform)
				{
					PlayableDirector component = item.GetComponent<PlayableDirector>();
					if (component != null)
					{
						component.time = component.duration + 1.0;
						component.Stop();
					}
				}
			}
		}
		foreach (GameObject enemyModelGo in enemyModelGoList)
		{
			if (!(enemyModelGo != null))
			{
				continue;
			}
			Transform transform2 = enemyModelGo.transform.Find("timeline");
			if (!(transform2 != null))
			{
				continue;
			}
			transform2.gameObject.SetActive(value: false);
			foreach (Transform item2 in transform2)
			{
				PlayableDirector component2 = item2.GetComponent<PlayableDirector>();
				if (component2 != null)
				{
					component2.Stop();
				}
			}
		}
		StopTimer();
		GameRestart();
	}

	public void StartDebateStage()
	{
		uiDebeateRoundTipsGo.SetActive(value: true);
		playRoundTick = 0;
		playRoundTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			playRoundTick++;
			if (playRoundTick == 4)
			{
				PinballGameManager.Instance.CanPlayGuide = true;
				FuncTimerManager.inst.RemoveFuncTimer(playRoundTimer);
			}
		}, 0.33f);
		CheckBubbleTrigger(4);
		uiDebateProgressGo.SetActive(value: true);
		debateStartRound = curRound;
		hitDebateBlockCount = 0;
		remainHitDebateBlockCount = 0;
		UpdateDebateProgressSlider();
		uiControllerCollectionEx.GetController("bg").SetSelectedState("on");
		uiDebateBgAni.Play("in", -1, 0f);
		SkillAndBuffReduceTime();
		uiControllerCollectionEx.GetController("roundInfo").SetSelectedState("roundOnly");
		uiControllerCollectionEx.GetController("playerATK").SetSelectedState("hide");
		UpdateDebateLeftRoundText();
	}

	public void ExitDebateStage()
	{
		SaveDebateEndStageInfo();
		uiDebeateRoundTipsGo.SetActive(value: false);
		uiDebateProgressGo.SetActive(value: false);
		uiExitDebeateRoundFailTipsGo.SetActive(value: false);
		curRound = debateStartRound;
		debateStartRound = 1;
		hitDebateBlockCount = 0;
		hasPassDebate = true;
		uiDebateBgAni.Play("out", -1, 0f);
		uiBreakBtnGo.SetActive(value: false);
		if (PinballGameManager.Instance.MapData.challengeRound != 0)
		{
			uiControllerCollectionEx.GetController("roundInfo").SetSelectedState("challengemode");
			UpdateChallengeLeftRoundText();
		}
		else
		{
			uiControllerCollectionEx.GetController("roundInfo").SetSelectedState("waves");
		}
		SkillAndBuffReduceTime();
	}

	private void UpdateChallengeLeftRoundText()
	{
		object[] array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_LEFT_ROUND");
		if (array != null && array != null)
		{
			string format = array[0].ToString();
			uiChallengeLeftRoundCountText.text = string.Format(format, PinballGameManager.Instance.MapData.challengeRound - curRound);
		}
	}

	private void UpdateDebateLeftRoundText()
	{
		object[] array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_LEFT_ROUND");
		if (array != null)
		{
			string format = array[0].ToString();
			uiDebateLeftRoundCountText.text = string.Format(format, PinballGameManager.Instance.MapData.stageData.debateRoundLimit - (curRound - debateStartRound));
		}
	}

	private void UpdateChallengeScoreText()
	{
		object[] array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_SCORE");
		if (array != null)
		{
			string format = array[0].ToString();
			uiChallengeScoreText.text = string.Format(format, challengeScore);
		}
	}

	public void UpdateChargeStatesUI(ChargeState chargeState)
	{
		chargeRoundText.text = chargeState.remainingRounds.ToString();
		chargeInterruptedDamageText.text = chargeState.receivedDamage + "/" + chargeState.requiredDamageToInterrupt;
	}

	private void AddBtnListener()
	{
		RemoveBtnListener();
		tipsMaskBtn.onClick.AddListener(delegate
		{
			tipsMaskBtn.transform.gameObject.SetActive(value: false);
			if (pressTipsGo != null)
			{
				pressTipsGo.SetActive(value: false);
			}
			isPress = false;
			pressTime = 0f;
		});
		uiDoubleBtn.onClick.AddListener(delegate
		{
			PinballGameManager.Instance.GMDoubleSpeed = !PinballGameManager.Instance.GMDoubleSpeed;
			uiDoubleTagOn.SetActive(PinballGameManager.Instance.GMDoubleSpeed);
			uiDoubleTagOff.SetActive(!PinballGameManager.Instance.GMDoubleSpeed);
		});
		uiBreakBtn.onClick.AddListener(delegate
		{
			PinballGameManager.Instance.RoundOver(forceBreak: true);
		});
		foreach (PinballAimTrigger uiPlayerSkillTrigger in uiPlayerSkillTriggerList)
		{
			uiPlayerSkillTrigger.SetClickCallBack(delegate
			{
				if (state == TurnGameState.RoundBeginPhase)
				{
					int num2 = uiPlayerSkillTriggerList.IndexOf(uiPlayerSkillTrigger);
					if (num2 < activePlayerSkillIndex.Count)
					{
						PlayerUseSkill(num2);
					}
				}
			});
			uiPlayerSkillTrigger.SetPressDownCallBack(delegate
			{
				int num2 = uiPlayerSkillTriggerList.IndexOf(uiPlayerSkillTrigger);
				if (num2 < activePlayerSkillIndex.Count)
				{
					OnPressDownPlayerSkillIcon(num2);
				}
			});
			uiPlayerSkillTrigger.SetPressUpCallBack(delegate
			{
				int num2 = uiPlayerSkillTriggerList.IndexOf(uiPlayerSkillTrigger);
				if (num2 < activePlayerSkillIndex.Count)
				{
					OnPressUp(num2);
				}
			});
		}
		for (int num = 0; num < uiEnemySkillTriggerList.Count; num++)
		{
			int idx = num;
			uiEnemySkillTriggerList[num].SetClickCallBack(delegate
			{
				OnPressDownEnemyActionIcon(activeEnemySkillIndex[idx]);
				tipsMaskBtn.transform.gameObject.SetActive(value: true);
			});
			uiEnemySkillTriggerList[num].SetPressUpCallBack(delegate
			{
				OnPressUp(activeEnemySkillIndex[idx]);
			});
		}
	}

	private void RemoveBtnListener()
	{
		uiDoubleBtn.onClick.RemoveAllListeners();
		uiBreakBtn.onClick.RemoveAllListeners();
	}

	private void OnPressDownPlayerSkillIcon(int index)
	{
		PinballRoleSkillData pinballRoleSkillData = playerData.skillList[index];
		uiSkillTipsText.text = pinballRoleSkillData.desc;
		uiSkillTipsNameText.text = pinballRoleSkillData.name;
		string format = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_SKILL_LEVEL2")[0].ToString();
		uiSkillTipsLevelText.text = string.Format(format, pinballRoleSkillData.level);
		pressTipsGo = uiSkillTipsGo;
		uiSkillTipsGo.transform.SetParent(playerTipsParentTrs, worldPositionStays: false);
		isPress = true;
		uiTipsControllerCollectionEx.GetController("charge").SetSelectedState("hide");
	}

	private void OnPressDownEnemyActionIcon(int[] index)
	{
		if (state == TurnGameState.EnemyActionPhase || activeEnemies.Count == 0)
		{
			return;
		}
		int num = index[0];
		int num2 = index[1];
		if (num < currentWaveEnemies.Count && num2 >= 0 && num2 < currentWaveEnemies[num].skillList.Length)
		{
			PinballRoleSkillData pinballRoleSkillData = currentWaveEnemies[num].skillList[num2];
			uiSkillTipsText.text = pinballRoleSkillData.desc;
			uiSkillTipsNameText.text = pinballRoleSkillData.name;
			string format = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_SKILL_LEVEL2")[0].ToString();
			uiSkillTipsLevelText.text = string.Format(format, pinballRoleSkillData.level);
			pressTipsGo = uiSkillTipsGo;
			uiSkillTipsGo.transform.SetParent(enemyTipsParentTrs, worldPositionStays: false);
			uiSkillTipsGo.SetActive(value: true);
			isPress = true;
			ChargeState chargeState = enemyChargeStates.Find((ChargeState s) => !s.isInterrupted && s.weaknessRounds <= 0);
			if (chargeState != null && pinballRoleSkillData.sType == 14)
			{
				uiTipsControllerCollectionEx.GetController("charge").SetSelectedState("show");
				UpdateChargeStatesUI(chargeState);
			}
			else
			{
				uiTipsControllerCollectionEx.GetController("charge").SetSelectedState("hide");
			}
		}
	}

	private void OnPressUp(int[] index)
	{
		if ((double)pressTime > 0.5)
		{
			isPressFlag = true;
		}
		isPress = false;
		pressTime = 0f;
	}

	private void OnPressUp(int index)
	{
		if ((double)pressTime > 0.5)
		{
			isPressFlag = true;
		}
		isPress = false;
		pressTime = 0f;
	}

	public void InitRoleBattleData(PinballDataForExchange data)
	{
		startSP = data.playerData.skillPoint;
		playerData = data.playerData;
		enemyDataList = data.enemyDataList;
		SetRoleModel();
		InitEnemyData();
		UpdateWaveHealthUI(needAni: false, isInit: true);
	}

	public void InitEnemyData()
	{
		currentWaveEnemies = enemyDataList[PinballGameManager.Instance.currentStageIndex].ToList();
		activeEnemies.Clear();
		currentWaveTotalHp = 0f;
		currentWaveRemainingHp = 0f;
		waveDeathThresholds.Clear();
		foreach (ChargeState enemyChargeState in enemyChargeStates)
		{
			enemyChargeState.Replace();
		}
		enemyChargeStates.Clear();
		if (!PinballGameManager.Instance.MapData.stageData.isBossStage || PinballGameManager.Instance.currentStageIndex < 1)
		{
			enemyModelGoList.Clear();
			enemyAnimList.Clear();
			for (int i = 0; i < 3; i++)
			{
				Transform transform = GameObject.Find("enemySpawn/enemyPos" + (i + 1)).transform;
				while (transform.childCount > 0)
				{
					UnityEngine.Object.DestroyImmediate(transform.GetChild(0).gameObject);
				}
			}
		}
		if (currentWaveEnemies != null && currentWaveEnemies.Count > 0)
		{
			int num = Mathf.Min(currentWaveEnemies.Count, 3);
			for (int j = 0; j < headTrs.Count; j++)
			{
				headTrs[j].gameObject.SetActive(value: false);
			}
			for (int k = 0; k < num; k++)
			{
				PinballRoleBattleData pinballRoleBattleData = currentWaveEnemies[k];
				activeEnemies.Add(pinballRoleBattleData);
				pinballRoleBattleData.health = pinballRoleBattleData.maxHealth;
				currentWaveTotalHp += pinballRoleBattleData.maxHealth;
				waveDeathThresholds.Add(Mathf.RoundToInt(currentWaveRemainingHp));
				headTrs[k].SetAnchoredPosition(new Vector2(headTrs[k].parent.GetRectWidth() * currentWaveRemainingHp / currentWaveTotalHp, headTrs[k].localPosition.y));
				currentWaveRemainingHp += pinballRoleBattleData.health;
				if (!PinballGameManager.Instance.MapData.stageData.isBossStage || PinballGameManager.Instance.currentStageIndex < 1)
				{
					SpawnEnemyModel(pinballRoleBattleData, k);
				}
				if (k != 0)
				{
					headTrs[k].gameObject.SetActive(value: true);
				}
			}
			for (int l = 0; l < 3; l++)
			{
				bubbleGoList[l].SetActive(value: false);
			}
			CheckBubbleTrigger(3);
		}
		else
		{
			Debug.LogError("当前关卡没有敌人数据");
		}
		UpdateEnemySkillState(isInit: true);
	}

	private void SpawnEnemyModel(PinballRoleBattleData enemyData, int index)
	{
		GameObject gameObject = Asset.InstantiateWithoutCache(enemyData.model);
		gameObject.name = gameObject.name.Replace("(Clone)", "");
		Animator component = gameObject.GetComponent<Animator>();
		enemyModelGoList.Add(gameObject);
		enemyAnimList.Add(component);
		Transform transform = GameObject.Find("enemySpawn").transform;
		Transform transform2 = transform.Find("enemyPos" + (index + 1));
		if (transform2 == null)
		{
			transform2 = transform.Find("enemyPos") ?? transform;
		}
		Vector3 localPosition = gameObject.transform.localPosition;
		Vector3 localEulerAngles = gameObject.transform.localEulerAngles;
		Vector3 localScale = gameObject.transform.localScale;
		gameObject.transform.SetParent(transform2, worldPositionStays: false);
		gameObject.transform.localPosition = localPosition;
		gameObject.transform.localEulerAngles = localEulerAngles;
		gameObject.transform.localScale = localScale;
		gameObject.SetActive(value: true);
		EnemyAniAndEffect("appear", index);
	}

	private void UpdateWaveHealthUI(bool needAni, bool isInit = false)
	{
		uiEnemyHpText.text = currentWaveRemainingHp + "/" + currentWaveTotalHp;
		float healthRatio = currentWaveRemainingHp / currentWaveTotalHp;
		float oriDebateFill = uiEnemyDebateSlider.value;
		if (needAni)
		{
			enemyHpSlrAnimTick = 0;
			enemyHpSlrAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				enemyHpSlrAnimTick++;
				float fillAmount = uiEnemyHpRedImg.fillAmount;
				float value = uiEnemyDebateSlider.value;
				uiEnemyHpSlr.value = healthRatio;
				uiEnemyDebateSlider.value = value + ((1f - healthRatio) / (1f - PinballGameManager.Instance.MapData.stageData.debateStageDamageTrigger) - oriDebateFill) / 8f;
				uiEnemyHpRedImg.fillAmount = fillAmount - (fillAmount - healthRatio) / (float)(9 - enemyHpSlrAnimTick);
				uiEnemyHpRedImg.color = Color.red;
				Debug.Log("在第" + enemyHpSlrAnimTick + "帧，怪物血条动画数值为" + uiEnemyHpRedImg.fillAmount);
				if (enemyHpSlrAnimTick == 8)
				{
					CheckEnemyDeath();
					FuncTimerManager.inst.RemoveFuncTimer(enemyHpSlrAnimTimer);
				}
			}, 0.033f, 8);
		}
		else if (isInit)
		{
			uiEnemyHpSlr.value = 1f;
			uiEnemyHpRedImg.fillAmount = uiEnemyHpSlr.value;
			uiEnemyDebateSlider.value = 0f;
			uiDebateProgressImage.fillAmount = 0f;
		}
		else
		{
			uiEnemyHpSlr.value = healthRatio;
			uiEnemyHpRedImg.fillAmount = uiEnemyHpSlr.value;
			uiEnemyDebateSlider.value = (1f - currentWaveRemainingHp / currentWaveTotalHp) / (1f - PinballGameManager.Instance.MapData.stageData.debateStageDamageTrigger);
		}
		if (activeEnemies.Count > 0 && !PinballGameManager.Instance.MapData.stageData.isBossStage)
		{
			uiSliderControllerCollectionEx.GetController("heads").SetSelectedState("show");
		}
		else
		{
			uiSliderControllerCollectionEx.GetController("heads").SetSelectedState("hide");
		}
		if (PinballGameManager.Instance.MapData.stageData.hasDebateStage && !hasPassDebate)
		{
			uiSliderControllerCollectionEx.GetController("rationality").SetSelectedState("progress");
		}
		else
		{
			uiSliderControllerCollectionEx.GetController("rationality").SetSelectedState("null");
		}
	}

	private void SetRoleModel()
	{
		Transform transform = GameObject.Find("playerSpawn").transform;
		Transform transform2 = GameObject.Find("playerSpawn/playerPos").transform;
		Transform transform3 = GameObject.Find("enemySpawn").transform;
		if (transform2.childCount == 0)
		{
			playerModelGo = Asset.InstantiateWithoutCache(playerData.model);
			playerModelGo.name = playerModelGo.name.Replace("(Clone)", "");
			playerAnim = playerModelGo.GetComponent<Animator>();
			Vector3 localEulerAngles = playerModelGo.transform.localEulerAngles;
			Vector3 localScale = playerModelGo.transform.localScale;
			Vector3 localPosition = playerModelGo.transform.localPosition;
			playerModelGo.transform.SetParent(transform2);
			playerModelGo.transform.localPosition = localPosition;
			playerModelGo.transform.localEulerAngles = localEulerAngles;
			playerModelGo.transform.localScale = localScale;
		}
		particleInScene[1, 1] = transform.Find("playerEffect/healthPoint/glow").GetComponent<ParticleSystem>();
		particleInScene[1, 2] = transform.Find("playerEffect/playerHit/glow").GetComponent<ParticleSystem>();
		particleInScene[4, 2] = transform.Find("playerEffect/playerHit/glow").GetComponent<ParticleSystem>();
		particleInScene[1, 4] = transform.Find("playerEffect/skillPoint/glow").GetComponent<ParticleSystem>();
		particleInScene[0, 2] = transform3.Find("enemyEffect/enemyHit/glow").GetComponent<ParticleSystem>();
		particleInScene[3, 2] = transform3.Find("enemyEffect/enemyHit/glow").GetComponent<ParticleSystem>();
		bossPsEffect = transform3.Find("enemyEffect/boss/dian1").GetComponent<ParticleSystem>();
		if (PinballGameManager.Instance.PlayAreaEffectList[4] == null)
		{
			PinballGameManager.Instance.PlayAreaEffectList[4] = PinballGameManager.Instance.transform.Find("EffectBossChange/smk_ring").GetComponent<ParticleSystem>();
		}
		for (int i = 0; i < heartTrs.Count; i++)
		{
			heartTrs[i].SetActive(bActive: false);
		}
		if (PinballGameManager.Instance.MapData.stageData.isBossStage)
		{
			bossPsEffect.Play();
			uiSliderControllerCollectionEx.GetController("hearts").SetSelectedState("show");
			for (int j = 0; j < enemyDataList.Length; j++)
			{
				heartTrs[j].SetActive(bActive: true);
				heartTrs[j].GetComponent<ControllerExCollection>().GetController("status").SetSelectedState("full");
			}
		}
		else
		{
			bossPsEffect.Stop();
			uiSliderControllerCollectionEx.GetController("hearts").SetSelectedState("hide");
		}
	}

	private void InitPassiveSkill(PinballRoleSkillData data)
	{
		switch (data.sType)
		{
		case 16:
			ChangePlayerSpValue((int)data.sValue[1]);
			break;
		case 17:
			skillPointDiscount = data.sValue[1] / 100f;
			break;
		case 18:
			skillPointRecovery = (int)(playerData.skillPointRestore + data.sValue[1]);
			break;
		}
	}

	private void UIViewSetup()
	{
		UpdateRoundText();
		uiPlayerHpText.text = playerData.health + "/" + playerData.maxHealth;
		uiPlayerHpSlr.value = playerData.health / playerData.maxHealth;
		uiPlayerHpRedImg.fillAmount = uiPlayerHpSlr.value;
		uiPlayerSpText.text = playerData.skillPoint + "/" + playerData.maxSkillPoint;
		playerActiveSkillCount = 0;
		for (int i = 0; i < playerData.skillList.Length; i++)
		{
			PinballSkillType sType = (PinballSkillType)playerData.skillList[i].sType;
			if (Enum.IsDefined(typeof(PinballPassiveSkillType), (int)sType))
			{
				InitPassiveSkill(playerData.skillList[i]);
			}
		}
		activeEnemySkillIndex.Clear();
		activeUseSkillCount = new int[2];
		activePlayerSkillIndex.Clear();
		tipsMaskBtn.transform.gameObject.SetActive(value: false);
		for (int j = 0; j < uiSkillTextList.Count; j++)
		{
			Text text = uiSkillTextList[j];
			Image image = uiSkillIconList[j];
			for (int k = 0; k < playerData.skillList.Length; k++)
			{
				PinballSkillType sType2 = (PinballSkillType)playerData.skillList[k].sType;
				bool flag = false;
				if (Enum.IsDefined(typeof(PinballHiddenSkillType), (int)sType2) || Enum.IsDefined(typeof(PinballPassiveSkillType), (int)sType2))
				{
					flag = true;
				}
				if (!flag && !activePlayerSkillIndex.Contains(k))
				{
					text.text = "-" + GetSkillCost(playerData.skillList[k].sValue[0]);
					image.sprite = AtlasManager.GetSpriteWithoutAtlas(playerData.skillList[k].icon);
					uiPlayerSkillTriggerList[j].transform.gameObject.SetActive(value: true);
					playerActiveSkillCount++;
					playerData.skillList[k].remainCD = 0;
					activePlayerSkillIndex.Add(k);
					break;
				}
			}
		}
		for (int l = 0; l < uiSkillTextList.Count; l++)
		{
			if (l > playerActiveSkillCount - 1)
			{
				uiSkillControllerExList[l].GetController("status").SetSelectedState("empty");
			}
		}
		UpdateWaveHealthUI(needAni: false, isInit: true);
		foreach (PinballRoleBattleData currentWaveEnemy in currentWaveEnemies)
		{
			for (int m = 0; m < currentWaveEnemy.skillList.Length; m++)
			{
				currentWaveEnemy.skillList[m].remainCD = currentWaveEnemy.skillList[m].cooldown;
			}
		}
		UpdateEnemySkillState(isInit: true);
		OnAimingTipsShow(show: false);
		isPress = false;
		pressTime = 0f;
		uiSkillTipsGo.SetActive(value: false);
		uiBreakBtnGo.SetActive(value: false);
		uiControllerCollectionEx.GetController("playerATK").SetSelectedState("hide");
		uiDebateProgressGo.SetActive(value: false);
		uiPlayerRoundTipsGo.SetActive(value: false);
		uiEnemyRoundTipsGo.SetActive(value: false);
		uiDebeateRoundTipsGo.SetActive(value: false);
		uiExitDebeateRoundTipsGo.SetActive(value: false);
		uiNextRoundTipsGo.SetActive(value: false);
		uiControllerCollectionEx.GetController("bg").SetSelectedState("off");
		uiDoubleTagOn.SetActive(PinballGameManager.Instance.GMDoubleSpeed);
		uiDoubleTagOff.SetActive(!PinballGameManager.Instance.GMDoubleSpeed);
		if (PinballGameManager.Instance.MapData.challengeRound != 0)
		{
			uiControllerCollectionEx.GetController("roundInfo").SetSelectedState("challengemode");
			UpdateChallengeLeftRoundText();
			UpdateChallengeScoreText();
		}
		else
		{
			uiControllerCollectionEx.GetController("roundInfo").SetSelectedState("waves");
		}
		countDownTick = 2;
		countDownTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (countDownTick > 1)
			{
				countDownTick--;
			}
			else
			{
				ProcessToNextState();
				FuncTimerManager.inst.RemoveFuncTimer(countDownTimer);
			}
		}, 1f, countDownNum);
	}

	public void PlayerAnimAndEffect(string animName, Action callback = null)
	{
		if (!(playerModelGo != null))
		{
			return;
		}
		Transform transform = playerModelGo.transform.Find("timeline");
		if (!(transform != null))
		{
			return;
		}
		transform.SetActive(bActive: true);
		Transform transform2 = transform.Find(animName);
		if (transform2 != null)
		{
			PlayableDirector component = transform2.GetComponent<PlayableDirector>();
			if (component != null)
			{
				StartCoroutine(PlayTimelineWithMarkers(component, callback));
			}
		}
		else
		{
			playerAnim.Play(animName);
			callback?.Invoke();
		}
	}

	private IEnumerator PlayTimelineWithMarkers(PlayableDirector director, Action callback)
	{
		Assembly assembly = Assembly.Load("P08.timeline");
		Type type = assembly.GetType("AnimatorCallBackMark");
		PropertyInfo timeField = type.BaseType.GetProperty("time");
		FieldInfo actionNameField = type.GetField("actionName");
		Type type2 = assembly.GetType("CommonAudioPlayActionNode");
		FieldInfo cueSheet = type2.GetField("mCueSheet");
		FieldInfo cueName = type2.GetField("mCueName");
		TimelineAsset obj = director.playableAsset as TimelineAsset;
		List<object> allMarkers = new List<object>();
		List<TimelineClip> allPlayCriWareAudio = new List<TimelineClip>();
		foreach (TrackAsset outputTrack in obj.GetOutputTracks())
		{
			if (outputTrack.GetType().Name == "AnimationTrack" || outputTrack.GetType().Name == "AnimatorTrack")
			{
				foreach (IMarker marker in outputTrack.GetMarkers())
				{
					if (type.IsInstanceOfType(marker))
					{
						allMarkers.Add(marker);
					}
				}
			}
			if (!(outputTrack.GetType().Name == "CommonAudioPlayActionTrack"))
			{
				continue;
			}
			foreach (TimelineClip clip in outputTrack.GetClips())
			{
				allPlayCriWareAudio.Add(clip);
			}
		}
		allMarkers.Sort(delegate(object a, object b)
		{
			double num2 = (double)timeField.GetValue(a);
			double value = (double)timeField.GetValue(b);
			return num2.CompareTo(value);
		});
		Dictionary<string, bool> triggeredMarkers = new Dictionary<string, bool>();
		director.time = 0.0;
		director.Play();
		bool triggerCallBack = false;
		if (!(director != null))
		{
			yield break;
		}
		while (director != null && director.state == PlayState.Playing)
		{
			double time = director.time;
			foreach (object item in allMarkers)
			{
				double num = (double)timeField.GetValue(item);
				string text = ((string)actionNameField.GetValue(item)) ?? "";
				if (!triggeredMarkers.ContainsKey(text))
				{
					triggeredMarkers[text] = false;
				}
				if (!triggeredMarkers[text] && time >= num)
				{
					triggeredMarkers[text] = true;
					if (text == "playerHit")
					{
						PlayerAnimAndEffect("hit");
						callback?.Invoke();
						triggerCallBack = true;
					}
					else
					{
						callback?.Invoke();
						triggerCallBack = true;
					}
				}
			}
			foreach (TimelineClip item2 in allPlayCriWareAudio)
			{
				double start = item2.start;
				string text2 = cueSheet.GetValue(item2.asset) as string;
				string text3 = cueName.GetValue(item2.asset) as string;
				string key = text2 + "_" + text3;
				if (!triggeredMarkers.ContainsKey(key))
				{
					triggeredMarkers[key] = false;
				}
				if (!triggeredMarkers[key] && time >= start)
				{
					triggeredMarkers[key] = true;
					AudioManager.Instance.Play("effect", text2, text3, useStream: false);
				}
			}
			yield return null;
		}
		if (!triggerCallBack)
		{
			callback?.Invoke();
		}
	}

	private void SetSkillIconState(bool usable, int index)
	{
		uiSkillTextList[index].color = (usable ? Color.white : new Color(0.86f, 0.86f, 0.86f));
		if (!usable)
		{
			uiSkillControllerExList[index].GetController("status").SetSelectedState("unable");
		}
		else
		{
			uiSkillControllerExList[index].GetController("status").SetSelectedState("completing");
		}
	}

	public void SetUIHitNumberTextOnCollision(int changeNumber, bool isDamageType)
	{
		curRoundHitNumber += (float)changeNumber * damageBlockExtraRate * playerTotalAtk;
		uiPlayerAttackText.text = Mathf.FloorToInt(curRoundHitNumber).ToString();
		uiPlayerAttackAni.Play("playerATKNum_01", -1, 0f);
		if (curRoundHitNumber >= 5000f)
		{
			uiPlayerAttackFireEffect.SetActive(value: true);
		}
		else
		{
			uiPlayerAttackFireEffect.SetActive(value: false);
		}
	}

	public void SetUIBreakNumberText(int breakNums)
	{
		uiBreakNumText.text = breakNums.ToString();
	}

	private void ChangePhaseLightState(bool playerPhase)
	{
		uiPlayerRoundTipsGo.SetActive(value: false);
		uiEnemyRoundTipsGo.SetActive(value: false);
		if (playerPhase)
		{
			uiPlayerRoundTipsGo.SetActive(value: true);
			string text = ((PinballGameManager.Instance.MapData.stageData.isBossStage && isBossTurnPhase) ? "PINBALLGAME_GAME_ROUND_TIPS3" : ((PinballGameManager.Instance.MapData.challengeRound == 0 || PinballGameManager.Instance.MapData.stageData.isDebateStage) ? "PINBALLGAME_GAME_ROUND_TIPS5" : "PINBALLGAME_GAME_ROUND_TIPS4"));
			object[] array = LuaHelper.CallFunction("GetTips", text);
			if (array != null)
			{
				string text2 = array[0].ToString();
				if (PinballGameManager.Instance.MapData.stageData.isBossStage && isBossTurnPhase)
				{
					uiPlayerRoundTipsText.text = string.Format(text2, PinballGameManager.Instance.currentStageIndex + 1);
				}
				else if (PinballGameManager.Instance.MapData.challengeRound != 0 && !PinballGameManager.Instance.MapData.stageData.isDebateStage)
				{
					uiPlayerRoundTipsText.text = string.Format(text2, PinballGameManager.Instance.MapData.challengeRound - curRound);
				}
				else
				{
					uiPlayerRoundTipsText.text = text2;
				}
			}
			playRoundTick = 0;
			playRoundTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				playRoundTick++;
				if (playRoundTick == 2)
				{
					PinballGameManager.Instance.CanPlayGuide = true;
					FuncTimerManager.inst.RemoveFuncTimer(playRoundTimer);
				}
			}, 0.33f);
			isBossTurnPhase = false;
		}
		else
		{
			object[] array2 = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_ROUND_TIPS6");
			if (array2 != null)
			{
				string text3 = array2[0].ToString();
				uiEnemyRoundTipsText.text = text3;
			}
			uiEnemyRoundTipsGo.SetActive(value: true);
		}
	}

	public void NextStage()
	{
		if (PinballGameManager.Instance.MapData.stageData.isBossStage)
		{
			heartTrs[enemyDataList.Length - curStage].GetComponent<ControllerExCollection>().GetController("status").SetSelectedState("empty");
		}
		curStage++;
		hasPassDebate = false;
		UpdateRoundText();
	}

	public void UpdateRoundText()
	{
		string format = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_ROUND_TIPS1")[0].ToString();
		if (PinballGameManager.Instance.MapData.challengeRound != 0)
		{
			format = LuaHelper.CallFunction("GetTips", "PINBALLGAME_GAME_ROUND_TIPS2")[0].ToString();
			uiRoundText.text = string.Format(format, curStage.ToString());
		}
		else
		{
			uiRoundText.text = string.Format(format, curStage, PinballGameManager.Instance.MapData.stageIDList.Length);
		}
	}

	public void ShowHideBlockText(int index, int jumpType, string value)
	{
		JumpTextAnim(index, jumpType, value);
	}

	private void JumpTextAnim(int index, int jumpType, string value)
	{
		bool flag = true;
		Color outlineColor;
		switch (jumpType)
		{
		case 1:
			outlineColor = new Color(0.21f, 0.7f, 0.56f);
			break;
		case 2:
			outlineColor = default(Color);
			outlineColor = ((index <= 2) ? new Color(0.63f, 0.3f, 0.34f) : new Color(0.6f, 0.15f, 0.15f));
			break;
		case 3:
			outlineColor = new Color(0.89f, 0.26f, 0.27f);
			break;
		case 4:
			outlineColor = new Color(0.27f, 0.43f, 0.71f);
			break;
		default:
			outlineColor = Color.white;
			break;
		}
		uiJumpTextGoList[index].SetActive(value: false);
		uiJumpTextList[index].text = value;
		uiJumpTextGoList[index].SetActive(value: true);
		if (flag)
		{
			uiJumpTextColorList[index]._OutlineColor = outlineColor;
		}
		if (index == 2)
		{
			uiJumpTextGoList[2].GetComponent<Animator>().Play("in", -1, 0f);
		}
		if (particleInScene[index, jumpType] != null)
		{
			particleInScene[index, jumpType].Play();
		}
	}

	private void AddAtkBuffToPlayer(float atkValue, int remain)
	{
		playerAtkBuffList.Add(atkBuffID, new AtkBuff(atkBuffID, atkValue, remain));
		atkBuffID++;
	}

	private void ChangePlayerSpValue(float detla)
	{
		detla = Mathf.Min(detla, playerData.maxSkillPoint - playerData.skillPoint);
		if (detla > 0f)
		{
			JumpTextAnim(1, 4, "+" + Mathf.FloorToInt(detla));
		}
		playerData.skillPoint += Mathf.FloorToInt(detla);
		uiPlayerSpText.text = playerData.skillPoint + "/" + playerData.maxSkillPoint;
	}

	private void HealPlayer(float recovery)
	{
		JumpTextAnim(1, 1, "+" + Mathf.FloorToInt(recovery));
		playerData.health += Mathf.FloorToInt(recovery);
		if (playerData.health > playerData.maxHealth)
		{
			playerData.health = playerData.maxHealth;
		}
		uiPlayerHpText.text = playerData.health + "/" + playerData.maxHealth;
		uiPlayerHpSlr.value = playerData.health / playerData.maxHealth;
	}

	public void HitPlayer(float damage, bool isThump = false, bool isMultiTrigger = false)
	{
		if (isThump)
		{
			JumpTextAnim(4, 2, "-" + Mathf.FloorToInt(damage));
		}
		else
		{
			JumpTextAnim(1, 2, "-" + Mathf.FloorToInt(damage));
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_6", "minigame_activity_4_6_marble_hit", useStream: false);
		playerData.health -= Mathf.FloorToInt(damage);
		if (playerData.health < 0f)
		{
			playerData.health = 0f;
		}
		float healthRatio = playerData.health / playerData.maxHealth;
		uiPlayerHpText.text = playerData.health + "/" + playerData.maxHealth;
		uiPlayerHpSlr.value = healthRatio;
		if (!isMultiTrigger)
		{
			playerHpSlrAnimTick = 0;
			playerHpSlrAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				playerHpSlrAnimTick++;
				float fillAmount = uiPlayerHpRedImg.fillAmount;
				uiPlayerHpRedImg.fillAmount = fillAmount - (fillAmount - healthRatio) / (float)(9 - playerHpSlrAnimTick);
			}, 0.033f, 8);
		}
		else
		{
			uiPlayerHpRedImg.fillAmount = healthRatio;
		}
		if (playerData.health == 0f)
		{
			RoundBreakToOverPhase(win: false);
		}
	}

	public void HealEnemy(float recovery, PinballRoleBattleData targetEnemy = null)
	{
		if (targetEnemy == null)
		{
			foreach (PinballRoleBattleData activeEnemy in activeEnemies)
			{
				activeEnemy.health += Mathf.FloorToInt(recovery);
				if (activeEnemy.health > activeEnemy.maxHealth)
				{
					activeEnemy.health = activeEnemy.maxHealth;
				}
			}
		}
		else
		{
			targetEnemy.health += Mathf.FloorToInt(recovery);
			if (targetEnemy.health > targetEnemy.maxHealth)
			{
				targetEnemy.health = targetEnemy.maxHealth;
			}
		}
		UpdateWaveHealthUI(needAni: true);
	}

	private void HitEnemy(float damage, bool isDebateDamange = false, bool isSuccess = false)
	{
		PinballGameManager instance = PinballGameManager.Instance;
		float num = damage;
		if (!hasPassDebate && activeEnemies.Count > 0 && instance.MapData.stageData.hasDebateStage && !instance.MapData.stageData.isDebateStage)
		{
			float num2 = currentWaveRemainingHp - instance.MapData.stageData.debateStageDamageTrigger * currentWaveTotalHp;
			if (damage > num2)
			{
				ChangePlayerSpValue((damage - num2) * PinballGameManager.Instance.MapData.debateOverflowDamageToSkillPointRate);
				damage = Mathf.CeilToInt(num2);
			}
		}
		float num3 = damage;
		if (num3 < 1f)
		{
			num3 = 1f;
		}
		float num4 = num3;
		if (num4 > currentWaveRemainingHp)
		{
			int num5 = 0;
			object[] array = (LuaHelper.CallFunction("PinballBridge.GetOverFlowDamageScore")[0] as LuaTable).ToArray();
			if (array.Length != 0)
			{
				object[] array2 = array;
				for (int i = 0; i < array2.Length; i++)
				{
					object[] array3 = (array2[i] as LuaTable).ToArray();
					if (num4 - currentWaveRemainingHp > (float)(int)(double)array3[0])
					{
						num5 = Mathf.Max((int)(double)array3[1], num5);
					}
				}
			}
			num4 = currentWaveRemainingHp + (float)num5;
		}
		allBlockDamage += Mathf.CeilToInt(num3);
		if (isDebateDamange)
		{
			if (isSuccess)
			{
				challengeScore += PinballGameManager.Instance.MapData.debateSuccessScore;
			}
			else
			{
				challengeScore += Mathf.CeilToInt(PinballGameManager.Instance.MapData.debateLoseScore);
			}
		}
		else
		{
			challengeScore += Mathf.CeilToInt(num4);
		}
		if (activeEnemies.Count == 0)
		{
			return;
		}
		if (num3 > 5000f)
		{
			JumpTextAnim(3, 2, "-" + Mathf.FloorToInt(num3));
		}
		else
		{
			JumpTextAnim(0, 2, "-" + Mathf.FloorToInt(num3));
		}
		float num6 = activeEnemies.Sum((PinballRoleBattleData e) => e.health);
		foreach (PinballRoleBattleData enemy in activeEnemies)
		{
			if (!(enemy.health > 0f))
			{
				continue;
			}
			float damage2 = num3 * (enemy.health / num6);
			ApplyDamageToEnemy(enemy, damage2);
			int enemyIndex = currentWaveEnemies.FindIndex((PinballRoleBattleData e) => e == enemy);
			if (enemyIndex < 0 || enemyIndex >= enemyAnimList.Count || !(enemyAnimList[enemyIndex] != null))
			{
				continue;
			}
			ChargeState chargeState = enemyChargeStates.Find((ChargeState s) => s.enemy == enemy);
			if (chargeState != null)
			{
				if (num3 < num)
				{
					chargeState.isInterrupted = true;
					enemyChargeStates.Remove(chargeState);
					EnemyAniAndEffect("charging", enemyIndex, null, play: false);
					EnemyAniAndEffect("breaking", enemyIndex, delegate
					{
						EnemyAniAndEffect("hit", enemyIndex);
					}, play: false);
					int[] array4 = activeEnemySkillIndex.Find((int[] index) => index[0] == enemyIndex && currentWaveEnemies[enemyIndex].skillList[index[1]].sType == 14);
					if (array4 != null && array4[0] >= 0)
					{
						SetSkillChargingState(array4[0], show: false, 100);
					}
				}
				CheckInterruptCharge(enemy, Mathf.CeilToInt(num3));
			}
			else
			{
				EnemyAniAndEffect("hit", enemyIndex);
			}
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_6", "minigame_activity_4_6_pinball_hit", useStream: false);
		currentWaveRemainingHp = activeEnemies.Sum((PinballRoleBattleData e) => e.health);
		UpdateWaveHealthUI(needAni: true);
		UpdateChallengeScoreText();
	}

	private void ApplyDamageToEnemy(PinballRoleBattleData enemy, float damage)
	{
		enemy.health -= Mathf.CeilToInt(damage);
		if (enemy.health < 0f)
		{
			enemy.health = 0f;
		}
	}

	public void GMToNextWave()
	{
		if (!hasPassDebate && PinballGameManager.Instance.MapData.stageData.hasDebateStage)
		{
			PinballGameManager instance = PinballGameManager.Instance;
			state = TurnGameState.RoundOverPhase;
			instance.DebateInitGame(instance.MapData.stageData.debateStageData);
			StartDebateStage();
			ProcessToNextState();
			return;
		}
		activeEnemies.Clear();
		if (PinballGameManager.Instance.currentStageIndex == PinballGameManager.Instance.MapData.stageIDList.Length - 1)
		{
			RoundBreakToOverPhase(win: true);
			return;
		}
		PinballGameManager.Instance.NextStage();
		InitEnemyData();
		UpdateWaveHealthUI(needAni: false, isInit: true);
		state = TurnGameState.RoundOverPhase;
		ProcessToNextState();
	}

	private void CheckEnemyDeath()
	{
		needPlayAni = false;
		hasTriggerCallback = false;
		for (int i = 0; i < waveDeathThresholds.Count; i++)
		{
			if (!(currentWaveRemainingHp <= waveDeathThresholds[i]) || activeEnemies.Count <= i)
			{
				continue;
			}
			int num = currentWaveEnemies.Count - i;
			for (int j = 0; j < num; j++)
			{
				if (currentWaveEnemies.Count <= 0)
				{
					break;
				}
				PinballRoleBattleData enemyToRemove = currentWaveEnemies[currentWaveEnemies.Count - 1 - j];
				enemyToRemove.health = 0f;
				int num2 = currentWaveEnemies.FindIndex((PinballRoleBattleData e) => e == enemyToRemove);
				if (num2 < 0 || num2 >= enemyAnimList.Count || !(enemyAnimList[num2] != null))
				{
					continue;
				}
				needPlayAni = true;
				if (pressTipsGo != null && pressTipsGo.activeInHierarchy)
				{
					isPress = false;
					pressTime = 0f;
					uiSkillTipsGo.SetActive(value: false);
				}
				bool flag = PinballGameManager.Instance.MapData.stageData.isBossStage && curStage < PinballGameManager.Instance.MapData.stageIDList.Length;
				string aniName = (flag ? "phase" : "dead");
				GameObject enemyGo = enemyModelGoList[num2];
				isBossTurnPhase = (flag ? true : false);
				EnemyAniAndEffect(aniName, num2, delegate
				{
					if (aniName == "dead" && enemyGo != null)
					{
						enemyGo.SetActive(value: false);
					}
					activeEnemies.Remove(enemyToRemove);
					UpdateEnemySkillState();
					if (activeEnemies.Count == 1)
					{
						activeEnemies[0].health = currentWaveRemainingHp;
					}
					headTrs[j].SetActive(bActive: false);
					if (!hasTriggerCallback)
					{
						hasTriggerCallback = true;
						CheckEnterNextRound();
					}
				});
				EnemyAniAndEffect("breaking", num2, null, play: false);
				EnemyAniAndEffect("charging", num2, null, play: false);
			}
			break;
		}
		if (!needPlayAni)
		{
			CheckEnterNextRound();
		}
	}

	private void CheckEnterNextRound()
	{
		if (CanEnterDebateStage() && !hasPassDebate)
		{
			state = TurnGameState.RoundOverPhase;
			PinballGameManager.Instance.CanPlayGuide = false;
			PinballGameManager.Instance.DebateInitGame(PinballGameManager.Instance.MapData.stageData.debateStageData);
			isEnterDebateStage = true;
			StartDebateStage();
		}
		if (currentWaveRemainingHp <= 0f)
		{
			activeEnemies.Clear();
			if (PinballGameManager.Instance.currentStageIndex == PinballGameManager.Instance.MapData.stageIDList.Length - 1)
			{
				RoundBreakToOverPhase(win: true);
				return;
			}
			nextStageAnimTick = 0;
			nextStageAnimTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				nextStageAnimTick++;
				if (nextStageAnimTick == 1)
				{
					if (PinballGameManager.Instance.MapData.stageData.isBossStage && curStage < PinballGameManager.Instance.MapData.stageIDList.Length)
					{
						PinballGameManager.Instance.PlayAreaEffectList[4].transform.parent.SetActive(bActive: true);
					}
					PinballGameManager.Instance.NextStage();
					InitEnemyData();
					UpdateWaveHealthUI(needAni: false, isInit: true);
				}
				if (nextStageAnimTick == 3)
				{
					state = TurnGameState.RoundOverPhase;
					SkillAndBuffReduceTime();
					ProcessToNextState();
					FuncTimerManager.inst.RemoveFuncTimer(nextStageAnimTimer);
				}
			}, 0.33f);
		}
		else
		{
			if (!PinballGameManager.Instance.MapData.stageData.isDebateStage && PinballGameManager.Instance.MapData.challengeRound != 0 && curRound >= PinballGameManager.Instance.MapData.challengeRound)
			{
				state = TurnGameState.RoundOverPhase;
			}
			ProcessToNextState();
		}
	}

	private void CheckInterruptCharge(PinballRoleBattleData enemy, int damage)
	{
		ChargeState chargeState = enemyChargeStates.Find((ChargeState s) => s.enemy == enemy && !s.isInterrupted && s.weaknessRounds <= 0);
		if (chargeState == null)
		{
			return;
		}
		chargeState.receivedDamage += damage;
		int enemyIndex = currentWaveEnemies.IndexOf(enemy);
		int[] sindex = activeEnemySkillIndex.Find((int[] index) => index[0] == enemyIndex && currentWaveEnemies[enemyIndex].skillList[index[1]].sType == 14);
		if (chargeState.receivedDamage >= chargeState.requiredDamageToInterrupt)
		{
			chargeState.isInterrupted = true;
			chargeState.weaknessRounds = chargeState.weaknessCount;
			if (enemy.health > 0f)
			{
				object[] array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_3");
				JumpTextAnim(2, 0, string.Format(array[0].ToString(), chargeState.weaknessCount));
				if (enemyIndex >= 0 && enemyIndex < enemyAnimList.Count && enemyAnimList[enemyIndex] != null)
				{
					EnemyAniAndEffect("break", enemyIndex, delegate
					{
						EnemyAniAndEffect("breaking", enemyIndex);
						EnemyAniAndEffect("charging", enemyIndex, null, play: false);
						if (sindex != null && sindex[0] >= 0)
						{
							SetSkillChargingState(sindex[0], show: false, 100);
						}
					});
					FuncTimerManager.inst.CreateFuncTimer(delegate
					{
						uiJumpTextGoList[2].GetComponent<Animator>().Play("out", -1, 0f);
					}, 0.5f, 1);
				}
				if (sindex != null && sindex[0] >= 0)
				{
					SetSkillChargingState(sindex[0], show: true, Mathf.RoundToInt((chargeState.requiredDamageToInterrupt - chargeState.receivedDamage) / chargeState.requiredDamageToInterrupt * 100f));
				}
			}
			else
			{
				EnemyAniAndEffect("breaking", enemyIndex);
				EnemyAniAndEffect("charging", enemyIndex, null, play: false);
				if (sindex != null && sindex[0] >= 0)
				{
					SetSkillChargingState(sindex[0], show: false, 100);
				}
			}
		}
		else if (sindex != null && sindex[0] >= 0)
		{
			SetSkillChargingState(sindex[0], show: true, Mathf.RoundToInt((chargeState.requiredDamageToInterrupt - chargeState.receivedDamage) / chargeState.requiredDamageToInterrupt * 100f));
		}
	}

	private void PlayerUseSkill(int index)
	{
		PinballRoleSkillData pinballRoleSkillData = playerData.skillList[index];
		if (playerData.skillPoint < (float)GetSkillCost(pinballRoleSkillData.sValue[0]))
		{
			if (pinballRoleSkillData.remainCD != pinballRoleSkillData.cooldown + 1)
			{
				object[] array = LuaHelper.CallFunction("GetTips", "PINBALL_SKILLPOINT_NOT_ENOUGH");
				LuaHelper.CallFunction("ShowTips", array[0].ToString());
			}
			return;
		}
		if (pinballRoleSkillData.remainCD > 0)
		{
			if (pinballRoleSkillData.remainCD != pinballRoleSkillData.cooldown + 1)
			{
				object[] array2 = LuaHelper.CallFunction("GetTips", "PINBALL_SKILL_COOLDOWN");
				LuaHelper.CallFunction("ShowTips", array2[0].ToString());
			}
			return;
		}
		Debug.Log("玩家释放了技能");
		allSkillCount++;
		activeUseSkillCount[index]++;
		ChangePlayerSpValue(-GetSkillCost(pinballRoleSkillData.sValue[0]));
		pinballRoleSkillData.remainCD = pinballRoleSkillData.cooldown + 1;
		uiSkillControllerExList[index].GetController("status").SetSelectedState("completed");
		for (int i = 0; i < uiSkillControllerExList.Count; i++)
		{
			if ((i >= activePlayerSkillIndex.Count || activePlayerSkillIndex[i] != index) && uiSkillControllerExList[i].GetController("status").GetSelectedIndex() != 2)
			{
				if (i > activePlayerSkillIndex.Count - 1)
				{
					uiSkillControllerExList[i].GetController("status").SetSelectedState("empty");
				}
				else if (playerData.skillPoint < (float)GetSkillCost(playerData.skillList[activePlayerSkillIndex[i]].sValue[0]))
				{
					uiSkillControllerExList[i].GetController("status").SetSelectedState("unable");
				}
			}
		}
		PlayerAnimAndEffect(pinballRoleSkillData.animName);
		useDiffSkillRound++;
		int num = 1;
		switch ((PinballSkillType)pinballRoleSkillData.sType)
		{
		case PinballSkillType.PLAYER01:
			HitEnemy(pinballRoleSkillData.sValue[1] * 0.01f * playerData.abilityPower);
			Debug.Log("玩家直伤");
			break;
		case PinballSkillType.PLAYER02:
			HealPlayer(pinballRoleSkillData.sValue[1] * 0.01f * playerData.abilityPower);
			Debug.Log("玩家回血");
			break;
		case PinballSkillType.PLAYER03:
			num = Mathf.FloorToInt((pinballRoleSkillData.sValue[2] == 0f) ? 560000f : pinballRoleSkillData.sValue[2]);
			AddAtkBuffToPlayer(pinballRoleSkillData.sValue[1] * 0.01f * playerData.abilityPower, num);
			Debug.Log("玩家加攻");
			break;
		case PinballSkillType.PLAYER04:
			num = Mathf.FloorToInt((pinballRoleSkillData.sValue[2] == 0f) ? 560000f : pinballRoleSkillData.sValue[2]);
			PinballGameManager.Instance.SetAllBallTypeForSkill(Mathf.FloorToInt(pinballRoleSkillData.sValue[1]), num, pinballRoleSkillData.sValue);
			Debug.Log("玩家转化球");
			break;
		case PinballSkillType.PLAYER05:
		{
			int num3 = Mathf.FloorToInt(pinballRoleSkillData.sValue[1]);
			for (int j = 0; j < num3; j++)
			{
				PinballGameManager.Instance.GetFreeTempBall();
			}
			Debug.Log("玩家增加临时球");
			break;
		}
		case PinballSkillType.PLAYER06:
		{
			int num2 = Mathf.FloorToInt(pinballRoleSkillData.sValue[1]);
			PinballGameManager.Instance.SupplementBlocksAtEmptySpace(num2);
			break;
		}
		case PinballSkillType.PLAYER07:
			PinballGameManager.Instance.SetBallBuffWithCount(1, (int)pinballRoleSkillData.sValue[1], pinballRoleSkillData.sValue);
			Debug.Log("玩家转化爆破弹");
			break;
		case PinballSkillType.PLAYER08:
			PinballGameManager.Instance.SetBallBuffWithCount(2, (int)pinballRoleSkillData.sValue[1], pinballRoleSkillData.sValue);
			Debug.Log("玩家转化分裂弹");
			break;
		case PinballSkillType.PLAYER09:
			PinballGameManager.Instance.SetBallBuffWithCount(4, (int)pinballRoleSkillData.sValue[1], pinballRoleSkillData.sValue);
			Debug.Log("玩家转化贯穿弹");
			break;
		}
	}

	private void EnemyActionSkill(int enemyIndex, int skillIndex)
	{
		if (activeEnemies.Count == 0)
		{
			return;
		}
		if (enemyIndex < 0 || enemyIndex >= currentWaveEnemies.Count)
		{
			Debug.LogError("敌人索引无效: " + enemyIndex);
			return;
		}
		PinballRoleBattleData currentEnemy = currentWaveEnemies[enemyIndex];
		if (skillIndex < 0 || skillIndex >= currentEnemy.skillList.Length)
		{
			Debug.LogError("技能索引无效: " + skillIndex + " 对于敌人: " + enemyIndex);
			return;
		}
		PinballRoleSkillData skill = currentEnemy.skillList[skillIndex];
		Debug.Log("怪物技能冷却剩余" + skill.remainCD);
		if (skill.remainCD > 0)
		{
			return;
		}
		Debug.Log("怪物释放了第" + skillIndex + "个技能");
		skill.remainCD = skill.cooldown;
		int num = 1;
		object[] array = null;
		switch ((PinballSkillType)skill.sType)
		{
		case PinballSkillType.ENEMY02:
			num = Mathf.FloorToInt((skill.sValue[2] == 0f) ? 560000f : skill.sValue[2]);
			AddAtkBuffToPlayer((0f - skill.sValue[1]) * 0.01f * currentEnemy.abilityPower, num);
			Debug.Log("怪物减攻");
			break;
		case PinballSkillType.ENEMY03:
			ChangePlayerSpValue((0f - skill.sValue[1]) * 0.01f * currentEnemy.abilityPower);
			Debug.Log("怪物扣sp");
			break;
		case PinballSkillType.ENEMY04:
			num = Mathf.FloorToInt((skill.sValue[2] == 0f) ? 560000f : skill.sValue[2]);
			AddAtkToEnemy(currentEnemy, skill.sValue[1] * 0.01f * currentEnemy.abilityPower, num);
			Debug.Log("怪物加攻");
			break;
		case PinballSkillType.ENEMY05:
			PinballGameManager.Instance.ChangeAllBlockRemainHpForSkill(Mathf.FloorToInt(skill.sValue[1] * 0.01f * currentEnemy.abilityPower));
			Debug.Log("怪物加砖块血");
			break;
		case PinballSkillType.ENEMY06:
			num = Mathf.FloorToInt((skill.sValue[3] == 0f) ? 560000f : skill.sValue[3]);
			PinballGameManager.Instance.ChangeBlockTypeForSkill(Mathf.FloorToInt(skill.sValue[2]), Mathf.FloorToInt(skill.sValue[1]), num);
			Debug.Log("怪物改部分砖块类型");
			break;
		case PinballSkillType.ENEMY07:
			enemyMultiActionCount = Mathf.FloorToInt(skill.sValue[1]);
			Debug.Log("怪物多重施法");
			break;
		case PinballSkillType.ENEMY08:
			num = Mathf.FloorToInt((skill.sValue[2] == 0f) ? 560000f : skill.sValue[2]);
			PinballGameManager.Instance.SetAllBallTypeForSkill(Mathf.FloorToInt(skill.sValue[1]), num, skill.sValue);
			Debug.Log("怪物改球");
			break;
		case PinballSkillType.ENEMY09:
			num = Mathf.FloorToInt((skill.sValue[2] == 0f) ? 560000f : skill.sValue[2]);
			PinballGameManager.Instance.ChangeAllBlockTypeForSkill(Mathf.FloorToInt(skill.sValue[1]), num);
			Debug.Log("怪物改所有砖块类型");
			break;
		case PinballSkillType.PLAYER05:
		{
			int num2 = Mathf.FloorToInt(skill.sValue[1]);
			int damage = Mathf.FloorToInt(skill.sValue[2]);
			int hideBlockCount = 0;
			int recoverHideBlockTime = 0;
			int num3 = Mathf.FloorToInt(skill.sValue[3]);
			int weaknessCount = Mathf.FloorToInt(skill.sValue[4]);
			enemyChargeStates.Add(new ChargeState(currentEnemy, num2, damage, hideBlockCount, recoverHideBlockTime, num3, weaknessCount));
			int[] array2 = activeEnemySkillIndex.Find((int[] index) => index[0] == enemyIndex && currentWaveEnemies[enemyIndex].skillList[index[1]].sType == 14);
			if (array2 != null && array2[0] >= 0)
			{
				SetSkillChargingState(array2[0], show: true, 100);
			}
			array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_2");
			JumpTextAnim(2, 0, string.Format(array[0].ToString(), num2, num3));
			Debug.Log("怪物蓄力并隐藏砖块");
			break;
		}
		case PinballSkillType.ENEMY11:
			num = 9999;
			PinballGameManager.Instance.AddBuffToRandomBlocks(BlockBuffType.protect, (int)skill.sValue[1], skill.sValue);
			array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_5");
			JumpTextAnim(2, 0, array[0].ToString());
			Debug.Log("怪物转换" + (int)skill.sValue[1] + "个守护砖块");
			break;
		case PinballSkillType.ENEMY12:
			num = 9999;
			PinballGameManager.Instance.AddBuffToRandomBlocks(BlockBuffType.protect, (int)skill.sValue[1], skill.sValue);
			PinballGameManager.Instance.SupplementBlocksAtEmptySpace((int)skill.sValue[2], PolygonType.protect, skill.sValue);
			Debug.Log("怪物转换" + (int)skill.sValue[1] + "个守护砖块,并生成" + (int)skill.sValue[2] + "个守护砖块");
			array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_5");
			JumpTextAnim(2, 0, array[0].ToString());
			break;
		case PinballSkillType.ENEMY13:
			num = 9999;
			PinballGameManager.Instance.AddBuffToRandomBlocks(BlockBuffType.affect, (int)skill.sValue[1], skill.sValue);
			array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_6");
			JumpTextAnim(2, 0, array[0].ToString());
			Debug.Log("怪物转换" + (int)skill.sValue[1] + "个感染砖块");
			break;
		}
		if (skill.sType != 5)
		{
			CheckBubbleTrigger(1, enemyIndex);
		}
		if (enemyIndex >= enemyAnimList.Count || !(enemyAnimList[enemyIndex] != null))
		{
			return;
		}
		EnemyAniAndEffect(skill.animName, enemyIndex, delegate
		{
			Animator component = uiJumpTextGoList[2].GetComponent<Animator>();
			switch ((PinballSkillType)skill.sType)
			{
			case PinballSkillType.ENEMY01:
				HitPlayer(skill.sValue[1] * 0.01f * currentEnemy.attack, skill.sValue[1] > 40f);
				allEnemyDamage += (int)(skill.sValue[1] * 0.01f * currentEnemy.attack);
				Debug.Log("怪物直伤");
				break;
			case PinballSkillType.PLAYER05:
				EnemyAniAndEffect("charging", enemyIndex);
				component.Play("out", -1, 0f);
				break;
			case PinballSkillType.ENEMY11:
				component.Play("out", -1, 0f);
				break;
			case PinballSkillType.ENEMY12:
				component.Play("out", -1, 0f);
				break;
			case PinballSkillType.ENEMY13:
				component.Play("out", -1, 0f);
				break;
			}
		});
	}

	private void EnemyAniAndEffect(string aniName, int enemyIndex, Action callBack = null, bool play = true)
	{
		Transform transform = enemyModelGoList[enemyIndex].transform.Find("timeline");
		if (!(transform != null))
		{
			return;
		}
		transform.SetActive(bActive: true);
		Transform transform2 = transform.Find(aniName);
		if (transform2 != null)
		{
			PlayableDirector component = transform2.GetComponent<PlayableDirector>();
			if (!(component != null))
			{
				return;
			}
			if (!play)
			{
				component.Play();
				component.time = 0.0;
				component.Stop();
				callBack?.Invoke();
				return;
			}
			StartCoroutine(PlayTimelineWithMarkers(component, callBack));
			switch (aniName)
			{
			case "attack1":
			case "skill1":
			case "skill2":
			case "charge":
			case "charge_attack":
				enemyTimelineActionTime = (float)component.duration + 0.5f;
				break;
			}
		}
		else
		{
			enemyAnimList[enemyIndex].Play(aniName);
			callBack?.Invoke();
		}
	}

	private void AddAtkToEnemy(PinballRoleBattleData enemy, float atkValue, int remain)
	{
		if (!enemyAtkBuffLists.ContainsKey(enemy))
		{
			enemyAtkBuffLists[enemy] = new Dictionary<int, AtkBuff>();
		}
		enemyAtkBuffLists[enemy].Add(atkBuffID, new AtkBuff(atkBuffID, atkValue, remain));
		atkBuffID++;
	}

	public bool UpdateChargeStates(out bool isRecovery, PinballRoleBattleData enemy)
	{
		isRecovery = false;
		List<ChargeState> list = new List<ChargeState>();
		bool result = false;
		foreach (ChargeState chargeState in enemyChargeStates)
		{
			if (enemy != chargeState.enemy)
			{
				continue;
			}
			if (!chargeState.isInterrupted)
			{
				chargeState.remainingRounds--;
				int enemyIndex = currentWaveEnemies.IndexOf(chargeState.enemy);
				if (chargeState.remainingRounds <= 0)
				{
					if (enemyIndex < 0 || enemyIndex >= enemyAnimList.Count || !(enemyAnimList[enemyIndex] != null))
					{
						continue;
					}
					int hideBlockCount = chargeState.hideBlockCount;
					int recoverHideBlockTime = chargeState.recoverHideBlockTime;
					object[] array = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_4");
					JumpTextAnim(2, 0, string.Format(array[0].ToString(), chargeState.damage, hideBlockCount, recoverHideBlockTime));
					EnemyAniAndEffect("charge_attack", enemyIndex, delegate
					{
						allEnemyDamage += chargeState.damage;
						PlayerAnimAndEffect("hit");
						HitPlayer(chargeState.damage);
						uiJumpTextGoList[2].GetComponent<Animator>().Play("out", -1, 0f);
						EnemyAniAndEffect("charging", enemyIndex, null, play: false);
						int[] array4 = activeEnemySkillIndex.Find((int[] index) => index[0] == enemyIndex && currentWaveEnemies[enemyIndex].skillList[index[1]].sType == 14);
						if (array4 != null && array4[0] >= 0)
						{
							SetSkillChargingState(array4[0], show: false, 100);
						}
					});
					list.Add(chargeState);
					result = true;
				}
				else
				{
					object[] array2 = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_2");
					JumpTextAnim(2, 0, string.Format(array2[0].ToString(), chargeState.remainingRounds, chargeState.requiredDamageToInterrupt - chargeState.receivedDamage));
					FuncTimerManager.inst.CreateFuncTimer(delegate
					{
						uiJumpTextGoList[2].GetComponent<Animator>().Play("out", -1, 0f);
					}, 1f, 1);
					result = true;
				}
			}
			else if (chargeState.weaknessRounds <= 0)
			{
				int num = currentWaveEnemies.IndexOf(chargeState.enemy);
				if (num >= 0 && num < enemyAnimList.Count && enemyAnimList[num] != null)
				{
					EnemyAniAndEffect("getup", num);
					EnemyAniAndEffect("breaking", num, null, play: false);
				}
				list.Add(chargeState);
				result = true;
				isRecovery = true;
			}
			else
			{
				object[] array3 = LuaHelper.CallFunction("GetTips", "PINBALLGAME_SKILL_TIPS_7");
				JumpTextAnim(2, 0, string.Format(array3[0].ToString(), chargeState.weaknessRounds));
				Animator ani = uiJumpTextGoList[2].GetComponent<Animator>();
				FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					ani.Play("out", -1, 0f);
				}, 1f, 1);
				result = true;
				isRecovery = true;
			}
		}
		foreach (ChargeState item in list)
		{
			item?.Replace();
			enemyChargeStates.Remove(item);
		}
		return result;
	}

	private void SkillAndBuffReduceTime()
	{
		PinballRoleSkillData[] skillList = playerData.skillList;
		foreach (PinballRoleSkillData pinballRoleSkillData in skillList)
		{
			if (pinballRoleSkillData.remainCD > 0)
			{
				pinballRoleSkillData.remainCD--;
			}
		}
		List<int> list = new List<int>();
		foreach (AtkBuff value2 in playerAtkBuffList.Values)
		{
			value2.remainTime--;
			if (value2.remainTime <= 0)
			{
				list.Add(value2.uid);
			}
		}
		foreach (int item in list)
		{
			playerAtkBuffList.Remove(item);
		}
		foreach (PinballRoleBattleData activeEnemy in activeEnemies)
		{
			skillList = activeEnemy.skillList;
			foreach (PinballRoleSkillData pinballRoleSkillData2 in skillList)
			{
				if (pinballRoleSkillData2.remainCD > 0)
				{
					pinballRoleSkillData2.remainCD--;
				}
			}
		}
		foreach (PinballRoleBattleData activeEnemy2 in activeEnemies)
		{
			if (!enemyAtkBuffLists.TryGetValue(activeEnemy2, out var value))
			{
				continue;
			}
			list.Clear();
			foreach (AtkBuff value3 in value.Values)
			{
				value3.remainTime--;
				if (value3.remainTime <= 0)
				{
					list.Add(value3.uid);
				}
			}
			foreach (int item2 in list)
			{
				value.Remove(item2);
			}
		}
		if (!PinballGameManager.Instance.MapData.stageData.isDebateStage)
		{
			ChangePlayerSpValue(skillPointRecovery);
		}
		UpdatePlayerSkillState();
	}

	public void UpdateEnemySkillState(bool isInit = false)
	{
		activeEnemySkillIndex.Clear();
		for (int i = 0; i < uiEnemySkillTextList.Count; i++)
		{
			uiEnemySkillTriggerList[i].gameObject.SetActive(value: true);
		}
		int j = 0;
		foreach (PinballRoleBattleData currentWaveEnemy in currentWaveEnemies)
		{
			if (!(currentWaveEnemy.health > 0f))
			{
				continue;
			}
			for (int k = 0; k < currentWaveEnemy.skillList.Length; k++)
			{
				PinballSkillType sType = (PinballSkillType)currentWaveEnemy.skillList[k].sType;
				if (!Enum.IsDefined(typeof(PinballHiddenSkillType), (int)sType))
				{
					if (j >= uiEnemySkillTextList.Count)
					{
						break;
					}
					uiEnemySkillImgList[j].sprite = AtlasManager.GetSpriteWithoutAtlas(currentWaveEnemy.skillList[k].icon);
					uiEnemySkillTextList[j].text = currentWaveEnemy.skillList[k].remainCD.ToString();
					SetSkillLevelState(j, currentWaveEnemy.skillList[k].level);
					if (isInit)
					{
						SetSkillChargingState(j, show: false, 100);
					}
					activeEnemySkillIndex.Add(new int[2]
					{
						currentWaveEnemies.IndexOf(currentWaveEnemy),
						k
					});
					j++;
				}
			}
		}
		for (; j < uiEnemySkillTextList.Count; j++)
		{
			uiEnemySkillTriggerList[j].gameObject.SetActive(value: false);
		}
	}

	public void UpdatePlayerSkillState()
	{
		for (int i = 0; i < playerActiveSkillCount; i++)
		{
			SetSkillIconState(playerData.skillList[activePlayerSkillIndex[i]].remainCD <= 0 && playerData.skillPoint >= (float)GetSkillCost(playerData.skillList[activePlayerSkillIndex[i]].sValue[0]), i);
		}
	}

	public void OnSkillBlockBreak()
	{
		ChangePlayerSpValue(playerData.maxSkillPoint * skillBlockExtraRate);
	}

	public void OnHealthBlockBreak()
	{
		HealPlayer(playerData.maxHealth * healthBlockExtraRate);
	}

	public void OnAimingTipsShow(bool show)
	{
		uiShootTipsGo.SetActive(show);
	}

	public void OnStopAimingTipsShow(bool show)
	{
		uiShootSecondTipsGo.SetActive(show);
	}

	public int GetRandomStaticItemHpValue()
	{
		return 999999;
	}

	public bool CheckStateToShootBall()
	{
		return state == TurnGameState.RoundBeginPhase;
	}

	public int GetRecoveryBlockValue()
	{
		return curRound;
	}

	public int GetCurRound()
	{
		return curRound;
	}

	public int GetSkillCost(float baseSkillCost)
	{
		return Mathf.RoundToInt(baseSkillCost * (1f - skillPointDiscount));
	}

	public bool CanEnterDebateStage()
	{
		if (PinballGameManager.Instance.MapData == null || activeEnemies.Count == 0 || !PinballGameManager.Instance.MapData.stageData.hasDebateStage)
		{
			return false;
		}
		return Mathf.FloorToInt(currentWaveRemainingHp) <= Mathf.CeilToInt(PinballGameManager.Instance.MapData.stageData.debateStageDamageTrigger * currentWaveTotalHp);
	}

	public bool CanExitDebateStage()
	{
		if (PinballGameManager.Instance.MapData == null || ((bool)PinballGameManager.Instance && PinballGameManager.Instance.turnBasedGame.hasPassDebate))
		{
			return false;
		}
		bool num = curRound - debateStartRound >= PinballGameManager.Instance.MapData.stageData.debateRoundLimit;
		bool flag = hitDebateBlockCount >= PinballGameManager.Instance.MapData.stageData.debateFinishCount;
		return num | flag;
	}

	public void HitDebateBlock(Vector3 pos, int value = 1)
	{
		PlayLightEffectToDebateProgress(pos, isHighValue: false, 1);
	}

	public void HitHighValueDebateBlock(Vector3 pos)
	{
		PlayLightEffectToDebateProgress(pos, isHighValue: true, PinballGameManager.Instance.MapData.stageData.baseHighValueWordValue);
	}

	private void AddHitDebateBlockCount(int value = 1)
	{
		hitDebateBlockCount += value;
		UpdateDebateProgressSlider();
	}

	private void UpdateDebateProgressSlider()
	{
		if (PinballGameManager.Instance.MapData != null && !(PinballGameManager.Instance.MapData.stageData == null))
		{
			if (uiDebateText != null)
			{
				string text = hitDebateBlockCount + "/" + PinballGameManager.Instance.MapData.stageData.debateFinishCount;
				uiDebateText.text = ((!string.IsNullOrEmpty(text)) ? text : "默认辩论描述文本");
			}
			if (uiDebateText2 != null)
			{
				string debateDescription = PinballGameManager.Instance.MapData.stageData.debateDescription;
				uiDebateText2.text = ((!string.IsNullOrEmpty(debateDescription)) ? debateDescription : "默认辩论描述文本");
			}
			if (uiSuccessDebateText != null)
			{
				string debateSuccessDesc = PinballGameManager.Instance.MapData.stageData.debateSuccessDesc;
				uiSuccessDebateText.text = ((!string.IsNullOrEmpty(debateSuccessDesc)) ? debateSuccessDesc : "默认辩论成功描述文本");
			}
			int debateFinishCount = PinballGameManager.Instance.MapData.stageData.debateFinishCount;
			if (debateFinishCount > 0)
			{
				float fillAmount = (float)hitDebateBlockCount / (float)debateFinishCount;
				uiDebateProgressImage.fillAmount = fillAmount;
			}
		}
	}

	public void PlayLightEffectToDebateProgress(Vector3 pos, bool isHighValue, int value)
	{
		StartCoroutine(PlayLightEffectToDebateProgressCoroutine(pos, isHighValue, value));
	}

	private IEnumerator PlayLightEffectToDebateProgressCoroutine(Vector3 fromPos, bool isHighValue, int value)
	{
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, fromPos);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(uiDebateProgressImage.transform.parent as RectTransform, screenPoint, CanvasManager.Instance.uiCamera, out var localPos);
		Vector3 localPosition = uiDebateProgressImage.transform.localPosition;
		float x = uiDebateProgressImage.GetComponent<RectTransform>().sizeDelta.x;
		float fillAmount = uiDebateProgressImage.fillAmount;
		Vector3 toPos = new Vector3(localPosition.x - x / 2f + x * fillAmount, localPosition.y, localPosition.z);
		GameObject effect = ((!isHighValue) ? UnityEngine.Object.Instantiate(lightEffectPrefab, uiDebateProgressImage.transform.parent) : UnityEngine.Object.Instantiate(HighValueLightEffectPrefab, uiDebateProgressImage.transform.parent));
		effect.transform.localPosition = localPos;
		effect.SetActive(value: true);
		float num = 0.5f;
		Vector3 controlPoint = new Vector3(localPos.x + (toPos.x - localPos.x) / 2f, localPos.y + (toPos.y - localPos.y) / 2f + num, 0f);
		remainHitDebateBlockCount++;
		bool add = false;
		if (remainHitDebateBlockCount <= PinballGameManager.Instance.MapData.stageData.debateFinishCount)
		{
			add = true;
		}
		float duration = 0.66f;
		float t = 0f;
		while (t < 1f)
		{
			t += Time.deltaTime / duration;
			effect.transform.localPosition = CalculateQuadraticBezierPoint(t, localPos, controlPoint, toPos);
			yield return null;
		}
		if (add)
		{
			uiDebateSliderAni.Play("Hit", -1, 0f);
			AddHitDebateBlockCount(value);
		}
		yield return new WaitForSeconds(0.5f);
		UnityEngine.Object.Destroy(effect);
	}

	private Vector3 CalculateQuadraticBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2)
	{
		float num = 1f - t;
		float num2 = t * t;
		return num * num * p0 + 2f * num * t * p1 + num2 * p2;
	}

	private ControllerEx GetControllerExByskillIndexAndName(int skillIndex, string controllerName)
	{
		if (skillIndex < 0 || skillIndex >= uiEnemySkillControllerExCollectionList.Count)
		{
			Debug.LogError("技能索引超出范围: " + skillIndex);
			return null;
		}
		ControllerExCollection controllerExCollection = uiEnemySkillControllerExCollectionList[skillIndex];
		if (controllerExCollection == null)
		{
			Debug.LogError("技能索引 " + skillIndex + " 对应的ControllerExCollection为空");
			return null;
		}
		return controllerExCollection.GetController(controllerName);
	}

	private void SetSkillLevelState(int skillIndex, float level)
	{
		ControllerEx controllerExByskillIndexAndName = GetControllerExByskillIndexAndName(skillIndex, "level");
		if (controllerExByskillIndexAndName != null)
		{
			string value = "lv" + level;
			controllerExByskillIndexAndName.SetSelectedState(value);
		}
	}

	private void SetSkillChargingState(int skillIndex, bool show, int value)
	{
		ControllerEx controllerExByskillIndexAndName = GetControllerExByskillIndexAndName(skillIndex, "charge");
		if (value < 0)
		{
			value = 0;
		}
		if (controllerExByskillIndexAndName != null)
		{
			string value2 = (show ? "show" : "hide");
			controllerExByskillIndexAndName.SetSelectedState(value2);
		}
		Transform transform = uiEnemySkillControllerExCollectionList[skillIndex].transform.Find("charge/numbg/textNum");
		if (transform != null)
		{
			transform.GetComponent<Text>().text = value + "%";
		}
		Transform transform2 = uiEnemySkillControllerExCollectionList[skillIndex].transform.Find("charge");
		if (transform2 != null)
		{
			transform2.GetComponent<Image>().fillAmount = value;
		}
	}

	private void SetSkillUsingState(int skillIndex, bool isUsing)
	{
		ControllerEx controllerExByskillIndexAndName = GetControllerExByskillIndexAndName(skillIndex, "isActive");
		if (controllerExByskillIndexAndName != null)
		{
			string value = isUsing.ToString();
			controllerExByskillIndexAndName.SetSelectedState(value);
		}
	}

	private IEnumerator ResetSkillUsingState(int enemyIndex, float delay)
	{
		yield return new WaitForSeconds(delay);
		SetSkillUsingState(enemyIndex, isUsing: false);
	}

	public RoundInfo GetRoundInfo(RoundInfo preInfo)
	{
		RoundInfo roundInfo = new RoundInfo();
		roundInfo.sequence_id = PinballGameManager.Instance.MapData.stageData.stageId;
		roundInfo.is_special = PinballGameManager.Instance.MapData.stageData.isDebateStage;
		roundInfo.battle_times = curRound;
		roundInfo.hit_num = PinballGameManager.Instance.collsionCount - roundInfo.hit_num;
		roundInfo.remove_num = PinballGameManager.Instance.resetCollsionCount - roundInfo.remove_num;
		roundInfo.different_skill_num = ((useDiffSkillRound >= 2) ? curRound : 0);
		roundInfo.activeSkillUseCount = new int[2]
		{
			activeUseSkillCount[0] - preInfo.activeSkillUseCount[0],
			activeUseSkillCount[1] - preInfo.activeSkillUseCount[1]
		};
		roundInfo.enemyHurt = allEnemyDamage - preInfo.enemyHurt;
		roundInfo.affectHurt = PinballGameManager.Instance.affectHitDamage - roundInfo.affectHurt;
		roundInfo.leftEnemyCount = activeEnemies.Count;
		roundInfo.leftEnemyWaveHp = (int)currentWaveRemainingHp;
		roundInfo.leftPlayerHp = (int)playerData.health;
		roundInfo.debateProgress = Mathf.CeilToInt((1f - currentWaveRemainingHp / currentWaveTotalHp) / (1f - PinballGameManager.Instance.MapData.stageData.debateStageDamageTrigger) * 100f);
		roundInfo.debateResult = (hasPassDebate ? 1 : 0);
		roundInfo.startTime = Time.time;
		roundInfo.useSceond = Time.time - ((preInfo.startTime == 0f) ? PinballGameManager.Instance.currentStartTime : preInfo.startTime);
		return roundInfo;
	}

	public void SaveDebateStartStageInfo()
	{
		startRoundInfo = GetRoundInfo(preRoundInfo);
	}

	public void SaveDebateEndStageInfo()
	{
		roundInfos.Add(GetRoundInfo(startRoundInfo));
	}

	public void SaveCurrRoundInfo()
	{
		preRoundInfo = GetRoundInfo(preRoundInfo);
		roundInfos.Add(preRoundInfo);
	}
}
