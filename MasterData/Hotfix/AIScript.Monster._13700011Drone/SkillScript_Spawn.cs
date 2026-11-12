namespace AIScript.Monster._13700011Drone;

public class SkillScript_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
		_actor.EnableUnparalleled();
	}
}
