namespace UnityEngine.Playables;

public interface IPlayableAsset
{
	double duration { get; }

	Playable CreatePlayable(PlayableGraph graph, GameObject owner);
}
