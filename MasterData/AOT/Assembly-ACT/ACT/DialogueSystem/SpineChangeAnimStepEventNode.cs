using UnityEngine;

namespace ACT.DialogueSystem;

public class SpineChangeAnimStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	[Header("Animation Name")]
	public string animationName;

	[Header("Loop")]
	public bool loop = true;

	[Header("Track Index")]
	public int trackIndex;

	[Header("Clear Tracks")]
	public bool clearTracks;

	[Header("Mix Duration")]
	public float mixDuration;
}
