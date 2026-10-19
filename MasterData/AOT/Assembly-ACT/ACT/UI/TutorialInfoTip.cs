using ACT.Config;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TutorialInfoTip : UIBehaviour
{
	public BImage tutorialTypeImage;

	public LocalizeStringEvent contentLocalize;

	public LocalizeStringEvent titleLocalize;

	public OperateBtnPrompt operateBtnPrompt;

	public Image time_Progress;

	public void Init(GuideTutorial tutorialData, ImageAssetStation station)
	{
		if (time_Progress != null)
		{
			time_Progress.fillAmount = 1f;
		}
		station?.LoadImage(180, tutorialData.tutorialType, tutorialTypeImage);
		contentLocalize.StringReference.TableEntryReference = tutorialData.tutorialTitle;
		int id = tutorialData.tutorialType switch
		{
			1 => 657, 
			2 => 1015, 
			3 => 1016, 
			4 => 1017, 
			_ => 0, 
		};
		titleLocalize?.SetReference(LocalizeTable.Common, id);
	}

	public void SetProgress(float progress)
	{
		if (time_Progress != null)
		{
			time_Progress.fillAmount = Mathf.Clamp01(progress);
		}
	}

	public void UnInit()
	{
	}
}
