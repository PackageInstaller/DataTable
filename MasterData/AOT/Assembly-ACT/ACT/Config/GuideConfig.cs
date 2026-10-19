using System.Collections.Generic;
using ACT.Model;
using UnityEngine;

namespace ACT.Config;

public class GuideConfig : ScriptableObject
{
	public int id;

	public GuideStepType guideType;

	[SerializeReference]
	public GuideStepCondition[] Conditions = new GuideStepCondition[0];

	[SerializeReference]
	public GuideFinshCondition[] FinshConditions = new GuideFinshCondition[0];

	public bool IsNeedSkip;

	[SerializeReference]
	public GuideStepAction[] Actions = new GuideStepAction[0];

	[SerializeReference]
	public GuideStepAction[] FinshActions = new GuideStepAction[0];

	[SerializeReference]
	public List<GuideStepConfig> mobileStepConfigs;

	public int mobileFinishStepIndex = -1;

	[SerializeReference]
	public List<GuideStepConfig> pcStepConfigs;

	public int pcFinishStepIndex = -1;

	[SerializeReference]
	public List<GuideStepConfig> handshankStepConfigs;

	public int handshankFinishStepIndex = -1;
}
