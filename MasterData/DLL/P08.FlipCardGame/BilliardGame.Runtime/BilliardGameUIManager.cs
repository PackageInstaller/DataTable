using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace BilliardGame.Runtime;

public class BilliardGameUIManager : MonoBehaviour
{
	public static BilliardGameUIManager Instance;

	private bool _insThis;

	private const int ENEMY_HP_BAR_NUM = 30;

	private const int PLAYER_HP_BAR_NUM = 10;

	private const int SKILL_HUD_NUM = 10;

	[Header("需要绑定的UI")]
	[SerializeField]
	private GameObject gameStartGo_;

	[SerializeField]
	private GameObject playerTurnGo_;

	[SerializeField]
	private GameObject enemyTurnGo_;

	[SerializeField]
	private GameObject comboGo_;

	[SerializeField]
	private Text comboText_;

	[SerializeField]
	private Animator comboAni_;

	[SerializeField]
	private GameObject totalDamageGo_;

	[SerializeField]
	private Text totalDamageText_;

	[SerializeField]
	private Animator totalDamageAni_;

	private GameObject comboRotateGo_;

	private GameObject comboEffectGo_;

	private Animator comboTextAnim_;

	private double addAngle;

	private double reduceAngle;

	private int effectComboNum;

	private double currentRotateZ = 135.0;

	[SerializeField]
	private List<ControllerExCollection> foodGoList_ = new List<ControllerExCollection>();

	private List<ControllerEx> foodControllerList = new List<ControllerEx>();

	[SerializeField]
	private BilliardMainHeroHeadUI[] heroHeadList_ = new BilliardMainHeroHeadUI[3];

	[SerializeField]
	private Text roundText_;

	private TurnType turnType;

	public BilliardSkillPopUI skillPop;

	[Header("HUD")]
	public GameObject enemyHpBarGo;

	public GameObject enemyPredictGo;

	public Transform enemyHpBarRoot;

	public GameObject enemyTextHudGo;

	public GameObject playerTextHudGo;

	public Transform textHudRoot;

	public GameObject skillHudGo;

	public Transform skillHudRoot;

	private LRUCache textHudLRU;

	private LRUCache playerTextHudLRU;

	private LRUCache skillHudLRU;

	[Header("胜利目标")]
	public Text victoryText_;

	public Text victoryNumText_;

	public Image victoryNumFillImage_;

	public ControllerExCollection controllerExCollection;

	private ControllerEx stateController;

	private int turnTimer = -1;

	private int damageTimer = -1;

	private bool isComboAni;

	private int maxComboNum;

	private bool isBallGame;

	public List<CanvasGroup> skillHideList_ = new List<CanvasGroup>();

	private void Awake()
	{
		if (Instance == null)
		{
			Instance = this;
			_insThis = true;
		}
		else
		{
			Object.Destroy(base.gameObject);
			Debug.LogError("已经存在一个弹球游戏管理器：" + Instance.gameObject.name);
		}
		Debug.Log("PinballGameDebugger: LogicManager:Init");
	}

	private void OnDestroy()
	{
		if (null != FuncTimerManager.inst && turnTimer != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(turnTimer);
		}
		if (_insThis)
		{
			Instance = null;
		}
		if (null != FuncTimerManager.inst && damageTimer != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(damageTimer);
		}
	}

	public void InitUI()
	{
		isComboAni = false;
		maxComboNum = 0;
		turnTimer = -1;
		damageTimer = -1;
		isBallGame = BilliardGameDataManager.IsBallGame();
		for (int i = 0; i < foodGoList_.Count; i++)
		{
			ControllerEx controller = foodGoList_[i].GetController("status");
			if (controller != null)
			{
				foodControllerList.Add(controller);
			}
		}
		InitHudBar();
		if (controllerExCollection != null)
		{
			stateController = controllerExCollection.GetController("state");
			stateController.SetSelectedState("hide");
		}
		if (!isBallGame)
		{
			InitVehicleUI();
		}
	}

	private void InitHudBar()
	{
		textHudLRU = new LRUCache(30);
		for (int i = 0; i < 30; i++)
		{
			GameObject gameObject = Object.Instantiate(enemyTextHudGo, textHudRoot, worldPositionStays: false);
			BilliardGameTextHud component = gameObject.GetComponent<BilliardGameTextHud>();
			if (null != component)
			{
				gameObject.SetActive(value: true);
				component.Init();
				component.Show(isShow: false);
				textHudLRU.Set("textHud", component);
			}
		}
		playerTextHudLRU = new LRUCache(10);
		for (int j = 0; j < 10; j++)
		{
			GameObject gameObject2 = Object.Instantiate(playerTextHudGo, textHudRoot, worldPositionStays: false);
			BilliardGameTextHud component2 = gameObject2.GetComponent<BilliardGameTextHud>();
			if (null != component2)
			{
				gameObject2.SetActive(value: true);
				component2.Init();
				component2.Show(isShow: false);
				playerTextHudLRU.Set("playerTextHud", component2);
			}
		}
		if (!(skillHudGo != null) || !(skillHudRoot != null))
		{
			return;
		}
		skillHudLRU = new LRUCache(10);
		for (int k = 0; k < 10; k++)
		{
			GameObject gameObject3 = Object.Instantiate(skillHudGo, skillHudRoot, worldPositionStays: false);
			BilliardGameSkillHud component3 = gameObject3.GetComponent<BilliardGameSkillHud>();
			if (null != component3)
			{
				gameObject3.SetActive(value: true);
				component3.Init();
				component3.Show(isShow: false);
				skillHudLRU.Set("skillHud", component3);
			}
		}
	}

	private void InitVehicleUI()
	{
		comboRotateGo_ = comboGo_.transform.Find("pointer").gameObject;
		comboEffectGo_ = comboGo_.transform.Find("eff_fire").gameObject;
		comboTextAnim_ = totalDamageGo_.transform.Find("ani_panel").GetComponent<Animator>();
		currentRotateZ = 135.0;
		object[] array = LuaHelper.CallFunction("GetPointerRoteteParams");
		if (array != null && array.Length >= 3)
		{
			addAngle = (double)array[0];
			reduceAngle = (double)array[1];
			effectComboNum = (int)(double)array[2];
		}
	}

	public void Update()
	{
		if (!isBallGame && comboRotateGo_ != null && currentRotateZ < 135.0)
		{
			currentRotateZ += reduceAngle * (double)Time.deltaTime;
			if (currentRotateZ > 135.0)
			{
				currentRotateZ = 135.0;
			}
			Vector3 localEulerAngles = comboRotateGo_.transform.localEulerAngles;
			localEulerAngles.z = (float)currentRotateZ;
			comboRotateGo_.transform.localEulerAngles = localEulerAngles;
		}
	}

	public void InitHero(int[] heroIDs)
	{
		for (int i = 0; i < heroHeadList_.Length; i++)
		{
			heroHeadList_[i].Init(heroIDs[i], i);
		}
	}

	public void ChangeTurnType(TurnType turnType)
	{
		this.turnType = turnType;
		if (!isBallGame)
		{
			if (turnType == TurnType.Enemy || turnType == TurnType.None)
			{
				OnChangeEnemyType();
			}
			return;
		}
		switch (turnType)
		{
		case TurnType.Player:
			playerTurnGo_.SetActive(value: true);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_turn01");
			break;
		case TurnType.Enemy:
			enemyTurnGo_.SetActive(value: true);
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_turn02");
			break;
		case TurnType.None:
			playerTurnGo_.SetActive(value: false);
			enemyTurnGo_.SetActive(value: false);
			break;
		}
	}

	public void OnChangeEnemyType()
	{
		comboAni_.Play("Exit");
		comboEffectGo_.SetActive(value: false);
		comboText_.text = "0";
		totalDamageText_.text = "0";
		currentRotateZ = 135.0;
		if (comboRotateGo_ != null)
		{
			Vector3 localEulerAngles = comboRotateGo_.transform.localEulerAngles;
			localEulerAngles.z = (float)currentRotateZ;
			comboRotateGo_.transform.localEulerAngles = localEulerAngles;
		}
	}

	public void UpdateCombo(int comboNum)
	{
		if (comboNum <= 1)
		{
			return;
		}
		if (comboNum < 100)
		{
			comboText_.text = $"{comboNum:00}";
		}
		else
		{
			comboText_.text = comboNum.ToString();
		}
		BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_combo");
		if (turnTimer != -1)
		{
			FuncTimerManager.inst.RemoveFuncTimer(turnTimer);
		}
		if (isBallGame)
		{
			comboGo_.SetActive(value: true);
			comboAni_.Play("UI_beatitem_cx", -1, 0f);
			turnTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				comboGo_.SetActive(value: false);
			}, 2f, 1);
			return;
		}
		if (comboNum > effectComboNum)
		{
			comboEffectGo_.SetActive(value: true);
		}
		comboAni_.Play("damageGauge");
		comboTextAnim_.Play("textNum");
		currentRotateZ -= addAngle;
		if (currentRotateZ < -135.0)
		{
			currentRotateZ = -135.0;
		}
		if (comboRotateGo_ != null)
		{
			Vector3 localEulerAngles = comboRotateGo_.transform.localEulerAngles;
			localEulerAngles.z = (float)currentRotateZ;
			comboRotateGo_.transform.localEulerAngles = localEulerAngles;
		}
	}

	private string FormatNumber(int number)
	{
		if (number >= 1000000)
		{
			return ((float)number / 1000000f).ToString("F1") + "M";
		}
		if (number >= 1000)
		{
			return ((float)number / 1000f).ToString("F1") + "K";
		}
		return number.ToString();
	}

	public void UpdateTotalDamage(int totalDamage)
	{
		totalDamageGo_.SetActive(value: true);
		if (totalDamageAni_ != null)
		{
			totalDamageAni_.Play("UI_beatitem_cx", -1, 0f);
		}
		totalDamageText_.text = FormatNumber(totalDamage);
		if (isBallGame)
		{
			if (damageTimer != -1)
			{
				FuncTimerManager.inst.RemoveFuncTimer(damageTimer);
			}
			damageTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				totalDamageGo_.SetActive(value: false);
			}, 2f, 1);
		}
	}

	public void UpdateFood(int food)
	{
		for (int i = 0; i < foodControllerList.Count; i++)
		{
			if (i < food)
			{
				foodControllerList[i].SetSelectedState("on");
			}
			else
			{
				foodControllerList[i].SetSelectedState("off");
			}
		}
	}

	public void UpdateRound(int round)
	{
		string format = LuaHelper.CallFunction("GetTips", "PINBALL_ROUND_NUM")[0].ToString();
		roundText_.text = string.Format(format, round);
	}

	public void UpdateVictory(WinType winType, int curNum, int allNum, bool isBossTurn = false)
	{
		string text = "";
		switch (winType)
		{
		case WinType.WipeOutEnemies:
			text = (isBallGame ? LuaHelper.CallFunction("GetTips", "NYA_SUMMER_PINBALL_VICTORY_GOAL_1")[0].ToString() : LuaHelper.CallFunction("GetTips", "MERGE_BALL_PROGRESS_MINION")[0].ToString());
			break;
		case WinType.HoldOnForTurns:
			text = LuaHelper.CallFunction("GetTips", "NYA_SUMMER_PINBALL_VICTORY_GOAL_2")[0].ToString();
			break;
		case WinType.WipeOutTarget:
			if (isBallGame)
			{
				text = LuaHelper.CallFunction("GetTips", "NYA_SUMMER_PINBALL_VICTORY_GOAL_3")[0].ToString();
				break;
			}
			text = (isBossTurn ? LuaHelper.CallFunction("GetTips", "MERGE_BALL_PROGRESS_BOSS")[0].ToString() : LuaHelper.CallFunction("GetTips", "NYA_SUMMER_PINBALL_VICTORY_GOAL_2")[0].ToString());
			victoryNumText_.gameObject.SetActive(!isBossTurn);
			if (stateController != null)
			{
				stateController.SetSelectedState((curNum >= allNum) ? "beat" : (isBossTurn ? "fighting" : "normal"));
			}
			break;
		}
		victoryText_.text = text;
		victoryNumText_.text = $"{curNum}/{allNum}";
		if (victoryNumFillImage_ != null)
		{
			victoryNumFillImage_.fillAmount = (isBossTurn ? 1f : ((float)curNum / (float)allNum));
		}
		if (curNum >= allNum)
		{
			LuaHelper.CallFunction("OnStageConditionFinish", true);
		}
	}

	public void UpdateHero(int heroID, HeroHeadContext context)
	{
		if (isBallGame)
		{
			for (int i = 0; i < heroHeadList_.Length; i++)
			{
				if (heroHeadList_[i].heroID == heroID)
				{
					heroHeadList_[i].RefreshHeroHead(context);
				}
			}
		}
		else
		{
			LuaHelper.CallFunction("OnVehicleInjured", context.curHp);
		}
	}

	public void ShowHeroInfo(int index)
	{
		heroHeadList_[index].ShowHeroInfo(index);
	}

	public void ShowHeadInfoBar(int index, bool isShow)
	{
		heroHeadList_[index].RefreshInfoBarShow(isShow);
	}

	public void OnLongPressHeroHead(int index, float time, float allTime)
	{
		heroHeadList_[index].RefreshInfoBar(time, allTime);
	}

	public BilliardGameEnemyHpBar InitEnemyHpBar()
	{
		GameObject obj = Object.Instantiate(enemyHpBarGo, enemyHpBarRoot, worldPositionStays: false);
		obj.SetActive(value: true);
		return obj.GetComponent<BilliardGameEnemyHpBar>();
	}

	public BilliardGameEnemyHpBar InitEnemyHpBar(int hpBarType)
	{
		GameObject obj = Object.Instantiate(enemyHpBarGo.transform.GetChild(hpBarType - 1).gameObject, enemyHpBarRoot, worldPositionStays: false);
		obj.SetActive(value: true);
		return obj.GetComponent<BilliardGameEnemyHpBar>();
	}

	public BilliardGameEnemyBuffPredict InitEnemyBuff()
	{
		GameObject obj = Object.Instantiate(enemyPredictGo, enemyHpBarRoot, worldPositionStays: false);
		obj.SetActive(value: true);
		return obj.GetComponent<BilliardGameEnemyBuffPredict>();
	}

	public BilliardGameTextHud ShowTextHud(int number, Transform trs)
	{
		BilliardGameTextHud obj = (BilliardGameTextHud)textHudLRU.Get("textHud");
		obj.SetData(number, trs);
		obj.Show(isShow: true);
		return obj;
	}

	public BilliardGameTextHud ShowPlayerTextHud(int number, Transform trs)
	{
		BilliardGameTextHud obj = (BilliardGameTextHud)playerTextHudLRU.Get("playerTextHud");
		obj.SetData(number, trs);
		obj.Show(isShow: true);
		return obj;
	}

	public BilliardGameSkillHud ShowSkillHud(string skillText, Transform trs)
	{
		BilliardGameSkillHud obj = (BilliardGameSkillHud)skillHudLRU.Get("skillHud");
		obj.SetData(skillText, trs);
		obj.Show(isShow: true);
		return obj;
	}

	public void ShowUI(bool isShow)
	{
		for (int i = 0; i < skillHideList_.Count; i++)
		{
			skillHideList_[i].alpha = (isShow ? 1 : 0);
		}
	}
}
