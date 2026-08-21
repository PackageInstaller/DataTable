using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EquipSlotNew : UGuiView
{
	[SerializeField]
	public Button button;

	[SerializeField]
	private GameObject equip;

	[SerializeField]
	private GameObject empty;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private Image frameBg;

	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private GameObject tipImg;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private Image frame2;

	private string path = "";

	private string entryPath = "";

	public async void RefreshData(ArmourData armourData, bool tipShow = false)
	{
		equip.SetActive(value: false);
		empty.SetActive(value: false);
		if (armourData != null)
		{
			equip.SetActive(value: true);
			path = AssetUtility.GetTextureIconSprite("Equipment/ArmourIcon/" + armourData.Icon + ".png");
			Image image = icon;
			image.sprite = await LoadSpriteAsync(path);
			if (entryIcon != null)
			{
				entryPath = AssetUtility.GetTextureIconSprite("BuffIcon/Folder/EntryIcon/" + armourData.EntryDataList[0].IconPath + "_Rock.png");
				image = entryIcon;
				image.sprite = await LoadSpriteAsync(entryPath);
			}
			rankBg.color = RankBgColor(armourData.Rarity);
			((TMP_Text)rank).text = $"R{armourData.Rank}";
			if ((Object)(object)level != null)
			{
				((TMP_Text)level).text = $"+{armourData.Level}";
			}
			if (frame != null)
			{
				frame.color = FrameColor(armourData.Rarity);
			}
			if (frameBg != null)
			{
				frameBg.color = FrameBgColor(armourData.Rarity);
			}
			if (frame2 != null)
			{
				frame2.color = FrameBgColor(armourData.Rarity);
			}
		}
		else
		{
			empty.SetActive(value: true);
			if (tipImg != null)
			{
				tipImg.SetActive(tipShow);
			}
			if (frame2 != null)
			{
				frame2.color = Color.white;
			}
		}
	}

	public static Color RankBgColor(int rarity)
	{
		string htmlString = "";
		switch (rarity)
		{
		case 0:
			htmlString = "#d7d7d7";
			break;
		case 1:
			htmlString = "#9becdb";
			break;
		case 2:
			htmlString = "#a3ccff";
			break;
		case 3:
			htmlString = "#b1abff";
			break;
		case 4:
			htmlString = "#fbc584";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public static Color FrameColor(int rarity)
	{
		string htmlString = "";
		switch (rarity)
		{
		case 0:
			htmlString = "#FFFFFF";
			break;
		case 1:
			htmlString = "#9BFFCE";
			break;
		case 2:
			htmlString = "#86ACFF";
			break;
		case 3:
			htmlString = "#F2C4FF";
			break;
		case 4:
			htmlString = "#FED88C";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public static Color FrameBgColor(int rarity)
	{
		string htmlString = "";
		switch (rarity)
		{
		case 0:
			htmlString = "#a3a3a3";
			break;
		case 1:
			htmlString = "#93b1a0";
			break;
		case 2:
			htmlString = "#abcbf5";
			break;
		case 3:
			htmlString = "#bda8ff";
			break;
		case 4:
			htmlString = "#ffd78d";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}
}
