using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using ZumaGame;

public class ZumaGamePlay : MonoBehaviour
{
	public bool gameOver;

	public bool gamePause;

	public bool gameStart;

	private bool gameTrackIsAllOver;

	private bool gameTrackScoreIsFinish;

	private bool isPlayBeginAudio;

	[SerializeField]
	private SceneSetting sceneSetting;

	private Transform ballNode;

	public GameObject normalBallPrefab;

	public GameObject specialBallPrefab;

	public ZumaPool<ZumaBaseBall> ballNormalPool;

	public ZumaPool<ZumaBaseBall> ballSpecialPool;

	public ZumaItemManager itemManager;

	public ZumaShooter3D zumaShooter;

	public Transform trackNode;

	public GameObject trackPrefab;

	public List<ZumaTrack> trackList;

	private Dictionary<BallColorType, bool> colorDict = new Dictionary<BallColorType, bool>();

	private int createColorType;

	public SpriteRenderer bgSp;

	public SpriteRenderer bgLSp;

	public SpriteRenderer bgRSp;

	public SpriteRenderer bgBSp;

	[SerializeField]
	private SpriteRenderer heroFootBg;

	public SpriteRenderer routeSp;

	public SpriteRenderer shootFootSp;

	public ZumaMapSpriteManager bgSprteMgr;

	public int comboCount;

	private int ballCount;

	private float curTimes;

	public string realName = "";

	private float scoreSettleTimes;

	private float scoreSettleCycle = 0.05f;

	private Text timeCountdownUI;

	private Text skillCountdownUI;

	private Image skillProgressImg;

	private Animator timeCountAnimator;

	public void PauseZumaGame()
	{
		gamePause = true;
	}

	public void ReStartZumaGame()
	{
		gamePause = false;
	}

	public void ReChallengeZumaGame(ZumaDataForExchange config)
	{
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaGameReChallenge");
		foreach (ZumaTrack track in trackList)
		{
			track.Dispose();
		}
		PlayEndlessTimeAni(isPlay: false);
		trackList.Clear();
		gameOver = false;
		gamePause = false;
		colorDict.Clear();
		InitConfig(config);
		ZumaGameManager.GetInstance().isGameStart = true;
		curTimes = 0f;
	}

	public void InitConfig(ZumaDataForExchange config)
	{
		ZumaGameManager.GetInstance().InitZumaMgr(config, this);
		realName = config.mapName;
		if (config.isEndless)
		{
			realName = ZumaGameManager.GetInstance().zumaEndlessManager.RandomEndlessMap();
		}
		ZumaGameManager.GetInstance().InitZumaData(realName);
		InitData();
	}

	public void InitConfig(string wantLoadMapName, bool isEndless = false)
	{
		realName = wantLoadMapName;
		ZumaGameManager.GetInstance().InitZumaMgr(this);
		ZumaGameManager.GetInstance().InitZumaData(realName, isEndless: true);
		InitData();
		ZumaGameManager.GetInstance().isGameStart = true;
	}

	public void StartGame()
	{
		ZumaGameManager.GetInstance().isGameStart = true;
	}

	public void ExitGame()
	{
		ZumaGameManager.GetInstance().ExitGame();
	}

	private void Awake()
	{
		gameStart = false;
	}

	private void InitData()
	{
		trackList = new List<ZumaTrack>();
		ballNode = base.transform.Find("GameNode/BallNode");
		if (ballNormalPool == null)
		{
			ballNormalPool = new ZumaPool<ZumaBaseBall>(InstanceNormalBallFunc, 50);
		}
		if (ballSpecialPool == null)
		{
			ballSpecialPool = new ZumaPool<ZumaBaseBall>(InstanceSpecialBallFunc, 10);
		}
		comboCount = 0;
		isPlayBeginAudio = false;
		InitPos();
		gameStart = true;
		InitTrack();
		InitMapBg();
		itemManager.Init();
		List<bool> useColorList = ZumaGameManager.GetInstance().GetZumaMapData().useColorList;
		for (int i = 0; i < 8; i++)
		{
			if (useColorList[i])
			{
				colorDict.Add((BallColorType)i, value: true);
			}
		}
	}

	private void InitMapBg()
	{
		int difficult = ZumaGameManager.difficult;
		bgSp.sprite = bgSprteMgr.GetMapBgSprite(difficult);
		bgLSp.sprite = bgSprteMgr.GetMapBgSpriteLeft(difficult);
		bgRSp.sprite = bgSprteMgr.GetMapBgSpriteRight(difficult);
		bgBSp.sprite = bgSprteMgr.GetMapBgSpriteBottom(difficult);
		heroFootBg.sprite = bgSprteMgr.GetShootFootBgSprite(difficult);
		string mapName = ZumaGameManager.GetInstance().realName;
		routeSp.sprite = bgSprteMgr.GetRouteSprite(mapName);
		if (sceneSetting != null)
		{
			if (difficult == 1)
			{
				sceneSetting.exposure = 1.38f;
			}
			else
			{
				sceneSetting.exposure = 1.36f;
			}
		}
	}

	private void InitPos()
	{
		base.transform.Find("Shooter3D").position = ZumaGameManager.GetInstance().shootPos;
	}

	private void InitTrack()
	{
		int trackCount = ZumaGameManager.GetInstance().GetTrackCount();
		for (int i = 0; i < trackCount; i++)
		{
			ZumaTrack zumaTrack;
			if (i < trackList.Count)
			{
				zumaTrack = trackList[i];
			}
			else
			{
				zumaTrack = AddTrack();
				trackList.Add(zumaTrack);
			}
			zumaTrack.Init(this, i);
			ballCount += zumaTrack.remainBallNums;
		}
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaBallCountsUpdate", ballCount);
	}

	private ZumaTrack AddTrack()
	{
		return Object.Instantiate(trackPrefab, trackNode).GetComponent<ZumaTrack>();
	}

	private ZumaBaseBall InstanceNormalBallFunc()
	{
		GameObject obj = Object.Instantiate(normalBallPrefab, ballNode);
		obj.SetActive(value: false);
		return obj.AddComponent<ZumaNormalBall>();
	}

	private ZumaBaseBall InstanceSpecialBallFunc()
	{
		GameObject obj = Object.Instantiate(specialBallPrefab, ballNode);
		obj.SetActive(value: false);
		return obj.AddComponent<ZumaSpecialBall>();
	}

	public ZumaBaseBall CreateZumaBall(ZumaTrack track)
	{
		BallColorType colorType = track.ballCreate.SpawnBallStrategyColor();
		BallEffctType ballEffctType = track.ballCreate.SpawnBallStrategyEffect();
		if (ballEffctType == BallEffctType.NORMAL)
		{
			ZumaBaseBall zumaBaseBall = ballNormalPool.GetBallObj().Init(ballEffctType, colorType, track);
			zumaBaseBall.transform.SetAsFirstSibling();
			return zumaBaseBall;
		}
		ZumaBaseBall zumaBaseBall2 = ballSpecialPool.GetBallObj().Init(ballEffctType, colorType, track);
		zumaBaseBall2.transform.SetAsFirstSibling();
		return zumaBaseBall2;
	}

	public ZumaBaseBall InitInsertBall(ZumaTrack track, BallColorType colorType)
	{
		return ballNormalPool.GetBallObj().Init(BallEffctType.NORMAL, colorType, track);
	}

	public void SetAllBallSpeicalEffect(ZumaShootBall fb)
	{
		BallEffctType effectType = fb.effectType;
		BallColorType colorType = fb.colorType;
		Vector3 position = fb.transform.position;
		float num;
		if (effectType == BallEffctType.BULLET)
		{
			int effectValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.BulletShooterBallShootRangeAdd);
			num = 0.11f * (float)(1 + effectValue);
		}
		else
		{
			num = ZumaGameConst.speicalEffectRange;
		}
		bool flag = false;
		foreach (ZumaTrack track in trackList)
		{
			int count = track.ballSegmentList.Count;
			while (count-- > 0)
			{
				ZumaBaseBall zumaBaseBall = track.ballSegmentList[count];
				do
				{
					if (Vector3.Distance(zumaBaseBall.transform.position, position) < num)
					{
						track.comboBackCount = 0;
						if (!ZumaGameManager.GetInstance().zumaEndlessManager.isEndless)
						{
							comboCount = 0;
						}
						switch (effectType)
						{
						case BallEffctType.CHANGECOLOR:
							zumaBaseBall.ChangeColorType(colorType);
							break;
						case BallEffctType.BOOM:
							track.effectDestoryList.Add(zumaBaseBall);
							flag = true;
							break;
						case BallEffctType.BULLET:
							track.effectDestoryList.Add(zumaBaseBall);
							flag = true;
							break;
						}
					}
					zumaBaseBall = zumaBaseBall.Next;
				}
				while (zumaBaseBall != null);
			}
		}
		if (ZumaGameManager.GetInstance().zumaEndlessManager.isEndless)
		{
			if (flag)
			{
				comboCount++;
				LuaHelper.CallFunction("ZumaToLuaBridge.ZumaCombo", comboCount);
			}
		}
		else
		{
			comboCount = 0;
		}
		if ((effectType == BallEffctType.BOOM || effectType == BallEffctType.BULLET) && Vector3.Distance(itemManager.goldItem.transform.position, position) < num)
		{
			itemManager.goldItem.TriggerCollision();
		}
	}

	public void CheckStrikeEffect()
	{
		ZumaGameManager.GetInstance().UpdateStrikeEffectValue(BallEffctType.AIM, ZumaGameConst.GetTimeValue());
		ZumaGameManager.GetInstance().UpdateStrikeEffectValue(BallEffctType.STOP, ZumaGameConst.GetTimeValue());
	}

	public void CheckIsAllMoveToBeginPos()
	{
		if (!isPlayBeginAudio)
		{
			ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.BackEnd);
			isPlayBeginAudio = true;
		}
		if (ZumaGameManager.GetInstance().isMoveToBegin)
		{
			return;
		}
		bool flag = true;
		foreach (ZumaTrack track in trackList)
		{
			flag = track.GetIsMoveToBegin();
			if (!flag)
			{
				return;
			}
		}
		if (flag)
		{
			ZumaGameManager.GetInstance().isMoveToBegin = true;
		}
	}

	public float GetCurTime()
	{
		return curTimes;
	}

	private void Update()
	{
		ZumaShootBallManager.Instance.Process();
		if (gameOver || gamePause || !gameStart)
		{
			return;
		}
		curTimes += Time.deltaTime;
		CheckIsAllMoveToBeginPos();
		CheckStrikeEffect();
		CheckEmptyColor();
		foreach (ZumaTrack track in trackList)
		{
			track.Process();
		}
		itemManager.Process();
		CheckScoreSettle();
		UpdateRemainBallCount();
		UpdateZumaSkillTimes();
		UpdateEndlessTimes();
	}

	private void UpdateRemainBallCount()
	{
		int num = 0;
		foreach (ZumaTrack track in trackList)
		{
			num += track.remainBallNums;
			if (track.ballSegmentList.Count > 0)
			{
				ZumaBaseBall zumaBaseBall = track.ballSegmentList[0];
				while (zumaBaseBall != null && !zumaBaseBall.IsExitEnterBegin())
				{
					num++;
					zumaBaseBall = zumaBaseBall.Next;
				}
			}
		}
		if (num != ballCount)
		{
			ballCount = num;
			LuaHelper.CallFunction("ZumaToLuaBridge.ZumaBallCountsUpdate", num);
		}
	}

	public bool IsGameTrackIsAllOver()
	{
		return gameTrackIsAllOver;
	}

	private void CheckScoreSettle()
	{
		scoreSettleTimes += ZumaGameConst.GetTimeValue();
		if (scoreSettleTimes < scoreSettleCycle)
		{
			return;
		}
		scoreSettleTimes = 0f;
		bool flag = true;
		foreach (ZumaTrack track in trackList)
		{
			if (!track.trackGameOver)
			{
				flag = false;
				break;
			}
		}
		gameTrackIsAllOver = flag;
		if (!flag)
		{
			return;
		}
		bool flag2 = true;
		foreach (ZumaTrack track2 in trackList)
		{
			if (!track2.PathScoreSettle())
			{
				flag2 = false;
			}
		}
		gameTrackScoreIsFinish = flag2;
		if (!flag2)
		{
			return;
		}
		if (ZumaGameManager.GetInstance().zumaEndlessManager.isEndless)
		{
			ZumaGameManager.GetInstance().UpdateStrikeEffectValue(BallEffctType.STOP, 99999f);
			if (ZumaGameManager.GetInstance().zumaSkillManager.GetUseSkillID() == SkillType.StopMove)
			{
				ZumaGameManager.GetInstance().zumaSkillManager.UpdateSkillTimes(99999f);
			}
			ZumaGameManager.GetInstance().zumaEndlessManager.BeginChangeMap();
		}
		else
		{
			gameOver = true;
			LuaHelper.CallFunction("ZumaToLuaBridge.OnZumaOver", true);
		}
	}

	private void CheckEmptyColor()
	{
		int num = 0;
		foreach (ZumaTrack track in trackList)
		{
			num += track.remainBallNums;
		}
		if (num > 0)
		{
			return;
		}
		for (int num2 = 7; num2 >= 0; num2--)
		{
			BallColorType key = (BallColorType)num2;
			if (colorDict.ContainsKey(key))
			{
				colorDict[key] = false;
			}
		}
		foreach (ZumaTrack track2 in trackList)
		{
			track2.GetBallColorList(ref colorDict);
		}
		UpdateColorList();
	}

	public void UpdateColorList()
	{
		for (int num = 7; num >= 0; num--)
		{
			BallColorType key = (BallColorType)num;
			if (colorDict.ContainsKey(key))
			{
				if (!colorDict[key])
				{
					int num2 = ZumaCreate.createColorList.IndexOf(num);
					if (num2 != -1 && ZumaCreate.createColorList.Count > 1)
					{
						ZumaCreate.createColorList.RemoveAt(num2);
					}
				}
				else if (ZumaCreate.createColorList.IndexOf(num) == -1)
				{
					ZumaCreate.createColorList.Add(num);
				}
			}
		}
	}

	public void PlayEndlessTimeAni(bool isPlay)
	{
		if (timeCountAnimator != null)
		{
			timeCountAnimator.Play("UI_timeBg_cx", 0, 0f);
			if (isPlay)
			{
				timeCountAnimator.speed = 1f;
			}
			else
			{
				timeCountAnimator.speed = 0f;
			}
		}
	}

	public void SetZumaGameCountdownUI(Animator timeCountAnimator, Text timeCountdownUI, Text skillCountdownUI, Image skillProgressImg)
	{
		this.timeCountAnimator = timeCountAnimator;
		PlayEndlessTimeAni(isPlay: false);
		this.timeCountdownUI = timeCountdownUI;
		if (this.timeCountdownUI != null)
		{
			this.timeCountdownUI.text = string.Empty;
		}
		this.skillCountdownUI = skillCountdownUI;
		if (this.skillCountdownUI != null)
		{
			this.skillCountdownUI.text = string.Empty;
		}
		this.skillProgressImg = skillProgressImg;
	}

	public void EndlessEnterNextMap(string newMapName)
	{
		comboCount = 0;
		colorDict.Clear();
		foreach (ZumaTrack track in trackList)
		{
			track.Dispose();
		}
		trackList.Clear();
		InitConfig(newMapName, isEndless: true);
		zumaShooter.RefrashAllBallType();
		UpdateColorList();
	}

	private void UpdateEndlessTimes()
	{
		if (!gameTrackIsAllOver || gameTrackScoreIsFinish)
		{
			ZumaGameManager.GetInstance().zumaEndlessManager.UpdateEndlessTimes(ZumaGameConst.GetTimeValue());
			if (timeCountdownUI != null)
			{
				timeCountdownUI.text = Mathf.Round(ZumaGameManager.GetInstance().zumaEndlessManager.GetEndlessTimes()).ToString();
			}
		}
	}

	public void UseZumaSkill()
	{
		if (!ZumaGameManager.GetInstance().isGameStart || !ZumaGameManager.GetInstance().isMoveToBegin || !ZumaGameManager.GetInstance().zumaSkillManager.CheckIsCanUseSkill())
		{
			return;
		}
		if (ZumaGameManager.GetInstance().zumaSkillManager.GetUseSkillID() == SkillType.ClearScreen)
		{
			ClearScreenSkill();
			int effectValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.ClearScreenAgain);
			if (effectValue > 0)
			{
				Invoke("ClearScreenSkill", effectValue);
			}
		}
		ZumaGameManager.GetInstance().zumaSkillManager.SkillStart();
	}

	public void ClearScreenSkill()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_3_11", "minigame_activity_3_11_zuma_skill02", useStream: false);
		int num = 0;
		foreach (ZumaTrack track in trackList)
		{
			int count = track.ballSegmentList.Count;
			while (count-- > 0)
			{
				ZumaBaseBall zumaBaseBall = track.ballSegmentList[count];
				do
				{
					num++;
					track.effectDestoryList.Add(zumaBaseBall);
					zumaBaseBall = zumaBaseBall.Next;
				}
				while (zumaBaseBall != null);
			}
		}
		int effectValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.ClearScreenReturnCharge);
		ZumaGameManager.GetInstance().zumaSkillManager.UpdateSkillChargeValue(effectValue * num);
	}

	private void UpdateZumaSkillTimes()
	{
		ZumaGameManager.GetInstance().zumaSkillManager.UpdateSkillTimes(ZumaGameConst.GetTimeValue());
		if (skillCountdownUI != null && ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.BulletShooterBall))
		{
			skillCountdownUI.text = Mathf.Round(ZumaGameManager.GetInstance().zumaSkillManager.GetRemainDuration()).ToString();
			skillProgressImg.fillAmount = ZumaGameManager.GetInstance().zumaSkillManager.GetRemainProgress();
		}
	}
}
