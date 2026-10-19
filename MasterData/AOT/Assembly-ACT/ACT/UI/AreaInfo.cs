using ACT.Core;
using ACT.World;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AreaInfo : MonoBehaviour
{
	public LocalizeStringEvent areaNameLocalize;

	public void Init(MapArea area)
	{
		gameObject.SetActive(value: true);
		areaNameLocalize.StringReference.TableEntryReference = CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas).name;
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}
}
