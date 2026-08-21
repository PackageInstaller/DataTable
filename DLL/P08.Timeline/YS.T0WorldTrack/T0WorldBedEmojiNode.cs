using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldBedEmojiNode : PlayableAsset
{
	public bool endingHideEmoji = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<T0WorldBedEmojiNodeeBehaviour> scriptPlayable = ScriptPlayable<T0WorldBedEmojiNodeeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().endingHideEmoji = endingHideEmoji;
		return scriptPlayable;
	}
}
