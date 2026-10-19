using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TutorialReward : MonoBehaviour
{
	public BImage icon;

	public LocalizeStringEvent description;

	public void LoadIcon(int tutorialId, ImageAssetStation station)
	{
		int iconAddress = CoreUtils.GetData(CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials).reward[0].id, RuntimeConfigs.data.itemDatas).iconAddress;
		station.LoadItemIcon(iconAddress, icon);
	}

	public void LoadLoaclizeSteing(int referenceId)
	{
		description.StringReference.TableEntryReference = referenceId;
	}
}
