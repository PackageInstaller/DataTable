using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取场景坐标点配置", 0)]
[Category("✫ DragonLost/Scene")]
[Description("获取场景中指定名称的坐标点的位置和朝向")]
public class GetScenePointAction : ActionTaskBase
{
	[RequiredField]
	[Name("坐标索引", 0)]
	[Description("场景坐标点的名称")]
	public BBParameter<string> scenePointKey;

	[Name("目标位置", 0)]
	[Description("获取到的场景坐标点的位置")]
	public BBParameter<Vector3> targetPosition;

	[Name("目标朝向", 0)]
	[Description("获取到的场景坐标点的朝向")]
	public BBParameter<Vector3> targetRotation;

	protected override void OnExecute()
	{
		base.OnExecute();
		ScenePoint scenePoint = ownerEntity.GetSystem<SceneSystem>().GetScenePoint(scenePointKey.value);
		if (scenePoint == null)
		{
			OnActionFail();
			return;
		}
		targetPosition.value = scenePoint.transform.position;
		targetRotation.value = scenePoint.transform.eulerAngles;
		OnActionFinish();
	}
}
