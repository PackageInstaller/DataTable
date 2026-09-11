using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("timeline设置依赖", 0)]
[Category("Render/Asset")]
[Description("设置timeline依赖")]
public class SetTimelineTrackReference<T> : FlowNode where T : Object
{
	protected override void RegisterPorts()
	{
		ValueInput<PlayableDirector> director = AddValueInput<PlayableDirector>("director");
		ValueInput<string> trackName = AddValueInput<string>("轨道名");
		ValueInput<T> objectInput = AddValueInput<T>("值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			IEnumerator<PlayableBinding> enumerator = director.value.playableAsset.outputs.GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (enumerator.Current.streamName.Equals(trackName.value))
				{
					director.value.SetGenericBinding(enumerator.Current.sourceObject, objectInput.value);
				}
			}
			f.Call(output);
		});
	}
}
