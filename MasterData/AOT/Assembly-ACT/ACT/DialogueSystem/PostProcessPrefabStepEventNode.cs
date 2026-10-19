namespace ACT.DialogueSystem;

public class PostProcessPrefabStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	public float delay;

	public string effectKey;

	public PostProcessPrefabOperation operation;

	public YooAssetReference postProcessPrefab;

	public string animationStateName;

	public int animationLayer;

	public float initialWeight;

	public float targetWeight = 1f;

	public float weightDuration = 0.5f;

	public bool playAnimation = true;

	public bool tweenWeight = true;

	public bool waitEnd;

	public bool releaseOnExit;

	public bool releaseAfterAnimation;

	public bool releaseOnDialogueEnd = true;
}
