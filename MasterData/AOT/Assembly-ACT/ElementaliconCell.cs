using ACT;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;

public class ElementaliconCell : MonoBehaviour
{
	public BImage ActIveIcon;

	public BImage UnActIveIcon;

	public Element element;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void Init(bool isactive)
	{
		ElementResonanceData data = CoreUtils.GetData((int)element, RuntimeConfigs.data.elementResonanceDatas);
		if (data != null)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.elementalResonanceAtlasAssetID, isactive ? data.activatedSmallIcon : data.inactivatedSmallIcon, isactive ? ActIveIcon : UnActIveIcon);
		}
		ActIveIcon.icon.gameObject.SetActive(isactive);
		UnActIveIcon.icon.gameObject.SetActive(!isactive);
	}
}
