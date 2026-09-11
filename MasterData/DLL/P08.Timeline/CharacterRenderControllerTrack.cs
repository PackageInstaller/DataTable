using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[TrackClipType(typeof(CharacterRenderControlAllNode))]
[TrackBindingType(typeof(HeroUITimelineBrain))]
public class CharacterRenderControllerTrack : TrackAsset
{
	public bool isUsePath;

	public ExposedReference<GameObject> controlObject;

	public string controlPath;

	protected override Playable CreatePlayable(PlayableGraph graph, GameObject gameObject, TimelineClip clip)
	{
		if (clip.asset is CharacterRenderControlAllNode characterRenderControlAllNode)
		{
			GameObject gameObject2 = null;
			if (isUsePath)
			{
				PlayableDirector playableDirector = graph.GetResolver() as PlayableDirector;
				HeroUITimelineBrain heroUITimelineBrain = playableDirector.GetGenericBinding(this) as HeroUITimelineBrain;
				if (heroUITimelineBrain == null)
				{
					return Playable.Null;
				}
				gameObject2 = ((!string.IsNullOrEmpty(controlPath)) ? heroUITimelineBrain.FindTarget(controlPath, playableDirector.transform) : heroUITimelineBrain.gameObject);
			}
			else
			{
				gameObject2 = controlObject.Resolve(graph.GetResolver());
			}
			if (gameObject2 == null)
			{
				if (isUsePath)
				{
					Debug.LogError(gameObject.name + "的CharacterRenderControllerTrack(" + base.name + ")无法找到控制物体, 路径: " + controlPath);
				}
				else
				{
					Debug.LogError(gameObject.name + "的CharacterRenderControllerTrack(" + base.name + ")无法找到控制物体");
				}
				return Playable.Null;
			}
			characterRenderControlAllNode.controlObject = gameObject2;
		}
		return base.CreatePlayable(graph, gameObject, clip);
	}
}
