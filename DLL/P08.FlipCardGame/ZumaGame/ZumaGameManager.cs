using UnityEngine;

namespace ZumaGame;

public class ZumaGameManager
{
	public static ZumaDataForExchange exchangeDataNew;

	public string realName = "";

	private ZumaMapDataNew mapData;

	public ZumaEffectDataManager zumaEffectDataManager;

	public ZumaSkillManager zumaSkillManager;

	public ZumaEndlessManager zumaEndlessManager;

	public ZumaSpeicalEffectManager zumaSpeicalEffectManager;

	public ZumaGamePlay zumaGamePlay;

	private bool _isGameStart;

	private bool _isMoveToBegin;

	private ZumaEffectSpriteManager effectSpriteMgr;

	private ZumaScoreManager scoreManager;

	private int zumaGameScore;

	public ZumaTrackBallSpriteMgr trackBallSpriteMgr;

	public ZumaShootBallSpriteMgr shootBallSpriteMgr;

	public ZumaShooterSpriteMgr shooterSpriteMgr;

	private static Vector3 hidePos = new Vector3(999f, 999f, 0f);

	private static ZumaGameManager _instance;

	public static int difficult => exchangeDataNew?.difficult ?? 1;

	public bool isGameStart
	{
		get
		{
			return _isGameStart;
		}
		set
		{
			_isGameStart = value;
		}
	}

	public bool isMoveToBegin
	{
		get
		{
			return _isMoveToBegin;
		}
		set
		{
			_isMoveToBegin = value;
		}
	}

	public float moveSpeed
	{
		get
		{
			if (IsMeetTrackEffect(BallEffctType.STOP) || GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.StopMove))
			{
				return 0f;
			}
			return mapData.moveSpeed;
		}
	}

	public float shootSpeed
	{
		get
		{
			if (IsMeetTrackEffect(BallEffctType.AIM))
			{
				return mapData.shootSpeed + GetStrikeEffectValueSpeed(BallEffctType.AIM);
			}
			return mapData.shootSpeed;
		}
	}

	public Vector3 shootPos => mapData.shootPos;

	public void InitMgrData(ZumaDataForExchange config = null)
	{
		if (zumaEffectDataManager == null)
		{
			zumaEffectDataManager = new ZumaEffectDataManager();
		}
		if (zumaSkillManager == null)
		{
			zumaSkillManager = new ZumaSkillManager();
		}
		if (zumaEndlessManager == null)
		{
			zumaEndlessManager = new ZumaEndlessManager();
		}
		if (config != null)
		{
			zumaEffectDataManager.TalentInit(exchangeDataNew.effectList);
			zumaEndlessManager.InitEndless(config.isEndless);
			zumaSkillManager.InitSkillType((SkillType)exchangeDataNew.useSkillType);
		}
	}

	public void InitZumaMgr(ZumaDataForExchange config, ZumaGamePlay zumaGamePlay)
	{
		_instance = this;
		exchangeDataNew = config;
		this.zumaGamePlay = zumaGamePlay;
		InitMgrData(config);
	}

	public void InitZumaMgr(ZumaGamePlay zumaGamePlay)
	{
		_instance = this;
		this.zumaGamePlay = zumaGamePlay;
		InitMgrData();
	}

	public void ExitGame()
	{
		ZumaCreate.ClearData();
	}

	public void InitZumaData(string realName, bool isEndless = false)
	{
		this.realName = realName;
		mapData = Object.Instantiate(Asset.Load<ZumaMapDataNew>("Map/ZumaMap/" + realName));
		mapData.moveSpeed *= 1f - zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.BallSpeedSlow);
		ZumaCreate.InitRandData();
		if (zumaSpeicalEffectManager == null)
		{
			zumaSpeicalEffectManager = new ZumaSpeicalEffectManager();
		}
		zumaSpeicalEffectManager.InitEffectValue();
		ZumaGameConst.InitTalentValue();
		isMoveToBegin = false;
		isGameStart = false;
		if (!isEndless)
		{
			zumaGameScore = 0;
		}
	}

	public void StrikeBallEffect(BallEffctType effectType, int trackID = 0)
	{
		zumaSpeicalEffectManager.StrikeBallEffect(effectType, trackID);
	}

	public bool IsMeetTrackEffect(BallEffctType effectType, int trackID = 0)
	{
		if (zumaSpeicalEffectManager == null)
		{
			return false;
		}
		return zumaSpeicalEffectManager.IsMeetTrackEffect(effectType, trackID);
	}

	public void UpdateStrikeEffectValue(BallEffctType effectType, float changeValue, int trackID = 0)
	{
		zumaSpeicalEffectManager.UpdateStrikeEffectValue(effectType, changeValue, trackID);
	}

	public float GetStrikeEffectValueSpeed(BallEffctType effectType)
	{
		return zumaSpeicalEffectManager.GetStrikeEffectValueSpeed(effectType);
	}

	public void StrikeComboEffect(int commboLv, int trackID)
	{
		zumaSpeicalEffectManager.StrikeComboEffect(commboLv, trackID);
	}

	public int GetTrackCount()
	{
		return mapData.trackList.Count;
	}

	public ZumaTrackData GetTrackData(int trackID)
	{
		return mapData.trackList[trackID];
	}

	public ZumaMapDataNew GetZumaMapData()
	{
		return mapData;
	}

	public void SetEffectSpriteManager(ZumaEffectSpriteManager effectSpriteMgr)
	{
		this.effectSpriteMgr = effectSpriteMgr;
	}

	public void ShowEffect(Vector3 pos, FrameType frameType, BallColorType colorType = BallColorType.EmptyColor)
	{
		effectSpriteMgr.ShowEffect(pos, frameType, colorType);
	}

	public void ShowComboEffect(Vector3 beginPos, Vector3 toPos)
	{
		effectSpriteMgr.ShowComboEffect(beginPos, toPos);
	}

	public FrameSprite GetFrameSprite(FrameType frameType, BallColorType colorType = BallColorType.EmptyColor)
	{
		return effectSpriteMgr.GetFrameSprite(frameType, colorType);
	}

	public void SetZumaScoreManager(ZumaScoreManager scoreManager)
	{
		this.scoreManager = scoreManager;
	}

	public void SetZumaGameScore(Vector3 pos, int numValue, bool isGold = false, bool isEnter = false)
	{
		ZumaCreate.createSpecialScore += numValue;
		zumaGameScore += numValue;
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaballHit", zumaGameScore);
		zumaSkillManager.UpdateSkillChargeValue(numValue);
		scoreManager.ShowScore(pos, numValue, isGold, isEnter);
	}

	public int GetZumaGameScore()
	{
		return zumaGameScore;
	}

	public void SetTrackBallSpriteMgr(ZumaTrackBallSpriteMgr trackBallSpriteMgr)
	{
		this.trackBallSpriteMgr = trackBallSpriteMgr;
	}

	public void SetShootBallSpriteMgr(ZumaShootBallSpriteMgr shootBallSpriteMgr)
	{
		this.shootBallSpriteMgr = shootBallSpriteMgr;
	}

	public void SetZumaShooterSpriteMgr(ZumaShooterSpriteMgr shooterSpriteMgr)
	{
		this.shooterSpriteMgr = shooterSpriteMgr;
	}

	public static void IsShowObj(Transform trs, bool isShow)
	{
		if (isShow)
		{
			trs.localPosition = Vector3.zero;
		}
		else
		{
			trs.localPosition = hidePos;
		}
	}

	public static ZumaGameManager GetInstance()
	{
		if (_instance == null)
		{
			_instance = new ZumaGameManager();
		}
		return _instance;
	}
}
