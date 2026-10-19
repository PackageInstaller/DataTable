using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class BloodBottleDetail : UIBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _bottleName;

	[SerializeField]
	private TextMeshProUGUI _MaxUseCount;

	[SerializeField]
	private TextMeshProUGUI _bottleLevel;

	[SerializeField]
	private BImage _bottleIcon;

	[SerializeField]
	private ActButton _DetailBtn;

	[SerializeField]
	private GameObject _unLockRoot;

	[SerializeField]
	private LocalizeStringEvent _unlockDes;

	[SerializeField]
	private Color[] _titleBoardColors;

	[SerializeField]
	private Image _titleBoard;

	[SerializeField]
	private TextMeshProUGUI _bottleDes;

	[SerializeField]
	private List<BottleMaterialCell> _wineMatSolts;

	[Header("按钮节点")]
	[SerializeField]
	private GameObject buttonRoot;

	[FormerlySerializedAs("_changeMatBtn")]
	[SerializeField]
	private ActButton _goTochangeMatBtn;

	[SerializeField]
	private ActButton _strengthenBtn;

	[SerializeField]
	private ActButton _changeMatBtn;

	[SerializeField]
	private OperateBtnPrompt _changeMatBtnPrompt;

	private Action<int> _openChangePanel;

	private ImageAssetStation _station;

	public LocalizeStringEvent _changeMatBtnText;

	public List<BottleMaterialCell> slots => _wineMatSolts;

	public ActButton changeMatBtn => _changeMatBtn;

	public ActButton goToChangeMatBtn => _goTochangeMatBtn;

	public ActButton goToLevelUpBtn => _strengthenBtn;

	public OperateBtnPrompt changeMatBtnPrompt => _changeMatBtnPrompt;

	public void Init(Action<int> goToChangePanel)
	{
		_openChangePanel = goToChangePanel;
		_goTochangeMatBtn.SetBtnClick(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Click_2");
			_openChangePanel?.Invoke(1);
		});
		_strengthenBtn.SetBtnClick(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Click_2");
			_openChangePanel?.Invoke(2);
		});
	}

	public void Refresh(BloodBottleData bottle, StringBuilder sb, ImageAssetStation station)
	{
		_station = station;
		sb.Clear();
		ItemData data = CoreUtils.GetData(bottle.id, RuntimeConfigs.data.itemDatas);
		_bottleName.StringReference.TableEntryReference = data.nameLocal;
		_MaxUseCount.SetText(bottle.maxUseCount.FastToString());
		_titleBoard.color = _titleBoardColors[data.quality - 1];
		_bottleLevel.SetText(sb.Append("Lv.").Append(bottle.curLevel).Append("/")
			.Append(bottle.maxLevel));
		station.LoadItemIcon(data.iconAddress, _bottleIcon);
		buttonRoot.SetActive(!bottle.isLock);
		_unLockRoot.SetActive(bottle.isLock);
		if (bottle.isLock)
		{
			_unlockDes.StringReference.TableEntryReference = CoreUtils.GetData(bottle.uid, RuntimeConfigs.data.potionDatas).unlockTaxt;
		}
		_bottleDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetSpecifyLevelBottleSkillDes(bottle, sb, bottle.curLevel, detailDesc: false));
		TextMeshProUGUI componentInChildren = _bottleDes.GetComponentInChildren<TextMeshProUGUI>();
		if (componentInChildren != null)
		{
			componentInChildren.enableWordWrapping = true;
			componentInChildren.overflowMode = TextOverflowModes.Ellipsis;
			componentInChildren.maxVisibleLines = 4;
		}
		_wineMatSolts.ForEach((BottleMaterialCell x) =>
		{
			x.gameObject.SetActive(value: true);
		});
		List<BottleMaterialSlot> wineMaterialSlots = bottle.wineMaterialSlots;
		for (int num = _wineMatSolts.Count - 1; num >= wineMaterialSlots.Count; num--)
		{
			_wineMatSolts[num].gameObject.SetActive(value: false);
		}
		for (int num2 = 0; num2 < wineMaterialSlots.Count; num2++)
		{
			_wineMatSolts[num2].Refresh(wineMaterialSlots[num2], bottle.uid, num2, station);
		}
		_DetailBtn.SetBtnClick(() =>
		{
		});
	}

	public void UnInit()
	{
	}

	public void RefreshUnlockSlotDisplayByIndex(int index, BloodBottleMaterial matData)
	{
		if (matData == null)
		{
			_wineMatSolts[index].EmptyStateDisPlay();
		}
		else
		{
			_wineMatSolts[index].FilledStateDisPlay(matData, _station);
		}
	}
}
