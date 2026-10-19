using System;
using System.Collections.Generic;
using ACT.Game.Data;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CommonSubWorldEntranceItem : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private ActButton _itemButton;

	[SerializeField]
	private GameObject _select;

	[SerializeField]
	private LocalizeStringEvent _title;

	[SerializeField]
	private Color _unLockColor;

	[SerializeField]
	private Color _lockColor;

	[SerializeField]
	private Color _selectColor;

	[SerializeField]
	private List<GameObject> _stars;

	[SerializeField]
	private List<GameObject> _starBGs;

	[SerializeField]
	private GameObject _perfectTag;

	[SerializeField]
	private GameObject _selectPerfectTag;

	[SerializeField]
	private GameObject _unLockDecoration;

	[SerializeField]
	private GameObject _lockDecoration;

	[SerializeField]
	private GameObject _lock;

	[SerializeField]
	private GameObject _firstFreeTag;

	public ACT.ViewControl.SelectableEx SelectableEx;

	public CanvasGroup CanvasGroup;

	private bool isUnLock;

	private StageChallengeTarget stageChallengeTarget;

	private Action<int> _onItemClick;

	private bool _isPerfect;

	private bool _isSelect;

	public bool SyncFocusOnSelect { get; set; }

	public void RefreshUI(int index, int titleLocalizeId, List<int> taskIds, StageChallengeTarget stageChallengeTarget, bool isUnLock, Action<int> onItemClick, bool? isPerfect = null)
	{
		_onItemClick = onItemClick;
		_itemButton.SetBtnClick(SelectFromGamePad, "event:/UI/Common/Button_Click");
		this.isUnLock = isUnLock;
		this.stageChallengeTarget = stageChallengeTarget;
		_isPerfect = isPerfect ?? stageChallengeTarget?.IsPerfect ?? false;
		_isSelect = false;
		_lock.SetActive(!isUnLock);
		_title.StringReference.TableEntryReference = titleLocalizeId;
		_title.GetComponent<TextMeshProUGUI>().color = (isUnLock ? _unLockColor : _lockColor);
		_perfectTag.SetActive(_isPerfect);
		_selectPerfectTag.SetActive(value: false);
		_unLockDecoration.SetActive(isUnLock);
		_lockDecoration.SetActive(!isUnLock);
		SetFirsetFreeTag(value: false);
		bool value = default;
		for (int i = 0; i < _stars.Count; i++)
		{
			if ((i < taskIds.Count) & isUnLock)
			{
				bool active = (stageChallengeTarget?.TargetReward != null && stageChallengeTarget.TargetReward.TryGetValue(taskIds[i], out value)) & value;
				_stars[i].SetActive(active);
				_starBGs[i].SetActive(value: true);
			}
			else
			{
				_stars[i].SetActive(value: false);
				_starBGs[i].SetActive(value: false);
			}
		}
	}

	public void SetSelect(bool value)
	{
		if (!_isSelect || _isSelect != value)
		{
			_isSelect = value;
			_select.SetActive(value);
			TextMeshProUGUI component = _title.GetComponent<TextMeshProUGUI>();
			Color color;
			if (value)
			{
				color = _selectColor;
			}
			else
			{
				color = (isUnLock ? _unLockColor : _lockColor);
			}
			component.color = color;
			_perfectTag.SetActive(_isPerfect && !value);
			_selectPerfectTag.SetActive(_isPerfect & value);
			if (value)
			{
				AnimationBuilder sequence = _betterAnimation.GetSequence("Select");
				sequence.Goto(sequence.Duration());
			}
			else
			{
				_betterAnimation.GetSequence("Normal").Play();
			}
		}
	}

	public void SelectFromGamePad()
	{
		if (SyncFocusOnSelect)
		{
			SyncGamePadFocus();
		}
		if (!_isSelect)
		{
			((SelectableEx != null) ? SelectableEx.GetComponent<SelectionUGUI>() : GetComponent<SelectionUGUI>())?.ScrollTargetToShow(transform);
			_onItemClick?.Invoke(index);
			_betterAnimation.GetSequence("Select").Play();
		}
	}

	public void SyncGamePadFocus()
	{
		if (!(SelectableEx == null) && EventSystemHelper.Available && !(EventSystemHelper.CurrentSelected == SelectableEx.gameObject))
		{
			EventSystemHelper.SetSelectedGameObject(SelectableEx.gameObject);
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ESC/Hover");
	}

	public void SetFirsetFreeTag(bool value)
	{
		_firstFreeTag.SetActive(value);
	}

	public void PlayAnimation()
	{
		_betterAnimation.GetSequence("Show").Play();
	}

	public void PlaySwitchShowAnimation()
	{
		_betterAnimation?.GetSequence("SwithShow")?.Play();
	}
}
