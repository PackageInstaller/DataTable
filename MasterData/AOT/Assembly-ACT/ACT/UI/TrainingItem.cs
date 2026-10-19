using System;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class TrainingItem : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler
{
	private const string SelectedAnimationName = "Selected";

	[SerializeField]
	private LayoutElement _layoutElement;

	[SerializeField]
	private GameObject _headerVisualRoot;

	[SerializeField]
	private GameObject _normalVisualRoot;

	[SerializeField]
	private GameObject _normalStar;

	[SerializeField]
	private GameObject _lightStar;

	[SerializeField]
	private GameObject _freeTraining;

	[SerializeField]
	private GameObject _freeTrainingSelect;

	[SerializeField]
	private GameObject _perfectTag;

	[SerializeField]
	private GameObject _selectPerfectTag;

	[SerializeField]
	private TMP_Text _raidName;

	[SerializeField]
	private BImage _characterHead;

	[FormerlySerializedAs("_toggle")]
	[SerializeField]
	private ActButton _itemButton;

	[SerializeField]
	private GameObject _normalRoot;

	[SerializeField]
	private GameObject _selectRoot;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private float _headerHeight = 120f;

	[SerializeField]
	private float _normalHeight = 100f;

	private Action<TrainingItem> _onClick;

	private bool _completed;

	private bool _isPerfect;

	private bool _isSelect;

	public bool IsFreeTraining { get; private set; }

	public CharacterTutorialRaidInfo RaidInfo { get; private set; }

	public void PlayShowAnimation()
	{
		_betterAnimation?.GetSequence("Show")?.Play();
	}

	public void PlayHideAnimation()
	{
		_betterAnimation?.GetSequence("Hide")?.Play();
	}

	public void BindFreeTraining(string title, bool selected, Action<TrainingItem> onClick)
	{
		IsFreeTraining = true;
		RaidInfo = null;
		_completed = false;
		_isPerfect = false;
		BindClick(onClick);
		if (_characterHead != null)
		{
			_characterHead.icon.gameObject.SetActive(value: false);
		}
		ApplyVisual(title, completed: false);
		_isSelect = false;
		SetSelect(selected);
	}

	public void BindCharacterTutorial(CharacterTutorialRaidInfo raidInfo, bool completed, bool isPerfect, ImageAssetStation station, bool selected, Action<TrainingItem> onClick)
	{
		IsFreeTraining = false;
		RaidInfo = raidInfo;
		_completed = completed;
		_isPerfect = isPerfect;
		BindClick(onClick);
		string title = ((raidInfo == null) ? string.Empty : LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(raidInfo.RaidNameLocalizedStringData.Table), raidInfo.RaidNameLocalizedStringData.Id));
		if (_characterHead != null)
		{
			bool flag = raidInfo != null && raidInfo.CharacterId > 0;
			_characterHead.icon.gameObject.SetActive(flag);
			if (flag)
			{
				station.LoadImage(148, raidInfo.CharacterId, _characterHead);
			}
		}
		ApplyVisual(title, completed);
		_isSelect = false;
		SetSelect(selected);
	}

	public void SetSelect(bool value)
	{
		if (!(_isSelect & value))
		{
			_isSelect = value;
			ApplySelectedVisual(value);
		}
	}

	public void SelectFromGamePad()
	{
		SyncGamePadFocus();
		if (!_isSelect)
		{
			GetComponent<SelectionUGUI>()?.ScrollTargetToShow(transform);
			_onClick?.Invoke(this);
			_betterAnimation?.GetSequence("Selected")?.Play();
		}
	}

	public void SyncGamePadFocus()
	{
		if (EventSystemHelper.Available && !(EventSystemHelper.CurrentSelected == gameObject))
		{
			EventSystemHelper.SetSelectedGameObject(gameObject);
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ESC/Hover");
	}

	private void BindClick(Action<TrainingItem> onClick)
	{
		_onClick = onClick;
		_itemButton.SetBtnClick(SelectFromGamePad, "event:/UI/Common/Button_Click");
	}

	private void ApplyVisual(string title, bool completed)
	{
		if (_headerVisualRoot != null)
		{
			_headerVisualRoot.SetActive(IsFreeTraining);
		}
		if (_normalVisualRoot != null)
		{
			_normalVisualRoot.SetActive(!IsFreeTraining);
		}
		if (_normalStar != null)
		{
			_normalStar.SetActive(!IsFreeTraining && !completed);
		}
		if (_lightStar != null)
		{
			_lightStar.SetActive(!IsFreeTraining & completed);
		}
		if (_layoutElement != null)
		{
			_layoutElement.preferredHeight = (IsFreeTraining ? _headerHeight : _normalHeight);
		}
		if (_raidName != null)
		{
			_raidName.SetText(title);
		}
	}

	private void ApplySelectedVisual(bool selected)
	{
		if (_normalRoot != null)
		{
			_normalRoot.SetActive(value: true);
		}
		if (_selectRoot != null)
		{
			_selectRoot.SetActive(selected);
		}
		if (_raidName != null)
		{
			_raidName.color = (selected ? Color.black : Color.white);
		}
		if (_freeTraining != null)
		{
			_freeTraining.SetActive(IsFreeTraining && !selected);
		}
		if (_freeTrainingSelect != null)
		{
			_freeTrainingSelect.SetActive(IsFreeTraining & selected);
		}
		bool flag = !IsFreeTraining && _completed;
		if (_perfectTag != null)
		{
			_perfectTag.SetActive(flag && !selected);
		}
		if (_selectPerfectTag != null)
		{
			_selectPerfectTag.SetActive(flag & selected);
		}
	}
}
