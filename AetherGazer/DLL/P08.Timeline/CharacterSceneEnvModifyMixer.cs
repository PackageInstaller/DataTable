using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Playables;

internal class CharacterSceneEnvModifyMixer : PlayableBehaviour
{
	private CharacterSceneEnvironment env;

	public Color skyColor;

	public Color equatorColor;

	public Color groundColor;

	public override void OnPlayableCreate(Playable playable)
	{
		env = Object.FindFirstObjectByType<CharacterSceneEnvironment>();
		if (!(env == null))
		{
			skyColor = env.skyColor;
			equatorColor = env.equatorColor;
			groundColor = env.groundColor;
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		UpdateCharacterSceneEnvComParam(skyColor, equatorColor, groundColor);
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!(env == null))
		{
			int inputCount = playable.GetInputCount();
			Color clear = Color.clear;
			Color clear2 = Color.clear;
			Color clear3 = Color.clear;
			float num = 0f;
			for (int i = 0; i < inputCount; i++)
			{
				float inputWeight = playable.GetInputWeight(i);
				CharacterSceneEnvModifyBehaviour behaviour = ((ScriptPlayable<CharacterSceneEnvModifyBehaviour>)playable.GetInput(i)).GetBehaviour();
				clear += Color.LerpUnclamped(Color.clear, behaviour.skyColor, inputWeight);
				clear2 += Color.LerpUnclamped(Color.clear, behaviour.equatorColor, inputWeight);
				clear3 += Color.LerpUnclamped(Color.clear, behaviour.groundColor, inputWeight);
				num += inputWeight;
			}
			clear += Color.LerpUnclamped(Color.clear, skyColor, 1f - num);
			clear2 += Color.LerpUnclamped(Color.clear, equatorColor, 1f - num);
			clear3 += Color.LerpUnclamped(Color.clear, groundColor, 1f - num);
			UpdateCharacterSceneEnvComParam(clear, clear2, clear3);
		}
	}

	private void UpdateCharacterSceneEnvComParam(Color sky, Color equator, Color ground)
	{
		if ((bool)env)
		{
			env.skyColor = sky;
			env.equatorColor = equator;
			env.groundColor = ground;
		}
	}
}
