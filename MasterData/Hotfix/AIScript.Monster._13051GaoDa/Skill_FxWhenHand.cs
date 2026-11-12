using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_FxWhenHand : SkillSimpleBase
{
	private List<LogicEntity> LiveHandsL = new List<LogicEntity>();

	private List<LogicEntity> LiveHandsR = new List<LogicEntity>();

	private LogicEntity LeftHand;

	private LogicEntity RightHand;

	protected override IEnumerator DoMainLogic()
	{
		LiveHandsL = GetTargetByTeammateIndex(1);
		if (LiveHandsL.Count > 0)
		{
			LeftHand = LiveHandsL.get_Item(0);
		}
		LiveHandsR = GetTargetByTeammateIndex(2);
		if (LiveHandsR.Count > 0)
		{
			RightHand = LiveHandsR.get_Item(0);
		}
		if (LiveHandsL.Count > 0)
		{
			Skill_FxWhenHand skill_FxWhenHand = this;
			LogicEntity leftHand = LeftHand;
			skill_FxWhenHand.PlayLinkEffect("SkillFXL", useCustomSource: false, null, default, default, leftHand);
		}
		if (LiveHandsR.Count > 0)
		{
			Skill_FxWhenHand skill_FxWhenHand2 = this;
			LogicEntity leftHand = RightHand;
			skill_FxWhenHand2.PlayLinkEffect("SkillFXR", useCustomSource: false, null, default, default, leftHand);
		}
		PlayFx("SkillFXL2", 1f, 0, new TSVector2(0, 0), GetRotation());
		PlayFx("SkillFXR2", 1f, 0, new TSVector2(0, 0), GetRotation());
		PlayFx("SkillFXEyes", 1f, 0, new TSVector2(0, 0), GetRotation());
		yield return WaitTime(2);
	}
}
