using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取和实体的距离", 0)]
[Description("计算当前实体与目标位置之间的距离，并保存到指定的黑板变量中。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityDistance : ActionTaskBase
{
	[BlackboardOnly]
	[Name("保存距离", 0)]
	[Description("保存计算得到的距离值的黑板变量")]
	public BBParameter<float> saveAs;

	[Name("目标坐标", 0)]
	[Description("要计算距离的目标位置")]
	public BBParameter<Vector3> targetPosition;

	protected override void OnExecute()
	{
		base.OnExecute();
		saveAs.value = Vector3.Distance(ownerEntity.transform.position, targetPosition.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取和实体的距离  {saveAs.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
