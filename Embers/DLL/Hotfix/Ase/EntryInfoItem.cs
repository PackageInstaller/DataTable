using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryInfoItem : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private new GameObject tag;

	[SerializeField]
	private TextMeshProUGUI effect;

	public void Refresh(EntryData data, bool isCurLevel, bool isMax = false)
	{
		((TMP_Text)level).text = (isMax ? "Lv.Max" : $"Lv.{data.DrEntry.Level}");
		((Graphic)(object)level).color = (isCurLevel ? Color.black : Color.gray);
		tag.SetActive(isCurLevel);
		((TMP_Text)effect).text = data.DrEntry.DetailDesc;
		((Graphic)(object)effect).color = (isCurLevel ? Color.black : Color.gray);
	}
}
