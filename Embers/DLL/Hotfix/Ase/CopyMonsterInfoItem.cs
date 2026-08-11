using TMPro;
using UnityEngine;

namespace Ase;

public class CopyMonsterInfoItem : MonoBehaviour
{
	public TextMeshProUGUI text;

	public LoadUISprite icon;

	public void AddIndex(int index)
	{
		switch (index)
		{
		case 1:
			((TMP_Text)text).text = "第一波";
			break;
		case 2:
			((TMP_Text)text).text = "第二波";
			break;
		case 3:
			((TMP_Text)text).text = "第三波";
			break;
		default:
			((TMP_Text)text).text = $"第{index}波";
			break;
		}
	}

	public void AddMonster(MonsterInfoData infoData)
	{
		((TMP_Text)text).text = infoData.monsterName;
		icon.Path = "ItemIcons/Monster/" + infoData.monsterIcon;
	}
}
