using System.Collections.Generic;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class DamageInfoUI : MonoBehaviour, IBattleUIElement
{
	public CanvasGroup canvasGroup;

	public Button resetBtn;

	public Button totalInfoBtn;

	public Button hideTotalInfoBtn;

	public Button pauseBtn;

	public Button continueBtn;

	private GameObject pauseBtnGo;

	private GameObject continueBtnGo;

	public GameObject totalInfoPanel;

	public Text totalTime;

	public Text perSecDamage;

	public Text per10SecDamage;

	public Text per30SecDamage;

	public Text first30SecDamage;

	public Text first60SecDamage;

	public Text totalDamage;

	public GameObject hero1Go;

	public GameObject hero2Go;

	public GameObject hero3Go;

	public Text hero1MeleeDamage;

	public Text hero2MeleeDamage;

	public Text hero3MeleeDamage;

	public Text hero1MeleeDamagePersent;

	public Text hero2MeleeDamagePersent;

	public Text hero3MeleeDamagePersent;

	public Text hero1Skill1Damage;

	public Text hero2Skill1Damage;

	public Text hero3Skill1Damage;

	public Text hero1Skill1DamagePersent;

	public Text hero2Skill1DamagePersent;

	public Text hero3Skill1DamagePersent;

	public Text hero1Skill2Damage;

	public Text hero2Skill2Damage;

	public Text hero3Skill2Damage;

	public Text hero1Skill2DamagePersent;

	public Text hero2Skill2DamagePersent;

	public Text hero3Skill2DamagePersent;

	public Text hero1Skill3Damage;

	public Text hero2Skill3Damage;

	public Text hero3Skill3Damage;

	public Text hero1Skill3DamagePersent;

	public Text hero2Skill3DamagePersent;

	public Text hero3Skill3DamagePersent;

	public Text hero1QTEDamage;

	public Text hero2QTEDamage;

	public Text hero3QTEDamage;

	public Text hero1QTEDamagePersent;

	public Text hero2QTEDamagePersent;

	public Text hero3QTEDamagePersent;

	public Text hero1AvoidDamage;

	public Text hero2AvoidDamage;

	public Text hero3AvoidDamage;

	public Text hero1AvoidDamagePersent;

	public Text hero2AvoidDamagePersent;

	public Text hero3AvoidDamagePersent;

	public Text hero1ExtendQTEDamage;

	public Text hero2ExtendQTEDamage;

	public Text hero3ExtendQTEDamage;

	public Text hero1ExtendQTEDamagePersent;

	public Text hero2ExtendQTEDamagePersent;

	public Text hero3ExtendQTEDamagePersent;

	public Text hero1Name;

	public Text hero2Name;

	public Text hero3Name;

	public Text hero1TotalDamage;

	public Text hero2TotalDamage;

	public Text hero3TotalDamage;

	public InputField pauseTimeInput;

	public Button setPauseTimeBtn;

	public Text hero1TotalDamagePersent;

	public Text hero2TotalDamagePersent;

	public Text hero3TotalDamagePersent;

	private static DamageInfoUI s_damageInfoUI;

	private int prePauseTime;

	private int lastDealHurtInfoNum;

	private bool isNeedUpdate;

	private float deltafreshTime;

	private const int FRESH_TIME = 1;

	private bool isPause;

	private bool isStartCountDamage;

	private uint startFrameNum;

	private List<HurtInfo> hurtInfoS1;

	private List<HurtInfo> hurtInfoS2;

	private List<HurtInfo> hurtInfoS3;

	private const int COUNT_CYCLE_10 = 10;

	private const int COUNT_CYCLE_30 = 30;

	private const int COUNT_CYCLE_60 = 60;

	public P08UISwitch uiSwitch { get; set; }

	public void SetActive(bool isActive, BattleUIElementActiveChangeReason reason)
	{
		uiSwitch.SetActive(isActive, reason);
	}

	private void SwitchLogicOnAwake()
	{
		if (uiSwitch == null)
		{
			uiSwitch = new P08UISwitch();
			uiSwitch.canvasGroup = canvasGroup;
			uiSwitch.gameObject = base.gameObject;
		}
	}

	public static DamageInfoUI CreateDamageInfoUI(Transform parent)
	{
		if (s_damageInfoUI != null)
		{
			return s_damageInfoUI;
		}
		s_damageInfoUI = Object.Instantiate(Asset.Load<GameObject>("UI/InjuryTest/ITTestDataUI"), parent).GetComponent<DamageInfoUI>();
		return s_damageInfoUI;
	}

	public void Awake()
	{
	}

	public void Start()
	{
		totalInfoPanel.SetActive(value: false);
		hurtInfoS1 = new List<HurtInfo>();
		hurtInfoS2 = new List<HurtInfo>();
		hurtInfoS3 = new List<HurtInfo>();
		pauseBtnGo = pauseBtn.gameObject;
		continueBtnGo = continueBtn.gameObject;
		resetBtn.onClick.AddListener(delegate
		{
			Reset();
		});
		pauseBtn.onClick.AddListener(delegate
		{
			SetIsPause(isPause: true);
		});
		continueBtn.onClick.AddListener(delegate
		{
			SetIsPause(isPause: false);
		});
		totalInfoBtn.onClick.AddListener(delegate
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				battleScene.GetBattleSimulatorSystem().PauseGame();
			}
			DrawTotalInfoPanel();
			totalInfoPanel.SetActive(value: true);
		});
		hideTotalInfoBtn.onClick.AddListener(delegate
		{
			BattleScene.isPause = false;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				battleScene.GetBattleSimulatorSystem().ResumeGame();
			}
			totalInfoPanel.SetActive(value: false);
		});
		setPauseTimeBtn.onClick.AddListener(delegate
		{
			if (!(pauseTimeInput == null))
			{
				int.TryParse(pauseTimeInput.text, out prePauseTime);
			}
		});
		if (pauseTimeInput != null)
		{
			pauseTimeInput.text = "0";
		}
		UpdateHeroName();
		Reset();
	}

	private void UpdateHeroName()
	{
		SimWorldState status = ClientSimulator.Instance.mSimContext.sEntityWorldState.status;
		int iD = status.mRoomMembers[MemberPosition.First].roleData.ID;
		int num = 0;
		if (status.mRoomMembers.ContainsKey(MemberPosition.Second))
		{
			num = status.mRoomMembers[MemberPosition.Second].roleData.ID;
		}
		int num2 = 0;
		if (status.mRoomMembers.ContainsKey(MemberPosition.Third))
		{
			num2 = status.mRoomMembers[MemberPosition.Third].roleData.ID;
		}
		charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(iD);
		hero1Go.SetActive(config != null);
		if (config != null)
		{
			hero1Name.text = WorldStateManager.GetSystemTableI18N(config.Name);
		}
		hero2Go.SetActive(num != 0);
		if (num != 0)
		{
			charactor_param config2 = ConfigHelper.GetInstance().GetConfig<charactor_param>(num);
			hero2Name.text = WorldStateManager.GetSystemTableI18N(config2.Name);
		}
		hero3Go.SetActive(num2 != 0);
		if (num2 != 0)
		{
			charactor_param config3 = ConfigHelper.GetInstance().GetConfig<charactor_param>(num2);
			hero3Name.text = WorldStateManager.GetSystemTableI18N(config3.Name);
		}
	}

	public void Update()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager == null)
		{
			return;
		}
		DealWithHurtInfo();
		if (!isStartCountDamage)
		{
			return;
		}
		deltafreshTime += Time.deltaTime;
		if (deltafreshTime > 1f && !isPause)
		{
			DrawDamageWindow();
			deltafreshTime = 0f;
			float num = (float)(1000 / BattleSimulatorSystem.sTargetLogicFrameRate) / 1000f;
			float num2 = (float)(worldStateManager.currentFrameNumber - startFrameNum) * num;
			if (prePauseTime != 0 && num2 > (float)prePauseTime)
			{
				SetIsPause(isPause: true);
			}
		}
	}

	public void SetIsPause(bool isPause)
	{
		this.isPause = isPause;
		pauseBtnGo.SetActive(!isPause);
		continueBtnGo.SetActive(isPause);
		if (!isPause)
		{
			Reset();
		}
	}

	private void DealWithHurtInfo()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		List<HurtInfo> hurtInfos = worldStateManager.data.hurtInfos;
		int count = worldStateManager.data.hurtInfos.Count;
		for (int i = lastDealHurtInfoNum; i < count; i++)
		{
			HurtInfo item = hurtInfos[i];
			if (item.IsCasterLocalPlayer || item.casterOrder > 0)
			{
				isNeedUpdate = true;
				if (!isStartCountDamage)
				{
					isStartCountDamage = true;
					startFrameNum = item.frameCount;
				}
				switch (item.casterOrder)
				{
				case 1:
					hurtInfoS1.Add(item);
					break;
				case 2:
					hurtInfoS2.Add(item);
					break;
				case 3:
					hurtInfoS3.Add(item);
					break;
				}
			}
		}
		lastDealHurtInfoNum = count;
	}

	private void DrawDamageWindow()
	{
		if (!isStartCountDamage)
		{
			return;
		}
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		float num = (float)(1000 / BattleSimulatorSystem.sTargetLogicFrameRate) / 1000f;
		float num2 = (float)(worldStateManager.currentFrameNumber - startFrameNum) * num;
		totalTime.text = num2.ToString();
		long num3 = 0L;
		long num4 = 0L;
		long num5 = 0L;
		long num6 = 0L;
		long num7 = 0L;
		for (int i = 0; i < hurtInfoS1.Count; i++)
		{
			HurtInfo hurtInfo = hurtInfoS1[i];
			long num8 = ((hurtInfo.damageValue < 0) ? hurtInfo.damageValue : 0);
			if (hurtInfo.frameCount >= startFrameNum)
			{
				num3 += num8;
				float num9 = (float)(hurtInfo.frameCount - startFrameNum) * num;
				if (num9 < 30f)
				{
					num4 += num8;
				}
				if (num9 < 60f)
				{
					num5 += num8;
				}
				int num10 = Mathf.FloorToInt(num2 / 10f) - 1;
				int num11 = Mathf.FloorToInt(num2 / 30f) - 1;
				if (num10 < 0)
				{
					num6 = 0L;
				}
				else if (num9 >= (float)(num10 * 10) && num9 < (float)((num10 + 1) * 10))
				{
					num6 += num8;
				}
				if (num11 < 0)
				{
					num7 = 0L;
				}
				else if (num9 >= (float)(num11 * 30) && num9 < (float)((num11 + 1) * 30))
				{
					num7 += num8;
				}
			}
		}
		for (int j = 0; j < hurtInfoS2.Count; j++)
		{
			HurtInfo hurtInfo2 = hurtInfoS2[j];
			long num12 = ((hurtInfo2.damageValue < 0) ? hurtInfo2.damageValue : 0);
			if (hurtInfo2.frameCount >= startFrameNum)
			{
				num3 += num12;
				float num13 = (float)(hurtInfo2.frameCount - startFrameNum) * num;
				if (num13 < 30f)
				{
					num4 += num12;
				}
				if (num13 < 60f)
				{
					num5 += num12;
				}
				int num14 = Mathf.FloorToInt(num2 / 10f) - 1;
				int num15 = Mathf.FloorToInt(num2 / 30f) - 1;
				if (num14 < 0)
				{
					num6 = 0L;
				}
				else if (num13 >= (float)(num14 * 10) && num13 < (float)((num14 + 1) * 10))
				{
					num6 += num12;
				}
				if (num15 < 0)
				{
					num7 = 0L;
				}
				else if (num13 >= (float)(num15 * 30) && num13 < (float)((num15 + 1) * 30))
				{
					num7 += num12;
				}
			}
		}
		for (int k = 0; k < hurtInfoS3.Count; k++)
		{
			HurtInfo hurtInfo3 = hurtInfoS3[k];
			long num16 = ((hurtInfo3.damageValue < 0) ? hurtInfo3.damageValue : 0);
			if (hurtInfo3.frameCount >= startFrameNum)
			{
				num3 += num16;
				float num17 = (float)(hurtInfo3.frameCount - startFrameNum) * num;
				if (num17 < 30f)
				{
					num4 += num16;
				}
				if (num17 < 60f)
				{
					num5 += num16;
				}
				int num18 = Mathf.FloorToInt(num2 / 10f) - 1;
				int num19 = Mathf.FloorToInt(num2 / 30f) - 1;
				if (num18 < 0)
				{
					num6 = 0L;
				}
				else if (num17 >= (float)(num18 * 10) && num17 < (float)((num18 + 1) * 10))
				{
					num6 += num16;
				}
				if (num19 < 0)
				{
					num7 = 0L;
				}
				else if (num17 >= (float)(num19 * 30) && num17 < (float)((num19 + 1) * 30))
				{
					num7 += num16;
				}
			}
		}
		perSecDamage.text = Mathf.FloorToInt((float)(-1 * num3) / ((num2 < 1f) ? 1f : num2)).ToString();
		per10SecDamage.text = (-1 * num6).ToString();
		per30SecDamage.text = (-1 * num7).ToString();
		first30SecDamage.text = (-1 * num4).ToString();
		first60SecDamage.text = (-1 * num5).ToString();
		totalDamage.text = (-1 * num3).ToString();
	}

	private void DrawTotalInfoPanel()
	{
		long num = 0L;
		for (int i = 0; i < hurtInfoS1.Count; i++)
		{
			HurtInfo hurtInfo = hurtInfoS1[i];
			long num2 = ((hurtInfo.damageValue < 0) ? hurtInfo.damageValue : 0);
			num += num2;
		}
		hero1TotalDamage.text = (-1 * num).ToString();
		long num3 = 0L;
		for (int j = 0; j < hurtInfoS2.Count; j++)
		{
			HurtInfo hurtInfo2 = hurtInfoS2[j];
			long num4 = ((hurtInfo2.damageValue < 0) ? hurtInfo2.damageValue : 0);
			num3 += num4;
		}
		hero2TotalDamage.text = (-1 * num3).ToString();
		long num5 = 0L;
		for (int k = 0; k < hurtInfoS3.Count; k++)
		{
			HurtInfo hurtInfo3 = hurtInfoS3[k];
			long num6 = ((hurtInfo3.damageValue < 0) ? hurtInfo3.damageValue : 0);
			num5 += num6;
		}
		hero3TotalDamage.text = (-1 * num5).ToString();
		float num7 = num + num3 + num5;
		hero1TotalDamagePersent.text = $"{(float)num / num7 * 100f:F2}%";
		hero2TotalDamagePersent.text = $"{(float)num3 / num7 * 100f:F2}%";
		hero3TotalDamagePersent.text = $"{(float)num5 / num7 * 100f:F2}%";
	}

	private void Reset()
	{
		isStartCountDamage = false;
		startFrameNum = 0u;
		string text = "0";
		deltafreshTime = 0f;
		totalTime.text = text;
		perSecDamage.text = text;
		per10SecDamage.text = text;
		per30SecDamage.text = text;
		first30SecDamage.text = text;
		first60SecDamage.text = text;
		totalDamage.text = text;
	}

	private void OnDestroy()
	{
		s_damageInfoUI = null;
	}
}
