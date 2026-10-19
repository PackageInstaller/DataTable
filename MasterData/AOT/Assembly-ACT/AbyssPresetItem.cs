using System.Collections.Generic;
using ACT;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class AbyssPresetItem : LoopScrollBaseItem
{
	public ActButton ItemButton;

	public List<AbyssCharacter> AbyssCharacters;

	public TextMeshProUGUI Index;

	public TextMeshProUGUI Index2;

	public TextMeshProUGUI Title;

	public TextMeshProUGUI Title2;

	public GameObject Select;

	public GameObject Configuration;

	private AbyssTeamSubView _abyssTeamSubView;

	public override void ScrollCellIndex(int idx)
	{
		MonoAbyssListView monoAbyssListView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		_abyssTeamSubView = monoAbyssListView.GetAbyssTeamSubView();
		if (_abyssTeamSubView == null || idx > _abyssTeamSubView.PresetTeamProfiles.Count)
		{
			return;
		}
		PresetTeam teamProfile = _abyssTeamSubView.PresetTeamProfiles[idx];
		if (teamProfile == null)
		{
			return;
		}
		ItemButton.SetBtnClick(() =>
		{
			if (Configuration.activeSelf)
			{
				GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2295));
			}
			else
			{
				for (int i = 0; i < teamProfile.CharacterIds.Count; i++)
				{
					if (teamProfile.CharacterIds[i] > 0)
					{
						_abyssTeamSubView.OnClickPresetItem(idx, teamProfile.CharacterIds);
					}
				}
				_abyssTeamSubView.ConfigurationBloodBottle(teamProfile.EquipPotionId);
				SetConfiguration(_abyssTeamSubView.CurSelectTeam);
			}
		});
		Index.SetText("{0:00}", idx + 1);
		Index2.text = Index.text;
		Title.text = teamProfile.Name;
		Title2.text = Title.text;
		List<Character> bagCharacters = CharacterDataHelper.GetBagCharacters();
		int num = CompareConfigurationed(teamProfile);
		for (int num2 = 0; num2 < AbyssCharacters.Count; num2++)
		{
			if (num2 >= teamProfile.CharacterIds.Count)
			{
				AbyssCharacters[num2].gameObject.SetActive(value: false);
				continue;
			}
			int characterId = teamProfile.CharacterIds[num2];
			if (characterId <= 0)
			{
				AbyssCharacters[num2].gameObject.SetActive(value: false);
				continue;
			}
			int skinId = bagCharacters.Find((Character c) => c.Id == characterId)?.SkinId ?? 0;
			AbyssCharacters[num2].gameObject.SetActive(value: true);
			AbyssCharacters[num2].RefreshUI(characterId, skinId);
			if (num == -1)
			{
				int num3 = IsInTeam(characterId);
				if (num3 != -1)
				{
					AbyssCharacters[num2].SetTeam(num3);
				}
				else
				{
					AbyssCharacters[num2].SetTeam(-1);
				}
			}
			else
			{
				AbyssCharacters[num2].SetTeam(num);
			}
		}
		Configuration.SetActive(num > 0);
	}

	public void SetConfiguration(int team)
	{
		Configuration.SetActive(team > 0);
		for (int i = 0; i < AbyssCharacters.Count; i++)
		{
			AbyssCharacters[i].SetTeam(team);
		}
	}

	private int CompareConfigurationed(PresetTeam teamProfile)
	{
		int num = -1;
		for (int i = 0; i < teamProfile.CharacterIds.Count; i++)
		{
			int num2 = teamProfile.CharacterIds[i];
			if (num2 > 0)
			{
				int num3 = IsInTeam(num2);
				if (num3 == -1)
				{
					return -1;
				}
				if (num != -1 && num != num3)
				{
					return -1;
				}
				num = num3;
			}
		}
		return num;
	}

	private int IsInTeam(int characterId)
	{
		if (characterId <= 0)
		{
			return -1;
		}
		for (int i = 0; i < Model<AbyssModel>.Interface.AbyssModifyData.Count; i++)
		{
			for (int j = 0; j < Model<AbyssModel>.Interface.AbyssModifyData[i].CharacterUsage.Count; j++)
			{
				if (Model<AbyssModel>.Interface.AbyssModifyData[i].CharacterUsage[j].CharacterId == characterId)
				{
					return i + 1;
				}
			}
		}
		return -1;
	}
}
