using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldSubtitleNode : PlayableAsset
{
	[HideInInspector]
	public T0WorldSubtitleBehaviour template;

	public int formID;

	public string file;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<T0WorldSubtitleBehaviour> scriptPlayable = ScriptPlayable<T0WorldSubtitleBehaviour>.Create(graph, template);
		scriptPlayable.GetBehaviour().SetData(formID, file);
		return scriptPlayable;
	}
}
