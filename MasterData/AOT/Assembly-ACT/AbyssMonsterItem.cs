using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class AbyssMonsterItem : MonoBehaviour
{
	public BImage MonsterIcon;

	public LocalizeStringEvent Name;

	public TextMeshProUGUI Level;

	public List<BImage> Weakneses;

	public GameObject WeaknesesEmpty;

	public List<BImage> Resisters;

	public GameObject ResistersEmpty;

	public void RefreshUI(int monsterId, int level)
	{
		if (!RuntimeConfigs.data.entityDatas.TryGetValue(monsterId, out var value))
		{
			return;
		}
		Name.StringReference.TableEntryReference = value.nameLocal;
		Level.SetText("Lv.{0:0}", level);
		if (!RuntimeConfigs.data.entityEnemyDatas.TryGetValue(monsterId, out var value2))
		{
			return;
		}
		this.GetImageStation().LoadSprite(GameLoader.meta.monsterheadiconAtlasAssetID, value2.monsterIcon, MonsterIcon);
		EntityData entityData = RuntimeConfigs.data.entityDatas[monsterId];
		for (int i = 0; i < 2; i++)
		{
			if (entityData.weaknessElement.Length >= i + 1 && entityData.weaknessElement[i] > 0)
			{
				Weakneses[i].icon.gameObject.SetActive(value: true);
				this.GetImageStation().LoadSprite(GameLoader.meta.elementAssetID, entityData.weaknessElement[i], Weakneses[i]);
			}
			else
			{
				Weakneses[i].icon.gameObject.SetActive(value: false);
			}
			if (entityData.resistanceElement.Length >= i + 1 && entityData.resistanceElement[i] > 0)
			{
				Resisters[i].icon.gameObject.SetActive(value: true);
				this.GetImageStation().LoadSprite(GameLoader.meta.elementAssetID, entityData.resistanceElement[i], Resisters[i]);
			}
			else
			{
				Resisters[i].icon.gameObject.SetActive(value: false);
			}
		}
		WeaknesesEmpty.SetActive(entityData.weaknessElement.Length == 0 || entityData.weaknessElement[0] < 0);
		ResistersEmpty.SetActive(entityData.resistanceElement.Length == 0 || entityData.resistanceElement[0] < 0);
	}
}
