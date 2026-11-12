using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_Jump_2 : SkillSimpleBase
{
	protected readonly TSVector2 LookAtJumpTarget = new TSVector2(0, 0);

	protected readonly FP rotateSpeed = 480;

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_K = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	protected override IEnumerator DoMainLogic()
	{
		MoveToPosition(new TSVector2(0, -2), 0.1, AdventureActor.MovementMode.Walk);
		yield return WaitTime(1.8);
	}
}
