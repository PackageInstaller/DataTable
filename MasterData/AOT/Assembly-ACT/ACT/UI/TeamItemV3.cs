using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TeamItemV3 : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	private PresetTeam _teamProfile;

	public bool isChosen;

	public bool isBattle;

	private TeamModel _model;

	public BetterAnimation animaton;

	public GameObject SelectIcon;

	public TeamSelectSidebarV3 teamSelectSidebar;

	public TextMeshProUGUI teamNameText;

	public ActButton btn;

	public List<BImage> characterHeadImageList;

	[SerializeField]
	private BImage[] _characterQualityImages;

	public ActButton reName;

	[SerializeField]
	private GameObject reNameNormal;

	[SerializeField]
	private GameObject reNameSelected;

	[SerializeField]
	private TextMeshProUGUI _teamIndexText;

	public Color normalTeamNameColor = Color.black;

	public Color selectTeamNameColor = Color.white;

	public Color normalBattleTextColor = Color.black;

	public Color selectBattleTextColor = Color.black;

	[SerializeField]
	private CanvasGroup _battleGroup;

	[SerializeField]
	private CanvasGroup _unBattleGroup;

	[SerializeField]
	private GameObject _gamePadHandle;

	[SerializeField]
	private OperateBtnPrompt _operateBtnPrompt;

	private ImageAssetStation _station;

	private void OnEnable()
	{
		MonoECS.instance?.onInputModeChange.AddListener(OnInputModeChanged);
		RefreshGamePadHandle();
	}

	private void OnDisable()
	{
		MonoECS.instance?.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		RefreshGamePadHandle();
	}

	public override void Show()
	{
		base.Show();
		if (!teamSelectSidebar.initialComplete)
		{
			animaton.GetSequence("NormalShow").Goto(0f);
		}
	}

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		_model = Model<TeamModel>.Interface;
		if (_station == null)
		{
			_station = ImageManager.instance.GetAssetStation();
		}
		_teamProfile = GetPresetTeam(idx);
		isChosen = idx == _model.curSelectedIndex;
		isBattle = idx == _model.curBattleIndex;
		_operateBtnPrompt.SetVisible(isChosen);
		_teamIndexText.text = new StringBuilder().AppendFormat("{0:D2}", idx + 1).ToString();
		SetBattleGroup(isBattle);
		SelectIcon.SetActive(isChosen);
		teamNameText.text = GetPresetTeam(idx).Name;
		SetTeamTextColor();
		RefreshGamePadHandle();
		int index = idx;
		btn.SetBtnClick(() =>
		{
			if (!isChosen)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Left_Click");
			}
			SelectTeam(index);
		});
		reName.SetBtnClick(() =>
		{
			PresetTeam presetTeam = GetPresetTeam(idx);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAMRENAMEWIN, new TeamRenameWin.Param
			{
				teamProfile = presetTeam.Clone(),
				index = idx,
				teamItem = this
			});
		});
		for (int num = 0; num < characterHeadImageList.Count; num++)
		{
			int num2 = _teamProfile.CharacterIds[num];
			_characterQualityImages[num].icon.gameObject.SetActive(num2 != 0);
			characterHeadImageList[num].icon.gameObject.SetActive(num2 != 0);
			if (num2 != 0)
			{
				_station.LoadImage(126, num2, characterHeadImageList[num]);
				int bagCharacterQuality = GameUtility.GetBagCharacterQuality(num2);
				_station.LoadImage(175, bagCharacterQuality, _characterQualityImages[num]);
			}
		}
	}

	public void OnSelect(BaseEventData baseEventData)
	{
		if (IsControllerInputMode())
		{
			btn.OnSubmit(baseEventData);
			RefreshGamePadHandle();
		}
	}

	public void OnDeselect(BaseEventData baseEventData)
	{
		if (IsControllerInputMode() && !(teamSelectSidebar == null))
		{
			if (teamSelectSidebar.curSelectTeamIndex != index && isChosen)
			{
				SetNormal();
			}
			RefreshGamePadHandle();
		}
	}

	private void SelectTeam(int targetIndex)
	{
		if (!isChosen && !(teamSelectSidebar == null) && teamSelectSidebar.initialComplete && teamSelectSidebar.isNormal)
		{
			teamSelectSidebar.OnSelectedTeamChange(this, targetIndex);
			SetSelect();
		}
	}

	internal void SetBattle(bool value)
	{
		isBattle = value;
	}

	internal void SetChose(bool value)
	{
		isChosen = value;
		RefreshGamePadHandle();
	}

	private void SetTeamTextColor()
	{
		TextMeshProUGUI textMeshProUGUI = teamNameText;
		Color color;
		if (isChosen)
		{
			color = (isBattle ? selectBattleTextColor : selectTeamNameColor);
		}
		else
		{
			color = (isBattle ? normalBattleTextColor : normalTeamNameColor);
		}
		textMeshProUGUI.color = color;
		reNameNormal.SetActive(!isChosen);
		reNameSelected.SetActive(isChosen);
	}

	public void SetNormalStatus()
	{
		SetBattleGroup(isBattle);
		SelectIcon.SetActive(isChosen);
		SetTeamTextColor();
		RefreshGamePadHandle();
		animaton.GetSequence("NormalShow").Play();
	}

	public void SetSelectStatus()
	{
		SetBattleGroup(isBattle);
		SelectIcon.SetActive(isChosen);
		SetTeamTextColor();
		RefreshGamePadHandle();
		animaton.GetSequence("SelectedShow").Play();
	}

	public void SetNormal()
	{
		isChosen = false;
		_operateBtnPrompt.SetVisible(isChosen);
		SetBattleGroup(isBattle);
		teamNameText.color = (isBattle ? normalBattleTextColor : normalTeamNameColor);
		SelectIcon.SetActive(isChosen);
		reNameNormal.SetActive(!isChosen);
		reNameSelected.SetActive(isChosen);
		RefreshGamePadHandle();
		animaton.GetSequence("Normal").Play();
	}

	public void SetSelect()
	{
		isChosen = true;
		_operateBtnPrompt.SetVisible(isChosen);
		SetBattleGroup(isBattle);
		teamNameText.color = (isBattle ? selectBattleTextColor : selectTeamNameColor);
		SelectIcon.SetActive(isChosen);
		reNameNormal.SetActive(!isChosen);
		reNameSelected.SetActive(isChosen);
		RefreshGamePadHandle();
		animaton.GetSequence("Selected").Play();
	}

	private void RefreshGamePadHandle()
	{
		if (!(_gamePadHandle == null))
		{
			_gamePadHandle.SetActive(isChosen && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}

	private bool IsControllerInputMode()
	{
		if (MonoECS.instance != null)
		{
			if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
			{
				return MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse;
			}
			return true;
		}
		return false;
	}

	public override void OnUnLoad()
	{
		base.OnUnLoad();
		_station.ReleaseStation();
	}

	public void SetBattleGroup(bool isBattle)
	{
		_battleGroup.alpha = (isBattle ? 1 : 0);
		_unBattleGroup.alpha = ((!isBattle) ? 1 : 0);
	}

	private PresetTeam GetPresetTeam(int idx)
	{
		return _model.source switch
		{
			TeamProfileSource.World => _model.uiTeamProfiles[idx], 
			TeamProfileSource.Raid => _model.raidTeamProfiles[idx], 
			_ => null, 
		};
	}
}
