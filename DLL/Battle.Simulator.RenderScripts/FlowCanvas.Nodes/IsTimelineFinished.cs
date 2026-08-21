using ParadoxNotion.Design;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("判断Timeline是否播放完毕", 0)]
[Category("Render/Asset")]
[Description("判断Timeline是否播放完毕")]
public class IsTimelineFinished : CallableFunctionNode<bool, PlayableDirector>
{
	public override bool Invoke(PlayableDirector director)
	{
		return director.state != PlayState.Playing;
	}
}
