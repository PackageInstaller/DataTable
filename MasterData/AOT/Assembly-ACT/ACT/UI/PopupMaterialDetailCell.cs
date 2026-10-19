using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupMaterialDetailCell : MonoBehaviour
{
	public LocalizeStringEvent bottleMatName;

	public TextMeshProUGUI BottleMatDes;

	public BImage matIcon;

	public Color[] qualityColor;

	public Image qualityBoard;

	public BImage matTypeIocn;

	public void Refresh(BloodBottleMaterial mat, ImageAssetStation station)
	{
		ItemData data = CoreUtils.GetData(mat.id, RuntimeConfigs.data.itemDatas);
		bottleMatName.StringReference.TableEntryReference = data.nameLocal;
		BottleMatDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetBottleMatDesc(mat, isDetailDesc: true));
		station.LoadItemIcon(data.iconAddress, matIcon);
		qualityBoard.color = qualityColor[mat.type - 1];
		station.LoadImageAsync(157, mat.type, matTypeIocn);
	}
}
