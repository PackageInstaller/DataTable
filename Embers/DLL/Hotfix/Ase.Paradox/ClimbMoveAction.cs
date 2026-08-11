using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("攀爬", 0)]
[Description("执行实体的攀爬动作，可选择向上或向下攀爬，并指定攀爬的高度。")]
[Category("✫ DragonLost/Transform")]
public class ClimbMoveAction : ActionTaskBase
{
	[Name("攀爬方向 （1：向上 -1:向下）", 0)]
	[Description("指定攀爬的方向，1为向上，-1为向下。")]
	public BBParameter<int> climbDirect = new BBParameter<int>();

	[Name("高度", 0)]
	[Description("指定攀爬的高度。")]
	public BBParameter<float> climbHeight = new BBParameter<float>();

	[Name("目标实体ID", 0)]
	[Description("指定进行攀爬的目标实体的ID。")]
	public BBParameter<int> targetEntityId = new BBParameter<int>();

	[Name("洞窟传送", 0)]
	[Description("指定是否进行洞窟传送。")]
	[ShowIf("openTeleportMode", 1)]
	public CavesTransform CavesTransform;

	[Name("洞窟Id", 0)]
	[Description("进入洞窟的ID")]
	[ShowIf("openTeleportMode", 1)]
	public BBParameter<int> CavesId;

	[Name("开启传送", 0)]
	[Description("指定是否开启传送模式。")]
	public bool openTeleportMode;

	[Name("传送坐标点Key", 0)]
	[Description("指定传送的坐标点Key。")]
	[ShowIf("openTeleportMode", 1)]
	public BBParameter<string> scenePointKey = new BBParameter<string>();

	[Name("传送后移动高度", 0)]
	[Description("指定传送后进行移动的高度。")]
	[ShowIf("openTeleportMode", 1)]
	public BBParameter<float> nextClimbHeight = new BBParameter<float>();

	[Name("传送后移动朝向", 0)]
	[Description("指定传送后进行移动的朝向。")]
	[ShowIf("openTeleportMode", 1)]
	public BBParameter<float> nextStaircaseDirect = new BBParameter<float>();

	protected override void OnExecute()
	{
		base.OnExecute();
		if (targetEntityId == null)
		{
			OnActionFinish();
			return;
		}
		BaseEntity entity = GetEntity(targetEntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFinish();
			return;
		}
		ClimbExecute(entity);
		List<HeroEntity> teamHero = entity.GetSystem<EntitySystem>().GetTeamHero();
		float num = 1f;
		foreach (HeroEntity item in teamHero)
		{
			if (!item.IsActorEntity && !item.GetComponent<StateComponent>().IsDeadState() && !item.GetComponent<StateComponent>().IsNearDeathState() && item.GetComponent<AIParadoxComponent>().GetVariableValue<HeroAIStageEnum>("HeroAiStage") != HeroAIStageEnum.Wait)
			{
				ClimbExecute(item, num);
				num++;
			}
		}
		OnActionFinish();
	}

	public void ClimbExecute(BaseEntity targetEntity, float waittime = 0f)
	{
		ClimbMovementComponent component = targetEntity.GetComponent<ClimbMovementComponent>();
		if (component == null || component.IsClimbing)
		{
			OnActionFinish();
		}
		else if (openTeleportMode)
		{
			CavesTransform cavesTransform = CavesTransform.Null;
			if (targetEntity.IsActorEntity)
			{
				cavesTransform = CavesTransform;
			}
			ClimbMoveAndTeleport(component, GetOwnerEntity().transform.position, climbDirect.value, climbHeight.value, GetOwnerEntity().transform.rotation * Vector3.back, scenePointKey.value, nextClimbHeight.value, Quaternion.Euler(0f, nextStaircaseDirect.value, 0f) * Vector3.back, waittime, cavesTransform, CavesId.value);
		}
		else
		{
			ClimbMove(component, GetOwnerEntity().transform.position, climbDirect.value, climbHeight.value, GetOwnerEntity().transform.rotation * Vector3.back, waittime);
		}
	}

	public void ClimbMove(ClimbMovementComponent climbMovementComponent, Vector3 startPosition, int climbDirect, float climbHeight, Vector3 staircaseDirect, float waittime)
	{
		climbMovementComponent.ClimbMove(startPosition, climbDirect, climbHeight, staircaseDirect, waittime);
	}

	public void ClimbMoveAndTeleport(ClimbMovementComponent climbMovementComponent, Vector3 startPosition, int climbDirect, float climbHeight, Vector3 staircaseDirect, string scenePointKey, float nextClimbHeight, Vector3 nextStaircaseDirect, float waittime, CavesTransform cavesTransform, int cavesId)
	{
		climbMovementComponent.ClimbMoveAndTeleport(startPosition, climbDirect, climbHeight, staircaseDirect, scenePointKey, nextClimbHeight, nextStaircaseDirect, waittime, cavesTransform, cavesId);
	}
}
