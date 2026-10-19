using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EnemyDetailItem : LoopScrollBaseItem
{
	public BImage icon;

	public new LocalizeStringEvent name;

	public TextMeshProUGUI level;

	private PopupEnemyDetailView detailView;

	public override void ScrollCellIndex(int idx)
	{
		detailView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_POPUPENEMYDETAIL) as PopupEnemyDetailView;
		ItemKv enemyInfo = detailView.GetEnemyInfo(idx);
		level.SetText("Lv.{0:0}", enemyInfo.count);
		if (RuntimeConfigs.data.entityDatas.TryGetValue(enemyInfo.id, out var value))
		{
			name.StringReference.TableEntryReference = value.nameLocal;
		}
		if (RuntimeConfigs.data.entityEnemyDatas.TryGetValue(enemyInfo.id, out var value2))
		{
			Station.LoadSprite(GameLoader.meta.monsterheadiconAtlasAssetID, value2.monsterIcon, icon);
		}
	}
}
