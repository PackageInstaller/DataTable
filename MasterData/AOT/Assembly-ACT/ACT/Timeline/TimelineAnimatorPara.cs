using System;

namespace ACT.Timeline;

[Serializable]
public class TimelineAnimatorPara
{
	public enum ParamType
	{
		Trigger,
		Bool,
		CrossFade
	}

	public string paramName;

	public ParamType paramType;

	public bool newValue;

	public float crossFadetime;
}
