using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class StarConditionItem2 : LoopListViewItem2
{
	[SerializeField]
	private UIStarGroup uiStarGroup;

	[SerializeField]
	private GameObject starDefault;

	[SerializeField]
	private GameObject starLight;

	[SerializeField]
	private GameObject starLose;

	[SerializeField]
	private TextMeshProUGUI text;

	private StarConditionItem2Data _data;

	public void Init(StarConditionItem2Data data)
	{
		_data = data;
		if (uiStarGroup != null)
		{
			uiStarGroup.CurCount = _data.StarCount;
		}
		else
		{
			switch (_data.SingleStarState)
			{
			case 0:
				starDefault.SetActive(value: true);
				break;
			case 1:
				starLose.SetActive(value: true);
				break;
			case 2:
				starLight.SetActive(value: true);
				break;
			}
		}
		((TMP_Text)text).text = _data.Text;
	}
}
