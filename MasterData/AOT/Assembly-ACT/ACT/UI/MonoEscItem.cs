using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoEscItem : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler
{
	public BetterAnimation betterAnimation;

	public GameObject NormalState;

	public ActButton ItemButton;

	public BImage Icon;

	public BImage BtnIcon;

	public Color BtnIconColor;

	public TextMeshProUGUI Name;

	public RedDotItem RedDotItem;

	public GameObject LockState;

	[SerializeField]
	private GameObject _gachaInfo;

	[SerializeField]
	private GameObject _gachaInfo1;

	[SerializeField]
	private TextMeshProUGUI _gachaCount1;

	[SerializeField]
	private GameObject _gachaInfo2;

	[SerializeField]
	private TextMeshProUGUI _gachaCount2;

	[SerializeField]
	private GameObject _otherInfo;

	[SerializeField]
	private TextMeshProUGUI _otherInfoTitle;

	[SerializeField]
	private TextMeshProUGUI _otherInfoLeft;

	[SerializeField]
	private TextMeshProUGUI _otherInfoSlash;

	[SerializeField]
	private TextMeshProUGUI _otherInfoRight;

	[SerializeField]
	private Color _normalColor;

	[SerializeField]
	private Color _hightColor;

	private ACT.Config.SystemOpen _systemConfig;

	[OdinSerialize]
	private Dictionary<int, Action> _selfActionDictionary = new Dictionary<int, Action>();

	[Header("Special Theme")]
	public Image unLockImage;

	public Image lockImage;

	[OdinSerialize]
	private Dictionary<int, EscItemSpecialTheme> _systemSpecialTheme = new Dictionary<int, EscItemSpecialTheme>();

	private EscSystem _escSystemConfig;

	private const int gachaItemId1 = 200129;

	private const int gachaItemId2 = 200130;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ESC);
		if (baseUIView != null)
		{
			MonoEscView monoEscView = baseUIView as MonoEscView;
			if ((bool)monoEscView)
			{
				EscSystem escSystemByIndex = monoEscView.GetEscSystemByIndex(idx);
				RefreshUI(escSystemByIndex.id, monoEscView.sb);
				name = escSystemByIndex.id.FastToString();
				GetComponent<GuideTargetNode>()?.Register(escSystemByIndex.id.FastToString());
			}
		}
	}

	public void RefreshUI(int escSystemID, StringBuilder sb)
	{
		ImageAssetStation imageAssetStation = ParentUIView?.Station;
		if (imageAssetStation == null || !RuntimeConfigs.data.escSystems.TryGetValue(escSystemID, out var escSystem) || !RuntimeConfigs.data.systemOpens.TryGetValue(escSystemID, out var value))
		{
			return;
		}
		_systemConfig = value;
		_escSystemConfig = escSystem;
		if (_escSystemConfig.openType == 2)
		{
			ItemButton.SetBtnClick(() =>
			{
				if (_selfActionDictionary.TryGetValue(escSystemID, out var value2))
				{
					SetRedpointState(escSystem.id, sb);
					ReportTrack(escSystem.id);
					GameUtility.SendFinshStepGuideEvent((GuideConsts.GuideType)int.Parse($"{40}" + $"{escSystem.id}"));
					value2();
				}
			});
		}
		else
		{
			ItemButton.SetBtnClick(() =>
			{
				OpenUIView(escSystem, sb);
			});
		}
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(value.id);
		RefreshTheme(escSystem, flag, imageAssetStation);
		if (flag)
		{
			RefreshRedpoint();
			RefreshSystemInfo((SystemType)escSystemID);
		}
	}

	private void RefreshTheme(EscSystem escSystem, bool isUnlock, ImageAssetStation station)
	{
		NormalState.SetActive(isUnlock);
		LockState.SetActive(!isUnlock);
		Name.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, escSystem.localNameId);
		station.LoadImage(134, escSystem.icon, BtnIcon);
		BtnIcon.icon.color = BtnIconColor;
		if (escSystem.Theme == 0)
		{
			station.LoadImageAsync(198, escSystem.icon, Icon).Forget();
			Icon.icon.color = new Color(1f, 1f, 1f, 0.36f);
			ItemButton.OnEnter.RemoveAllListeners();
			ItemButton.OnEnter.AddListener(() =>
			{
				Icon.icon.color = new Color(1f, 1f, 1f, 1f);
			});
			ItemButton.OnExit.RemoveAllListeners();
			ItemButton.OnExit.AddListener(() =>
			{
				Icon.icon.color = new Color(1f, 1f, 1f, 0.36f);
			});
		}
		else if (escSystem.Theme == 1)
		{
			int id = escSystem.id;
			if (_systemSpecialTheme.TryGetValue(id, out var value))
			{
				unLockImage.sprite = value.normalSprite;
				lockImage.sprite = value.lockSprite;
				SpriteState spriteState = ItemButton.spriteState;
				spriteState.pressedSprite = value.normalPress;
				spriteState.highlightedSprite = value.normalHighlight;
				spriteState.selectedSprite = value.normalHighlight;
				ItemButton.spriteState = spriteState;
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"EscItem 特殊样式不支持 system Id: {escSystem.id}");
			}
		}
	}

	private void RefreshRedpoint()
	{
		if (G.localPlayer.redPoints.Systems.TryGetValue(_systemConfig.id, out var value))
		{
			string[] source = _systemConfig.redPoint.Split("|");
			RedDotType redDotType;
			if (value)
			{
				redDotType = RedDotType.SystemNew;
			}
			else
			{
				RedDotType redDotType2 = ((_systemConfig.id == 1044) ? (Model<BattlePassModel>.Interface.NewRedDotExist ? RedDotType.New : RedDotType.Dot) : RedDotType.Dot);
				redDotType = redDotType2;
			}
			RedDotItem.gameObject.SetActive(value: true);
			RedDotItem.redDotType = redDotType;
			RedDotItem.fullPath = source.ToList();
			ref RedDotDisplayAction displayAction = ref RedDotItem.displayAction;
			RedDotDisplayAction redDotDisplayAction;
			if (value)
			{
				redDotDisplayAction = new CurSystemUnLockDotActive
				{
					isActive = true
				};
			}
			else
			{
				redDotDisplayAction = ((_systemConfig.id == 1028) ? ((RedDotDisplayAction)new WorldMapExploreRewardOnTab()) : ((RedDotDisplayAction)new SelfNodeActive()));
			}
			displayAction = redDotDisplayAction;
			RedDotItem.BindTrieNode();
			RedDotItem.UpdateDisplay();
		}
		else if (!string.IsNullOrEmpty(_systemConfig.redPoint))
		{
			string[] source2 = _systemConfig.redPoint.Split("|");
			RedDotItem.gameObject.SetActive(value: true);
			RedDotItem.redDotType = RedDotType.Dot;
			RedDotItem.fullPath = source2.ToList();
			RedDotItem.displayAction = new SelfNodeActive();
			RedDotItem.BindTrieNode();
			RedDotItem.UpdateDisplay();
		}
		else
		{
			RedDotItem.gameObject.SetActive(value: false);
		}
	}

	private void SetRedpointState(int systemId, StringBuilder sb)
	{
		if (G.localPlayer.redPoints.Systems.TryGetValue(systemId, out var value) && value)
		{
			Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(systemId);
			RefreshRedpoint();
		}
	}

	private void ReportTrack(int id)
	{
		ACT.EventTrack.SystemOpen evt = EventTrackSolver.Instance.GetEvt<ACT.EventTrack.SystemOpen>();
		evt.id = id;
		evt.type = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private async void OpenUIView(EscSystem escSystem, StringBuilder sb)
	{
		if (escSystem == null)
		{
			return;
		}
		SetRedpointState(escSystem.id, sb);
		ReportTrack(escSystem.id);
		GameUtility.SendFinshStepGuideEvent((GuideConsts.GuideType)int.Parse($"{40}" + $"{escSystem.id}"));
		if (escSystem.id == 7001)
		{
			OnClickQuestionnaire();
			return;
		}
		string path = escSystem.path;
		if (string.IsNullOrEmpty(path))
		{
			return;
		}
		foreach (KeyValuePair<UI_TYPE, UIData> dICT_UI_DATum in CommonUIData.DICT_UI_DATA)
		{
			if (dICT_UI_DATum.Value == null || !dICT_UI_DATum.Value.mobilePath.Equals(path))
			{
				continue;
			}
			if (escSystem.id == 1013)
			{
				if (MonoECS.instance.playState == PlayState.UnBattle || MonoECS.instance.IsInTrainingground)
				{
					Singleton<NewUIManager>.instance.OpenUI(dICT_UI_DATum.Key, new TeamViewData
					{
						source = TeamProfileSource.World
					});
				}
				else
				{
					GameUtility.OpenToolTip(479);
				}
			}
			else if (escSystem.id == 1044)
			{
				if (Model<BattlePassModel>.Interface.AvailAble)
				{
					Singleton<NewUIManager>.instance.OpenUI(dICT_UI_DATum.Key, GetUIViewDataByUIType(dICT_UI_DATum.Key));
				}
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUI(dICT_UI_DATum.Key, GetUIViewDataByUIType(dICT_UI_DATum.Key));
			}
		}
	}

	public async void OpenLoungeWorld()
	{
		MonoECS.instance.PushPause();
		await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Lounge);
		MonoECS.instance.PopPause();
	}

	public async void EnterTrainingGround()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Play");
		if (MonoECS.instance.playState != PlayState.UnBattle)
		{
			GameUtility.OpenToolTip(1184);
			return;
		}
		MonoECS.instance.SyncGameInfos();
		Model<TrainingGroundModel>.Interface.MainWorldBattleCharaPostion = Vector3.zero;
		Model<TrainingGroundModel>.Interface.MainWorldBattleCharaPostion = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().SyncPosition;
		G.service.EnterTrainingGround((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Trainingground);
			}
		});
	}

	private UIViewData GetUIViewDataByUIType(UI_TYPE uiType)
	{
		return null;
	}

	private void OnClickQuestionnaire()
	{
		if (!Model<QuestionnaireModel>.Interface.HasQuestionnaire())
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("没有问卷可填写");
			}
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				tableName = LocalizationUtility.localizeTableName_Common,
				localizeId = 1813
			});
		}
		else
		{
			G.service.QuestionnaireRead(Model<QuestionnaireModel>.Interface.GetQuestionnaireId());
			UIUtility.OpenWebView(Model<QuestionnaireModel>.Interface.WebUrl(), isPortrait: true);
			HyperlinkClick evt = EventTrackSolver.Instance.GetEvt<HyperlinkClick>();
			evt.title = Model<QuestionnaireModel>.Interface.Title();
			evt.link = Model<QuestionnaireModel>.Interface.WebUrl();
			evt.systemId = 7001;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public void PlayAnimation()
	{
		betterAnimation.GetSequence("Show").Play();
	}

	public void OnSubmit()
	{
		ItemButton?.OnSubmit(null);
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ESC/Hover");
	}

	private async void RefreshSystemInfo(SystemType systemType)
	{
		_gachaInfo.SetActive(value: false);
		_otherInfo.SetActive(value: false);
		switch (systemType)
		{
		case SystemType.DrawCard:
		{
			int itemCount = G.localPlayer.Inventory.GetItemCount(200129);
			int itemCount2 = G.localPlayer.Inventory.GetItemCount(200130);
			_gachaInfo.SetActive(itemCount > 0 || itemCount2 > 0);
			_gachaInfo1.SetActive(itemCount > 0);
			_gachaInfo2.SetActive(itemCount2 > 0);
			_gachaCount1.text = "x" + itemCount;
			_gachaCount2.text = "x" + itemCount2;
			break;
		}
		case SystemType.MapUnLock:
		{
			string localizeString7 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 983);
			AreaExploreData areaExploreData = (Model<MapModel>.HasInstance() ? Model<MapModel>.Interface.GetAreaGroupExploreData(MapUtility.playerMapArea) : null);
			int num5 = ((areaExploreData != null) ? ((int)areaExploreData.GetAreaExploreRatio()) : 0);
			Color color = ((num5 >= 100) ? _normalColor : _hightColor);
			SetOtherSystemInfo(localizeString7, num5 + "%", color, string.Empty);
			break;
		}
		case SystemType.Mission:
		{
			string localizeString6 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2895);
			int num4 = 0;
			List<int> list = ListPool<int>.Get();
			Singleton<MissionManager>.instance.GetAllMissions(list);
			for (int i = 0; i < list.Count; i++)
			{
				ACT.MissionSystem.MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(list[i]);
				if (missionData != null && !missionData.Config.MissionBase.isHidden)
				{
					num4++;
				}
			}
			SetOtherSystemInfo(localizeString6, num4.ToString(), _hightColor, string.Empty);
			ListPool<int>.Release(list);
			break;
		}
		case SystemType.HandBook:
		{
			string localizeString3 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2896);
			long value = 0L;
			G.detailUserInfo.Attributes.TryGetValue(RuntimeConfigs.data.game.attrActivePoint, out value);
			int? num = RuntimeConfigs.data.dailyMissionRewards.LastOrDefault().Value?.creditRequire;
			Color color = ((value >= num) ? _normalColor : _hightColor);
			SetOtherSystemInfo(localizeString3, value.ToString(), color, num.ToString());
			break;
		}
		case SystemType.BattlePass:
		{
			string localizeString4 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2922);
			int curtWeekCumulativeExp = Model<BattlePassModel>.Interface.CurtWeekCumulativeExp;
			int weekExpLimitation = Model<BattlePassModel>.Interface.WeekExpLimitation;
			Color color = ((curtWeekCumulativeExp >= weekExpLimitation) ? _normalColor : _hightColor);
			SetOtherSystemInfo(localizeString4, curtWeekCumulativeExp.ToString(), color, weekExpLimitation.ToString());
			break;
		}
		case SystemType.Abyss:
		{
			if (Model<AbyssModel>.Interface.GetIsAllComplete())
			{
				SetOtherSystemInfo(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1816), string.Empty, _normalColor, string.Empty);
				break;
			}
			(AbyssType, int, int) lastChallengeInfo = Model<AbyssModel>.Interface.GetLastChallengeInfo();
			if (lastChallengeInfo.Item2 <= 0)
			{
				SetOtherSystemInfo(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2800), string.Empty, _normalColor, string.Empty);
			}
			else if (lastChallengeInfo.Item1 == AbyssType.Fixed)
			{
				string localizeString8 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 590);
				SetOtherSystemInfo(localizeString8, lastChallengeInfo.Item2.ToString(), _hightColor, lastChallengeInfo.Item3.ToString());
			}
			else
			{
				string localizeString9 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2866);
				SetOtherSystemInfo(localizeString9, lastChallengeInfo.Item2.ToString(), _hightColor, lastChallengeInfo.Item3.ToString());
			}
			break;
		}
		case SystemType.Rogue:
		{
			int num2 = 0;
			int num3 = 0;
			RogueInfo info = Model<RogueNewModel>.Interface.Info;
			if (info != null && RuntimeConfigs.data.seasons.TryGetValue(info.SeasonId, out var value2))
			{
				num2 = info.WeeklyCoinGain;
				num3 = value2.cycleMax;
			}
			string localizeString5 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2922);
			SetOtherSystemInfo(localizeString5, num2.ToString(), _hightColor, num3.ToString());
			break;
		}
		case SystemType.Message:
		{
			int unreadCount = Model<SNSModel>.Interface.GetUnreadCount();
			if (unreadCount <= 0)
			{
				SetOtherSystemInfo(string.Empty, string.Empty, _normalColor, string.Empty);
				break;
			}
			string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2897);
			SetOtherSystemInfo(localizeString2, unreadCount.ToString(), _hightColor, string.Empty);
			break;
		}
		case SystemType.Training:
		{
			(int, int) simulateTrainingProgress = Model<TeamTeachingModel>.Interface.GetSimulateTrainingProgress();
			string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2915);
			string left = simulateTrainingProgress.Item1.ToString();
			SetOtherSystemInfo(localizeString, left, _hightColor, simulateTrainingProgress.Item2.ToString());
			break;
		}
		}
		await UniTask.DelayFrame(1);
		LayoutRebuilder.ForceRebuildLayoutImmediate(_otherInfoLeft.transform.parent.GetComponent<RectTransform>());
	}

	private void SetOtherSystemInfo(string title, string left, Color color, string right)
	{
		_otherInfo.SetActive(value: true);
		_otherInfoTitle.gameObject.SetActive(!string.IsNullOrEmpty(title));
		_otherInfoTitle.text = title;
		_otherInfoLeft.gameObject.SetActive(value: true);
		_otherInfoLeft.text = left;
		_otherInfoLeft.color = color;
		_otherInfoSlash.gameObject.SetActive(value: false);
		_otherInfoRight.gameObject.SetActive(value: false);
		if (!string.IsNullOrEmpty(right))
		{
			_otherInfoSlash.gameObject.SetActive(value: true);
			_otherInfoRight.gameObject.SetActive(value: true);
			_otherInfoSlash.color = color;
			_otherInfoRight.color = color;
			_otherInfoRight.text = right;
		}
	}
}
