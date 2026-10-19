using UnityEngine.Playables;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[MovedFrom("UnityEngine.Experimental.Animations")]
public interface IAnimationWindowPreview
{
	void UpdatePreviewGraph(PlayableGraph graph);
}
