using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class HighlightStepConfig : GuideStepConfig
{
	[SerializeReference]
	public FindHighlightObjAction findAction;

	public bool clickAnywhere;

	[SerializeReference]
	public GuideStepAction[] Actions = new GuideStepAction[0];

	[SerializeReference]
	public GuideStepAction[] FinshActions = new GuideStepAction[0];

	public HighlightGuideSkipPosType SkipPosType;

	public int guideTutorialDesId;

	public HighlightGuideStepTextPosType textPosType;
}
