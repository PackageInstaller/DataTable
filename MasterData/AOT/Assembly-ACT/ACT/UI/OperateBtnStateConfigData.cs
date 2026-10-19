using ACT.Utility;

namespace ACT.UI;

public class OperateBtnStateConfigData
{
	public string MotionName { get; }

	public GroupImageData ImageData { get; }

	public bool ShowCd { get; }

	public float InteractiveEnergyThreshold { get; }

	public bool ShowCount { get; }

	public bool ShowDuration { get; }

	public string AbilityName { get; }

	public SpskillType CurSkillType { get; }

	public OperateBtnStateConfigData(OperateBtnFormConfig config)
	{
		MotionName = config.skillName;
		CurSkillType = config.spSkillCurType;
		ImageData = new GroupImageData(config.imageData);
		ShowCd = config.showCd;
		InteractiveEnergyThreshold = config.interactiveEnergyThreshold;
		ShowCount = config.showCount;
		ShowDuration = config.showDuration;
		AbilityName = config.abilityName;
	}
}
