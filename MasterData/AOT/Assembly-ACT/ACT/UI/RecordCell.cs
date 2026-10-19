using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RecordCell : MonoBehaviour
{
	public TextMeshProUGUI TextTime;

	public TextMeshProUGUI TextNum;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextType;

	[SerializeField]
	private Color HighlightColor;

	[SerializeField]
	private Color AColor;

	[SerializeField]
	private Color SColor;

	[SerializeField]
	private Color NormalColor;

	public void Init(GachaHistoryItem item)
	{
		ItemData data = CoreUtils.GetData(item.Item.Id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			if (data.type == 5)
			{
				TextName.GetComponent<TextMeshProUGUI>().color = ((data.quality == 5) ? SColor : AColor);
			}
			else
			{
				Color color;
				if (data.quality < 4)
				{
					color = NormalColor;
				}
				else
				{
					color = ((data.quality == 4) ? AColor : SColor);
				}
				TextName.GetComponent<TextMeshProUGUI>().color = color;
			}
			TextName.StringReference.TableEntryReference = data.nameLocal;
			TextType.StringReference.TableEntryReference = data.typeLocal;
			TextNum.text = item.Item.Count.ToString();
			TextTime.text = TimeManager.GetDateTimeString(item.DrawTimestamp, "yyyy/MM/dd  HH:mm:ss");
		}
	}
}
