using System;
using System.Linq;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class RecentAchievementsItem : LoopScrollBaseItem
{
	[SerializeField]
	private BImage icon;

	[SerializeField]
	private ActButton _btn_goto;

	[SerializeField]
	private TextMeshProUGUI _nameText;

	[SerializeField]
	private TextMeshProUGUI _processText;

	[SerializeField]
	private GameObject _arrowImage;

	[SerializeField]
	private GameObject _completeImage;

	[SerializeField]
	private RedDotItem redDotItem;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private GamePadSelectComponent _gamePadSelectComponent;

	private ImageAssetStation imageStation;

	private MonoAccomplishmentView _view;

	private int typeId;

	private int groupId;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		if (imageStation == null)
		{
			imageStation = GetComponentInParent<IBaseUIView>().Station;
		}
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel == null)
		{
			return;
		}
		if (_view == null)
		{
			_view = GetComponentInParent<MonoAccomplishmentView>();
		}
		if (!(_view == null) && _view.TryGetRecentAchievementContentId(idx, out var contentId) && accomplishmentModel.TryGetContent(contentId, out var content))
		{
			_nameText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, content.groupName);
			_processText.text = accomplishmentModel.GetCompleteTimeText(contentId);
			AccomplishmentRowState rowState = accomplishmentModel.GetRowState(contentId);
			if (_completeImage != null)
			{
				_completeImage.SetActive(rowState == AccomplishmentRowState.Claimed);
			}
			if (_arrowImage != null)
			{
				_arrowImage.SetActive(rowState != AccomplishmentRowState.Claimed);
			}
			typeId = accomplishmentModel.GetMainIdForContent(contentId);
			groupId = content.groupID;
			if (icon != null)
			{
				imageStation.LoadImage(207, typeId, icon);
			}
			if (_btn_goto != null)
			{
				_btn_goto.SetBtnClick(OpenAccomplishmentDetailsView);
			}
			SetGamepadSelected(isActive: false);
			SetRedDotStatus(rowState == AccomplishmentRowState.Claimable, contentId);
		}
	}

	public void SetGamepadSelected(bool isActive)
	{
		if (!isActive)
		{
			ClearButtonSpriteSwapState();
		}
		if (_gamePadSelectComponent != null)
		{
			_gamePadSelectComponent.gameObject.SetActive(isActive);
			_gamePadSelectComponent.SetSelectState(isActive && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}

	private void ClearButtonSpriteSwapState()
	{
		if (!(_btn_goto == null) && _btn_goto.transition == Selectable.Transition.SpriteSwap && _btn_goto.targetGraphic is Image image)
		{
			image.overrideSprite = null;
		}
	}

	private void SetRedDotStatus(bool isClaimable, int accomplishmentId)
	{
		string text = string.Format(RedDotPathDefine.NewAccomplishment + "|{0}|RecentAchievement", accomplishmentId);
		Singleton<RedDotManager>.instance.SetLeafNodeActive(text, isClaimable);
		if (!(redDotItem == null))
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.fullPath = text.Split("|").ToList();
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
	}

	public void OpenAccomplishmentDetailsView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOACCOMPLISHMENTDETAILS, new MonoAccomplishmentDetailsViewData
		{
			TypeId = typeId,
			GroupId = groupId
		});
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
}
