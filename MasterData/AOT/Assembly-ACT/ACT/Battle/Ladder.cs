using System;
using System.Threading;
using ACT.MultiPlayer;
using ACT.World;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using EasyCharacterMovement;
using Fundamental;
using UnityEngine;
using World;

namespace ACT.Battle;

public sealed class Ladder : MonoTriggerEvent, ITrigger, IDrawInMiniMap
{
	public Transform TopPoint;

	public Transform BottomPoint;

	[HideInInspector]
	public FaceDir topFaceDir;

	[HideInInspector]
	public FaceDir bottomFaceDir;

	[HideInInspector]
	public FaceDir ladderFaceDir;

	public Collider topCollider;

	[Header("是否需要跟随移动")]
	public bool isMove;

	[Header("跟随的运动物体的rigidbody")]
	public Rigidbody rig;

	private bool _isWaitingForSceneLoad;

	private Vector3 pathNormal;

	private float pathMagnitude;

	private Entity entity;

	private Vector3 bottomAnchorPoint => BottomPoint.position;

	private Vector3 topAnchorPoint => TopPoint.position;

	public Vector3 MoveGrabVelocity { get; private set; }

	private void IsMoveValueChange()
	{
		if (!isMove)
		{
			rig = null;
		}
	}

	private void RigValueChange()
	{
		if (rig == null)
		{
			isMove = false;
		}
	}

	public void FixedUpdate()
	{
		if (entity.IsLogicAvailable() && (bool)rig)
		{
			CharacterMovement characterMovement = entity.GetCompPhysics().characterMovement;
			Vector3 vector = ClosestPointOnPath(characterMovement.position, characterMovement.ladderOffset, out var _);
			MoveGrabVelocity = (vector - characterMovement.position) / Time.fixedDeltaTime;
		}
	}

	private void Start()
	{
		topFaceDir = GetDir(TopPoint);
		bottomFaceDir = GetDir(BottomPoint);
		ladderFaceDir = GetDir(transform);
		Vector3 vector = topAnchorPoint - bottomAnchorPoint;
		pathNormal = vector.normalized;
		pathMagnitude = vector.magnitude;
	}

	public Vector3 ClosestPointOnPath(Vector3 position, float pathOffset, out float pathPosition)
	{
		float num = Vector3.Dot(position - bottomAnchorPoint, pathNormal);
		if (num > 0f)
		{
			if (num <= pathMagnitude - pathOffset)
			{
				pathPosition = 0f;
				return bottomAnchorPoint + pathNormal * num;
			}
			pathPosition = num - (pathMagnitude - pathOffset);
			return topAnchorPoint;
		}
		pathPosition = num;
		return bottomAnchorPoint;
	}

	public FaceDir GetDir(Transform point)
	{
		float num = Mathf.Repeat(point.localEulerAngles.y, 360f);
		if (num > 45f && num <= 135f)
		{
			return FaceDir.Right;
		}
		if (num > 135f && num <= 225f)
		{
			return FaceDir.Back;
		}
		if (num > 225f && num <= 315f)
		{
			return FaceDir.Left;
		}
		return FaceDir.Forward;
	}

	private bool IsSceneLoading()
	{
		if (!Singleton<LoadManager>.instance.InLoading)
		{
			return Singleton<GameState>.instance.RunningState == GameRunningState.Loading;
		}
		return true;
	}

	private async UniTaskVoid RebindInputAfterSceneLoad()
	{
		if (!IsSceneLoading() || _isWaitingForSceneLoad)
		{
			return;
		}
		_isWaitingForSceneLoad = true;
		CancellationToken cancellationToken = this.GetCancellationTokenOnDestroy();
		try
		{
			await UniTask.WaitUntil(() => !IsSceneLoading(), PlayerLoopTiming.Update, cancellationToken);
		}
		catch (OperationCanceledException arg)
		{
			Debug.LogWarning($"[Ladder] 加载结束后的输入补绑等待被取消。{arg}");
			return;
		}
		finally
		{
			_isWaitingForSceneLoad = false;
		}
		if (!cancellationToken.IsCancellationRequested && entity.IsValid && entity.TryGetCompInput(out CompInput component))
		{
			component.onUpPressed.Remove(OnUp);
			component.onDownPressed.Remove(OnDown);
			component.onUpPressed.Add(OnUp);
			component.onDownPressed.Add(OnDown);
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsCharacter())
		{
			CompPhysics? compPhysics = component.entity.GetCompPhysics();
			CompInput compInput = component.entity.GetCompInput();
			if (compPhysics != null)
			{
				entity = component.entity;
				compInput.onUpPressed.Add(OnUp);
				compInput.onDownPressed.Add(OnDown);
				OnEnterEvt(component.entity, this);
				RebindInputAfterSceneLoad().Forget();
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsCharacter())
		{
			CompInput compInput = component.entity.GetCompInput();
			if (compInput != null)
			{
				entity = default;
				compInput.onUpPressed.Remove(OnUp);
				compInput.onDownPressed.Remove(OnDown);
			}
			OnExitEvt(component.entity, this);
		}
	}

	private void OnUp(Entity entity, float pressTime)
	{
		entity.GetCompPhysics().InputEnterClimb(downBtn: false);
	}

	private void OnDown(Entity entity, float pressTime)
	{
		entity.GetCompPhysics().InputEnterClimb(downBtn: true);
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.yellow;
		Gizmos.DrawLine(bottomAnchorPoint, topAnchorPoint);
		if (!(BottomPoint == null) && !(TopPoint == null))
		{
			Gizmos.DrawWireCube(BottomPoint.position, Vector3.one * 0.25f);
			Gizmos.DrawWireCube(TopPoint.position, Vector3.one * 0.25f);
		}
	}

	public void RuntimeSetCollider(float length)
	{
		BoxCollider component = GetComponent<BoxCollider>();
		float num = topAnchorPoint.y + 0.3f;
		float num2 = topAnchorPoint.y - length;
		BottomPoint.position = new Vector3(BottomPoint.position.x, num2, BottomPoint.position.z);
		float y = (num + num2) / 2f;
		Vector3 position = transform.position;
		position.y = y;
		Vector3 center = transform.InverseTransformPoint(position);
		component.center = center;
		component.size = new Vector3(1f, num - num2, 1f);
		Vector3 vector = topAnchorPoint - bottomAnchorPoint;
		pathNormal = vector.normalized;
		pathMagnitude = vector.magnitude;
	}

	public void TriggerExit()
	{
		CompInput compInput = MonoECS.instance.mainEntity.GetCompInput();
		if (compInput != null)
		{
			entity = default;
			compInput.onUpPressed.Remove(OnUp);
			compInput.onDownPressed.Remove(OnDown);
		}
	}

	public bool CanDrawInMiniMap()
	{
		return true;
	}

	private void OnDestroy()
	{
		if (!entity.IsValid || !entity.HasCompPhysics())
		{
			return;
		}
		CompPhysics compPhysics = entity.GetCompPhysics();
		if (compPhysics == null)
		{
			return;
		}
		CharacterMovement characterMovement = compPhysics.characterMovement;
		if (characterMovement != null)
		{
			characterMovement.IgnoreCollision(topCollider, ignore: false);
			if (rig != null && rig == characterMovement.movingPlatform.platform)
			{
				characterMovement.SetPlatform(null);
			}
		}
	}
}
