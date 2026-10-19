using ACT.Config;
using ACT.Core;
using ACT.World;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class LargeMapTargetPlaceCell : MonoBehaviour
{
	public LocalizeStringEvent localizeString;

	public TextMeshProUGUI num;

	public GameObject selected;

	public ActButton btn;

	private MapSubArea _subArea;

	public void Init(MapSubArea subAreaa, int count)
	{
		_subArea = subAreaa;
		gameObject.SetActive(value: true);
		selected.gameObject.SetActive(value: false);
		num.SetText("({0:0})", count);
		SubMapArea data = CoreUtils.GetData((int)subAreaa, RuntimeConfigs.data.subMapAreas);
		localizeString.StringReference.TableEntryReference = data.name;
	}

	public MapSubArea GetSubArea()
	{
		return _subArea;
	}

	public void SetSelected(bool select)
	{
		selected.gameObject.SetActive(select);
	}

	public void BindClick(UnityAction action)
	{
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(action);
	}

	public void OnDestroy()
	{
		btn?.OnClick.RemoveAllListeners();
	}
}
