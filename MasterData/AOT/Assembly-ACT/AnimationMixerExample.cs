using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

public class AnimationMixerExample : MonoBehaviour
{
	[Header("Animation Clips")]
	public AnimationClip idleAnimation;

	public AnimationClip walkAnimation;

	public AnimationClip runAnimation;

	[Header("Blend Settings")]
	[Range(0f, 1f)]
	public float blendWeight;

	public float blendSpeed = 1f;

	private PlayableGraph playableGraph;

	private AnimationMixerPlayable mixerPlayable;

	private AnimationPlayableOutput playableOutput;

	private AnimationClipPlayable idlePlayable;

	private AnimationClipPlayable walkPlayable;

	private AnimationClipPlayable runPlayable;

	private void Start()
	{
		playableGraph = PlayableGraph.Create("AnimationMixerExample");
		idlePlayable = AnimationClipPlayable.Create(playableGraph, idleAnimation);
		walkPlayable = AnimationClipPlayable.Create(playableGraph, walkAnimation);
		runPlayable = AnimationClipPlayable.Create(playableGraph, runAnimation);
		mixerPlayable = AnimationMixerPlayable.Create(playableGraph, 3);
		playableGraph.Connect(idlePlayable, 0, mixerPlayable, 0);
		playableGraph.Connect(walkPlayable, 0, mixerPlayable, 1);
		playableGraph.Connect(runPlayable, 0, mixerPlayable, 2);
		playableOutput = AnimationPlayableOutput.Create(playableGraph, "Animation", GetComponent<Animator>());
		playableOutput.SetSourcePlayable(mixerPlayable);
		mixerPlayable.SetInputWeight(0, 1f);
		mixerPlayable.SetInputWeight(1, 0f);
		mixerPlayable.SetInputWeight(2, 0f);
		playableGraph.Play();
	}

	private void Update()
	{
		if (Input.GetKey(KeyCode.W))
		{
			mixerPlayable.SetInputWeight(0, 1f - blendWeight);
			mixerPlayable.SetInputWeight(1, blendWeight);
			mixerPlayable.SetInputWeight(2, 0f);
			if (blendWeight < 1f)
			{
				blendWeight += Time.deltaTime * blendSpeed;
			}
		}
		else if (Input.GetKey(KeyCode.R))
		{
			mixerPlayable.SetInputWeight(0, 0f);
			mixerPlayable.SetInputWeight(1, 1f - blendWeight);
			mixerPlayable.SetInputWeight(2, blendWeight);
			if (blendWeight < 1f)
			{
				blendWeight += Time.deltaTime * blendSpeed;
			}
		}
		else
		{
			mixerPlayable.SetInputWeight(0, 1f);
			mixerPlayable.SetInputWeight(1, 0f);
			mixerPlayable.SetInputWeight(2, 0f);
			blendWeight = 0f;
		}
	}

	private void OnDestroy()
	{
		if (playableGraph.IsValid())
		{
			playableGraph.Destroy();
		}
	}
}
