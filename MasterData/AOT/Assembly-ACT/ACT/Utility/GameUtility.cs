using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.MultiPlayer;
using ACT.Net;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.World;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Networking;
using UnityEngine.Playables;
using UnityEngine.Video;
using YooAsset;

namespace ACT.Utility;

public static class GameUtility
{
	private sealed class VideoApplicationPauseBridge : MonoBehaviour
	{
		public event Action<bool> ApplicationPauseChanged;

		private void OnApplicationPause(bool pauseStatus)
		{
			ApplicationPauseChanged?.Invoke(pauseStatus);
		}

		private void OnApplicationFocus(bool hasFocus)
		{
			if (hasFocus)
			{
				ApplicationPauseChanged?.Invoke(obj: false);
			}
		}
	}

	public struct ElementalResonanceData
	{
		public bool level1;

		public bool level2;

		public int resonanceId;

		public static string abilityName;
	}

	public struct ItemGainsData
	{
		public int curHaveNum;

		public int maxNum;

		public int couldGainNum;

		public int leftCount;

		public List<ItemKv> translateResult;
	}

	public static Camera mainCamera;

	public static Light mainLight;

	public static Camera uiCamera;

	public static Camera zNormalVCamera;

	public static Canvas uiCanvas;

	public static VideoPlayer mainVideoPlayer;

	private static VideoApplicationPauseBridge _videoApplicationPauseBridge;

	private static Action<bool> _prepareVideoPauseChangedHandler;

	public static GameLoader gameLoader;

	public static Transform npcInfoRoot;

	public static GameObject uiRobot;

	public static ParticleSystem uiRobotEffect;

	public static FilterEntityType defaultFilterEntityType;

	public static FilterEntityType comboFilterEntityType;

	public const float smallAndNormalScale = 1f;

	public const float middleScale = 1.5f;

	public const float bigScale = 2f;

	public const float giantScale = 2.5f;

	public static int refreshOffest;

	public static System.DateTime StartDate;

	public static DateMode dateMode;

	public static int year;

	public static int month;

	public static int day;

	public static int hour;

	public static Vector3 robotOffset;

	[Obsolete]
	public static GameObject traceCam;

	public static bool BloodBottleRecoverMax { get; private set; }

	public static System.DateTime UtcNow => dateMode switch
	{
		DateMode.System => System.DateTime.UtcNow, 
		DateMode.Debug => new System.DateTime(year, month, day, hour, 0, 0, DateTimeKind.Local).ToUniversalTime(), 
		_ => throw new NotImplementedException(), 
	};

	public static int Dir(float value)
	{
		if (value == 0f)
		{
			return 0;
		}
		if (value < 0f)
		{
			return -1;
		}
		return 1;
	}

	public static bool TryLoadRawFilePath(string location, out RawFileHandle rawFileHandle, out string filePath)
	{
		rawFileHandle = null;
		filePath = string.Empty;
		if (string.IsNullOrEmpty(location))
		{
			return false;
		}
		ResourcePackage resourcePackage = YooAssets.TryGetPackage("RawFile");
		if (resourcePackage == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("[GameUtility] Load raw file failed: YooAsset package not found, location=" + location);
			}
			return false;
		}
		string text;
		try
		{
			rawFileHandle = resourcePackage.LoadRawFileSync(location);
			if (rawFileHandle == null || !rawFileHandle.IsValid)
			{
				text = "Raw file handle is null or invalid.";
			}
			else if (!rawFileHandle.IsDone || rawFileHandle.Status != EOperationStatus.Succeed)
			{
				text = $"status={rawFileHandle.Status}, error={rawFileHandle.LastError}";
			}
			else
			{
				filePath = rawFileHandle.GetRawFilePath();
				if (!string.IsNullOrEmpty(filePath))
				{
					return true;
				}
				text = "Raw file path is empty.";
			}
		}
		catch (Exception ex)
		{
			text = ex.ToString();
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("[GameUtility] Load raw file failed: location=" + location + ", error=" + text);
		}
		if (rawFileHandle != null && rawFileHandle.IsValid)
		{
			rawFileHandle.Release();
		}
		rawFileHandle = null;
		filePath = string.Empty;
		return false;
	}

	public static RenderTexture CreateVideoRenderTexture(int width, int height)
	{
		return new RenderTexture(Mathf.Max(1, width), Mathf.Max(1, height), 0)
		{
			enableRandomWrite = true
		};
	}

	public static void PrepareVideoFromUrl(VideoPlayer videoPlayer, string url, Action<VideoPlayer, RenderTexture> onPrepared, Action<string> onError = null)
	{
		bool completed;
		bool pausedWhilePreparing;
		Action<bool> pauseChangedHandler;
		if (!(videoPlayer == null) && !string.IsNullOrEmpty(url))
		{
			completed = false;
			pausedWhilePreparing = false;
			pauseChangedHandler = null;
			videoPlayer.source = VideoSource.Url;
			videoPlayer.url = url;
			videoPlayer.prepareCompleted += OnPrepareCompleted;
			videoPlayer.errorReceived += OnErrorReceived;
			pauseChangedHandler = OnApplicationPauseChanged;
			if (_prepareVideoPauseChangedHandler != null && _videoApplicationPauseBridge != null)
			{
				_videoApplicationPauseBridge.ApplicationPauseChanged -= _prepareVideoPauseChangedHandler;
			}
			_videoApplicationPauseBridge = GetVideoApplicationPauseBridge(videoPlayer);
			_prepareVideoPauseChangedHandler = pauseChangedHandler;
			_videoApplicationPauseBridge.ApplicationPauseChanged += pauseChangedHandler;
			videoPlayer.Prepare();
		}
		void Cleanup(VideoPlayer source)
		{
			source.prepareCompleted -= OnPrepareCompleted;
			source.errorReceived -= OnErrorReceived;
			if (pauseChangedHandler != null && _videoApplicationPauseBridge != null)
			{
				_videoApplicationPauseBridge.ApplicationPauseChanged -= pauseChangedHandler;
				if (_prepareVideoPauseChangedHandler == pauseChangedHandler)
				{
					_prepareVideoPauseChangedHandler = null;
				}
			}
		}
		void CompletePrepare(VideoPlayer source)
		{
			if (!completed && IsCurrentSource(source))
			{
				completed = true;
				Cleanup(source);
				RenderTexture arg = (source.targetTexture = CreateVideoRenderTexture((int)source.width, (int)source.height));
				onPrepared?.Invoke(source, arg);
			}
		}
		bool IsCurrentSource(VideoPlayer source)
		{
			if (source == videoPlayer && source.source == VideoSource.Url)
			{
				return source.url == url;
			}
			return false;
		}
		void OnApplicationPauseChanged(bool pauseStatus)
		{
			if (completed || !IsCurrentSource(videoPlayer))
			{
				Cleanup(videoPlayer);
			}
			else if (pauseStatus)
			{
				pausedWhilePreparing = true;
			}
			else if (pausedWhilePreparing)
			{
				pausedWhilePreparing = false;
				if (videoPlayer.isPrepared)
				{
					CompletePrepare(videoPlayer);
				}
				else
				{
					videoPlayer.Prepare();
				}
			}
		}
		void OnErrorReceived(VideoPlayer source, string message)
		{
			Cleanup(source);
			if (IsCurrentSource(source))
			{
				completed = true;
				onError?.Invoke(message);
			}
		}
		void OnPrepareCompleted(VideoPlayer source)
		{
			CompletePrepare(source);
		}
	}

	private static VideoApplicationPauseBridge GetVideoApplicationPauseBridge(VideoPlayer videoPlayer)
	{
		VideoApplicationPauseBridge videoApplicationPauseBridge = videoPlayer.GetComponent<VideoApplicationPauseBridge>();
		if (videoApplicationPauseBridge == null)
		{
			videoApplicationPauseBridge = videoPlayer.gameObject.AddComponent<VideoApplicationPauseBridge>();
		}
		return videoApplicationPauseBridge;
	}

	static GameUtility()
	{
		defaultFilterEntityType = FilterEntityType.Character | FilterEntityType.Monster | FilterEntityType.Boss | FilterEntityType.Robot | FilterEntityType.Trajectory | FilterEntityType.Npc | FilterEntityType.Elite | FilterEntityType.StateObject | FilterEntityType.AssistNpc;
		comboFilterEntityType = FilterEntityType.Character | FilterEntityType.Monster | FilterEntityType.Boss | FilterEntityType.Robot | FilterEntityType.Trajectory | FilterEntityType.Elite;
		refreshOffest = 2;
		StartDate = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
		robotOffset = new Vector3(0f, 2f, -1f);
		DoGameUtility();
	}

	public static void DoGameUtility()
	{
		System.DateTime now = System.DateTime.Now;
		year = now.Year;
		month = now.Month;
		day = now.Day;
		hour = now.Hour;
	}

	public static long GetPlayerAttribute(PlayerAttribute attribute)
	{
		return G.detailUserInfo.Attributes[(int)attribute];
	}

	public static int GetWorldLevelIndex()
	{
		return SystemUnlockManager.worldLevel - 1;
	}

	public static void ChangeExpression(FaceExpression faceBlend, ConfigBlendShapes configBlendShapes, int? hash)
	{
		faceBlend.ChangeFace(configBlendShapes, hash);
	}

	public static void TriggerTeleportPoint()
	{
		RestorePlayerOnTriggerTeleportPoint();
		TriggerTeleportPointWorldReset();
	}

	private static void RestorePlayerOnTriggerTeleportPoint()
	{
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				if (teamCharacter.IsAlive())
				{
					CompAbility compAbility = teamCharacter.GetCompAbility();
					compAbility?.ServerSetHP(compAbility.maxHP);
				}
				else
				{
					Singleton<RespawnManager>.instance.LocalEntityReborn(teamCharacter);
					Singleton<AchievementSyncBattleTypeManager>.instance.DispatchResurrectionCount();
				}
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Player_Refresh, null);
		Singleton<BloodBottleHandler>.instance.RecoverItems();
	}

	public static void TriggerTeleportPointWorldReset()
	{
		if (MPPlayer.local.CurrentActiveBattlePotionId != 0)
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			CompAbility compAbility = mainEntity.GetCompAbility();
			if (compAbility != null && compAbility.TryGetAbility("RecoverMaxHP", includeAdd: true, out var ab) && !BloodBottleRecoverMax)
			{
				BloodBottleRecoverMax evt = Singleton<GameManager>.instance.ecsManager.systemAbility.GetEvt<BloodBottleRecoverMax>(mainEntity, ab);
				evt.bloodbottleRecoverMax = true;
				evt.mainEntity = mainEntity;
				Singleton<GameManager>.instance.ecsManager.systemAbility.FireEvt(evt);
				Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseEvt(evt);
			}
		}
		G.service.TriggerTeleportPoint(null);
		TriggerTeleportPoint evt2 = Singleton<EventManager>.instance.GetEvt<TriggerTeleportPoint>();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerTeleportPoint, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
		Singleton<DamageableManager>.instance.ResetAll();
		MonoECS.instance.SyncGameInfos();
	}

	public static void ResetMonsterInfo(Entity entity)
	{
		CompAbility compAbility = entity.GetCompAbility();
		CompHatred compHatred = entity.GetCompHatred();
		CompTransform compTransform = entity.GetCompTransform();
		CompPhysics compPhysics = entity.GetCompPhysics();
		CompAI compAI = entity.GetCompAI();
		foreach (Ability ability in compAbility.abilities)
		{
			if (ability.source == AbilitySource.Ability)
			{
				compAbility.RemoveAbility(ability.config.name);
			}
		}
		compAbility.ServerSetHP(compAbility.maxHP);
		compHatred.ClearHatred();
		compAbility.BattleInit();
		Singleton<EntityUIManager>.instance.ReBuild(entity);
		Vector3 vector = compAI.pos;
		if (CompPhysics.IsGroundLikeMotion(compPhysics.motion))
		{
			vector = PhysicsUtility.GetGroundPoint(vector + compTransform.center + new Vector3(0f, 0.05f, 0f), compTransform.size) - compTransform.center;
		}
		entity.Teleport(vector);
		compPhysics.SetConstZ(vector.z);
		SystemBehave behaveSystem = GameManager.behaveSystem;
		State state = behaveSystem.FindMotionState(entity, "born") ?? behaveSystem.FindMotionState(entity, "idle");
		behaveSystem.ForcedChangeToMotionState(entity, state);
	}

	public static ElementalResonanceData GetElementalResonance()
	{
		ElementalResonanceData result = default;
		Element[] array = new Element[3];
		int num = 1;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				array[i] = teamCharacter.GetCompAbility().element;
			}
		}
		for (int j = 0; j < array.Length; j++)
		{
			if (array[j] == Element.Owner)
			{
				continue;
			}
			for (int k = j + 1; k < array.Length; k++)
			{
				if (array[k] != Element.Owner && array[j] == array[k])
				{
					result.resonanceId = (int)array[j];
					num++;
				}
			}
		}
		result.level1 = num > 1;
		result.level2 = num > 2;
		return result;
	}

	public static void AddResonanceAbility(Entity entity)
	{
		int resonanceId = GetElementalResonance().resonanceId;
		ElementResonanceData elementResonanceData = RuntimeConfigs.data.elementResonanceDatas[resonanceId];
		if (elementResonanceData.abilityName != null)
		{
			CompAbility compAbility = entity.GetCompAbility();
			if (GetElementalResonance().level2)
			{
				compAbility.AddAbility(entity, elementResonanceData.abilityName1, AbilitySource.System, new MPSkill
				{
					id = elementResonanceData.id,
					level = 1
				}, 1);
				ElementalResonanceData.abilityName = elementResonanceData.abilityName1;
			}
			else
			{
				compAbility.AddAbility(entity, elementResonanceData.abilityName, AbilitySource.System, new MPSkill
				{
					id = elementResonanceData.id,
					level = 1
				}, 1);
				ElementalResonanceData.abilityName = elementResonanceData.abilityName;
			}
		}
	}

	public static void RemoveResonanceAbility(Entity entity)
	{
		entity.GetCompAbility().RemoveAbility(ElementalResonanceData.abilityName);
	}

	public static float GetBottleBaseRecoverCount(int skillGroupId, int level, Entity entity)
	{
		if (skillGroupId == 0 || level == 0)
		{
			return 0f;
		}
		int[] skillTotalIds = RuntimeConfigs.data.skillGroupDatas[skillGroupId].skillTotalIds;
		float[] param = CoreUtils.GetData(((skillTotalIds.Length > level - 1) ? CoreUtils.GetData(skillTotalIds[level - 1], RuntimeConfigs.data.skillDetailDatas) : CoreUtils.GetData(skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas)).id * 100 + level, RuntimeConfigs.data.skillDetailLevelDatas).param1;
		float num = param[0];
		return ((param.Length > 1) ? param[1] : 0f) + (float)entity.GetCompAbility().maxHP * num;
	}

	public static float GetBottleActuallyRecoverCount(float baseCount, Entity entity)
	{
		float value = entity.GetCompAbility().GetProperty(211u).value;
		if (value == 0f)
		{
			return baseCount;
		}
		return value + baseCount;
	}

	public static void UpdateRecoverMaxHPState(bool isMax)
	{
		BloodBottleRecoverMax = isMax;
	}

	public static Vector2 WorldToScreenPointForCanvas(Canvas canvas, Camera camera, Vector3 position)
	{
		return RectTransformUtility.WorldToScreenPoint((canvas.renderMode == RenderMode.ScreenSpaceOverlay) ? null : camera, position);
	}

	public static void CheckRefreshLegendMissionRedDot()
	{
		ItemKv itemKv = RuntimeConfigs.data.game.CharacterMissionCostItem[0];
		bool flag = G.localPlayer.Inventory.GetItemCount(itemKv.id) >= itemKv.count;
		foreach (RoleMissionData value in RuntimeConfigs.data.roleMissionDatas.Values)
		{
			MissionData data = CoreUtils.GetData(value.receiveMissionId, RuntimeConfigs.data.missionDatas);
			ServiceRefreshLegendMissionRedDot(value.receiveMissionId, flag && Singleton<SystemUnlockManager>.instance.IsUnlock(data.pre), remove: true);
		}
	}

	public static bool ServiceRefreshLegendMissionRedDot(int missionId, bool red, bool remove = false)
	{
		MapField<int, bool> missions = G.localPlayer.redPoints.Missions;
		if (missions.ContainsKey(missionId))
		{
			if (remove && !red)
			{
				missions.Remove(missionId);
				return false;
			}
			if (missions[missionId] == red)
			{
				return false;
			}
			if (!missions[missionId])
			{
				return false;
			}
		}
		else if (!red)
		{
			return false;
		}
		missions[missionId] = red;
		G.service.RefreshRedDot(G.localPlayer.redPoints, (bool isTrue) =>
		{
		});
		return true;
	}

	public static bool ServiceRefreshItemRedDot(int itemId, bool red)
	{
		MapField<int, bool> items = G.localPlayer.redPoints.Items;
		if (!items.ContainsKey(itemId) && !red)
		{
			return false;
		}
		if (items.ContainsKey(itemId) && red == items[itemId])
		{
			return false;
		}
		items[itemId] = red;
		G.service.RefreshRedDot(G.localPlayer.redPoints, (bool isTrue) =>
		{
		});
		return true;
	}

	public static void RefreshItemRedDot()
	{
		using IEnumerator<bool> enumerator = G.localPlayer.redPoints.Items.Values.GetEnumerator();
		while (enumerator.MoveNext() && !enumerator.Current)
		{
		}
	}

	public static void RefreshExploreChallengeRedDot()
	{
		if (Model<ActivityExploreChallengeModel>.Interface != null)
		{
			for (int i = 0; i < Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count; i++)
			{
				bool active = Model<ActivityExploreChallengeModel>.Interface.HasChallengePhaseRewardToReceive(i);
				string nodeFullPath = string.Format(RedDotPathDefine.Activity_ChallengeReward, i + 1);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active);
			}
		}
	}

	public static bool GetExploreChallengeRedDotState()
	{
		if (Model<ActivityExploreChallengeModel>.Interface != null)
		{
			for (int i = 0; i < Model<ActivityExploreChallengeModel>.Interface.ChallengePhaseInfos.Count; i++)
			{
				if (Model<ActivityExploreChallengeModel>.Interface.HasChallengePhaseRewardToReceive(i))
				{
					return true;
				}
			}
		}
		return false;
	}

	public static int ActivePointDailyRewardId()
	{
		return RuntimeConfigs.data.game.activePointDailyRewardExchangeCost[0].id;
	}

	public static int ActivePointDailyRewardCost()
	{
		return RuntimeConfigs.data.game.activePointDailyRewardExchangeCost[0].count;
	}

	public static int ActivePointExtraRewardId()
	{
		return RuntimeConfigs.data.game.activePointExtraRewardExchangeCost[0].id;
	}

	public static int ActivePointExtraRewardCost()
	{
		return RuntimeConfigs.data.game.activePointExtraRewardExchangeCost[0].count;
	}

	public static int ExpItemId()
	{
		return 1;
	}

	public static bool HaveReward()
	{
		if (G.localPlayer.Inventory.GetItemCount(ActivePointExtraRewardId()) >= ActivePointExtraRewardCost())
		{
			return true;
		}
		return false;
	}

	public static Color GetCharacterElementColor(Element element)
	{
		switch (element)
		{
		case Element.Owner:
		case Element.Born:
			return GameLoader.meta.elementUi.Born;
		case Element.Disturb:
			return GameLoader.meta.elementUi.Disturb;
		case Element.Ash:
			return GameLoader.meta.elementUi.Ash;
		case Element.Operate:
			return GameLoader.meta.elementUi.Operate;
		case Element.Promote:
			return GameLoader.meta.elementUi.Promote;
		case Element.Dark:
			return GameLoader.meta.elementUi.Dark;
		default:
			return Color.white;
		}
	}

	public static void OpenToolTip(string content, bool ignoreOtherToolTip = false)
	{
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonStringTip
		{
			content = content,
			ignoreWaitQueue = ignoreOtherToolTip
		});
	}

	public static void OpenToolTip(LocalizationCommonData.CommonString commonString, bool ignoreOtherToolTip = false)
	{
		OpenToolTip((int)commonString, "Common", null, ignoreOtherToolTip);
	}

	public static void OpenToolTip(int textLocalizeId, string tableName = "Common", List<string> variableList = null, bool ignoreToolTipWaitQueue = false)
	{
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
		{
			tableName = tableName,
			localizeId = textLocalizeId,
			variableList = variableList,
			ignoreWaitQueue = ignoreToolTipWaitQueue
		});
	}

	public static void OpenToolTip(LocalizedString localizedString, bool ignoreToolTipWaitQueue = false)
	{
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonLocalizedStringTip
		{
			content = localizedString,
			ignoreWaitQueue = ignoreToolTipWaitQueue
		});
	}

	public static void OpenJumpResultTips(JumpResult result)
	{
		List<string> messages = result.Messages;
		if (messages != null && messages.Count > 0)
		{
			foreach (string message in result.Messages)
			{
				if (!string.IsNullOrEmpty(message))
				{
					OpenToolTip(message);
				}
			}
			return;
		}
		if (!string.IsNullOrEmpty(result.Message))
		{
			OpenToolTip(result.Message);
		}
	}

	public static void OpenSystem(int systemID)
	{
	}

	private static void OpenPopRewardData(PopUpRewardOneRowData data, List<UniversalItem> characterItems)
	{
		if (characterItems != null && characterItems.Count > 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW, new CommonAcquireCharacterShowData
			{
				universalItems = characterItems,
				CallBack = async () =>
				{
					await UniTask.WaitUntil(() => Singleton<NewUIManager>.instance.CheckOpenUI(UI_TYPE.UI_POPUPREWARDONE));
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPREWARDONE, data);
				}
			});
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPREWARDONE, data);
		}
	}

	public static List<UniversalItem> ToUniversalItems(IEnumerable<Item> itemSource)
	{
		if (itemSource == null)
		{
			return null;
		}
		List<UniversalItem> list = new List<UniversalItem>();
		foreach (Item item in itemSource)
		{
			if (item != null)
			{
				int? num = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas)?.type;
				list.Add(new UniversalItem
				{
					Type = ((num == 5) ? UniversalItemType.UniversalItemCharacter : ((num == 36) ? UniversalItemType.UniversalItemSkin : UniversalItemType.UniversalItemNormal)),
					Index = item.Id,
					Count = item.Count,
					IsNew = item.IsNew,
					Uid = item.Uid
				});
			}
		}
		return list;
	}

	public static List<UniversalItem> ToUniversalItems(IEnumerable<ItemUnifierProxy> itemSource)
	{
		if (itemSource == null)
		{
			return null;
		}
		List<UniversalItem> list = new List<UniversalItem>();
		foreach (ItemUnifierProxy item2 in itemSource)
		{
			if (item2 != null)
			{
				int? num = item2.ItemData?.type;
				list.Add(new UniversalItem
				{
					Type = ((num == 5) ? UniversalItemType.UniversalItemCharacter : ((num == 36) ? UniversalItemType.UniversalItemSkin : UniversalItemType.UniversalItemNormal)),
					Index = item2.Id,
					Count = (int)item2.Count,
					IsNew = (item2.Source is Item item && item.IsNew),
					Uid = item2.Uid,
					Tag = item2.RewardTag
				});
			}
		}
		return list;
	}

	private static List<UniversalItem> BuildCharacterShowItems(IEnumerable<UniversalItem> itemSource)
	{
		if (itemSource == null)
		{
			return null;
		}
		List<UniversalItem> list = null;
		HashSet<int> hashSet = new HashSet<int>();
		foreach (UniversalItem item in itemSource)
		{
			if (item != null && item.Type == UniversalItemType.UniversalItemCharacter && hashSet.Add(item.Index))
			{
				if (list == null)
				{
					list = new List<UniversalItem>();
				}
				list.Add(item);
			}
		}
		return list;
	}

	public static void OpenNormalReward(NomalRewardOneViewData data, bool notSort = false)
	{
		List<UniversalItem> list = BuildCharacterShowItems(data?.itemList);
		if (list != null && list.Count > 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW, new CommonAcquireCharacterShowData
			{
				universalItems = list,
				CallBack = () =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_NOMALREWARDONE, data);
				}
			});
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_NOMALREWARDONE, data);
		}
	}

	public static void OpenSKillLevelUp(MonoSkillLevelUpMaxView.SkillLevelUpMaxData maxData)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LEVELUPPROPERTYINFO, maxData);
	}

	public static void OpenAdventureTip()
	{
		OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.Top;
		evt.type = HudComponentType.AdventureLevel;
		evt.priorityInQueue = 1;
		evt.uiData = new MonoPopUpPlayerAdventureTip.ExpChangeData
		{
			beforeLevel = G.localPlayer.playerExpData.beforeLevel,
			addExp = G.localPlayer.playerExpData.addExp,
			currentExp = G.localPlayer.playerExpData.currentExp,
			beforeExp = G.localPlayer.playerExpData.beforeExp,
			currentLevel = G.localPlayer.playerExpData.curLevel,
			isWorldLevel = false
		};
		evt.timeOutDuration = 15f;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public static RaidTypeData GetRaidTypeData(int id)
	{
		int value = 0;
		foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData.Value.raidId.Contains(id))
			{
				value = raidEntranceData.Key;
			}
		}
		RaidTypeData result = null;
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidTypeData.Value.raidEntranceId.Contains(value))
			{
				result = raidTypeData.Value;
			}
		}
		return result;
	}

	public static RaidEntranceData GetRaidEntranceData(int id)
	{
		foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData.Value.raidId.Contains(id))
			{
				return raidEntranceData.Value;
			}
		}
		return null;
	}

	public static void FinshGuideEvent(bool _isAllFinsh, int _guideId, bool _isFinshCurrent)
	{
		GmToolGuideFinishEvt gmToolGuideFinishEvt = new GmToolGuideFinishEvt();
		gmToolGuideFinishEvt.isAllFinsh = _isAllFinsh;
		gmToolGuideFinishEvt.guideId = _guideId;
		gmToolGuideFinishEvt.finshCurrent = _isFinshCurrent;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.GM_Guide_Finsh, gmToolGuideFinishEvt);
		Singleton<EventManager>.instance.ReleaseEvt(gmToolGuideFinishEvt);
	}

	public static void SendFinshStepGuideEvent(GuideConsts.GuideType guideType)
	{
		GuideStepFinishEvt evt = Singleton<EventManager>.instance.GetEvt<GuideStepFinishEvt>();
		evt.type = guideType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_StepFinish, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public static string CurrentDeviceModel()
	{
		return SystemInfo.deviceModel;
	}

	public static Vector4 GetDeviceSafeAreaOffset(out bool overrideSafeArea, out bool applyY, ACT.Config.Game game)
	{
		overrideSafeArea = false;
		applyY = false;
		Vector4 result = default;
		switch (Application.platform)
		{
		case RuntimePlatform.WindowsPlayer:
		case RuntimePlatform.WindowsEditor:
		{
			(bool, bool, Vector4) tuple = Setvalue(game.windowsSafeAreaOffset);
			(overrideSafeArea, applyY, _) = tuple;
			return tuple.Item3;
		}
		case RuntimePlatform.IPhonePlayer:
		{
			(bool, bool, Vector4) tuple = Setvalue(game.iPhoneSafeAreaOffset);
			(overrideSafeArea, applyY, _) = tuple;
			return tuple.Item3;
		}
		case RuntimePlatform.Android:
		{
			(bool, bool, Vector4) tuple = Setvalue(game.androidSafeAreaOffset);
			(overrideSafeArea, applyY, _) = tuple;
			return tuple.Item3;
		}
		default:
			return result;
		}
		static (bool, bool, Vector4) Setvalue(int[] data)
		{
			bool item = data[4] != 0;
			bool item2 = data[5] != 0;
			Vector4 item3 = new Vector4(data[0], data[1], data[2], data[3]);
			return (item, item2, item3);
		}
	}

	public static System.DateTime CovertIntToDateTime(int timeStamp)
	{
		return StartDate.AddSeconds(timeStamp);
	}

	public static int CovertDateTimeToInt(System.DateTime dateTime)
	{
		return (int)(dateTime - StartDate).TotalSeconds;
	}

	public static bool DataTimeInRange(long startTime, long endTime)
	{
		if (TimeManager.ServerTime.NowTimestamp >= startTime)
		{
			return TimeManager.ServerTime.NowTimestamp <= endTime;
		}
		return false;
	}

	public static System.DateTime GetOffestDate(System.DateTime dateTime)
	{
		return dateTime.AddHours(-refreshOffest).ToLocalTime().Date;
	}

	public static bool CollectionRefresh(System.DateTime last, System.DateTime now, CollectionRefreshRule rule)
	{
		System.DateTime offestDate = GetOffestDate(now);
		if (GetOffestDate(last) == offestDate)
		{
			return false;
		}
		return rule switch
		{
			CollectionRefreshRule.Once => false, 
			CollectionRefreshRule.EveryDay => true, 
			CollectionRefreshRule.Monday => offestDate.DayOfWeek == DayOfWeek.Monday, 
			_ => throw new NotImplementedException(), 
		};
	}

	public static async void OpenBuffDetail(EquipBuffViewData data)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPBUFF, data);
	}

	public static void SetEquipProperty(PropertyCell[] propertyCells, Equip m_equip, ImageAssetStation station = null)
	{
		for (int i = 0; i < propertyCells.Length; i++)
		{
			propertyCells[i].gameObject.SetActive(value: false);
		}
		int num = 0;
		foreach (EquipAttr attribute in m_equip.Attributes)
		{
			PropertyCell obj = propertyCells[num];
			obj.gameObject.SetActive(value: true);
			float value = attribute.Value;
			int attrId = RuntimeConfigs.data.equipAttrDatas[attribute.Id].attrId;
			PropertyData property2Data = RuntimeConfigs.data.propertyDatas[attrId];
			obj.Init(property2Data, value, null, float.NaN, station);
			num++;
		}
	}

	public static int FindGemEquip(int gemUid)
	{
		foreach (Character curAllCharacter in CharacterDataHelper.GetCurAllCharacters())
		{
			foreach (int value in curAllCharacter.Equips.Values)
			{
				Equip equip = G.localPlayer.Inventory.GetEquip(value);
				if (equip == null)
				{
					continue;
				}
				foreach (GemSlot gemSlot in equip.GemSlots)
				{
					if (gemSlot.GemId == gemUid)
					{
						return value;
					}
				}
			}
		}
		return -1;
	}

	public static Character FindEquipEquipCharacter(int equipUid)
	{
		foreach (Character curAllCharacter in CharacterDataHelper.GetCurAllCharacters())
		{
			foreach (int value in curAllCharacter.Equips.Values)
			{
				if (value == equipUid)
				{
					return curAllCharacter;
				}
			}
		}
		return null;
	}

	public static string GetPropertyEquip(Entity entity, int id)
	{
		PropertyData propertyData = RuntimeConfigs.data.propertyDatas[id];
		float num = (propertyData.judge ? entity.GetCompAbility().GetScreenMulProperty(propertyData.propertyId, MulScreen) : entity.GetCompAbility().GetScreenProperty(propertyData.propertyId, BaseScreen, AddScreen, MulScreen));
		if (!propertyData.judge)
		{
			return Mathf.CeilToInt(num).FastToString();
		}
		return Topercentage(num, 1);
		static bool AddScreen(IPropertyProvider provider)
		{
			if (provider is NumberPropertyProvider numberPropertyProvider)
			{
				return numberPropertyProvider.from.source == PropertySource.Equip;
			}
			return false;
		}
		static bool BaseScreen(IPropertyProvider provider)
		{
			if (provider is NumberPropertyProvider numberPropertyProvider)
			{
				PropertySource source = numberPropertyProvider.from.source;
				if ((uint)(source - 1) <= 1u || source == PropertySource.Equip)
				{
					return true;
				}
			}
			return false;
		}
		static bool MulScreen(IPropertyProvider provider)
		{
			if (provider is NumberPropertyProvider numberPropertyProvider)
			{
				return numberPropertyProvider.from.source == PropertySource.Equip;
			}
			return false;
		}
	}

	[Obsolete]
	public static void RefreshCharacterEquipInfo(Entity entity, int preEquipUid, int nowEquipUid)
	{
		if (!MonoECS.instance.isStartWorld || !(entity.GetCompCharacter().characterSource is Character character))
		{
			return;
		}
		Equip equip = G.localPlayer.Inventory.GetEquip(preEquipUid);
		Equip equip2 = G.localPlayer.Inventory.GetEquip(nowEquipUid);
		List<int> list = ListPool<int>.Get();
		if (equip != null)
		{
			equip.GetAllFeatureIDs(list);
			foreach (int item in list)
			{
				SkillGroupData data = CoreUtils.GetData(CoreUtils.GetData(item, RuntimeConfigs.data.equipFeatureDatas).skillGroupData, RuntimeConfigs.data.skillGroupDatas);
				for (int i = 0; i < data.skillTotalIds.Length; i++)
				{
					SkillDetailData data2 = CoreUtils.GetData(data.skillTotalIds[i], RuntimeConfigs.data.skillDetailDatas);
					CompAbility compAbility = entity.GetCompAbility();
					Ability abilityByName = compAbility.GetAbilityByName(data2.abilityName);
					if (abilityByName != null)
					{
						int featureData = character.GetFeatureData(item, FeatureData.FeatureSourceType.Equip);
						abilityByName.skillLevelInfo.level = (byte)featureData;
						if (featureData <= 0)
						{
							compAbility.RemoveAbility(data2.abilityName);
							continue;
						}
						abilityByName.RemoveProperty();
						abilityByName.AddProperty();
					}
				}
			}
		}
		if (equip2 == null)
		{
			return;
		}
		equip2.GetAllFeatureIDs(list);
		foreach (int item2 in list)
		{
			SkillGroupData data3 = CoreUtils.GetData(CoreUtils.GetData(item2, RuntimeConfigs.data.equipFeatureDatas).skillGroupData, RuntimeConfigs.data.skillGroupDatas);
			for (int j = 0; j < data3.skillTotalIds.Length; j++)
			{
				SkillDetailData data4 = CoreUtils.GetData(data3.skillTotalIds[j], RuntimeConfigs.data.skillDetailDatas);
				CompAbility compAbility2 = entity.GetCompAbility();
				Ability abilityByName2 = compAbility2.GetAbilityByName(data4.abilityName);
				int featureData2 = character.GetFeatureData(item2, FeatureData.FeatureSourceType.Equip);
				if (abilityByName2 == null)
				{
					compAbility2.AddAbility(entity, data4.abilityName, AbilitySource.Equip, new MPSkill
					{
						id = data4.id,
						level = (byte)featureData2
					}, 1);
				}
				else
				{
					abilityByName2.skillLevelInfo.level = (byte)featureData2;
					abilityByName2.RemoveProperty();
					abilityByName2.AddProperty();
				}
			}
		}
	}

	public static float GetPropertyValue(this Equip equip, int propertyID)
	{
		if (CoreUtils.GetData(equip.Id, RuntimeConfigs.data.equipDatas) == null)
		{
			return 0f;
		}
		float num = 0f;
		foreach (EquipAttr attribute in equip.Attributes)
		{
			EquipAttrData data = CoreUtils.GetData(attribute.Id, RuntimeConfigs.data.equipAttrDatas);
			if (data != null && propertyID == data.attrId)
			{
				num += attribute.Value;
			}
		}
		return num;
	}

	public static bool CheckIsHaveCharacter(int characterId)
	{
		foreach (KeyValuePair<int, Character> character in CharacterDataHelper.GetCharacterRepository(0).Characters)
		{
			if (character.Key == characterId)
			{
				return true;
			}
		}
		return false;
	}

	public static void SetWeaponPropertyUIInfo(Weapon weapon, PropertyCell[] propertyCells)
	{
		(float v1, float v2) weaponBaseProperty = weapon.GetWeaponBaseProperty();
		float item = weaponBaseProperty.v1;
		float item2 = weaponBaseProperty.v2;
		PropertyData property2Data = RuntimeConfigs.data.propertyDatas[200];
		PropertyData property2Data2 = RuntimeConfigs.data.propertyDatas[weapon.WeaponSubPropertyId];
		propertyCells[0].Init(property2Data, item);
		propertyCells[1].Init(property2Data2, item2);
	}

	public static Character GetEquiper(this Weapon w)
	{
		foreach (Character curAllCharacter in CharacterDataHelper.GetCurAllCharacters())
		{
			if (curAllCharacter.WeaponUid == w.Uid)
			{
				return curAllCharacter;
			}
		}
		return null;
	}

	public static int GetEquiperID(this Weapon w)
	{
		foreach (Character curAllCharacter in CharacterDataHelper.GetCurAllCharacters())
		{
			if (curAllCharacter.WeaponUid == w.Uid)
			{
				return curAllCharacter.Id;
			}
		}
		return -1;
	}

	public static void SuchItemList(List<Item> items)
	{
		int[] weaponEnhancementMaterial = RuntimeConfigs.data.game.weaponEnhancementMaterial;
		for (int i = 0; i < weaponEnhancementMaterial.Length; i++)
		{
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(weaponEnhancementMaterial[i]);
			if (itemInfo != null && itemInfo.Count > 0)
			{
				items.Add(itemInfo);
			}
		}
	}

	public static void SuchItemByQuality(int quality, List<Item> items)
	{
		int[] array = new int[3] { 3, 2, 1 };
		int[] weaponEnhancementMaterial = RuntimeConfigs.data.game.weaponEnhancementMaterial;
		for (int i = 0; i < array[quality]; i++)
		{
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(weaponEnhancementMaterial[i]);
			if (itemInfo != null && itemInfo.Count > 0)
			{
				items.Add(new Item
				{
					Id = itemInfo.Id,
					Count = 0
				});
			}
		}
	}

	public static void GetTeamCharactersId(int index, int[] charactersId)
	{
		RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[index].CharacterIds;
		for (int i = 0; i < characterIds.Count; i++)
		{
			charactersId[i] = characterIds[i];
		}
	}

	public static int GetTeamCharacterId(int teamIndex, int chIndex)
	{
		return G.localPlayer.teamInfo.PresetTeams[teamIndex].CharacterIds[chIndex];
	}

	public static void SuchUpdateWeaponListByQuality(IList<Weapon> weapons, int quality, List<Weapon> dogWeapons)
	{
		int[] array = new int[3] { 3, 2, 1 };
		RepeatedField<Weapon> weapons2 = G.localPlayer.Inventory.Weapons;
		for (int i = 0; i < weapons2.Count; i++)
		{
			if (weapons2[i].GetQuality() <= array[quality] && weapons2[i].Level == 1 && weapons2[i].Refine == 1 && !weapons2[i].Lock && !dogWeapons.Contains(weapons2[i]) && weapons2[i].GetEquiper() == null)
			{
				weapons.Add(weapons2[i]);
			}
		}
	}

	public static int GetDogItemsCount(List<Item> dogItems, int itemId)
	{
		return dogItems.Find((Item i) => i.Id == itemId)?.Count ?? 0;
	}

	public static void GetRefineWeaponList(Weapon exceptSelf, IList<Weapon> weapons)
	{
		weapons.Remove(exceptSelf);
		int num = 0;
		while (num < weapons.Count)
		{
			Weapon weapon = weapons[num];
			if (weapon.GetEquiper() != null || weapon.WeaponId != exceptSelf.WeaponId)
			{
				weapons.Remove(weapon);
			}
			else
			{
				num++;
			}
		}
	}

	public static void GetSuchWeaponList(bool removeEquipped, Weapon exceptSelf, int weaponType, bool isReplace, IList<Weapon> weapons)
	{
		if (exceptSelf != null && !isReplace)
		{
			weapons.Remove(exceptSelf);
		}
		if (removeEquipped)
		{
			int num = 0;
			while (num < weapons.Count)
			{
				Weapon weapon = weapons[num];
				if (weapon.GetEquiper() != null)
				{
					weapons.Remove(weapon);
				}
				else
				{
					num++;
				}
			}
		}
		if (weaponType <= 0)
		{
			return;
		}
		int num2 = 0;
		while (num2 < weapons.Count)
		{
			Weapon weapon2 = weapons[num2];
			if (weapon2.Type != weaponType)
			{
				weapons.Remove(weapon2);
			}
			else
			{
				num2++;
			}
		}
	}

	public static int CalcalateLevel(Weapon weapon, int totalExp)
	{
		int num = weapon.Exp + weapon.TotalExp;
		int num2 = weapon.Level;
		int maxLevel = RuntimeConfigs.data.itemWeaponBreakthroughs[TableRule.GetWeaponBreakId(weapon.WeaponId, weapon.Stage)].maxLevel;
		num += totalExp;
		for (int i = num2; i <= maxLevel && num >= RuntimeConfigs.data.itemWeaponUpgrades[TableRule.GetWeaponUpGradeId(weapon.UpGradeType, i)].totalEXPRequired; i++)
		{
			num2 = i;
		}
		return num2 - weapon.Level;
	}

	public static int[] CalculateExpAttribute(Character character, int totalExp)
	{
		Dictionary<int, EntityCharacterXPData> entityCharacterXPDatas = RuntimeConfigs.data.entityCharacterXPDatas;
		int num = character.Exp + entityCharacterXPDatas[character.GetCharacterXpId()].xpTotal;
		int num2 = character.Level;
		int num3 = 0;
		int levelMax = RuntimeConfigs.data.entityCharacterLevelDatas[character.GetCharacterLevelId()].levelMax;
		num += totalExp;
		for (int i = num2; i <= levelMax; i++)
		{
			if (num >= entityCharacterXPDatas[character.GetCharacterXpId(i)].xpTotal)
			{
				num2 = i;
				continue;
			}
			num3 = num - entityCharacterXPDatas[character.GetCharacterXpId(i - 1)].xpTotal;
			break;
		}
		int num4 = num2 - character.Level;
		return new int[2] { num4, num3 };
	}

	public static Color ToColor(int r, int g, int b, int a)
	{
		return new Color((float)r / 255f, (float)g / 255f, (float)b / 255f, (float)a / 255f);
	}

	public static string Topercentage(float p, int num)
	{
		return TopercentageMathfFloor(p, num);
	}

	public static string TopercentageMathfFloor(float p, int num)
	{
		decimal num2 = Math.Round((decimal)p, 3, MidpointRounding.AwayFromZero);
		decimal num3 = (decimal)Math.Pow(10.0, num);
		return (Math.Floor(num2 * 100m * num3) / num3).ToString($"F{num}") + "%";
	}

	public static string TopercentageNoSpace(float p, int num)
	{
		string text = "#0." + new string('0', num) + "%";
		return p.ToString(text);
	}

	public static void GetItemsByType(int type, List<Item> items)
	{
		foreach (Item item in G.localPlayer.Inventory.Items)
		{
			if (RuntimeConfigs.data.itemDatas[item.Id].type == type)
			{
				items.Add(item);
			}
		}
	}

	public static Vector3 GetMissionTargetPosition(MissionPointData pointData)
	{
		return pointData.GetGuidePointPosition();
	}

	public static float CalculateClosestMissionPoint(out MissionPointData output)
	{
		float result = CalculateClosestMissionPoint(out MissionArrowData output2);
		output = output2?.missionPointData;
		return result;
	}

	public static float CalculateClosestMissionPoint(out MissionArrowData output)
	{
		output = null;
		long num = long.MaxValue;
		foreach (MissionArrowData currentTrackMissionData in Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas())
		{
			long num2 = currentTrackMissionData.Distance;
			if (!currentTrackMissionData.missionPointData.IsSameArea || !currentTrackMissionData.missionPointData.IsSameWorld)
			{
				num2 = 9223372036854775806L;
			}
			if (num2 < num)
			{
				num = num2;
				output = currentTrackMissionData;
			}
		}
		return num;
	}

	public static bool CanSkillGroupLevelUp(Character character, int skillGroup, out CharacterViewConst.ReasonType reason)
	{
		SkillGroupData data = CoreUtils.GetData(skillGroup, RuntimeConfigs.data.skillGroupDatas);
		if (data.skillType == 1)
		{
			reason = CharacterViewConst.ReasonType.IsTalent;
			return false;
		}
		character.SkillGroupLevels.TryGetValue(data.id, out var value);
		if (value >= RuntimeConfigs.data.skillGroupDatas[skillGroup].levelUpLimit)
		{
			reason = CharacterViewConst.ReasonType.ReachMaxLevel;
			return false;
		}
		int num = value + 1;
		SkillGroupLevelData data2 = CoreUtils.GetData(new MPSkill
		{
			id = skillGroup,
			level = (byte)num
		}.GetSkillIdWithLevel(), RuntimeConfigs.data.skillGroupLevelDatas);
		foreach (ItemKv item in data2.preconditionParam)
		{
			int count = item.count;
			switch (item.id)
			{
			case 2:
				if (count >= SystemUnlockManager.playerLevel)
				{
					reason = CharacterViewConst.ReasonType.LessPlayerLevel;
					return false;
				}
				break;
			}
		}
		if (!ReachBreakLevel(character, data2))
		{
			reason = CharacterViewConst.ReasonType.LessBreakLevel;
			return false;
		}
		if (!ReachCharacterLevel(character, data2))
		{
			reason = CharacterViewConst.ReasonType.LessCharacterLevel;
			return false;
		}
		if (!PreNodeIsUnLock(character, data))
		{
			reason = CharacterViewConst.ReasonType.PreNodeLocked;
			return false;
		}
		if (!CoinIsEnough(data2))
		{
			reason = CharacterViewConst.ReasonType.LackCoin;
			return false;
		}
		if (!MatIsEnough(data2))
		{
			reason = CharacterViewConst.ReasonType.LackMaterial;
		}
		reason = CharacterViewConst.ReasonType.None;
		return true;
	}

	public static bool ItemsIsEnough(List<ItemKv> cost)
	{
		for (int i = 0; i < cost.Count; i++)
		{
			if (IsPlayerAttributeCost(cost[i].id))
			{
				if (G.TryGetAttribute(cost[i].id) < cost[i].count)
				{
					return false;
				}
			}
			else if (G.localPlayer.Inventory.GetItemCount(cost[i].id) < cost[i].count)
			{
				return false;
			}
		}
		return true;
	}

	public static bool ItemsIsEnough(List<ItemUnifierProxy> cost)
	{
		for (int i = 0; i < cost.Count; i++)
		{
			if (IsPlayerAttributeCost(cost[i].Id))
			{
				if (G.TryGetAttribute(cost[i].Id) < cost[i].Count)
				{
					return false;
				}
				continue;
			}
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(cost[i].Id);
			if (itemInfo == null || itemInfo.Count < cost[i].Count)
			{
				return false;
			}
		}
		return true;
	}

	private static bool IsPlayerAttributeCost(int itemId)
	{
		if (itemId != 2)
		{
			return itemId == 112;
		}
		return true;
	}

	public static bool PreNodeIsUnLock(Character character, SkillGroupData skillGroupInfo)
	{
		int[] frontPoint = skillGroupInfo.frontPoint;
		foreach (int key in frontPoint)
		{
			if (!character.SkillGroupLevels.ContainsKey(key))
			{
				return false;
			}
		}
		return true;
	}

	public static bool ReachBreakLevel(Character character, SkillGroupLevelData levelData)
	{
		return levelData.stageBreakLevel <= character.Stage;
	}

	public static bool ReachCharacterLevel(Character character, SkillGroupLevelData levelData)
	{
		return levelData.requireCharacterLevel <= character.Level;
	}

	public static bool SkillPointIsEnough(Character character, SkillGroupLevelData levelData)
	{
		return levelData.skillPointCost <= character.SkillPoint;
	}

	public static bool CoinIsEnough(SkillGroupLevelData levelData)
	{
		ItemKv itemKv = levelData.cost.FirstOrDefault((ItemKv x) => x.id == 2);
		if (itemKv != null)
		{
			return itemKv.count <= G.TryGetAttribute(2);
		}
		return true;
	}

	public static bool MatIsEnough(SkillGroupLevelData levelData)
	{
		foreach (ItemKv item in levelData.cost)
		{
			if (G.localPlayer.Inventory.GetItemCount(item.id) < item.count)
			{
				return false;
			}
		}
		return true;
	}

	public static int GetMaxAdventureLevel(int worldLevel)
	{
		KeyValuePair<int, PlayerLevelData> keyValuePair = RuntimeConfigs.data.playerLevelDatas.Last();
		if (worldLevel == keyValuePair.Value.worldLevelMax)
		{
			return keyValuePair.Key;
		}
		for (int num = keyValuePair.Key - 1; num >= 0; num--)
		{
			if (RuntimeConfigs.data.playerLevelDatas[num].worldLevelMax == worldLevel)
			{
				return RuntimeConfigs.data.playerLevelDatas[num + 1].id;
			}
		}
		return -1;
	}

	public static int GetRaidBossChallengePoint(int raidId)
	{
		int num = Mathf.FloorToInt((float)raidId / 100f);
		foreach (KeyValuePair<int, WorldBossMonster> worldBossMonster in RuntimeConfigs.data.worldBossMonsters)
		{
			if (worldBossMonster.Value.worldBossRaidId == num)
			{
				return worldBossMonster.Value.id;
			}
		}
		return 0;
	}

	public static float GetMonsterDeadUltraEnergyRecoveryValue(EntityType entityType)
	{
		int[][] monsterDeadUltraEnergyRecovery = RuntimeConfigs.data.game.monsterDeadUltraEnergyRecovery;
		foreach (int[] array in monsterDeadUltraEnergyRecovery)
		{
			if (array[0] == (int)entityType)
			{
				return array[1];
			}
		}
		return 0f;
	}

	public static bool HasEntityType(this FilterEntityType filterEntityType, EntityType entityType)
	{
		return entityType switch
		{
			EntityType.Null => false, 
			EntityType.Character => filterEntityType.HasFlag(FilterEntityType.Character), 
			EntityType.Monster => filterEntityType.HasFlag(FilterEntityType.Monster), 
			EntityType.Boss => filterEntityType.HasFlag(FilterEntityType.Boss), 
			EntityType.Robot => filterEntityType.HasFlag(FilterEntityType.Robot), 
			EntityType.Trajectory => filterEntityType.HasFlag(FilterEntityType.Trajectory), 
			EntityType.Npc => filterEntityType.HasFlag(FilterEntityType.Npc), 
			EntityType.Elite => filterEntityType.HasFlag(FilterEntityType.Elite), 
			EntityType.StateObject => filterEntityType.HasFlag(FilterEntityType.StateObject), 
			EntityType.AssistNpc => filterEntityType.HasFlag(FilterEntityType.Monster), 
			_ => false, 
		};
	}

	public static bool HasCharacterDamageType(this FilterCharacterDamageType filterCharacterDamageType, CharacterDamageType damageType)
	{
		return damageType switch
		{
			CharacterDamageType.Null => false, 
			CharacterDamageType.Striker => filterCharacterDamageType.HasFlag(FilterCharacterDamageType.Striker), 
			CharacterDamageType.Breaker => filterCharacterDamageType.HasFlag(FilterCharacterDamageType.Breaker), 
			CharacterDamageType.AssistStriker => filterCharacterDamageType.HasFlag(FilterCharacterDamageType.AssistStriker), 
			_ => false, 
		};
	}

	public static bool HasCharacterFrequencyType(this FilterCharacterFrequencyType filterCharacterFrequencyType, FilterCharacterFrequencyType frequencyType)
	{
		if (frequencyType == FilterCharacterFrequencyType.Null)
		{
			return false;
		}
		return (filterCharacterFrequencyType & frequencyType) != 0;
	}

	public static FilterCharacterFrequencyType ToCharacterFrequencyFlags(int[] types)
	{
		if (types == null || types.Length == 0)
		{
			return FilterCharacterFrequencyType.Null;
		}
		FilterCharacterFrequencyType filterCharacterFrequencyType = FilterCharacterFrequencyType.Null;
		for (int i = 0; i < types.Length; i++)
		{
			switch (types[i])
			{
			case 1:
				filterCharacterFrequencyType |= FilterCharacterFrequencyType.Echo;
				break;
			case 2:
				filterCharacterFrequencyType |= FilterCharacterFrequencyType.Resonance;
				break;
			case 3:
				filterCharacterFrequencyType |= FilterCharacterFrequencyType.Noise;
				break;
			}
		}
		return filterCharacterFrequencyType;
	}

	public static bool HasCharacterMannerType(this FilterMannerType filterMannerType, MannerType mannerType)
	{
		return mannerType switch
		{
			MannerType.Breaker => filterMannerType.HasFlag(FilterMannerType.Breaker), 
			MannerType.Ranger => filterMannerType.HasFlag(FilterMannerType.Ranger), 
			MannerType.Insight => filterMannerType.HasFlag(FilterMannerType.Insight), 
			MannerType.Strategist => filterMannerType.HasFlag(FilterMannerType.Strategist), 
			MannerType.Generalist => filterMannerType.HasFlag(FilterMannerType.Generalist), 
			_ => false, 
		};
	}

	public static bool FilterCantBeAttack(this FilterCantBeAttackType filterCantBeAttackType, Entity target)
	{
		if (filterCantBeAttackType.HasFlag(FilterCantBeAttackType.Property))
		{
			return !target.CantBeAttack();
		}
		if (filterCantBeAttackType.HasFlag(FilterCantBeAttackType.EntityIgnoreAttack))
		{
			return !target.InTag(EntityTag.IgnoreAttack);
		}
		CompMotion component;
		if (filterCantBeAttackType.HasFlag(FilterCantBeAttackType.MotionInvincibility))
		{
			return !target.TryGetCompMotion(out component) || (!component.InTag(MotionTag_backUp.Invincibility) && !component.InTag(MotionTag_backUp.TrueInvincible));
		}
		CompAbility component2;
		if (filterCantBeAttackType.HasFlag(FilterCantBeAttackType.AbilityInvincibility))
		{
			return !target.TryGetCompAbility(out component2) || (!component2.HasAbilityCustomTag("INVINCIBLE") && !component2.HasAbilityCustomTag("TRUEINVINCIBLE"));
		}
		return true;
	}

	public static Alliance GetAlliance(AllianceCondition condition, Alliance alliance)
	{
		return condition switch
		{
			AllianceCondition.Character => Alliance.Character, 
			AllianceCondition.Owner => alliance, 
			AllianceCondition.OwnerEnemy => alliance.GetOp(), 
			_ => Alliance.Enemy, 
		};
	}

	public static async UniTask<bool> PingNetAddress(string pingUrl = "10.0.50.221", int timeOut = 3)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("正在ping" + pingUrl);
		}
		Ping ping = new Ping(pingUrl);
		float timer = 0f;
		while (!ping.isDone && timer < (float)timeOut)
		{
			await UniTask.Yield();
			timer += Time.unscaledDeltaTime;
			if (ping.isDone)
			{
				return true;
			}
		}
		return false;
	}

	public static async UniTask<bool> PingNetAddressViaUnityWeb(string pingUrl)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("正在ping" + pingUrl);
		}
		UnityWebRequest webRequest = UnityWebRequest.Get(pingUrl);
		try
		{
			await webRequest.SendWebRequest().ToUniTask();
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
		switch (webRequest.result)
		{
		case UnityWebRequest.Result.ConnectionError:
			return false;
		case UnityWebRequest.Result.Success:
		case UnityWebRequest.Result.ProtocolError:
		case UnityWebRequest.Result.DataProcessingError:
			return true;
		default:
			return false;
		}
	}

	public static void QuitGame()
	{
		Application.Quit(0);
	}

	public static string ByteConverter(long byteSize, string[] formatters)
	{
		float num = byteSize;
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[0]) + "KB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[1]) + "MB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[2]) + "GB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[3]) + "TB";
		}
		return string.Empty;
	}

	public static bool IsInView(Vector3 worldPos)
	{
		Transform transform = mainCamera.transform;
		Vector2 vector = mainCamera.WorldToViewportPoint(worldPos);
		Vector3 normalized = (worldPos - transform.position).normalized;
		if (Vector3.Dot(transform.forward, normalized) > 0f && vector.x >= 0f && vector.x <= 1f && vector.y >= 0f && vector.y <= 1f)
		{
			return true;
		}
		return false;
	}

	public static bool GetSkillGroupLevel(int skillGroupId, out int level)
	{
		foreach (Character curAllCharacter in CharacterDataHelper.GetCurAllCharacters())
		{
			if (curAllCharacter.SkillGroupLevels.ContainsKey(skillGroupId))
			{
				level = curAllCharacter.GetSkillGroupEventualLevel(skillGroupId);
				return true;
			}
		}
		level = 0;
		return false;
	}

	public static bool canDelete(bool isEquip, int id, ItemUIComponent cell)
	{
		bool canBeDelete = RuntimeConfigs.data.itemDatas[id].canBeDelete;
		if (!isEquip & canBeDelete)
		{
			return !cell.isLock;
		}
		return false;
	}

	public static void SetCameraLayerDialog(bool isTimeline)
	{
		if (isTimeline)
		{
			mainCamera.cullingMask &= -32769;
			mainCamera.cullingMask &= -2097153;
		}
		else
		{
			mainCamera.cullingMask |= 32768;
			mainCamera.cullingMask |= 2097152;
		}
	}

	public static float GetMaxCurveValue(AnimationCurve curve)
	{
		if (curve == null)
		{
			return 0f;
		}
		Keyframe[] keys = curve.keys;
		if (keys == null || keys.Length == 0)
		{
			return 0f;
		}
		float num = keys[0].value;
		for (int i = 1; i < keys.Length; i++)
		{
			float value = keys[i].value;
			if (value > num)
			{
				num = value;
			}
		}
		return num;
	}

	public static ACT.World.MapArea GetMainMapArea()
	{
		SceneInfo sceneInfo = G.localPlayer.Profile.SceneInfos[0];
		return Singleton<GameManager>.instance.worldManager.GetMapAreaByChunkId(sceneInfo.ChunkID, SceneStatus.Main);
	}

	public static async UniTask PlayOpeningPreformance()
	{
		RaidPerformanceConfig raidPreformanceConfig = GameLoader.raidPerformanceConfig;
		if (!(raidPreformanceConfig == null) && !(raidPreformanceConfig.OpeningPrefrmanceTimeline == null))
		{
			MonoECS.instance.PushPauseInput();
			MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.Timeline);
			PlayableDirector timelineImmediately = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(raidPreformanceConfig.OpeningPrefrmanceTimeline);
			MonoTimelineConfig component = timelineImmediately.GetComponent<MonoTimelineConfig>();
			if (component.timelineConfig.useNewAssetsBindings)
			{
				TimelineTrackBinding.SetTrackBinding(timelineImmediately, component.timelineConfig.newAssetsBindings);
			}
			else
			{
				OldTimelineTrackBinding.SetTrackBinding(timelineImmediately, component.timelineConfig.assetsBindings);
			}
			timelineImmediately.transform.position = MonoECS.instance.mainEntity.GetRootTransform().position;
			timelineImmediately.Play();
			await UniTask.Delay(TimeSpan.FromSeconds(timelineImmediately.playableAsset.duration));
			MonoECS.instance.PopPauseInput();
			MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.Timeline);
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(raidPreformanceConfig.OpeningPrefrmanceTimeline);
			await UniTask.CompletedTask;
		}
	}

	public static async UniTask PlaySettlementPreformance(RaidPerformanceConfig raidPerformanceConfig)
	{
		if (!(raidPerformanceConfig == null) && !(raidPerformanceConfig.SettlementPreformanceTimeline == null) && raidPerformanceConfig.SettlementTimeScale != null)
		{
			MonoECS.instance.PushPauseInput();
			MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.Timeline);
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_BATTLEMAIN);
			PlayableDirector timelineImmediately = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(raidPerformanceConfig.SettlementPreformanceTimeline);
			MonoTimelineConfig component = timelineImmediately.GetComponent<MonoTimelineConfig>();
			if (component.timelineConfig.useNewAssetsBindings)
			{
				TimelineTrackBinding.SetTrackBinding(timelineImmediately, component.timelineConfig.newAssetsBindings);
			}
			else
			{
				OldTimelineTrackBinding.SetTrackBinding(timelineImmediately, component.timelineConfig.assetsBindings);
			}
			timelineImmediately.transform.position = MonoECS.instance.mainEntity.GetRootTransform().position;
			timelineImmediately.Play();
			await PlayAnimationCurve(raidPerformanceConfig.SettlementTimeScale, (float value) =>
			{
				value = Mathf.Max(0f, value);
				GameManager.timeSystem.ForceChangeGlobalSpeed(value);
			}, () =>
			{
				MonoECS.instance.PopPauseInput();
				MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.Timeline);
				GameManager.timeSystem.ForceChangeGlobalSpeed(1f);
				Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(raidPerformanceConfig.SettlementPreformanceTimeline);
			});
			await UniTask.CompletedTask;
		}
	}

	public static async UniTask PlayBattleRoomPerformance(RaidPerformanceConfig raidPerformanceConfig)
	{
		await PlaySettlementPreformance(raidPerformanceConfig);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
		await UniTask.CompletedTask;
	}

	public static async UniTask PlayAnimationCurve(AnimationCurve animationCurve, Action<float> onUpdate = null, Action onComplete = null)
	{
		if (animationCurve == null)
		{
			onComplete?.Invoke();
			return;
		}
		float curTime = 0f;
		float maxTime = animationCurve.keys[animationCurve.length - 1].time;
		while (curTime <= maxTime)
		{
			onUpdate?.Invoke(animationCurve.Evaluate(curTime));
			curTime += Time.deltaTime;
			if (curTime >= maxTime)
			{
				onComplete?.Invoke();
				return;
			}
			await UniTask.DelayFrame(1);
		}
		await UniTask.CompletedTask;
	}

	public static bool RuntimeGuidIsValid(string guid)
	{
		if (string.IsNullOrEmpty(guid))
		{
			return false;
		}
		return YooAssets.GetPackage("Assets").CheckLocationValid(guid);
	}

	public static int GetCharacterQuality(int characterId)
	{
		return G.localPlayer.GetCharacter(characterId).GetQuality();
	}

	public static int GetBagCharacterQuality(int characterId)
	{
		CharacterDataHelper.TryGetBagCharacterById(characterId, out var character);
		return character?.GetQuality() ?? 0;
	}

	public static bool CanInteract()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity == null)
		{
			return false;
		}
		MotionState stateType = mainEntity.GetCompMotion().layer0Peak.state.value.stateType;
		if (stateType != MotionState.Idle && stateType != MotionState.Move)
		{
			return false;
		}
		foreach (Ability ability in mainEntity.GetCompAbility().abilities)
		{
			ConfigAbility config = ability.config;
			if (config == null || (config.buffTag & BuffTag.CantInteract) != 0)
			{
				return false;
			}
		}
		return true;
	}

	public static void ModifyMonsterPointLevel(SpawnMonsterParams smp)
	{
		if (smp.levelOverride)
		{
			smp.level = Mathf.Clamp(smp.level, 1, 120);
		}
		else if (smp.levelType != -1)
		{
			if (smp.levelType == 0)
			{
				smp.level += GetMonsterPointWorldLevel(smp.monsterPointId);
			}
			else if (smp.levelType == 1)
			{
				smp.level = Mathf.Clamp(RuntimeConfigs.data.enemySpawns.TryGetValue(smp.monsterPointId, out var value) ? value.enemyLevelOffset : smp.level, 1, 120);
			}
			else if (smp.levelType == 2)
			{
				smp.level = GetMonsterPointRogueLevel(smp.id);
			}
		}
	}

	public static int GetMonsterPointWorldLevel(int monsterPointId)
	{
		int result = 0;
		try
		{
			if (Model<WorldLevelModel>.Interface.GetCurWorldLevel() == 1)
			{
				return result;
			}
			int num = 2;
			int num2 = Model<WorldLevelModel>.Interface.GetCurWorldLevel() - num;
			if (num2 < 0)
			{
				num2 = 0;
			}
			result = RuntimeConfigs.data.enemySpawns[monsterPointId].worldEnemyLevel[num2];
		}
		catch (Exception)
		{
		}
		return result;
	}

	public static int GetMonsterPointRogueLevel(int id)
	{
		int rogueMapnode = GetRogueMapnode();
		if (RuntimeConfigs.data.mapNodeConfigs.TryGetValue(rogueMapnode, out var value))
		{
			switch (GetEntityType(id))
			{
			case EntityType.Monster:
				return value.minionLevel;
			case EntityType.Elite:
				return value.eliteLevel;
			case EntityType.Boss:
				return value.bossLevel;
			}
		}
		return 1;
	}

	public static int GetRogueMapnode()
	{
		RogueGameInfo gameInfo = Model<RogueNewModel>.Interface.Info.GameInfo;
		RogueMode data = CoreUtils.GetData(gameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (data == null)
		{
			return 1;
		}
		if (data.mapNodeList.Length <= gameInfo.Index)
		{
			return 1;
		}
		return data.mapNodeList[gameInfo.Index];
	}

	public static EntityType GetEntityType(int id)
	{
		return RuntimeConfigs.data.entityDatas[id].type switch
		{
			1 => EntityType.Character, 
			2 => EntityType.Monster, 
			3 => EntityType.Boss, 
			4 => EntityType.Robot, 
			5 => EntityType.Npc, 
			6 => EntityType.Elite, 
			7 => EntityType.AssistNpc, 
			_ => EntityType.Null, 
		};
	}

	public static void ModifyMonsterPointAI(SpawnMonsterParams smp)
	{
		if (smp != null)
		{
			if (TryGetEnemySpawnTableAI(smp.monsterPointId, out var aiIndex))
			{
				smp.aiIndex = aiIndex;
			}
			else if (smp.levelType == 0)
			{
				smp.aiIndex = GetMonsterPointWorldAI(smp.monsterPointId);
			}
		}
	}

	public static bool TryGetEnemySpawnTableAI(int monsterPointId, out int aiIndex)
	{
		aiIndex = 0;
		if (RuntimeConfigs.data?.enemySpawns == null || !RuntimeConfigs.data.enemySpawns.TryGetValue(monsterPointId, out var value) || !value.useEnemyAi)
		{
			return false;
		}
		aiIndex = value.enemyAi;
		return true;
	}

	public static int GetMonsterPointWorldAI(int monsterPointId)
	{
		int result = 0;
		try
		{
			int num = 2;
			int num2 = Model<WorldLevelModel>.Interface.GetCurWorldLevel() - num;
			if (num2 < 0)
			{
				num2 = 0;
			}
			result = RuntimeConfigs.data.enemySpawns[monsterPointId].worldEnemyAi[num2];
		}
		catch (Exception)
		{
		}
		return result;
	}

	public static void FillRewardItemUnifierProxies(IList<UniversalItem> universalItems, List<ItemUnifierProxy> output)
	{
		if (universalItems == null || output == null)
		{
			return;
		}
		foreach (UniversalItem item in ItemUnifierMerger.MergeUniversalItems(universalItems))
		{
			if (item.Count == 0)
			{
				RepeatedField<UniversalItem> extraItems = item.ExtraItems;
				if (extraItems != null && extraItems.Count > 0)
				{
					foreach (UniversalItem extraItem in item.ExtraItems)
					{
						ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(extraItem.Index, extraItem.Count);
						itemUnifierProxy.RewardTag = extraItem.Tag;
						output.Add(itemUnifierProxy);
					}
					continue;
				}
			}
			if (item.Count > 0)
			{
				ItemUnifierProxy itemUnifierProxy2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.Index, item.Count);
				itemUnifierProxy2.RewardTag = item.Tag;
				output.Add(itemUnifierProxy2);
			}
		}
	}

	public static CommonWorldSuccessView.CommonWorldSuccessData CreateWorldSuccessRewardData(IList<UniversalItem> universalItems)
	{
		List<ItemUnifierProxy> list = ListPool<ItemUnifierProxy>.Get();
		FillRewardItemUnifierProxies(universalItems, list);
		return new CommonWorldSuccessView.CommonWorldSuccessData
		{
			rewardItemProxies = list
		};
	}

	public static void OpenPopReward(IList<UniversalItem> universalItems, bool notSort = false, Action callBack = null)
	{
		if (universalItems == null || universalItems.Count <= 0)
		{
			callBack?.Invoke();
			return;
		}
		List<UniversalItem> skinItems = universalItems.Where((UniversalItem item) => item != null && item.Type == UniversalItemType.UniversalItemSkin).ToList();
		List<UniversalItem> otherItems = universalItems.Where((UniversalItem item) => item == null || item.Type != UniversalItemType.UniversalItemSkin).ToList();
		Action callBack2 = () =>
		{
			if (otherItems.Count == 0)
			{
				callBack?.Invoke();
			}
			else
			{
				OpenPopRewardDataInternal(otherItems, notSort, callBack);
			}
		};
		OpenSkinPopReward(skinItems, callBack2);
	}

	private static void OpenPopRewardDataInternal(IList<UniversalItem> universalItems, bool notSort, Action callBack)
	{
		PopUpRewardOneRowData popUpRewardOneRowData = new PopUpRewardOneRowData
		{
			itemSource = universalItems
		};
		popUpRewardOneRowData.callBack = (Action)Delegate.Combine(popUpRewardOneRowData.callBack, callBack);
		OpenPopRewardData(popUpRewardOneRowData, BuildCharacterShowItems(universalItems));
	}

	public static List<Item> ToItems(this IList<UniversalItem> universalItems)
	{
		List<Item> list = new List<Item>();
		foreach (UniversalItem universalItem in universalItems)
		{
			if (universalItem.Count != 0)
			{
				list.Add(new Item
				{
					Id = universalItem.Index,
					Count = universalItem.Count
				});
				continue;
			}
			foreach (UniversalItem extraItem in universalItem.ExtraItems)
			{
				list.Add(new Item
				{
					Id = extraItem.Index,
					Count = extraItem.Count
				});
			}
		}
		return list;
	}

	public static T DeepCloneByOdin<T>(T source)
	{
		if (source == null)
		{
			return default;
		}
		return SerializationUtility.DeserializeValue<T>(SerializationUtility.SerializeValue(source, DataFormat.Binary), DataFormat.Binary);
	}

	public static bool CheckItemQuantityOwnedIsValid(int itemId, int gainCount, out ItemGainsData result)
	{
		result = default;
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return false;
		}
		bool num = data != null && data.stackLimit > 0;
		ACT.Config.ItemType data2 = CoreUtils.GetData(data.type, RuntimeConfigs.data.itemTypes);
		result.curHaveNum = G.localPlayer.Inventory.GetItemCount(itemId);
		result.maxNum = ((data != null && data.stackLimit > 1) ? data.stackLimit : (-1));
		if (num)
		{
			int num2 = data.stackLimit - result.curHaveNum - gainCount;
			if (num2 < 0)
			{
				result.couldGainNum = (result.leftCount = Mathf.Max(0, data.stackLimit - result.curHaveNum));
			}
			else
			{
				result.leftCount = num2;
				result.couldGainNum = gainCount;
			}
		}
		else
		{
			result.leftCount = -1;
			result.couldGainNum = gainCount;
		}
		result.translateResult = data.deleteCompensate;
		if (result.maxNum == -1)
		{
			return true;
		}
		if (!data2.CanOverflowConvert)
		{
			return result.curHaveNum + gainCount < data.stackLimit;
		}
		return result.curHaveNum + gainCount <= data.stackLimit;
	}

	private static async void OpenPopRewardAfterActivePanelIdle(List<UniversalItem> otherItems, bool notSort, Action callBack, AcquireCharacterShowConfig acquireCharacterShowConfig, Action onFinished)
	{
		try
		{
			await UniTask.WaitUntil(CanOpenPopupOnActivePanel);
			IBaseUIController baseUIController = Singleton<NewUIManager>.instance?.GetTopActivePanel();
			if (baseUIController == null || baseUIController.State != UIState.Opened || baseUIController.IsInHideRoot)
			{
				callBack?.Invoke();
			}
			else
			{
				OpenPopReward(otherItems, notSort, callBack);
			}
		}
		finally
		{
			onFinished?.Invoke();
		}
	}

	private static bool CanOpenPopupOnActivePanel()
	{
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance != null)
		{
			return !instance.IsUIManagerBusy();
		}
		return true;
	}

	public static void OpenSkinPopReward(List<UniversalItem> skinItems, Action callBack)
	{
		if (skinItems == null || skinItems.Count <= 0)
		{
			callBack?.Invoke();
		}
		else
		{
			OpenSkinPopRewardByIndex(skinItems, 0, callBack);
		}
	}

	private static void OpenSkinPopRewardByIndex(List<UniversalItem> skinItems, int index, Action callBack)
	{
		if (index >= skinItems.Count)
		{
			callBack?.Invoke();
			return;
		}
		Action action = () =>
		{
			OpenSkinPopRewardByIndex(skinItems, index + 1, callBack);
		};
		int num = ((skinItems[index] != null) ? skinItems[index].Index : 0);
		if (num <= 0)
		{
			action();
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHARACTERSKINACQUIRE, new PopupCharacterSkinAcquireViewData
		{
			SkinId = num,
			CallBack = action
		});
	}
}
