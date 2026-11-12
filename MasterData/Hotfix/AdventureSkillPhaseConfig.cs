using System;

[Serializable]
public class AdventureSkillPhaseConfig
{
	public SkillPhaseConfig _executeSkillPhaseConfig;

	public SkillPhaseConfig _breakSkillPhaseConfig;

	public SkillPhaseConfig ExecuteSkillPhaseConfig
	{
		get
		{
			return _executeSkillPhaseConfig;
		}
		set
		{
			_executeSkillPhaseConfig = value;
		}
	}

	public SkillPhaseConfig BreakSkillPhaseConfig
	{
		get
		{
			return _breakSkillPhaseConfig;
		}
		set
		{
			_breakSkillPhaseConfig = value;
		}
	}

	public AdventureSkillPhaseConfig()
	{
	}

	public AdventureSkillPhaseConfig(bool canExecute, bool canBreak)
	{
		_executeSkillPhaseConfig = new SkillPhaseConfig();
		_executeSkillPhaseConfig.skillPhaseFeatureFlag = (canExecute ? SkillPhaseFeatureFlag.All : SkillPhaseFeatureFlag.None);
		_breakSkillPhaseConfig = new SkillPhaseConfig();
		if (canBreak)
		{
			_breakSkillPhaseConfig.skillPhaseFeatureFlag = SkillPhaseFeatureFlag.Normal | SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate | SkillPhaseFeatureFlag.CertainSkillId | SkillPhaseFeatureFlag.LoadBullet;
		}
		else
		{
			_breakSkillPhaseConfig.skillPhaseFeatureFlag = SkillPhaseFeatureFlag.None;
		}
	}

	public void Clear()
	{
		_executeSkillPhaseConfig.skillIds?.Clear();
		_executeSkillPhaseConfig = null;
		_breakSkillPhaseConfig.skillIds?.Clear();
		_breakSkillPhaseConfig = null;
	}
}
