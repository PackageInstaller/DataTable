using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class ActorSkillManage : LogicComponent
{
	[Space]
	protected readonly List<AdventureSkill> _attachedSkills = new List<AdventureSkill>();

	[Space]
	protected readonly List<AdventureSkill> _attachedPassiveSkills = new List<AdventureSkill>();

	public AdventureSkill FirstSkill
	{
		get
		{
			if (_attachedSkills.Count <= 0)
			{
				return null;
			}
			return _attachedSkills.get_Item(0);
		}
	}

	public void PauseSkillBehaviour()
	{
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			_attachedSkills.get_Item(i).PauseLogicUpdate();
		}
		for (int j = 0; j < _attachedPassiveSkills.Count; j++)
		{
			_attachedPassiveSkills.get_Item(j).PauseLogicUpdate();
		}
	}

	public void ResumeSkillBehaviour()
	{
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			_attachedSkills.get_Item(i).ResumeLogicUpdate();
		}
		for (int j = 0; j < _attachedPassiveSkills.Count; j++)
		{
			_attachedPassiveSkills.get_Item(j).ResumeLogicUpdate();
		}
	}

	public void LogicUpdate(FP deltaTime)
	{
		for (int num = _attachedSkills.Count - 1; num >= 0; num--)
		{
			if (_attachedSkills.get_Item(num).IsRemoved)
			{
				_attachedSkills.RemoveAt(num);
			}
		}
		for (int num2 = _attachedPassiveSkills.Count - 1; num2 >= 0; num2--)
		{
			if (_attachedPassiveSkills.get_Item(num2).IsRemoved)
			{
				_attachedPassiveSkills.RemoveAt(num2);
			}
		}
	}

	public void AddAttachedSkill(AdventureSkill skill)
	{
		if (!_attachedSkills.Contains(skill))
		{
			_attachedSkills.Add(skill);
		}
	}

	public void AddAttachedPassiveSkill(AdventureSkill skill)
	{
		if (!_attachedPassiveSkills.Contains(skill))
		{
			_attachedPassiveSkills.Add(skill);
		}
	}

	public void RemoveAttachedSkill(AdventureSkill skill)
	{
		if (!_attachedSkills.Remove(skill))
		{
			_attachedPassiveSkills.Remove(skill);
		}
	}

	public void DestoryAllSkill(bool isRelease = false)
	{
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			_attachedSkills.get_Item(i).Clear(isRelease);
		}
		_attachedSkills.Clear();
	}

	public void DestroyPassiveSkill(AdventureSkill skill)
	{
		if (_attachedPassiveSkills.Contains(skill))
		{
			skill.Clear();
		}
	}

	public void DestroyAllPassiveSkill()
	{
		for (int i = 0; i < _attachedPassiveSkills.Count; i++)
		{
			_attachedPassiveSkills.get_Item(i).Clear();
		}
		_attachedPassiveSkills.Clear();
	}

	public bool CheckIsSkillExecutable(SkillPhaseFeatureFlag skillCastBehaviourType, int skillId)
	{
		SkillPhaseFeatureFlag skillPhaseFeatureFlag = SkillPhaseFeatureFlag.Normal | SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate | SkillPhaseFeatureFlag.CertainSkillId | SkillPhaseFeatureFlag.LoadBullet;
		if ((skillCastBehaviourType & skillPhaseFeatureFlag) == 0)
		{
			Debug.LogError("skillCastBehaviourType invalid,only can be :Normal/Skill1/Skill2/Dodge/Ultimate/CertainSkillId");
			return false;
		}
		return CheckIsExecute(skillCastBehaviourType, skillId);
	}

	public bool CheckIsSkillExecutableWhenSemiAutoBattle()
	{
		if (!ModuleController<AdventureModuleController>.Instance.SemiAutoBattle)
		{
			return true;
		}
		if (_attachedSkills.Count == 0)
		{
			return true;
		}
		bool result = true;
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (!_attachedSkills.get_Item(i).IsRemoved && (_attachedSkills.get_Item(i).skillCastBehaviourType == SkillPhaseFeatureFlag.Normal || _attachedSkills.get_Item(i).skillCastBehaviourType == SkillPhaseFeatureFlag.Skill1 || _attachedSkills.get_Item(i).skillCastBehaviourType == SkillPhaseFeatureFlag.Ultimate) && !_attachedSkills.get_Item(i).CanExecuteOtherSkillWhenSemiAutoBattle)
			{
				result = false;
				break;
			}
		}
		return result;
	}

	public bool CheckIsMovable()
	{
		return CheckIsExecute(SkillPhaseFeatureFlag.Move);
	}

	protected bool CheckIsExecute(SkillPhaseFeatureFlag skillCastBehaviourType, int skillId = 0)
	{
		bool result = true;
		if (_attachedSkills.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (_attachedSkills.get_Item(i).IsRemoved)
			{
				continue;
			}
			SkillPhaseConfig currentPhaseExecuteConfig = _attachedSkills.get_Item(i).GetCurrentPhaseExecuteConfig();
			if (currentPhaseExecuteConfig == null)
			{
				continue;
			}
			if ((currentPhaseExecuteConfig.skillPhaseFeatureFlag & skillCastBehaviourType) == 0)
			{
				result = false;
				break;
			}
			if ((skillCastBehaviourType & SkillPhaseFeatureFlag.CertainSkillId) != 0)
			{
				List<int> skillIds = currentPhaseExecuteConfig.skillIds;
				if (skillIds != null && skillIds.Count > 0 && !currentPhaseExecuteConfig.skillIds.Contains(skillId))
				{
					result = false;
					break;
				}
			}
		}
		return result;
	}

	public bool BreakOthers(SkillPhaseFeatureFlag skillCastBehaviourType, int skillId = 0, List<int> breakSkillIdList = null)
	{
		bool result = false;
		for (int num = _attachedSkills.Count - 1; num >= 0; num--)
		{
			if (!_attachedSkills.get_Item(num).IsRemoved)
			{
				bool flag = true;
				SkillPhaseConfig currentPhaseBreakConfig = _attachedSkills.get_Item(num).GetCurrentPhaseBreakConfig();
				if (currentPhaseBreakConfig != null)
				{
					if ((currentPhaseBreakConfig.skillPhaseFeatureFlag & skillCastBehaviourType) != 0)
					{
						if ((skillCastBehaviourType & SkillPhaseFeatureFlag.CertainSkillId) != 0)
						{
							List<int> skillIds = currentPhaseBreakConfig.skillIds;
							if (skillIds != null && skillIds.Count > 0 && !currentPhaseBreakConfig.skillIds.Contains(skillId))
							{
								flag = false;
							}
						}
					}
					else
					{
						flag = false;
					}
				}
				if (flag)
				{
					breakSkillIdList?.Add(_attachedSkills.get_Item(num).skillId);
					_attachedSkills.get_Item(num).Clear();
					result = true;
				}
			}
		}
		return result;
	}

	public bool HaveRunningSkill()
	{
		bool flag = _attachedSkills.Count > 0;
		if (flag)
		{
			flag = false;
			for (int i = 0; i < _attachedSkills.Count; i++)
			{
				if (!_attachedSkills.get_Item(i).IsRemoved)
				{
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

	public bool HaveSkill(int skillId)
	{
		if (_attachedSkills.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (!_attachedSkills.get_Item(i).IsRemoved && _attachedSkills.get_Item(i).skillId == skillId)
			{
				return true;
			}
		}
		return false;
	}

	public bool HaveSkill(SkillPhaseFeatureFlag skillPhaseFeatureFlag)
	{
		if (_attachedSkills.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (!_attachedSkills.get_Item(i).IsRemoved && (skillPhaseFeatureFlag & _attachedSkills.get_Item(i).skillCastBehaviourType) != 0)
			{
				return true;
			}
		}
		return false;
	}

	public void ClearSkillById(int skillId)
	{
		if (_attachedSkills.Count == 0)
		{
			return;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (_attachedSkills.get_Item(i).skillId == skillId)
			{
				if (!_attachedSkills.get_Item(i).IsRemoved)
				{
					_attachedSkills.get_Item(i).Clear();
				}
				break;
			}
		}
	}

	public bool CheckCanExit()
	{
		_ = _attachedSkills.Count;
		return true;
	}

	public bool HaveDodgeSkill()
	{
		if (_attachedSkills.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (!_attachedSkills.get_Item(i).IsRemoved && _attachedSkills.get_Item(i).skillCastBehaviourType == SkillPhaseFeatureFlag.Dodge)
			{
				return true;
			}
		}
		return false;
	}

	public AdventureSkill GetDodgeSkill()
	{
		if (_attachedSkills.Count == 0)
		{
			return null;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (!_attachedSkills.get_Item(i).IsRemoved && _attachedSkills.get_Item(i).skillCastBehaviourType == SkillPhaseFeatureFlag.Dodge)
			{
				return _attachedSkills.get_Item(i);
			}
		}
		return null;
	}

	public bool HaveRushSkill()
	{
		if (_attachedSkills.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < _attachedSkills.Count; i++)
		{
			if (!_attachedSkills.get_Item(i).IsRemoved && _attachedSkills.get_Item(i).skillCastBehaviourType == SkillPhaseFeatureFlag.Skill2)
			{
				return true;
			}
		}
		return false;
	}

	public void ForceBreakSkill(SkillPhaseFeatureFlag skillPhaseFeatureFlag)
	{
		if (_attachedSkills.Count == 0)
		{
			return;
		}
		List<AdventureSkill> list = _attachedSkills.FindAll((AdventureSkill skill) => (skillPhaseFeatureFlag & skill.skillCastBehaviourType) != 0);
		if (list.Count <= 0)
		{
			return;
		}
		for (int num = 0; num < list.Count; num++)
		{
			if (!_attachedSkills.get_Item(num).IsRemoved)
			{
				list.get_Item(num).Clear();
			}
		}
	}
}
