using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AbyssTeamInfoItem : MonoBehaviour
{
	public GameObject OpenPanel;

	public GameObject DisablePanel;

	public LocalizeStringEvent Record;

	public TextMeshProUGUI Level;

	public BImage MonsterIcon;

	public List<BImage> Weakneses;

	public GameObject WeaknesesEmpty;

	public List<BImage> Resisters;

	public GameObject ResistersEmpty;

	public TextMeshProUGUI BuffDescription;

	public GameObject TeamLevelLow;

	public List<AbyssCharacter> Characters;

	public List<ActButton> CharacterButton;

	public BImage BloodBottleIcon;

	public GameObject Select;

	public ActButton ItemButton;

	public ActButton BloodBottleButton;

	public ActButton MonsterDetailButton;

	public List<GameObject> Prompts;

	private int _index;

	private AbyssTeamSubView _abyssTeamSubView;

	private bool isNull;

	private AbyssData _abyssConfig;

	private void OnClickItemIndex()
	{
		if (!isNull)
		{
			_abyssTeamSubView.CurSelectTeam = _index + 1;
		}
	}

	private void OnClickItemCharacterIndex(int characterIndex)
	{
		_abyssTeamSubView.CurSelectTeam = _index + 1;
		_abyssTeamSubView.DeleteCharacter(characterIndex);
	}

	private void OnClickBloodBottleIcon()
	{
		_abyssTeamSubView.CurSelectTeam = _index + 1;
		_abyssTeamSubView.OpenAbyssBloodBottlePopup();
	}

	public void RefreshUI(AbyssData abyssConfig, int index, int abyssIndex)
	{
		_index = index;
		_abyssConfig = abyssConfig;
		MonoAbyssListView monoAbyssListView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		_abyssTeamSubView = monoAbyssListView.GetAbyssTeamSubView();
		for (int i = 0; i < CharacterButton.Count; i++)
		{
			int _i = i;
			CharacterButton[i].SetBtnClick(() =>
			{
				OnClickItemCharacterIndex(_i);
			});
		}
		ItemButton.SetBtnClick(OnClickItemIndex);
		BloodBottleButton.SetBtnClick(OnClickBloodBottleIcon);
		MonsterDetailButton.SetBtnClick(_abyssTeamSubView.OpenMonsterDetailView);
		isNull = false;
		if (index >= abyssConfig.subabyss.Length)
		{
			isNull = true;
			OpenPanel.SetActive(value: false);
			DisablePanel.SetActive(value: true);
			return;
		}
		OpenPanel.SetActive(value: true);
		DisablePanel.SetActive(value: false);
		int key = abyssConfig.subabyss[index];
		AbyssStage abyssStage = null;
		if (Model<AbyssModel>.Interface.AbyssStages.Count > abyssIndex)
		{
			abyssStage = Model<AbyssModel>.Interface.AbyssStages[abyssIndex];
		}
		if (abyssStage != null && abyssStage.SubStageMinimumSecs.ContainsKey(index))
		{
			int num = abyssStage.SubStageMinimumSecs[index];
			int value = num / 60;
			int value2 = num % 60;
			Record.StringReference.TableEntryReference = 2290L;
			Record.StringReference.GetVariable<int>("0").Value = value;
			Record.StringReference.GetVariable<int>("1").Value = value2;
		}
		else
		{
			Record.StringReference.TableEntryReference = null;
			Record.GetComponent<TextMeshProUGUI>().text = string.Empty;
		}
		List<ItemKv> list = ((index == 0) ? abyssConfig.enemyShowList : abyssConfig.enemyShowListDown);
		int id = list[0].id;
		EntityEnemyData entityEnemyData = RuntimeConfigs.data.entityEnemyDatas[id];
		EntityData entityData = RuntimeConfigs.data.entityDatas[id];
		Level.SetText("{0:0}", list[0].count);
		this.GetImageStation().LoadSprite(GameLoader.meta.monsterheadiconAtlasAssetID, entityEnemyData.monsterIcon, MonsterIcon);
		for (int num2 = 0; num2 < 2; num2++)
		{
			if (entityData.weaknessElement.Length >= num2 + 1 && entityData.weaknessElement[num2] > 0)
			{
				Weakneses[num2].icon.gameObject.SetActive(value: true);
				this.GetImageStation().LoadSprite(GameLoader.meta.elementAssetID, entityData.weaknessElement[num2], Weakneses[num2]);
			}
			else
			{
				Weakneses[num2].icon.gameObject.SetActive(value: false);
			}
			if (entityData.resistanceElement.Length >= num2 + 1 && entityData.resistanceElement[num2] > 0)
			{
				Resisters[num2].icon.gameObject.SetActive(value: true);
				this.GetImageStation().LoadSprite(GameLoader.meta.elementAssetID, entityData.resistanceElement[num2], Resisters[num2]);
			}
			else
			{
				Resisters[num2].icon.gameObject.SetActive(value: false);
			}
		}
		WeaknesesEmpty.SetActive(entityData.weaknessElement.Length == 0 || entityData.weaknessElement[0] < 0);
		ResistersEmpty.SetActive(entityData.resistanceElement.Length == 0 || entityData.resistanceElement[0] < 0);
		int skillGroupLevelId = TableRule.GetSkillGroupLevelId(RuntimeConfigs.data.subabyssDatas[key].buffId, 1);
		if (RuntimeConfigs.data.skillGroupLevelDatas.TryGetValue(skillGroupLevelId, out var value3))
		{
			BuffDescription.text = CustomTagParser.ReplaceSkillMessageText(value3.skillDes[0], "longcommon", isBrief: false);
		}
		else
		{
			BuffDescription.text = string.Empty;
		}
	}

	public void RefreshCharacters(TeamUsage teamUsage)
	{
		List<Character> bagCharacters = CharacterDataHelper.GetBagCharacters();
		for (int i = 0; i < Characters.Count; i++)
		{
			int characterId = teamUsage.CharacterUsage[i].CharacterId;
			if (i >= teamUsage.CharacterUsage.Count || characterId == 0)
			{
				Characters[i].gameObject.SetActive(value: false);
				continue;
			}
			int skinId = bagCharacters.Find((Character c) => c.Id == characterId)?.SkinId ?? 0;
			Characters[i].gameObject.SetActive(value: true);
			Characters[i].RefreshUI(characterId, skinId);
		}
		RefreshBloodBottle(teamUsage.EquipPotionId);
		TeamLevelLow.SetActive(Model<TeamModel>.Interface.IsLowLevel(teamUsage, _abyssConfig.abyssRecommendedLevel));
	}

	public void RefreshBloodBottle(int bloodBottleId)
	{
		if (bloodBottleId <= 0)
		{
			BloodBottleIcon.icon.gameObject.SetActive(value: false);
			return;
		}
		BloodBottleIcon.icon.gameObject.SetActive(value: true);
		this.GetImageStation().LoadItemIcon(RuntimeConfigs.data.itemDatas[bloodBottleId].iconAddress, BloodBottleIcon);
	}

	public void SetSelect(int index)
	{
		Select.SetActive(index == _index);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			for (int i = 0; i < Prompts.Count; i++)
			{
				Prompts[i].SetActive(index == _index);
			}
		}
	}

	public Vector3 GetBloodBottlePosition()
	{
		return BloodBottleButton.transform.position;
	}
}
