using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Playables;

namespace FlowCanvas.Nodes;

[Name("播放Timeline", 0)]
[Category("Render/Asset")]
[Description("播放Timeline")]
public class PlayTimeline : CallableFunctionNode<PlayableDirector, string>
{
	public override PlayableDirector Invoke(string prefabPath)
	{
		GameObject gameObject = Asset.Instantiate(prefabPath);
		SimEntity simEntity = ContextsExtensions.GetEntityWithEntityID(mID: SpawnProcessor.GetLocalPlayerID(), context: base.parentNode.mSimContext);
		Vector3 position = default(Vector3);
		Vector3 forward = default(Vector3);
		if (simEntity != null && simEntity.hasEntityPositon)
		{
			position = (Vector3)simEntity.entityPositon.mPosition;
			forward = (Vector3)simEntity.entityPositon.mForward;
		}
		gameObject.transform.position = position;
		gameObject.transform.forward = forward;
		PlayableDirector component = gameObject.GetComponent<PlayableDirector>();
		if (component == null)
		{
			return null;
		}
		component.Play();
		return component;
	}
}
