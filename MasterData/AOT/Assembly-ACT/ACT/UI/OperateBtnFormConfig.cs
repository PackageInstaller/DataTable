using System;
using ACT.Config;

namespace ACT.UI;

[Serializable]
public class OperateBtnFormConfig
{
	public string skillName;

	public SpskillType spSkillCurType;

	public GroupImageConfig imageData;

	public bool showCd;

	public float interactiveEnergyThreshold;

	public bool showCount;

	public bool showDuration;

	public string abilityName;
}
