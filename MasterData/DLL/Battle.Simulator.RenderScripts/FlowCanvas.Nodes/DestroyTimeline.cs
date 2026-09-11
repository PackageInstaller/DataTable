using System;
using ParadoxNotion.Design;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("回收Timeline", 0)]
[Category("Render/Asset")]
[Description("回收Timeline")]
public class DestroyTimeline : CallableActionNode<PlayableDirector>
{
	public override void Invoke(PlayableDirector director)
	{
		try
		{
			_ = director.gameObject.transform;
			PooledAsset.DestroyOrReturn(director.gameObject, 0.1f);
			director = null;
		}
		catch (Exception)
		{
		}
	}
}
