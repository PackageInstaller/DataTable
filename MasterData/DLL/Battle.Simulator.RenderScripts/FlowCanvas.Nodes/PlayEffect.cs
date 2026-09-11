using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放特效", 0)]
[Category("Render/Effect")]
[Description("播放一个特效,没有挂点,需要指定特效路径,位置和朝向,以及销毁的时间")]
[ExposeAsDefinition]
public class PlayEffect : CallableActionNode<string, Vector3, Vector3, float>
{
	public override void Invoke(string path, Vector3 position, Vector3 forward, float time)
	{
		try
		{
			GameObject gameObject = Asset.Instantiate(path);
			gameObject.transform.position = position;
			gameObject.transform.forward = forward;
			PooledAsset.DestroyOrReturn(gameObject, time);
		}
		catch (Exception)
		{
			Debug.Log("播放特效失败");
		}
	}
}
