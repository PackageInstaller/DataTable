using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_StopMove_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Book_Move";

	private string FxLink = "fx_m70001_loop_skill06_line";

	private long EffectName1;

	private List<TSVector2> LinkPosEnd = new List<TSVector2>
	{
		new TSVector2(-2.5, -10),
		new TSVector2(-2.5, -5),
		new TSVector2(2.5, -5),
		new TSVector2(2.5, -10)
	};

	protected override void OnInterrupt(int comboIndex)
	{
		StopEffect(EffectName1);
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 position = GetPosition();
		TSVector2 tSVector = LinkPosEnd.get_Item(0);
		FP fP = Distance(tSVector, position);
		PlayEffect("fx_m70001_base_skill06_shunyi_in", 1f, 0.5, position);
		for (int i = 0; i < LinkPosEnd.Count; i++)
		{
			if (Distance(LinkPosEnd.get_Item(i), position) <= fP)
			{
				fP = Distance(LinkPosEnd.get_Item(i), position);
				tSVector = LinkPosEnd.get_Item(i);
			}
		}
		EffectName1 = PlayLinkEffect(FxLink, useCustomSource: true, null, position, 1, null, tSVector, 0.1);
		yield return WaitTime(99);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
