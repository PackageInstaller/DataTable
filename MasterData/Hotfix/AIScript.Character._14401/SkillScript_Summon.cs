using System;
using AIScript.Utils;

namespace AIScript.Character._14401;

public class SkillScript_Summon : SkillAdvancedBase
{
	private string _comboTag;

	private bool _closeBlock;

	private bool _openCrossObstacleMode;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_comboTag = _actor.logicVariable.GetLogicTagStringValue("SkillComboTag_Summon");
		_closeBlock = _actor.logicVariable.GetLogicTagToggle("CloseBlock_Summon");
		_openCrossObstacleMode = _actor.logicVariable.GetLogicTagToggle("OpenCrossObstacleMode_Summon");
		if (_closeBlock)
		{
			_actor.EnableCloseBlock();
		}
		if (_openCrossObstacleMode)
		{
			CommonUtils.EnableCrossObstacleMode(_actor);
		}
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_comboTag))
		{
			OnFinish();
			return;
		}
		if (_openCrossObstacleMode)
		{
			CommonUtils.CheckAndSetCrossObstacleMode(_actor, Config_MainControl.realMoveDistance_Skill, Config_MainControl.crossAdditionDistance_Skill, Config_MainControl.crossKeepAwayNavmeshEdgeDistance_Skill, forceUseForwardDirection: true);
		}
		string comboTag = _comboTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_closeBlock)
		{
			_actor.DisableCloseBlock();
		}
		if (_openCrossObstacleMode)
		{
			CommonUtils.DisableCrossObstacleMode(_actor);
			CommonUtils.ClearCrossObstacleMode(_actor);
		}
		_comboTag = null;
		_closeBlock = false;
		_openCrossObstacleMode = false;
	}
}
