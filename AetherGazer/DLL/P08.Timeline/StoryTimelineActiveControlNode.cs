using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineActiveControlNode : PlayableAsset
{
	public StoryTimelineActiveControlType ctrlType = StoryTimelineActiveControlType.UI;

	public string sceneName = "C06";

	public string uiRootName = "UICamera";

	public string path = "Canvas/UIMain";

	public string childGoPath;

	public bool active = true;

	public bool inverseWhenFinished = true;

	public bool moveto;

	public bool startFromTargetPosition;

	public Vector3 startLocalPosition;

	public AnimationCurve moveCurve = new AnimationCurve();

	public Vector3 endLocalPosition;

	public bool rotate;

	public float rotateDegree;

	public AnimationCurve rotateCurve = new AnimationCurve();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineActiveControlNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineActiveControlNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().active = active;
		scriptPlayable.GetBehaviour().inverseWhenFinished = inverseWhenFinished;
		scriptPlayable.GetBehaviour().ctrlType = ctrlType;
		scriptPlayable.GetBehaviour().sceneName = sceneName;
		scriptPlayable.GetBehaviour().uiRootName = uiRootName;
		scriptPlayable.GetBehaviour().childGoPath = childGoPath;
		scriptPlayable.GetBehaviour().moveto = moveto;
		scriptPlayable.GetBehaviour().startFromTargetPosition = startFromTargetPosition;
		scriptPlayable.GetBehaviour().startLocalPosition = startLocalPosition;
		scriptPlayable.GetBehaviour().moveCurve = moveCurve;
		scriptPlayable.GetBehaviour().endLocalPosition = endLocalPosition;
		scriptPlayable.GetBehaviour().rotate = rotate;
		scriptPlayable.GetBehaviour().rotateDegree = rotateDegree;
		scriptPlayable.GetBehaviour().rotateCurve = rotateCurve;
		return scriptPlayable;
	}
}
