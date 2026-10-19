using System;
using ACT.Config;
using UnityEngine;

namespace ACT.Model;

[Serializable]
public class ActionGroup
{
	[SerializeReference]
	public GuideStepCondition[] conditions;

	[SerializeReference]
	public GuideStepAction[] actions;
}
