using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class NPCRaidView : BaseUIView<NPCRaidViewInputController>
{
	public ActButton CloseButton;

	public GameObject GoldExp_Skill;

	public GameObject GoldExpObj;

	public TextMeshProUGUI GoldExpTitle;

	public List<RaidEntranceItem> GoldExpEntranceItem;

	public GameObject SkillObj;

	public TextMeshProUGUI Skill_Title;

	public List<RaidEntranceItem> SkillEntranceItem;

	public GameObject EliteObj;

	public List<RaidEntranceItem> EliteEntranceItem;

	public TextMeshProUGUI EliteCurCount;

	public TextMeshProUGUI EliteTotalCount;

	public GameObject BossObj;

	public List<RaidEntranceItem> BossEntranceItem;

	public GameObject GamepadTipsRoot;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ParkourViewControlLayer;

	private int _currentRaidTypeID = -1;

	private Dictionary<int, RaidEntranceItem> _raidEntranceItems = new Dictionary<int, RaidEntranceItem>();

	protected override void AddEventListener()
	{
		base.AddEventListener();
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
		base.Init();
		CloseButton.SetBtnClick(Close);
		if (uiViewData != null)
		{
			_currentRaidTypeID = (int)uiViewData;
		}
		RefreshUI();
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Open_1");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		if (uiViewData != null)
		{
			switch ((int)uiViewData)
			{
			case 3:
				PlayEliteAnimation();
				break;
			case 8:
				PlayBossAnimation();
				break;
			}
		}
	}

	private async void PlayEliteAnimation()
	{
		for (int i = 0; i < EliteEntranceItem.Count; i++)
		{
			EliteEntranceItem[i].PlayAnimation();
			await UniTask.Delay(3);
		}
	}

	private async void PlayBossAnimation()
	{
		for (int i = 0; i < BossEntranceItem.Count; i++)
		{
			BossEntranceItem[i].PlayAnimation();
			await UniTask.Delay(3);
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
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

	private void RefreshUI()
	{
		if (!RuntimeConfigs.data.raidTypeDatas.TryGetValue(_currentRaidTypeID, out var value))
		{
			return;
		}
		if (value.raidType == 1 || value.raidType == 7)
		{
			GoldExp_Skill.SetActive(value: true);
			if (RuntimeConfigs.data.raidTypeDatas.TryGetValue(1, out var value2))
			{
				GoldExpObj.SetActive(value: true);
				GoldExpTitle.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value2.typeName);
				for (int i = 0; i < GoldExpEntranceItem.Count; i++)
				{
					if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value2.raidEntranceId[i], out var value3))
					{
						if (value3.unlockCondition <= 0)
						{
							_ = 1;
						}
						else
							Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value3.unlockCondition);
						bool flag = i < value2.raidEntranceId.Length;
						GoldExpEntranceItem[i].gameObject.SetActive(flag);
						if (flag)
						{
							GoldExpEntranceItem[i].RefreshUI(value3, OnClickItemButtonHandle, i, 7);
						}
					}
				}
			}
			if (RuntimeConfigs.data.raidTypeDatas.TryGetValue(2, out var value4))
			{
				SkillObj.SetActive(value: true);
				Skill_Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value4.typeName);
				for (int j = 0; j < SkillEntranceItem.Count; j++)
				{
					if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value4.raidEntranceId[j], out var value5))
					{
						if (value5.unlockCondition <= 0)
						{
							_ = 1;
						}
						else
							Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value5.unlockCondition);
						bool flag2 = j < value4.raidEntranceId.Length;
						SkillEntranceItem[j].gameObject.SetActive(flag2);
						if (flag2)
						{
							SkillEntranceItem[j].RefreshUI(value5, OnClickItemButtonHandle, j, 1);
						}
					}
				}
			}
			ParkourViewControlLayer.Focus();
		}
		else if (value.raidType == 3)
		{
			if (!RuntimeConfigs.data.raidTypeDatas.TryGetValue(3, out var value6))
			{
				return;
			}
			EliteObj.SetActive(value: true);
			for (int k = 0; k < EliteEntranceItem.Count; k++)
			{
				if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value6.raidEntranceId[k], out var value7))
				{
					if (value7.unlockCondition <= 0)
					{
						_ = 1;
					}
					else
						Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value7.unlockCondition);
					bool flag3 = k < value6.raidEntranceId.Length;
					EliteEntranceItem[k].gameObject.SetActive(flag3);
					if (flag3)
					{
						EliteEntranceItem[k].RefreshUI(value7, OnClickItemButtonHandle, k, value.raidType);
					}
				}
			}
			if (value6.cycleParm.Length >= 0)
			{
				EliteCurCount.text = GetLeftTimesByTypeId(3).ToString();
				EliteTotalCount.text = value6.cycleParm[1].ToString();
			}
		}
		else
		{
			if (value.raidType != 8)
			{
				return;
			}
			BossObj.SetActive(value: true);
			List<RaidTypeData> list = new List<RaidTypeData>();
			foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
			{
				if (raidTypeData.Value.raidType == 8)
				{
					list.Add(raidTypeData.Value);
				}
			}
			for (int l = 0; l < list.Count; l++)
			{
				if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(list[l].raidEntranceId[0], out var value8))
				{
					if (value8.unlockCondition <= 0)
					{
						_ = 1;
					}
					else
						Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value8.unlockCondition);
					bool flag4 = l < list.Count;
					BossEntranceItem[l].gameObject.SetActive(flag4);
					if (flag4)
					{
						BossEntranceItem[l].RefreshUI(value8, OnClickItemButtonHandle, l, value.raidType);
					}
				}
			}
		}
	}

	private async void OnClickItemButtonHandle(RaidEntranceData raidEntranceData)
	{
		if (raidEntranceData.raidType == 99)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST);
			return;
		}
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_RAID, new MonoRaidViewData
		{
			RaidEntranceId = raidEntranceData.id
		});
	}

	private int GetUsedTimesByEnteranceId(int entranceId)
	{
		RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[entranceId];
		int num = 0;
		int[] raidId = raidEntranceData.raidId;
		foreach (int raidId2 in raidId)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId2);
			if (raidInfo != null)
			{
				num += raidInfo.TakeRewardCount;
			}
		}
		return num;
	}

	private int GetLeftTimesByTypeId(int typeId)
	{
		int num = 0;
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[typeId];
		int num2 = 0;
		int[] raidEntranceId = raidTypeData.raidEntranceId;
		foreach (int entranceId in raidEntranceId)
		{
			num2 += GetUsedTimesByEnteranceId(entranceId);
		}
		num = raidTypeData.cycleParm[1] - num2;
		return Mathf.Max(0, num);
	}

	public void OnInputControllerActivate()
	{
		ParkourViewControlLayer.ReFocus();
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
	}

	public void HandleConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}
}
