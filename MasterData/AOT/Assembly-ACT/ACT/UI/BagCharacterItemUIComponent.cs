using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Serialization;

namespace ACT.UI;

public class BagCharacterItemUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private GameObject[] indexIcons = new GameObject[3];

	[SerializeField]
	private GameObject[] indexIcons2 = new GameObject[3];

	[FormerlySerializedAs("_elementIcon")]
	[SerializeField]
	private CharacterProfessionIcon _mannerIcon;

	[SerializeField]
	private GameObject _trialIcon;

	[SerializeField]
	private GameObject _inTeamIcon;

	[SerializeField]
	private GameObject _blackMask;

	[SerializeField]
	private GameObject _deathMask;

	private int m_IndexAtTeam;

	private bool _canChose;

	private bool _death;

	public int IndexAtTeam
	{
		get
		{
			return m_IndexAtTeam;
		}
		private set
		{
			m_IndexAtTeam = value;
			try
			{
				for (int i = 0; i < indexIcons.Length; i++)
				{
					indexIcons[i]?.SetActive(value == i + 1);
				}
			}
			catch (Exception value2)
			{
				Console.WriteLine(value2);
				throw;
			}
		}
	}

	public bool CanChose
	{
		get
		{
			return _canChose;
		}
		set
		{
			_canChose = value;
			_blackMask.SetActive(!_canChose);
		}
	}

	public bool Death
	{
		get
		{
			return _death;
		}
		set
		{
			_death = value;
			_deathMask.SetActive(_death);
		}
	}

	private bool NeedShowSelected
	{
		get
		{
			DeviceInputMode? deviceInputMode = MonoECS.instance?.InputMode;
			if (!deviceInputMode.HasValue || deviceInputMode != DeviceInputMode.KeyboardAndMouse)
			{
				deviceInputMode = MonoECS.instance?.InputMode;
				if (deviceInputMode.HasValue)
				{
					return deviceInputMode == DeviceInputMode.Gamepad;
				}
				return false;
			}
			return true;
		}
	}

	public void SetLevelColor(Color color)
	{
		if (m_NumberComponent?.numberText != null)
		{
			m_NumberComponent.numberText.color = color;
		}
		if (m_LevelPrefixText != null)
		{
			m_LevelPrefixText.color = color;
		}
	}

	public void SetTrialIconActive(bool active)
	{
		_trialIcon?.SetActive(active);
	}

	public void UpdateTeamIndexIcon(int characterId)
	{
		int num = Model<TeamModel>.Interface.quickSelectCharacters.IndexOf(characterId);
		IndexAtTeam = ((num != -1) ? (num + 1) : 0);
	}

	public void SetShowIndex(int index)
	{
		IndexAtTeam = index;
	}

	protected override void OnGameObjectAwake()
	{
		base.OnGameObjectAwake();
		MonoECS.instance?.onInputModeChange.AddListener(OnInputDeviceChange);
	}

	protected override void OnGameObjectDestroy()
	{
		base.OnGameObjectDestroy();
		MonoECS.instance?.onInputModeChange.RemoveListener(OnInputDeviceChange);
	}

	private void OnInputDeviceChange(DeviceInputMode device)
	{
		if (NeedShowSelected && _isSelected)
		{
			OnHighLight();
		}
		else
		{
			OnNormal();
		}
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		Character character = m_ItemUnifier.As<Character>();
		m_NumberComponent.UpdateNumber(character.Level);
		_mannerIcon.UpdateDisPlay(character.Id);
		if (m_InitType != InitType.TeamViewBagCharacter)
		{
			return;
		}
		TeamModel teamModel = Model<TeamModel>.Interface;
		int[] source = teamModel.DeepCopyArray(teamModel.CurSelectedTeamCharacters);
		_inTeamIcon.SetActive(teamModel.bagSingleSelect && source.Contains(character.Id));
		Death = !character.IsRuntimeAlive();
		if (teamModel.bagSingleSelect)
		{
			if (IndexAtTeam != 0)
			{
				IndexAtTeam = 0;
			}
		}
		else
		{
			UpdateTeamIndexIcon(character.Id);
		}
		if (teamModel.source == TeamProfileSource.Temple)
		{
			List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(teamModel.templeId);
			if (limitElements != null && limitElements.Count > 0 && !limitElements.Contains((int)character.element))
			{
				CanChose = false;
				CanChosen = () =>
				{
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterCantFight);
					return false;
				};
			}
			else
			{
				CanChosen = null;
				CanChose = true;
			}
		}
		else
		{
			CanChose = true;
		}
		_trialIcon.SetActive(character.IsTrailCharacter);
	}
}
