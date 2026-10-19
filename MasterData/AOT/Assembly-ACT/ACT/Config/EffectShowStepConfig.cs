using UnityEngine;

namespace ACT.Config;

public class EffectShowStepConfig : GuideStepConfig
{
	[SerializeReference]
	public FindHighlightObjAction findAction;
}
