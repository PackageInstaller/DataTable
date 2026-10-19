using Bamboo.ECS;

namespace ACT.UI;

public class OperateBtnDisplayData
{
	public UltraEnergyData CurUltraEnergyData;

	private OperateBtnStateConfigData StateConfigData { get; }

	public OperateBtnBindSkillInfo BindSkillInfo { get; set; }

	public int ImageGroupId => StateConfigData.ImageData.GroupId;

	public int ImageId => StateConfigData.ImageData.ImageId;

	public string MotionName => StateConfigData.MotionName;

	public string AbilityName => StateConfigData.AbilityName;

	public bool ShowCd => StateConfigData.ShowCd;

	public bool ShowInteractive => StateConfigData.InteractiveEnergyThreshold > 0f;

	public float InteractiveEnergyThreshold => StateConfigData.InteractiveEnergyThreshold;

	public bool ShowCount => StateConfigData.ShowCount;

	public bool ShowDuration => StateConfigData.ShowDuration;

	public SpskillType skillCurType => StateConfigData.CurSkillType;

	public float CurNormalEnergy { get; set; }

	public OperateBtnDisplayData(OperateBtnStateConfigData stateConfigData, Entity entity)
	{
		StateConfigData = stateConfigData;
		BindSkillInfo = OperateBtnUtility.GetSkillInfo(entity, stateConfigData);
		CurNormalEnergy = entity.GetCompAbility()?.EnergyValue ?? 0f;
		CurUltraEnergyData = new UltraEnergyData
		{
			curValue = (entity.GetCompAbility()?.CurrentUltimateSkillValue ?? 0f),
			percent = (entity.GetCompAbility()?.CurUltraEnergyPercent ?? 0f)
		};
	}
}
