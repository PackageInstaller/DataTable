using System.Collections;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11001;

public class Skill_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.EnableCloseBlock();
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_Spawn skill_Spawn = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Spawn.PlayEffect("fx_11001_base_FenShen_Birth", 1f, default, position, rotation);
		yield break;
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
