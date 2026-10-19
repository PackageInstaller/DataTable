using System;
using ACT.Model;
using ACT.UI;

namespace ACT.Config;

[Serializable]
public abstract class GuideStepConfig
{
	public int id;

	public UI_TYPE condition;

	public CharacterViewScene.CvSceneType secondViewType;

	public SystemType SystemId = SystemType.None;

	public BloodBottleView.SubPanelType bloodBottleSubViewType;

	public bool waitForMapIconLoaded;

	public string actionPath = "UI/Interact";

	public GuideConsts.GuideType guideType;

	public bool needTextTips;

	public int tipsId;

	private bool ShowDefaultSelectBottleId
	{
		get
		{
			if (condition != UI_TYPE.UI_BLOODBOTTLE)
			{
				return SystemId == SystemType.BloodBottleUse;
			}
			return true;
		}
	}

	private static string[] GetAllActionPaths()
	{
		return ACTInputActions_ActionNameDefines.GetActionNames();
	}
}
