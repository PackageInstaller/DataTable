using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class RaidEnemyDetailItem : LoopScrollBaseItem
{
	public BImage icon;

	public new LocalizeStringEvent name;

	public TextMeshProUGUI level;

	public GameObject monster;

	private MonoRaidView detailView;

	public override void ScrollCellIndex(int idx)
	{
		detailView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_RAID) as MonoRaidView;
		ItemKv enemyInfo = detailView.GetEnemyInfo(idx);
		level.SetText("Lv.{0:0}", enemyInfo.count);
		if (RuntimeConfigs.data.entityDatas.TryGetValue(enemyInfo.id, out var value))
		{
			name.StringReference.TableEntryReference = value.nameLocal;
		}
		if (RuntimeConfigs.data.entityEnemyDatas.TryGetValue(enemyInfo.id, out var value2))
		{
			Station.LoadSprite(GameLoader.meta.monsterheadiconAtlasAssetID, value2.monsterIcon, icon);
			if (value2.enemyType <= 0)
			{
				monster.SetActive(value: false);
				return;
			}
			int enemyType = value2.enemyType;
			EnemyType enemyType2 = (EnemyType)Convert.ToInt32(enemyType.ToString()[0].ToString());
			monster.SetActive(enemyType2 == EnemyType.Boss || enemyType2 == EnemyType.EliteMonster);
		}
	}
}
