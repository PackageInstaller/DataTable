using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TempleEntranceView : BaseUIView<TempleEntranceViewInputController>
{
	private TempleEntranceViewData m_data;

	[SerializeField]
	private ActButton _closeBtn;

	[Header("左侧列表")]
	[SerializeField]
	private LoopScrollRect _loopScrollRect;

	[Header("右侧")]
	[SerializeField]
	private CommonSubWorldEntranceTitle _title;

	[SerializeField]
	private CommonSubWorldEntranceDescription _descrption;

	[SerializeField]
	private CommonSubWorldEntranceTarget _target;

	[SerializeField]
	private CommonSubWorldEntranceRewards _rewards;

	public GameObject GamepadTipsRoot;

	public Dictionary<TempleEntranceViewControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<TempleEntranceViewControlType, List<GameObject>> ControlPromts;

	public Dictionary<TempleEntranceViewControlType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	private TempleData _templeData;

	private int _recommendLevel;

	private TempleEntranceViewControlType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		_closeBtn.SetBtnClick(CloseAtion);
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		m_data = uiViewData as TempleEntranceViewData;
		InstanceDungeon data = CoreUtils.GetData(m_data.templeId, RuntimeConfigs.data.instanceDungeons);
		_templeData = Model<TempleModel>.Interface.areaTempleDatas[data.area].FirstOrDefault((TempleData i) => i.templeId == m_data.templeId);
		_loopScrollRect.ClearCells();
		_loopScrollRect.OnItemLoad.RemoveAllListeners();
		_loopScrollRect.OnItemLoad.AddListener((ILoopScrollDataSource item) =>
		{
			OnItemLoad(item, _templeData);
		});
		_loopScrollRect.totalCount = 1;
		_loopScrollRect.RefillCells();
		List<int> list = new List<int>();
		List<int> completeIndexs = new List<int>();
		List<ItemUnifierProxy> list2 = new List<ItemUnifierProxy>();
		int num = 0;
		bool value = default;
		for (int num2 = 0; num2 < data.reward.Count; num2++)
		{
			int id = data.reward[num2].id;
			int count = data.reward[num2].count;
			bool flag = (_templeData.stageChallengeTarget != null && _templeData.stageChallengeTarget.TargetReward.TryGetValue(id, out value)) & value;
			list.Add(id);
			if (!RuntimeConfigs.data.collections.TryGetValue(count, out var value2))
			{
				continue;
			}
			foreach (ItemKv item in value2.certain)
			{
				ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(new Item
				{
					Id = item.id,
					Count = item.count
				});
				itemUnifierProxy.RewardTag = (UniversalItemTag)(num2 + 2);
				list2.Add(itemUnifierProxy);
				if (flag)
				{
					completeIndexs.Add(num);
				}
				num++;
			}
		}
		_recommendLevel = _templeData.staticData.recommendedLevel;
		if (RuntimeConfigs.data.instanceDungeonTypes.TryGetValue(_templeData.staticData.type, out var value3) && value3.showRecommendLevel)
		{
			_recommendLevel = -1;
		}
		_title.RefreshUI(data.name, _templeData.isComplate, _recommendLevel, _templeData.completeTime, _templeData.isPerfect);
		_descrption.RefreshUI(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, data.desc));
		_target.RefreshUI(list, _templeData.stageChallengeTarget);
		_rewards.RefreshUI(list2, Station);
		_rewards.OnItemShowAction = (ItemUIComponentBase item) =>
		{
			if ((object)item != null)
			{
				item.IsComplete = completeIndexs.Contains(item.Index);
			}
		};
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Temple/Explore/Open");
		base.Init();
	}

	private void OnItemLoad(ILoopScrollDataSource iSource, TempleData templeData)
	{
		if (iSource is CommonSubWorldEntranceItem commonSubWorldEntranceItem)
		{
			List<int> list = new List<int>();
			for (int i = 0; i < templeData.staticData.reward.Count; i++)
			{
				list.Add(templeData.staticData.reward[i].id);
			}
			commonSubWorldEntranceItem.RefreshUI(commonSubWorldEntranceItem.index, templeData.staticData.name, list, templeData.stageChallengeTarget, isUnLock: true, null);
			commonSubWorldEntranceItem.SetSelect(value: true);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	public void OpenTempleTeam()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAM, new TeamViewData
		{
			source = TeamProfileSource.Temple,
			templeId = m_data.templeId,
			subWorldCharacters = Model<TempleModel>.Interface.GetTeamCharacterIds(m_data.templeId),
			potionId = Model<TempleModel>.Interface.GetTeamPotionId(m_data.templeId),
			RecommendLevel = _recommendLevel,
			closeAction = async () =>
			{
				MonoECS.instance.SyncGameInfos();
				TeamUsage teamUsage = new TeamUsage
				{
					BattleCharacterIdx = 0,
					EquipPotionId = Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId
				};
				int[] templeCharactersId = Model<TeamModel>.Interface.templeCharactersId;
				foreach (int characterId in templeCharactersId)
				{
					TeamCharacterUsage item = new TeamCharacterUsage
					{
						CharacterId = characterId,
						IsTrial = false
					};
					teamUsage.CharacterUsage.Add(item);
				}
				G.service.EnterTempleChallenge(m_data.templeId, teamUsage, (bool b) =>
				{
					if (b)
					{
						Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Temple).Forget();
					}
					else if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"进入神庙[{m_data.templeId}]失败!!!");
					}
				});
			}
		});
	}

	public TempleData GetTempleData()
	{
		return _templeData;
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	private void CloseAtion()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	public override void Close()
	{
		base.Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		ChangeControlType(ControlType);
	}

	public void ChangeControlType(TempleEntranceViewControlType controlType)
	{
		TempleEntranceViewControlType controlType2 = ControlType;
		ControlType = controlType;
		ControlLayerDic[controlType].ReFocus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[controlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType2].Count; j++)
		{
			ControlPromts[controlType2][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[controlType].Count; k++)
		{
			ControlPromts[controlType][k].SetActive(value: true);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
	}

	public void HandleConfirm()
	{
		if (ControlType == TempleEntranceViewControlType.Main)
		{
			OpenTempleTeam();
		}
		else if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}
}
