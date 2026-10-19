namespace ACT.DialogueSystem;

public abstract class FixedPostProcessStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	public float delay;

	public float initialWeight;

	public float targetWeight = 1f;

	public float weightDuration = 0.5f;

	public bool tweenWeight = true;

	public bool waitEnd;

	public bool releaseOnExit;

	public bool releaseAfterAnimation;

	public bool releaseOnDialogueEnd = true;
}
