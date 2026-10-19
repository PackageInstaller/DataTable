using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public sealed class CinemachineShot : PlayableAsset, IPropertyPreview
{
	public string DisplayName;

	public ExposedReference<CinemachineVirtualCameraBase> VirtualCamera;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<CinemachineShotPlayable> scriptPlayable = ScriptPlayable<CinemachineShotPlayable>.Create(graph);
		scriptPlayable.GetBehaviour().VirtualCamera = VirtualCamera.Resolve(graph.GetResolver());
		return scriptPlayable;
	}

	public void GatherProperties(PlayableDirector director, IPropertyCollector driver)
	{
		driver.AddFromName<Transform>("m_LocalPosition.x");
		driver.AddFromName<Transform>("m_LocalPosition.y");
		driver.AddFromName<Transform>("m_LocalPosition.z");
		driver.AddFromName<Transform>("m_LocalRotation.x");
		driver.AddFromName<Transform>("m_LocalRotation.y");
		driver.AddFromName<Transform>("m_LocalRotation.z");
		driver.AddFromName<Transform>("m_LocalRotation.w");
		driver.AddFromName<Camera>("field of view");
		driver.AddFromName<Camera>("near clip plane");
		driver.AddFromName<Camera>("far clip plane");
	}
}
