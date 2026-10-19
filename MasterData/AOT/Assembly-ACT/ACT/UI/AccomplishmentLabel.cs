using System;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class AccomplishmentLabel : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	[SerializeField]
	private BImage bg;

	[SerializeField]
	private BImage iconBoard;

	[SerializeField]
	private BImage labelIcon;

	[SerializeField]
	private ActButton _btn_goto;

	[SerializeField]
	private TextMeshProUGUI _nameText;

	[SerializeField]
	private TextMeshProUGUI _processText;

	[SerializeField]
	private GameObject _select;

	[SerializeField]
	private RedDotItem redDotItem;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private GameObject gamePadSelect;

	private ImageAssetStation station;

	private int _mainId;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel == null)
		{
			return;
		}
		_mainId = GetMainIdByIndex(accomplishmentModel, idx);
		if (_mainId != 0)
		{
			int mainId = _mainId;
			int id = _mainId * 10;
			int id2 = _mainId * 100;
			if (station == null)
			{
				station = GetComponentInParent<IBaseUIView>().Station;
			}
			station.LoadImage(203, mainId, bg);
			station.LoadImage(203, id, iconBoard);
			station.LoadImage(203, id2, labelIcon);
			if (RuntimeConfigs.data.achievementMains.TryGetValue(_mainId, out var value))
			{
				_nameText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.typeName);
			}
			_processText.text = accomplishmentModel.GetMainPercent(_mainId);
			_btn_goto.SetBtnClick(OpenAccomplishDetailView);
			SetSelectActive(isActive: false);
			SetGamepadSelected(isActive: false);
			SetRedDotStatus();
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		SetSelectActive(isActive: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		SetSelectActive(isActive: false);
	}

	private void SetSelectActive(bool isActive)
	{
		if (_select != null)
		{
			_select.SetActive(isActive);
		}
	}

	public void SetGamepadSelected(bool isActive)
	{
		if (gamePadSelect != null)
		{
			gamePadSelect.SetActive(isActive && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}

	private void SetRedDotStatus()
	{
		string mainRedDotPath = GetMainRedDotPath(_mainId);
		RedDotDisplayAction redDotDisplayAction = GetRedDotDisplayAction(_mainId);
		if (mainRedDotPath != "")
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.fullPath = mainRedDotPath.Split("|").ToList();
			redDotItem.displayAction = redDotDisplayAction;
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
	}

	private RedDotDisplayAction GetRedDotDisplayAction(int typeId)
	{
		return new AccomplishmentEntranceActive(typeId);
	}

	public void OpenAccomplishDetailView()
	{
		if (_mainId != 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOACCOMPLISHMENTDETAILS, new MonoAccomplishmentDetailsViewData
			{
				TypeId = _mainId
			});
		}
	}

	public void PlayShowAnimation(float delaySeconds)
	{
		PlayShowAnimationAsync(delaySeconds).Forget();
	}

	private async UniTaskVoid PlayShowAnimationAsync(float delaySeconds)
	{
		if (!(_betterAnimation == null))
		{
			if (delaySeconds > 0f)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(delaySeconds), ignoreTimeScale: true, PlayerLoopTiming.Update, this.GetCancellationTokenOnDestroy());
			}
			_betterAnimation.GetSequence("Show")?.Play();
		}
	}

	private static int GetMainIdByIndex(AccomplishmentModel model, int labelIndex)
	{
		if (model?.OrderedMainIds == null || labelIndex < 0 || labelIndex >= model.OrderedMainIds.Count)
		{
			return 0;
		}
		return model.OrderedMainIds[labelIndex];
	}

	private static string GetMainRedDotPath(int mainId)
	{
		return mainId switch
		{
			1 => RedDotPathDefine.NewAccomplishmentTask, 
			2 => RedDotPathDefine.NewAccomplishmentExplore, 
			3 => RedDotPathDefine.NewAccomplishmentBattle, 
			4 => RedDotPathDefine.NewAccomplishmentCultivate, 
			5 => RedDotPathDefine.NewAccomplishmentOther, 
			_ => string.Empty, 
		};
	}
}
