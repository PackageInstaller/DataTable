using System;
using ACT.Game.Data;
using UnityEngine;

namespace ACT.UI;

public class AbyssBagCharacterItemUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private GameObject[] _teamIndexIcons = new GameObject[3];

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

	private int m_TeamIndex;

	private bool _canChose;

	private bool _death;

	public int TeamIndex
	{
		get
		{
			return m_TeamIndex;
		}
		set
		{
			m_TeamIndex = value;
			try
			{
				for (int i = 0; i < _teamIndexIcons.Length; i++)
				{
					_teamIndexIcons[i]?.SetActive(value > 0 && value == i + 1);
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

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		Character character = m_ItemUnifier.As<Character>();
		m_NumberComponent.UpdateNumber(character.Level);
		_mannerIcon.UpdateDisPlay(character.Id);
		_trialIcon.SetActive(character.IsTrailCharacter);
	}

	public void SetTeamIndex(int teamIndex)
	{
		TeamIndex = teamIndex;
	}

	public void HideAllTeamIcons()
	{
		TeamIndex = 0;
	}
}
