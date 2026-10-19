using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class RaidItem : LoopScrollBaseItem
{
	public GameObject Normal;

	public LocalizeStringEvent NormalTitle;

	public LocalizeStringEvent NormalTips;

	public GameObject Select;

	public LocalizeStringEvent SelectTitle;

	public LocalizeStringEvent SelectTips;

	public GameObject Disable;

	public GameObject DisableDi;

	public GameObject DisableDiSelect;

	public LocalizeStringEvent DisableTitle;

	public LocalizeStringEvent DisableTips;

	public GameObject SelectGameObject;

	public ActButton ItemButton;

	public Image NormalBG;

	public Image SelectBG;

	public Image DisableBG;

	public BetterAnimation BetterAnimation;

	public List<CanvasGroup> CanvasGroups;

	public GameObject FirstFree;

	public GameObject RecordObj;

	public TextMeshProUGUI curNum;

	public TextMeshProUGUI maxNum;

	public GameObject RecordIconGold;

	public GameObject RecordIconExp;

	public Color PerfectColor;

	public Color NormalColor;

	private int _raidEntranceId;

	private bool _isUnLock;

	private bool _isSelect;

	private ACT.Config.Raid _raidConfig;

	private Color disableSelectColor = Color.white;

	private Color disableColor = new Color(127f / 255f, 127f / 255f, 127f / 255f);

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		RefreshUI(idx);
	}

	private void RefreshUI(int index)
	{
		MonoRaidView monoRaidView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_RAID) as MonoRaidView;
		if (monoRaidView == null)
		{
			return;
		}
		_raidEntranceId = monoRaidView.GetEntranceID();
		ACT.Config.Raid raidInfo = monoRaidView.GetRaidInfo(index);
		if (raidInfo == null)
		{
			return;
		}
		_raidConfig = raidInfo;
		NormalTitle.StringReference.TableEntryReference = raidInfo.raidName;
		SelectTitle.StringReference.TableEntryReference = raidInfo.raidName;
		DisableTitle.StringReference.TableEntryReference = raidInfo.raidName;
		NormalTips.StringReference.TableEntryReference = 622L;
		NormalTips.StringReference.GetVariable<int>("0").Value = raidInfo.recommendTeamLevel;
		SelectTips.StringReference.TableEntryReference = 622L;
		SelectTips.StringReference.GetVariable<int>("0").Value = raidInfo.recommendTeamLevel;
		DisableTips.StringReference.TableEntryReference = 622L;
		DisableTips.StringReference.GetVariable<int>("0").Value = raidInfo.recommendTeamLevel;
		_ = raidInfo.id;
		_ = monoRaidView.curSelectRaidId;
		_isUnLock = Model<RaidModel>.Interface.IsUnlock(raidInfo);
		if (!_isUnLock)
		{
			Disable.SetActive(value: true);
			Normal.SetActive(value: false);
			Select.SetActive(value: false);
			DisableTitle.GetComponent<TextMeshProUGUI>().color = ((raidInfo.id == monoRaidView.curSelectRaidId) ? disableSelectColor : disableColor);
			DisableTips.GetComponent<TextMeshProUGUI>().color = ((raidInfo.id == monoRaidView.curSelectRaidId) ? disableSelectColor : disableColor);
			DisableDiSelect.SetActive(raidInfo.id == monoRaidView.curSelectRaidId);
			DisableDi.SetActive(raidInfo.id != monoRaidView.curSelectRaidId);
		}
		else
		{
			Disable.SetActive(value: false);
			Normal.SetActive(raidInfo.id != monoRaidView.curSelectRaidId);
			Select.SetActive(raidInfo.id == monoRaidView.curSelectRaidId);
			_isSelect = raidInfo.id == monoRaidView.curSelectRaidId;
		}
		ACT.Game.Data.Raid raidInfo2 = Model<RaidModel>.Interface.GetRaidInfo(raidInfo.id);
		if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(_raidEntranceId, out var value) && value.isFirstFree && (raidInfo2 == null || !raidInfo2.FirstRewardDone) && _isUnLock)
		{
			FirstFree.SetActive(value: true);
		}
		else
		{
			FirstFree.SetActive(value: false);
		}
		string soundPath = (_isUnLock ? "event:/UI/Interface/Instance/Left_Tab" : "event:/UI/Interface/Instance/Left_Tab_Gray");
		ItemButton.SetBtnClick(() =>
		{
		}, soundPath);
		ACT.Game.Data.Raid raidInfo3 = Model<RaidModel>.Interface.GetRaidInfo(raidInfo.id);
		if (raidInfo3 != null && _isUnLock && Model<RaidModel>.Interface.GetRaidType(raidInfo.id) == 7)
		{
			if (raidInfo3.CleanNum > 0)
			{
				RaidParkourData raidParkourData = RuntimeConfigs.data.raidParkourDatas[raidInfo.id];
				RecordObj.SetActive(value: true);
				curNum.SetText("{0:0}", raidInfo3.MaximumScore);
				maxNum.SetText("{0:0}", raidParkourData.total);
				curNum.color = ((raidInfo3.MaximumScore >= raidParkourData.total) ? PerfectColor : NormalColor);
				for (int num = 0; num < raidInfo.mainTarget.Length; num++)
				{
					if (RuntimeConfigs.data.raidMissionTargets.TryGetValue(raidInfo.mainTarget[num], out var value2) && value2.targetType == 1)
					{
						RecordIconGold.SetActive(value2.targetIcon == 1);
						RecordIconExp.SetActive(value2.targetIcon != 1);
						break;
					}
				}
			}
			else
			{
				RecordObj.SetActive(value: false);
			}
		}
		else
		{
			RecordObj.SetActive(value: false);
		}
	}

	public void SetSelect(bool value)
	{
		if (_isUnLock)
		{
			Normal.SetActive(!value);
			Select.SetActive(value);
			_isSelect = value;
			if (_isSelect)
			{
				BetterAnimation.GetSequence("Select").Play();
				CanvasGroups[2].alpha = 1f;
			}
			else
			{
				BetterAnimation.GetSequence("Normal").Play();
				CanvasGroups[1].alpha = 1f;
			}
		}
		else
		{
			DisableTitle.GetComponent<TextMeshProUGUI>().color = (value ? disableSelectColor : disableColor);
			DisableTips.GetComponent<TextMeshProUGUI>().color = (value ? disableSelectColor : disableColor);
			DisableDiSelect.SetActive(value);
			DisableDi.SetActive(!value);
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		SelectGameObject.SetActive(value: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		SelectGameObject.SetActive(value: false);
	}

	private WorldBossMonster GetWorldBossMonster()
	{
		if (RuntimeConfigs.data.worldBossMonsters.TryGetValue(_raidEntranceId, out var value))
		{
			return value;
		}
		return null;
	}

	public void PlayAnimation()
	{
		if (!_isUnLock)
		{
			BetterAnimation.GetSequence("NormalShow").Play();
		}
		else if (_isSelect)
		{
			BetterAnimation.GetSequence("SelectedShow").Play();
		}
		else
		{
			BetterAnimation.GetSequence("NormalShow").Play();
		}
	}
}
