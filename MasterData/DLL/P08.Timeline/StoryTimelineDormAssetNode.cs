using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-资源")]
public class StoryTimelineDormAssetNode : PlayableAsset
{
	public bool isCreate;

	[Tooltip("需要是ABReources目录下的资源")]
	public string asset_path;

	[Tooltip("给创建后的资源一个名字标记")]
	public string asset_name;

	public Vector3 position;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		throw new NotImplementedException();
	}
}
