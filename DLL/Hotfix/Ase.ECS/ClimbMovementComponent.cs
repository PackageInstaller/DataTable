#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class ClimbMovementComponent : BaseComponent
{
	public class ClimbMoveConfig
	{
		public AnimationCurve StartCurveX;

		public AnimationCurve StartCurveY;

		public AnimationCurve StartCurveZ;

		public float climbStartAniTime;

		public AnimationCurve EndCurveX;

		public AnimationCurve EndCurveY;

		public AnimationCurve EndCurveZ;

		public float climbEndAniTime;

		public string climbAnimationClipName;

		public float climbSpeed;

		public float climbEndDistance;

		public float stepDistance;
	}

	private bool isClimbing;

	private float waittime;

	private int climbDirect;

	private Vector3 startPosition;

	private Vector3 endPosition;

	private Vector3 staircaseDirect;

	private float climbHeight;

	private float nextClimbHeight;

	private Vector3 nextStaircaseDirect;

	private ScenePoint scenePoint;

	private CavesTransform cavesTransform;

	private int cavesId;

	private float climbCurrentTime;

	private float climbStartAniTime;

	private float climbLoopTime;

	private float climbEndAniTime;

	private float climbNextLoopTime;

	private ClimbMoveConfig climbMoveUpSetting;

	private ClimbMoveConfig climbMoveDownSetting;

	private int stepIndex;

	private Vector3 currentPosition;

	private float currentPercent;

	private bool teleportMode;

	private KinematicMoveComponent _kinematicMoveComponent;

	private ClimbMoveConfig CurrentClimbMoveConfig
	{
		get
		{
			if (climbDirect != 1)
			{
				return climbMoveDownSetting;
			}
			return climbMoveUpSetting;
		}
	}

	public bool IsClimbing => isClimbing;

	public override void OnStart(object data = null)
	{
		CharacterClimbConfig configByHeroId = base.Entity.GetWorld().CharacterClimbSetting.GetConfigByHeroId(base.Entity.EntityId);
		if (configByHeroId != null)
		{
			climbMoveUpSetting = new ClimbMoveConfig
			{
				StartCurveX = configByHeroId.ClimbUpStartConfig.climbCurveX,
				StartCurveY = configByHeroId.ClimbUpStartConfig.climbCurveY,
				StartCurveZ = configByHeroId.ClimbUpStartConfig.climbCurveZ,
				climbStartAniTime = configByHeroId.ClimbUpStartConfig.ClipTime,
				EndCurveX = configByHeroId.ClimbUpEndConfig.climbCurveX,
				EndCurveY = configByHeroId.ClimbUpEndConfig.climbCurveY,
				EndCurveZ = configByHeroId.ClimbUpEndConfig.climbCurveZ,
				climbEndAniTime = configByHeroId.ClimbUpEndConfig.ClipTime,
				climbAnimationClipName = "up",
				climbSpeed = configByHeroId.speed,
				climbEndDistance = configByHeroId.climbUpEndDistance,
				stepDistance = configByHeroId.stepDistance
			};
			climbMoveDownSetting = new ClimbMoveConfig
			{
				StartCurveX = configByHeroId.ClimbDownStartConfig.climbCurveX,
				StartCurveY = configByHeroId.ClimbDownStartConfig.climbCurveY,
				StartCurveZ = configByHeroId.ClimbDownStartConfig.climbCurveZ,
				climbStartAniTime = configByHeroId.ClimbDownStartConfig.ClipTime,
				EndCurveX = configByHeroId.ClimbDownEndConfig.climbCurveX,
				EndCurveY = configByHeroId.ClimbDownEndConfig.climbCurveY,
				EndCurveZ = configByHeroId.ClimbDownEndConfig.climbCurveZ,
				climbEndAniTime = configByHeroId.ClimbDownEndConfig.ClipTime,
				climbAnimationClipName = "down",
				climbSpeed = configByHeroId.speed,
				climbEndDistance = configByHeroId.climbDownEndDistance,
				stepDistance = configByHeroId.stepDistance
			};
			_kinematicMoveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (isClimbing)
		{
			if (waittime > 0f)
			{
				waittime = Mathf.Max(0f, waittime - deltaTime);
			}
			else if (!teleportMode)
			{
				OnClimbMoveUpdate(deltaTime);
			}
			else
			{
				OnTeleportClimbMoveUpdate(deltaTime);
			}
		}
	}

	public void ClimbMove(Vector3 startPosition, int climbDirect, float climbHeight, Vector3 staircaseDirect, float waittime = 0f)
	{
		if (!isClimbing)
		{
			this.waittime = waittime;
			this.startPosition = startPosition;
			this.climbDirect = climbDirect;
			this.climbHeight = climbHeight;
			this.staircaseDirect = staircaseDirect;
			endPosition = new Vector3(this.startPosition.x, this.startPosition.y + this.climbHeight * (float)this.climbDirect + 0.01f, this.startPosition.z) + staircaseDirect * CurrentClimbMoveConfig.stepDistance;
			climbStartAniTime = CurrentClimbMoveConfig.climbStartAniTime;
			climbLoopTime = climbStartAniTime + (climbHeight - CurrentClimbMoveConfig.climbEndDistance) / CurrentClimbMoveConfig.climbSpeed;
			climbEndAniTime = climbLoopTime + CurrentClimbMoveConfig.climbEndAniTime;
			climbCurrentTime = 0f;
			mBaseEntity.GetSystem<InputSystem>().SetPaused(paused: true);
			isClimbing = true;
			stepIndex = 0;
			currentPercent = 0f;
			mBaseEntity.GetComponent<StateComponent>().AddState(4005, mBaseEntity.Id);
			_kinematicMoveComponent.SetUseGravity(useGravity: false);
			_kinematicMoveComponent.SetMovementCollisionsSolvingActivation(movementCollisionsSolvingActive: false);
			_kinematicMoveComponent.SetWallCollisionSolvingActivation(wallCollisionSolvingActivation: false);
			_kinematicMoveComponent.SetGroundSolvingActivation(stabilitySolvingActive: false);
		}
	}

	private void OnClimbMoveUpdate(float deltaTime)
	{
		if (mBaseEntity == null || !mBaseEntity.IsSurvival)
		{
			OnClimbMoveEnd();
			return;
		}
		AnimatorComponent component = mBaseEntity.GetComponent<AnimatorComponent>();
		if (component == null)
		{
			Log.Error("animatorComponent是空的");
		}
		else if (_kinematicMoveComponent == null)
		{
			Log.Error("_kinematicMoveComponent是空的");
		}
		else if (stepIndex == 0)
		{
			Quaternion rotation = Quaternion.LookRotation(staircaseDirect);
			_kinematicMoveComponent.SetRotationForce(rotation, "上梯子");
			_kinematicMoveComponent.SetPosition(startPosition, "上梯子");
			component.PlayAnimation(CurrentClimbMoveConfig.climbAnimationClipName, -1, 0f);
			currentPosition = startPosition;
			stepIndex = 1;
		}
		else if (stepIndex == 1)
		{
			if (climbCurrentTime + deltaTime > climbStartAniTime)
			{
				Vector3 position = (currentPosition += mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveX, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveY, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveZ, 1f, currentPercent)));
				_kinematicMoveComponent.SetPosition(position, "爬梯子结束");
				currentPercent = 0f;
				stepIndex = 2;
			}
			else
			{
				float firstTime = (climbCurrentTime + deltaTime) / CurrentClimbMoveConfig.climbStartAniTime;
				Vector3 position2 = currentPosition + mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveX, firstTime, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveY, firstTime, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveZ, firstTime, currentPercent));
				currentPercent = firstTime;
				currentPosition = position2;
				_kinematicMoveComponent.SetPosition(position2, "爬梯子中");
			}
			climbCurrentTime += deltaTime;
		}
		else if (stepIndex == 2)
		{
			if (climbCurrentTime + deltaTime > climbLoopTime)
			{
				Vector3 position3 = (currentPosition += Vector3.up * climbDirect * CurrentClimbMoveConfig.climbSpeed * (climbLoopTime - climbCurrentTime));
				_kinematicMoveComponent.SetPosition(position3, "爬梯子结束");
				component.SetTrigger("arrive");
				stepIndex = 3;
			}
			else
			{
				Vector3 position4 = (currentPosition += Vector3.up * climbDirect * CurrentClimbMoveConfig.climbSpeed * deltaTime);
				_kinematicMoveComponent.SetPosition(position4, "爬梯子中");
			}
			climbCurrentTime += deltaTime;
		}
		else if (stepIndex == 3)
		{
			if (climbCurrentTime + deltaTime > climbEndAniTime)
			{
				Vector3 position5 = (currentPosition += mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveX, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveY, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveZ, 1f, currentPercent)));
				_kinematicMoveComponent.SetPosition(position5, "爬梯子结束");
				currentPercent = 0f;
				stepIndex = 4;
			}
			else
			{
				float firstTime2 = (climbCurrentTime + deltaTime - climbLoopTime) / CurrentClimbMoveConfig.climbEndAniTime;
				Vector3 position6 = currentPosition + mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveX, firstTime2, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveY, firstTime2, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveZ, firstTime2, currentPercent));
				currentPercent = firstTime2;
				currentPosition = position6;
				_kinematicMoveComponent.SetPosition(position6, "爬梯子中");
			}
			climbCurrentTime += deltaTime;
		}
		else if (stepIndex == 4)
		{
			stepIndex = 5;
		}
		else if (stepIndex == 5)
		{
			OnClimbMoveEnd();
		}
	}

	private float GetAnimationCurveValue(AnimationCurve curve, float firstTime, float secondTime)
	{
		if (curve == null)
		{
			return 0f;
		}
		return curve.Evaluate(firstTime) - curve.Evaluate(secondTime);
	}

	public void ClimbMoveAndTeleport(Vector3 startPosition, int climbDirect, float climbHeight, Vector3 staircaseDirect, string scenePointKey, float nextClimbHeight, Vector3 nextStaircaseDirect, float waittime = 0f, CavesTransform cavesTransform = CavesTransform.Null, int canvesId = 0)
	{
		if (!isClimbing)
		{
			this.waittime = waittime;
			this.startPosition = startPosition;
			this.climbDirect = climbDirect;
			this.climbHeight = climbHeight;
			this.staircaseDirect = staircaseDirect;
			scenePoint = base.Entity.GetSystem<SceneSystem>().GetScenePoint(scenePointKey);
			this.nextClimbHeight = nextClimbHeight;
			this.nextStaircaseDirect = nextStaircaseDirect;
			teleportMode = true;
			this.cavesTransform = cavesTransform;
			cavesId = canvesId;
			if ((bool)scenePoint)
			{
				endPosition = new Vector3(scenePoint.transform.position.x, scenePoint.transform.position.y + this.nextClimbHeight * (float)this.climbDirect + 0.01f, scenePoint.transform.position.z) + staircaseDirect * CurrentClimbMoveConfig.stepDistance;
			}
			climbStartAniTime = CurrentClimbMoveConfig.climbStartAniTime;
			climbLoopTime = climbStartAniTime + climbHeight / CurrentClimbMoveConfig.climbSpeed;
			climbNextLoopTime = climbLoopTime + (nextClimbHeight - CurrentClimbMoveConfig.climbEndDistance) / CurrentClimbMoveConfig.climbSpeed;
			climbEndAniTime = climbNextLoopTime + CurrentClimbMoveConfig.climbEndAniTime;
			climbCurrentTime = 0f;
			mBaseEntity.GetSystem<InputSystem>().SetPaused(paused: true);
			isClimbing = true;
			stepIndex = 0;
			currentPercent = 0f;
			mBaseEntity.GetComponent<StateComponent>().AddState(4005, mBaseEntity.Id);
			_kinematicMoveComponent.SetUseGravity(useGravity: false);
			_kinematicMoveComponent.SetMovementCollisionsSolvingActivation(movementCollisionsSolvingActive: false);
			_kinematicMoveComponent.SetWallCollisionSolvingActivation(wallCollisionSolvingActivation: false);
			_kinematicMoveComponent.SetGroundSolvingActivation(stabilitySolvingActive: false);
		}
	}

	private void OnTeleportClimbMoveUpdate(float deltaTime)
	{
		if (mBaseEntity == null || !mBaseEntity.IsSurvival)
		{
			OnClimbMoveEnd();
		}
		else if (stepIndex == 0)
		{
			Quaternion rotation = Quaternion.LookRotation(staircaseDirect);
			_kinematicMoveComponent.SetRotationForce(rotation, "上梯子");
			_kinematicMoveComponent.SetPosition(startPosition, "上梯子");
			mBaseEntity.GetComponent<AnimatorComponent>().PlayAnimation(CurrentClimbMoveConfig.climbAnimationClipName, -1, 0f);
			currentPosition = startPosition;
			stepIndex = 1;
		}
		else if (stepIndex == 1)
		{
			if (climbCurrentTime + deltaTime > climbStartAniTime)
			{
				Vector3 position = (currentPosition += mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveX, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveY, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveZ, 1f, currentPercent)));
				_kinematicMoveComponent.SetPosition(position, "上梯子结束");
				currentPercent = 0f;
				stepIndex = 2;
			}
			else
			{
				float firstTime = (climbCurrentTime + deltaTime) / CurrentClimbMoveConfig.climbStartAniTime;
				Vector3 position2 = currentPosition + mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveX, firstTime, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveY, firstTime, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.StartCurveZ, firstTime, currentPercent));
				currentPercent = firstTime;
				currentPosition = position2;
				_kinematicMoveComponent.SetPosition(position2, "上梯子中");
			}
			climbCurrentTime += deltaTime;
		}
		else if (stepIndex == 2)
		{
			if (climbCurrentTime + deltaTime > climbLoopTime)
			{
				Vector3 position3 = (currentPosition += Vector3.up * climbDirect * CurrentClimbMoveConfig.climbSpeed * (climbLoopTime - climbCurrentTime));
				_kinematicMoveComponent.SetPosition(position3, "爬梯子结束");
				OnTeleport(delegate
				{
					stepIndex = 4;
				});
				stepIndex = 3;
			}
			else
			{
				Vector3 position4 = (currentPosition += Vector3.up * climbDirect * CurrentClimbMoveConfig.climbSpeed * deltaTime);
				_kinematicMoveComponent.SetPosition(position4, "爬梯子中");
			}
			climbCurrentTime += deltaTime;
		}
		else
		{
			if (stepIndex == 3)
			{
				return;
			}
			if (stepIndex == 4)
			{
				if (climbCurrentTime + deltaTime > climbNextLoopTime)
				{
					Vector3 position5 = (currentPosition += Vector3.up * climbDirect * CurrentClimbMoveConfig.climbSpeed * (climbNextLoopTime - climbCurrentTime));
					_kinematicMoveComponent.SetPosition(position5, "爬梯子结束");
					mBaseEntity.GetComponent<AnimatorComponent>().SetTrigger("arrive");
					stepIndex = 5;
				}
				else
				{
					Vector3 position6 = (currentPosition += Vector3.up * climbDirect * CurrentClimbMoveConfig.climbSpeed * deltaTime);
					_kinematicMoveComponent.SetPosition(position6, "爬梯子中");
				}
				climbCurrentTime += deltaTime;
			}
			else if (stepIndex == 5)
			{
				if (climbCurrentTime + deltaTime > climbEndAniTime)
				{
					Vector3 position7 = (currentPosition += mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveX, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveY, 1f, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveZ, 1f, currentPercent)));
					_kinematicMoveComponent.SetPosition(position7, "爬梯子结束");
					currentPercent = 0f;
					stepIndex = 6;
				}
				else
				{
					float firstTime2 = (climbCurrentTime + deltaTime - climbLoopTime) / CurrentClimbMoveConfig.climbEndAniTime;
					Vector3 position8 = currentPosition + mBaseEntity.transform.rotation * new Vector3(GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveX, firstTime2, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveY, firstTime2, currentPercent), GetAnimationCurveValue(CurrentClimbMoveConfig.EndCurveZ, firstTime2, currentPercent));
					currentPercent = firstTime2;
					currentPosition = position8;
					_kinematicMoveComponent.SetPosition(position8, "爬梯子中");
				}
				climbCurrentTime += deltaTime;
			}
			else if (stepIndex == 6)
			{
				stepIndex = 7;
			}
			else if (stepIndex == 7)
			{
				OnClimbMoveEnd();
			}
		}
	}

	private void OnClimbMoveEnd()
	{
		waittime = 0f;
		stepIndex = 0;
		climbCurrentTime = 0f;
		climbStartAniTime = 0f;
		climbLoopTime = 0f;
		climbEndAniTime = 0f;
		climbNextLoopTime = 0f;
		isClimbing = false;
		teleportMode = false;
		cavesTransform = CavesTransform.Null;
		cavesId = 0;
		mBaseEntity.GetComponent<StateComponent>().RemoveState(4005);
		_kinematicMoveComponent.SetUseGravity(useGravity: true);
		_kinematicMoveComponent.SetMovementCollisionsSolvingActivation(movementCollisionsSolvingActive: true);
		_kinematicMoveComponent.SetWallCollisionSolvingActivation(wallCollisionSolvingActivation: true);
		_kinematicMoveComponent.SetGroundSolvingActivation(stabilitySolvingActive: true);
		mBaseEntity.GetSystem<InputSystem>().SetPaused(paused: false);
	}

	private async void OnTeleport(Action callback)
	{
		mBaseEntity.GetComponent<AnimatorComponent>().SetSpeed(0f);
		BlackScreen blackScreen = await BlackScreen.Show();
		await UniTask.WaitForSeconds(1f);
		Quaternion rotation = Quaternion.LookRotation(nextStaircaseDirect);
		if (cavesTransform != CavesTransform.Null)
		{
			mBaseEntity.GetSystem<SceneSystem>().SetCavesState(cavesTransform, cavesId);
			cavesTransform = CavesTransform.Null;
			cavesId = 0;
		}
		_kinematicMoveComponent.Teleport(scenePoint.transform.position, rotation);
		currentPosition = scenePoint.transform.position;
		await base.Entity.GetSystem<SceneSystem>().StreamerForceUpdate();
		blackScreen.Dispose();
		await UniTask.WaitForSeconds(1f);
		mBaseEntity.GetComponent<AnimatorComponent>().SetSpeed(1f);
		callback?.Invoke();
	}

	public void StopClimbMove()
	{
		if (isClimbing)
		{
			waittime = 0f;
			stepIndex = 0;
			climbCurrentTime = 0f;
			climbStartAniTime = 0f;
			climbLoopTime = 0f;
			climbEndAniTime = 0f;
			climbNextLoopTime = 0f;
			isClimbing = false;
			teleportMode = false;
			cavesTransform = CavesTransform.Null;
			cavesId = 0;
			mBaseEntity.GetComponent<AnimatorComponent>().PlayAnimation("Idle");
			mBaseEntity.GetComponent<StateComponent>().RemoveState(4005);
			_kinematicMoveComponent.SetUseGravity(useGravity: true);
			_kinematicMoveComponent.SetMovementCollisionsSolvingActivation(movementCollisionsSolvingActive: true);
			_kinematicMoveComponent.SetWallCollisionSolvingActivation(wallCollisionSolvingActivation: true);
			_kinematicMoveComponent.SetGroundSolvingActivation(stabilitySolvingActive: true);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		climbMoveUpSetting = null;
		climbMoveDownSetting = null;
	}
}
