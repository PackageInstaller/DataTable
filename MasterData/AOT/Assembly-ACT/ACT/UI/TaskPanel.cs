using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskPanel : BaseUIView<TaskViewInputController>
{
	public enum MissionTab
	{
		All = 0,
		MainMission = 6,
		SideMission = 24,
		WipeOutMission = 96,
		LegendMission = 128
	}

	[Serializable]
	public class TagInfo
	{
		public ActToggle tab;

		public LocalizedString leftTitleLocalize;

		public MissionTab missionType;

		[NonSerialized]
		public Transform groupRoot;

		[NonSerialized]
		public List<int> missionIds;

		[NonSerialized]
		public List<MainTaskCell> H1;

		[NonSerialized]
		public List<TaskBtnCell> H2;

		private long m_DefaultMissionId;

		public bool m_DefaultVisible = true;

		public bool m_Init;

		public UnityAction<bool> handler;

		public List<(bool isTitle, int id, BetterAnimation animation, CanvasGroup canvasGroup)> AnimationCells { get; } = new List<(bool, int, BetterAnimation, CanvasGroup)>();

		public async UniTask ShowGroup(TaskPanel owner)
		{
			if (!owner._isClosing)
			{
				if (!m_Init)
				{
					m_DefaultVisible = true;
				}
				if ((bool)groupRoot)
				{
					groupRoot.gameObject.SetActive(missionIds.Count > 0);
				}
				await PlayAnimation(owner);
			}
		}

		private async UniTask PlayAnimation(TaskPanel owner)
		{
			if (owner._isClosing)
			{
				return;
			}
			foreach (var animationCell in AnimationCells)
			{
				animationCell.canvasGroup.alpha = 0f;
			}
			foreach (var animationCell2 in AnimationCells)
			{
				BetterAnimation a = animationCell2.animation;
				await UniTask.WaitForSeconds(0.03f);
				if (owner._isClosing)
				{
					return;
				}
				a.GetSequence("NormalShow").Play();
			}
		}

		public void HideGroup()
		{
			if (!m_Init)
			{
				m_DefaultVisible = false;
			}
			if (!groupRoot)
			{
				return;
			}
			foreach (MainTaskCell item in H1)
			{
				item.SetNormal();
			}
			foreach (TaskBtnCell item2 in H2)
			{
				item2.SetSelectWithoutNotify(isOn: false);
				item2.SetNormal();
			}
			groupRoot.gameObject.SetActive(value: false);
		}

		public void SetSelectMission(long missionId)
		{
			m_DefaultMissionId = missionId;
			if (m_Init)
			{
				TaskBtnCell taskBtnCell = H2.Find((TaskBtnCell x) => x.curMissionId.Equals(missionId));
				if (taskBtnCell != null)
				{
					taskBtnCell.isSelect = true;
				}
				else if (H2.Count > 0)
				{
					H2[0].isSelect = true;
				}
			}
		}

		public void OnBtnLoaded(TaskBtnCell cell)
		{
			if (m_Init)
			{
				return;
			}
			if (missionIds.Count == H2.Count)
			{
				if (cell.curMissionId == m_DefaultMissionId)
				{
					cell.isSelect = true;
				}
				m_Init = true;
			}
			else if (cell.curMissionId == m_DefaultMissionId)
			{
				cell.isSelect = true;
				m_Init = true;
			}
		}
	}

	public abstract class MissionViewInfoAdapter
	{
		public abstract int ChapterId { get; }

		public abstract int MissionGroupId { get; }

		public abstract int Name { get; }

		public abstract int TitleDesc { get; }

		public abstract int ContentDesc { get; }

		public abstract int ZoneDesc { get; }

		public abstract int PlaceDesc { get; }

		public abstract int MissionType { get; }

		public abstract int RewardId { get; }

		public abstract bool HasProgress { get; }

		public abstract string ProgressDesc { get; }

		public abstract bool IsReady();

		public abstract bool IsTracing();

		public abstract bool IsFinished();

		public abstract bool IsOld();

		public abstract bool IsInMissionTargetWorld();

		public abstract bool IsMissionBlocked();

		public abstract bool IsSubMissionBlocked();
	}

	public class MissionViewInfoV2Adapter : MissionViewInfoAdapter
	{
		public MissionConfig missionConfig;

		public bool hasProgress;

		public string progressDesc;

		public int MissionId => missionConfig.MissionId;

		public override int ChapterId => missionConfig.ChapterId;

		public override int MissionGroupId => missionConfig.MissionGroupId;

		public override int Name => missionConfig.MissionNameId;

		public override int TitleDesc => missionConfig.MissionTitleDescId;

		public override int ContentDesc => missionConfig.MissionContentDescId;

		public override int ZoneDesc
		{
			get
			{
				if (!RuntimeConfigs.data.mapAreas.TryGetValue(missionConfig.MissionBase.mapArea, out var value))
				{
					return 0;
				}
				return value.name;
			}
		}

		public override int PlaceDesc
		{
			get
			{
				if (!RuntimeConfigs.data.subMapAreas.TryGetValue(missionConfig.MissionBase.subMapArea, out var value))
				{
					return 0;
				}
				return value.name;
			}
		}

		public override int MissionType => missionConfig.MissionType;

		public override int RewardId => missionConfig.RewardId;

		public override bool HasProgress => hasProgress;

		public override string ProgressDesc => progressDesc;

		public override bool IsReady()
		{
			return false;
		}

		public override bool IsTracing()
		{
			return Singleton<MissionManager>.instance.GetTracingMission() == missionConfig.MissionId;
		}

		public override bool IsFinished()
		{
			return Singleton<MissionManager>.instance.IsFinished(missionConfig.MissionId);
		}

		public override bool IsOld()
		{
			return true;
		}

		public override bool IsInMissionTargetWorld()
		{
			return Singleton<GameManager>.instance.worldManager.ActiveWorldId == missionConfig.World;
		}

		public override bool IsMissionBlocked()
		{
			return false;
		}

		public override bool IsSubMissionBlocked()
		{
			return false;
		}
	}

	protected TaskPanelBaseViewData _data;

	public YooAssetReference H1_ReferenceAssetID;

	public YooAssetReference H2_ReferenceAssetID;

	public YooAssetReference H2_Reference_NoTitleAssetID;

	public YooAssetReference H3_ReferenceAssetID;

	public List<TagInfo> tags;

	public GameObject content;

	[Header("MainMission")]
	public GameObject mainMissionDetail;

	public LocalizeStringEvent mainMissionTitle;

	public LocalizeStringEvent mainMissionDesc;

	[Header("SubMission")]
	public GameObject subMissionDetail;

	public LocalizeStringEvent taskText;

	public LocalizeStringEvent taskLocation;

	public LocalizeStringEvent taskLocationDetail;

	public LocalizeStringEvent taskTarget;

	public LocalizeStringEvent targetProcessNow;

	public LocalizeStringEvent taskDetail;

	[Header("通用")]
	public ToggleGroup taskToggleGroup;

	[NonSerialized]
	public TaskBtnCell curSelectMission;

	public List<ItemUIComponentBase> rewards;

	public GameObject TraceBtn;

	public GameObject UnTraceBtn;

	public GameObject rightPanel;

	public PublicToggleGroup toggles;

	public GameObject noTask;

	public CanvasGroup locationText;

	public GameObject blockTextRoot;

	public LocalizeStringEvent blockReasonTextLocalize;

	private TagInfo m_TagAll;

	private TagInfo m_TagMainMission;

	private TagInfo m_TagSideMission;

	private TagInfo m_TagWipeOutMission;

	private TagInfo m_TagLegendMission;

	private TagInfo m_CurrentTag;

	private int _missionId;

	private bool _isClosing;

	[Header("Input Binding")]
	public ViewControlLayer listControlLayer;

	public ViewControlLayer detailControlLayer;

	public ScrollRect ScrollRect;

	public RightStickScrollSupport RightStickScrollSupport;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<int, MissionViewInfoAdapter> m_MissionViewInfoMap = new Dictionary<int, MissionViewInfoAdapter>();

	private readonly List<ConditionDescription> m_SelectedMissionConditionDescriptions = new List<ConditionDescription>();

	private Vector2 _lastNavigateValue;

	private float _navigateHoldStartTime;

	private float _lastRepeatTime;

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public TagInfo TagAll => m_TagAll;

	public TagInfo TagMainMission => m_TagMainMission;

	public TagInfo TagSideMission => m_TagSideMission;

	public TagInfo TagWipeOutMission => m_TagWipeOutMission;

	public TagInfo TagLegendMission => m_TagLegendMission;

	public TagInfo CurrentTag => m_CurrentTag;

	public Dictionary<int, MissionViewInfoAdapter> MissionViewInfoMap => m_MissionViewInfoMap;

	public static int ConvertToMissionIconId(int missionType)
	{
		switch (missionType)
		{
		case 1:
		case 2:
			return 1;
		case 3:
		case 4:
			return 3;
		case 5:
		case 6:
			return 5;
		case 7:
			return 7;
		default:
			throw new IndexOutOfRangeException();
		}
	}

	public static int ConvertToMissionIconId(MissionTab missionType)
	{
		return missionType switch
		{
			MissionTab.MainMission => 1, 
			MissionTab.SideMission => 2, 
			MissionTab.WipeOutMission => 4, 
			MissionTab.LegendMission => 5, 
			_ => throw new IndexOutOfRangeException(), 
		};
	}

	public IReadOnlyList<ConditionDescription> GetSelectedMissionConditionDescriptions()
	{
		return m_SelectedMissionConditionDescriptions;
	}

	private void RefreshSelectedMissionConditionDescriptions(int missionId)
	{
		m_SelectedMissionConditionDescriptions.Clear();
		if (missionId > 0 && m_MissionViewInfoMap.ContainsKey(missionId))
		{
			m_SelectedMissionConditionDescriptions.AddRange(Singleton<MissionManager>.instance.GetMissionDescriptions(missionId));
		}
	}

	public void Track()
	{
		if (curSelectMission != null && curSelectMission.curMissionId > 0)
		{
			ClickTrackBtn();
		}
	}

	public void CycleTab(bool forward)
	{
		if (tags != null && tags.Count != 0)
		{
			int num = ((m_CurrentTag != null) ? tags.IndexOf(m_CurrentTag) : 0);
			int index = (forward ? ((num + 1) % tags.Count) : ((num - 1 + tags.Count) % tags.Count));
			tags[index].tab.SetIsOn(val: true);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/Left_Click");
		}
	}

	protected override async void Init()
	{
		base.Init();
		_isClosing = false;
		Singleton<MissionManager>.instance.RefreshRedDot();
		foreach (TagInfo t in tags)
		{
			switch (t.missionType)
			{
			case MissionTab.All:
				m_TagAll = t;
				t.tab.SetIsOn(val: true);
				break;
			case MissionTab.MainMission:
				m_TagMainMission = t;
				t.tab.SetIsOn(val: false);
				break;
			case MissionTab.SideMission:
				m_TagSideMission = t;
				t.tab.SetIsOn(val: false);
				break;
			case MissionTab.WipeOutMission:
				m_TagWipeOutMission = t;
				t.tab.SetIsOn(val: false);
				break;
			case MissionTab.LegendMission:
				m_TagLegendMission = t;
				t.tab.SetIsOn(val: false);
				break;
			default:
				Close();
				throw new NotImplementedException("没有该任务类型！");
			}
			t.missionIds = ListPool<int>.Get();
			t.H1 = ListPool<MainTaskCell>.Get();
			t.H2 = ListPool<TaskBtnCell>.Get();
			t.handler = (bool x) =>
			{
				OnTabChanged(t, x);
			};
			t.tab.onValueChanged.AddListener(t.handler);
			RedDotItem componentInChildren = t.tab.transform.GetComponentInChildren<RedDotItem>(includeInactive: true);
			if ((bool)componentInChildren)
			{
				componentInChildren.BindTrieNode();
				componentInChildren.UpdateDisplay();
			}
		}
		_data = uiViewData as TaskPanelBaseViewData;
		if (_data != null)
		{
			Mathf.Max(0, _data.missionType - 1);
		}
		_missionId = _data?.missionId ?? 0;
		if (m_MissionViewInfoMap == null)
		{
			m_MissionViewInfoMap = new Dictionary<int, MissionViewInfoAdapter>();
		}
		m_MissionViewInfoMap.Clear();
		List<int> list = new List<int>();
		Singleton<MissionManager>.instance.GetAllMissions(list);
		foreach (int item in list)
		{
			if (!RuntimeConfigs.data.missionBases.TryGetValue(item, out var value))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"表配错了！任务Id{item}找不到");
				}
			}
			else if (value.isValid && !value.isHidden && !Singleton<MissionManager>.instance.IsFinished(item))
			{
				MissionViewInfoV2Adapter missionViewInfoV2Adapter = new MissionViewInfoV2Adapter();
				missionViewInfoV2Adapter.missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(item);
				m_MissionViewInfoMap.TryAdd(item, missionViewInfoV2Adapter);
			}
		}
		foreach (KeyValuePair<int, MissionViewInfoAdapter> item2 in m_MissionViewInfoMap)
		{
			int key = item2.Key;
			switch (item2.Value.MissionType)
			{
			case 1:
			case 2:
				m_TagMainMission.missionIds.Add(key);
				break;
			case 3:
			case 4:
				m_TagSideMission.missionIds.Add(key);
				break;
			case 5:
			case 6:
				m_TagWipeOutMission.missionIds.Add(key);
				break;
			case 7:
				m_TagLegendMission.missionIds.Add(key);
				break;
			}
		}
		m_TagAll.missionIds.AddRange(m_TagMainMission.missionIds);
		m_TagAll.missionIds.AddRange(m_TagSideMission.missionIds);
		m_TagAll.missionIds.AddRange(m_TagWipeOutMission.missionIds);
		m_TagAll.missionIds.AddRange(m_TagLegendMission.missionIds);
		rightPanel.SetActive(value: false);
		foreach (TagInfo tag in tags)
		{
			if (tag.missionType != MissionTab.All)
			{
				LoadOuterPrefab(tag).Forget();
			}
		}
		for (int num = 0; num < tags.Count; num++)
		{
			OnTabChanged(tags[num], open: false);
		}
		OnTabChanged(m_TagAll, open: true);
		TraceBtn.GetComponent<ActButton>().SetBtnClick(ClickTrackBtn);
		UnTraceBtn.GetComponent<ActButton>().SetBtnClick(ClickTrackBtn);
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("Show")?.OnComplete(async (AnimationBuilder _) =>
		{
			if (!_isClosing)
			{
				OpenEffectFinishNew();
				m_TagAll.tab.SetIsOn(val: true);
				m_TagAll.tab.onValueChanged.Invoke(arg0: true);
			}
		}).Play();
		OpenEffectFinishNew();
	}

	protected override void PlayCloseAnimation()
	{
		_isClosing = true;
		AnimationBuilder sequence = betterAnimation.GetSequence("Hide");
		if (sequence == null)
		{
			CloseEffectFinishNew();
			return;
		}
		sequence.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public override void Close()
	{
		_isClosing = true;
		StopOpeningAnimations();
		IBaseUIController uIController = UIController;
		if (uIController != null && uIController.State == UIState.Opening)
		{
			OpenEffectFinishNew();
		}
		base.Close();
	}

	private void StopOpeningAnimations()
	{
		betterAnimation?.StopAnimation();
		if (tags == null)
		{
			return;
		}
		for (int i = 0; i < tags.Count; i++)
		{
			List<(bool, int, BetterAnimation, CanvasGroup)> animationCells = tags[i].AnimationCells;
			for (int j = 0; j < animationCells.Count; j++)
			{
				animationCells[j].Item3?.StopAnimation();
			}
		}
	}

	private async UniTask LoadOuterPrefab(TagInfo toLoad)
	{
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(H1_ReferenceAssetID, content.transform);
		await handle;
		GameObject gameObject = handle.AsGameObject();
		if (_isClosing)
		{
			AssetStationManager.BattleStation.ReleaseInstance(gameObject);
			return;
		}
		gameObject.transform.SetSiblingIndex(tags.IndexOf(toLoad));
		toLoad.groupRoot = gameObject.transform;
		toLoad.groupRoot.gameObject.SetActive(toLoad.m_DefaultVisible);
		TaskGroup component = gameObject.GetComponent<TaskGroup>();
		component.taskPanel = this;
		component.ReloadSecondPrefab(toLoad).Forget();
		if (toLoad.missionIds.Count == 0)
		{
			toLoad.groupRoot.gameObject.SetActive(value: false);
		}
	}

	public void UpdateRightPanel(int missionId)
	{
		RefreshSelectedMissionConditionDescriptions(missionId);
		if (!m_MissionViewInfoMap.TryGetValue(missionId, out var value))
		{
			return;
		}
		if (value.IsInMissionTargetWorld())
		{
			if (value.IsReady())
			{
				UnTraceBtn.SetActive(value.IsTracing());
				TraceBtn.SetActive(!value.IsTracing());
			}
			else
			{
				TraceBtn.SetActive(value: false);
				UnTraceBtn.SetActive(value: false);
			}
		}
		else
		{
			TraceBtn.SetActive(value: false);
			UnTraceBtn.SetActive(value: false);
		}
		subMissionDetail.SetActive(value: true);
		mainMissionDetail.SetActive(value: false);
		taskText.StringReference.TableEntryReference = value.Name;
		taskTarget.StringReference.TableEntryReference = value.TitleDesc;
		taskDetail.StringReference.TableEntryReference = value.ContentDesc;
		if (value.ZoneDesc == 0)
		{
			locationText.gameObject.SetActive(value: false);
		}
		else
		{
			locationText.gameObject.SetActive(value: true);
			taskLocation.StringReference.TableEntryReference = value.ZoneDesc;
			taskLocationDetail.StringReference.TableEntryReference = value.PlaceDesc;
		}
		if (value.HasProgress)
		{
			targetProcessNow.gameObject.SetActive(value: true);
			targetProcessNow.StringReference.GetVariable<string>("0").Value = value.ProgressDesc;
		}
		else
		{
			targetProcessNow.gameObject.SetActive(value: false);
		}
		for (int i = 0; i < rewards.Count; i++)
		{
			rewards[i].gameObject.SetActive(value: false);
		}
		int rewardId = value.RewardId;
		if (RuntimeConfigs.data.collections.TryGetValue(rewardId, out var value2))
		{
			for (int j = 0; j < value2.certain.Count; j++)
			{
				rewards[j].gameObject.SetActive(value: true);
				Item item = new Item();
				item.Id = value2.certain[j].id;
				item.Count = value2.certain[j].count;
				rewards[j].SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				rewards[j].UpdatePerformance();
			}
		}
		else if (rewardId != 0 && LuminApplication.LogEnabled)
		{
			Debug.LogError($"collections找不到{rewardId}!确定任务奖励中有这个id{rewardId}?空奖励rewardId用35");
		}
		if (curSelectMission != null && curSelectMission.curMissionId > 0)
		{
			UpdateTraceBtn();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		ReleaseTagResources();
	}

	private void OnDestroy()
	{
		ReleaseTagResources();
	}

	private void ReleaseTagResources()
	{
		m_SelectedMissionConditionDescriptions.Clear();
		foreach (TagInfo tag in tags)
		{
			if (tag.handler != null)
			{
				tag.tab.onValueChanged.RemoveListener(tag.handler);
				tag.handler = null;
			}
			if (tag.H2 != null)
			{
				foreach (TaskBtnCell item in tag.H2)
				{
					if (item != null)
					{
						AssetStationManager.BattleStation.ReleaseInstance(item.gameObject);
					}
				}
				ListPool<TaskBtnCell>.Release(tag.H2);
				tag.H2 = null;
			}
			if (tag.H1 != null)
			{
				foreach (MainTaskCell item2 in tag.H1)
				{
					if (item2 != null)
					{
						AssetStationManager.BattleStation.ReleaseInstance(item2.gameObject);
					}
				}
				ListPool<MainTaskCell>.Release(tag.H1);
				tag.H1 = null;
			}
			if (tag.missionIds != null)
			{
				ListPool<int>.Release(tag.missionIds);
				tag.missionIds = null;
			}
			if ((bool)tag.groupRoot)
			{
				AssetStationManager.BattleStation.ReleaseInstance(tag.groupRoot.gameObject);
				tag.groupRoot = null;
			}
			tag.m_Init = false;
			tag.SetSelectMission(0L);
			tag.AnimationCells.Clear();
		}
		m_CurrentTag = null;
	}

	public async void OnTabChanged(TagInfo toggle, bool open)
	{
		if (open)
		{
			if (object.Equals(m_CurrentTag, toggle))
			{
				return;
			}
			m_CurrentTag = toggle;
		}
		int tracingMission = Singleton<MissionManager>.instance.GetTracingMission();
		if (toggle.missionType == MissionTab.All)
		{
			IEnumerable<TagInfo> subTabs = tags.Where((TagInfo x) => x.missionType != MissionTab.All);
			if (open)
			{
				bool findMission = false;
				foreach (TagInfo item in subTabs)
				{
					await item.ShowGroup(this);
					if (_isClosing)
					{
						return;
					}
				}
				if (_missionId != 0 && m_MissionViewInfoMap.ContainsKey(_missionId))
				{
					foreach (TagInfo item2 in subTabs)
					{
						if (item2.missionIds.Contains(_missionId))
						{
							item2.SetSelectMission(_missionId);
							findMission = true;
							break;
						}
					}
				}
				_missionId = 0;
				if (!findMission && tracingMission != 0)
				{
					foreach (TagInfo item3 in subTabs)
					{
						if (item3.missionIds.Contains(tracingMission))
						{
							item3.SetSelectMission(tracingMission);
							findMission = true;
							break;
						}
					}
				}
				if (!findMission)
				{
					foreach (TagInfo item4 in subTabs)
					{
						if (item4.missionIds.Count > 0)
						{
							item4.SetSelectMission(item4.missionIds[0]);
							break;
						}
					}
				}
			}
			else
			{
				foreach (TagInfo tag in tags)
				{
					tag.HideGroup();
				}
			}
		}
		else if (m_CurrentTag != TagAll)
		{
			if (open)
			{
				await toggle.ShowGroup(this);
				if (_isClosing)
				{
					return;
				}
				if (tracingMission != 0 && toggle.missionIds.Contains(tracingMission))
				{
					toggle.SetSelectMission(tracingMission);
				}
				else if (toggle.missionIds.Count > 0)
				{
					toggle.SetSelectMission(toggle.missionIds[0]);
				}
			}
			else
			{
				toggle.HideGroup();
			}
		}
		bool flag = toggle.missionIds.Count > 0;
		if (open)
		{
			noTask.SetActive(!flag);
			rightPanel.SetActive(flag);
		}
	}

	public void ClickTrackBtn()
	{
		MissionViewInfoAdapter missionViewInfoAdapter = MissionViewInfoMap[curSelectMission.curMissionId];
		if (!(missionViewInfoAdapter is MissionViewInfoV2Adapter missionViewInfoV2Adapter))
		{
			return;
		}
		if (missionViewInfoAdapter.IsTracing())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/UnTrack");
			if (Singleton<MissionManager>.instance.RequestTracingMission(0) == UpdateTracingMissionResultType.Succeed)
			{
				TraceMission();
			}
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/Track");
			if (Singleton<MissionManager>.instance.RequestTracingMission(missionViewInfoV2Adapter.MissionId) == UpdateTracingMissionResultType.Succeed)
			{
				UnTraceMission();
			}
		}
	}

	private void TraceMission()
	{
		TraceBtn.SetActive(value: true);
		UnTraceBtn.SetActive(value: false);
		foreach (TaskBtnCell item in TagAll.H2)
		{
			item.UpdateTracingState();
		}
	}

	private void UnTraceMission()
	{
		TraceBtn.SetActive(value: false);
		UnTraceBtn.SetActive(value: true);
		foreach (TaskBtnCell item in TagAll.H2)
		{
			item.UpdateTracingState();
		}
	}

	private void UpdateTraceBtn()
	{
		MissionViewInfoAdapter valueOrDefault = MissionViewInfoMap.GetValueOrDefault(curSelectMission.curMissionId);
		if (valueOrDefault != null)
		{
			blockTextRoot.gameObject.SetActive(value: false);
			if (valueOrDefault.IsTracing())
			{
				UnTraceMission();
			}
			else
			{
				TraceMission();
			}
		}
	}

	public void RefreshRedDot()
	{
		Singleton<MissionManager>.instance.RefreshRedDot();
		m_TagMainMission.H2.ForEach((TaskBtnCell taskBtnCell) =>
		{
			taskBtnCell.redDotItem.redDotType = RedDotType.Dot;
			taskBtnCell.redDotItem.fullPath = (RedDotPathDefine.Task + $"|{6}|{taskBtnCell.curMissionId}").Split("|").ToList();
			taskBtnCell.redDotItem.BindTrieNode();
			taskBtnCell.redDotItem.UpdateDisplay();
		});
		m_TagSideMission.H2.ForEach((TaskBtnCell taskBtnCell) =>
		{
			taskBtnCell.redDotItem.redDotType = RedDotType.Dot;
			taskBtnCell.redDotItem.fullPath = (RedDotPathDefine.Task + $"|{24}|{taskBtnCell.curMissionId}").Split("|").ToList();
			taskBtnCell.redDotItem.BindTrieNode();
			taskBtnCell.redDotItem.UpdateDisplay();
		});
		m_TagLegendMission.H2.ForEach((TaskBtnCell taskBtnCell) =>
		{
			taskBtnCell.redDotItem.redDotType = RedDotType.Dot;
			taskBtnCell.redDotItem.fullPath = (RedDotPathDefine.Task + $"|{128}|{taskBtnCell.curMissionId}").Split("|").ToList();
			taskBtnCell.redDotItem.BindTrieNode();
			taskBtnCell.redDotItem.UpdateDisplay();
		});
		m_TagWipeOutMission.H2.ForEach((TaskBtnCell taskBtnCell) =>
		{
			taskBtnCell.redDotItem.redDotType = RedDotType.Dot;
			taskBtnCell.redDotItem.fullPath = (RedDotPathDefine.Task + $"|{96}|{taskBtnCell.curMissionId}").Split("|").ToList();
			taskBtnCell.redDotItem.BindTrieNode();
			taskBtnCell.redDotItem.UpdateDisplay();
		});
	}

	public void SetRedpointState(int missionId)
	{
		if (Singleton<MissionManager>.instance.GetMissionRedpointState(missionId))
		{
			G.localPlayer.redPoints.Missions[missionId] = false;
			RedPoints redPoints = new RedPoints();
			redPoints.Missions.Add(missionId, value: false);
			G.service.RefreshRedDot(redPoints, (bool value) =>
			{
				Singleton<MissionManager>.instance.RefreshRedDot();
			});
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	public void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	public void RefreshRightStickScrollForbid()
	{
		ScrollRect scrollRect = ScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (rightStickScrollSupport == null || scrollRect == null)
		{
			m_canRightStickScroll = scrollRect != null && scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (scrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		}
		bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect scrollRect = ScrollRect;
			if (!(scrollRect == null))
			{
				scrollRect.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
		}
	}
}
