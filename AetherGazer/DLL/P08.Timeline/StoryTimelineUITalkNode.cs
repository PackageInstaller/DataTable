using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineUITalkNode : PlayableAsset
{
	public int charName = 10660;

	public string charIcon;

	public int context = 3;

	public Vector2 pos;

	public bool needClick;

	public bool canSkip;

	public int skipFrame;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineUITalkNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineUITalkNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().charName = charName;
		scriptPlayable.GetBehaviour().charIcon = charIcon;
		scriptPlayable.GetBehaviour().context = context;
		scriptPlayable.GetBehaviour().pos = pos;
		scriptPlayable.GetBehaviour().needClick = needClick;
		scriptPlayable.GetBehaviour().canSkip = canSkip;
		scriptPlayable.GetBehaviour().skipFrame = skipFrame;
		return scriptPlayable;
	}
}
