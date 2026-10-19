using System;
using System.Collections.Generic;
using ACT.Model;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class SoftHighlightStepConfig : GuideStepConfig
{
	[SerializeReference]
	public FindHighlightObjAction findAction;

	[Header("引导存在时间(s)")]
	public int DeleteTime;

	public List<ActionGroup> conditionalActions = new List<ActionGroup>();

	[SerializeReference]
	public List<GuideStepFinishConditionConfig> finshConfig = new List<GuideStepFinishConditionConfig>();
}
