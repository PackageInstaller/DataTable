using System.Collections.Generic;

public class TimelineCharacterWeaponLineClipPlayer : CommonSimpleTimelineClipPlayer<CharacterWeaponLineClip>, ILoopClipPlayer
{
	public CharacterWeaponLinesHelper CharacterWeaponLinesHelper;

	protected override void _Initialize(List<CharacterWeaponLineClip> clips)
	{
	}

	protected override void _EnterNodes(List<CharacterWeaponLineClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetLines();
	}

	protected override void _UpdateNodes(List<CharacterWeaponLineClip> clipsInThisFrame, float normalized)
	{
		CharacterWeaponLineClip characterWeaponLineClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		CharacterWeaponLinesHelper.ShowLine(characterWeaponLineClip.LineEnable);
	}

	protected override void _ExitNodes(List<CharacterWeaponLineClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetLines();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetLines();
	}

	protected override void _Shutdown()
	{
		ResetLines();
	}

	public void ResetLines()
	{
		if (CharacterWeaponLinesHelper != null)
		{
			CharacterWeaponLinesHelper.ShowLine();
		}
	}
}
