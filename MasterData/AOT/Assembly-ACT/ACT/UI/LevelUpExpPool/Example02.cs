using System.Linq;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI.LevelUpExpPool;

internal class Example02 : MonoBehaviour
{
	[FormerlySerializedAs("scrollView")]
	[SerializeField]
	private LevelUpScrollView levelUpScrollView;

	[SerializeField]
	private Button prevCellButton;

	[SerializeField]
	private Button nextCellButton;

	[SerializeField]
	private Text selectedItemInfo;

	private void Start()
	{
		levelUpScrollView.OnSelectionChanged(OnSelectionChanged);
		LevelNumData[] items = (from i in Enumerable.Range(0, 20)
			select new LevelNumData()).ToArray();
		levelUpScrollView.UpdateData(items);
		levelUpScrollView.SelectCell(0);
	}

	private void OnSelectionChanged(int index)
	{
		selectedItemInfo.text = $"Selected item info: index {index}";
	}
}
