using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourShowView : MonoBehaviour
{
	[SerializeField]
	private Image frame;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private TextMeshProUGUI level2;

	[SerializeField]
	private Sprite normalBg;

	[SerializeField]
	private Sprite rockBg;

	public async void SetArmourData(ArmourData armourData)
	{
		if (armourData == null)
		{
			return;
		}
		string textureIconSprite = AssetUtility.GetTextureIconSprite("Equipment/ArmourIcon/" + armourData.Icon + ".png");
		Image image = icon;
		image.sprite = await GameEntry.Resource.LoadSpriteAsync(textureIconSprite, GetInstanceID().ToString());
		if (entryIcon != null)
		{
			if (armourData.EquipmentEnum == EquipmentEnum.SuitBox && armourData.EntryDataList.Count > 0)
			{
				string textureIconSprite2 = AssetUtility.GetTextureIconSprite("BuffIcon/Folder/EntryIcon/" + armourData.EntryDataList[0].IconPath + "_Rock.png");
				image = entryIcon;
				image.sprite = await GameEntry.Resource.LoadSpriteAsync(textureIconSprite2, GetInstanceID().ToString());
			}
			entryIcon.gameObject.SetActive(armourData.EquipmentEnum == EquipmentEnum.SuitBox);
		}
		((TMP_Text)rank).text = $"R{armourData.Rank}";
		if ((Object)(object)level != null)
		{
			((TMP_Text)level).text = ((armourData.ArmourEnum == ArmourEnum.Rock) ? "" : $"+{armourData.Level}");
		}
		if ((Object)(object)level2 != null)
		{
			((TMP_Text)level2).text = ((armourData.ArmourEnum == ArmourEnum.Rock) ? "" : $"+{armourData.Level}");
		}
		LoadConfig(armourData);
	}

	private void LoadConfig(ArmourData armourData)
	{
		rankBg.color = EquipSlotNew.RankBgColor(armourData.Rarity);
		frame.color = EquipSlotNew.FrameColor(armourData.Rarity);
		frame.sprite = ((armourData.ArmourEnum == ArmourEnum.Rock) ? rockBg : normalBg);
	}

	public void ClearObj()
	{
		GameEntry.Resource.UnLoadSpriteGroup(GetInstanceID().ToString());
	}
}
