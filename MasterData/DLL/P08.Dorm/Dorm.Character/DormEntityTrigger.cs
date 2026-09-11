using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Dorm.Character;

internal class DormEntityTrigger : MonoBehaviour, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IPointerDownHandler, IPointerUpHandler, IEidProvider
{
	public class PlayerGrabCmdTask : CmdTask
	{
		private class CompareDistance : IComparer<RaycastHit>
		{
			private readonly PlayerGrabCmdTask cmd;

			public CompareDistance(PlayerGrabCmdTask cmd)
			{
				this.cmd = cmd;
			}

			public int Compare(RaycastHit x, RaycastHit y)
			{
				float num = Vector3.Distance(x.transform.position, cmd.GrabingPos);
				float value = Vector3.Distance(y.transform.position, cmd.GrabingPos);
				return num.CompareTo(value);
			}
		}

		private Vector3? dropPos;

		private RaycastHit[] hits = new RaycastHit[4];

		private readonly CompareDistance distanceToGrabPosComp;

		private IProvideInteractEntity _lastOnFurniture;

		private static readonly int ignoreGroundRaycastLayer = DormEntityAction.ignoreGroundRaycastLayer;

		internal bool ignoreDragAvailable;

		private static int cnt;

		private bool changedRoomStatus;

		public bool IsGrabing { get; internal set; }

		public bool IsOnGround { get; internal set; }

		public bool CanDrop => CanDropAtPos(dropPos);

		public Vector3 GrabingPos { get; internal set; }

		internal IProvideInteractEntity LastOnFurnitrue
		{
			get
			{
				return _lastOnFurniture;
			}
			private set
			{
				if (value != _lastOnFurniture)
				{
					if (_lastOnFurniture != null)
					{
						DormEntityManager.SetHighlighted(_lastOnFurniture.EntityID, highlight: false);
					}
					if (value != null)
					{
						DormEntityManager.SetHighlighted(value.EntityID, highlight: true);
					}
					_lastOnFurniture = value;
				}
			}
		}

		internal static DormEntity CurDragging { get; set; }

		public PlayerGrabCmdTask()
			: base(DormEntityManager.EntityCmdPriority.Force)
		{
			distanceToGrabPosComp = new CompareDistance(this);
		}

		private void ResetPlayer(DormPlayerEntity player)
		{
			DormComplexEntity entity = player.entity;
			entity.faceToCamera = false;
			entity.DetachItemHost(resetFaceDir: false);
			entity.KeepInteractTo = 0;
		}

		private void UpdateDrop(DormEntity entity, ref Vector3 visualPos, ref Vector3? dropPos)
		{
			float radius = entity.radius;
			int num = Physics.SphereCastNonAlloc(new Ray(Camera.main.transform.position, visualPos - Camera.main.transform.position), radius, hits, float.PositiveInfinity, ignoreGroundRaycastLayer & ~DormConst.OBSTACLE_LAYER_MASK & ~DormConst.CHARA_LAYER_MASK, QueryTriggerInteraction.Ignore);
			if (num == 0)
			{
				LastOnFurnitrue = null;
				if (IsOnGround)
				{
					dropPos = GrabingPos;
				}
				return;
			}
			Array.Sort(hits, 0, num, distanceToGrabPosComp);
			for (int i = 0; i < num; i++)
			{
				RaycastHit raycastHit = hits[i];
				IProvideInteractEntity componentInParent = raycastHit.transform.GetComponentInParent<IProvideInteractEntity>();
				if (componentInParent != null && componentInParent.AnyActionAvailable(entity))
				{
					visualPos = SnapToFurnitrue(DormEntityManager.Instance.TryGet(componentInParent.EntityID)?.ModelTrs, GrabingPos);
					LastOnFurnitrue = componentInParent;
					dropPos = visualPos;
					return;
				}
			}
			LastOnFurnitrue = null;
			dropPos = null;
		}

		private IEnumerator SearchNearByIfCanNotDrop(DormEntity entity, Vector3 grabingPos, int searchPerItor = 16)
		{
			if (CanDropAtPos(grabingPos) && DormLuaBridge.TestCanSpawn(grabingPos, entity.radius, ignoreGroundTest: true, out var _))
			{
				dropPos = grabingPos;
				yield break;
			}
			float step = 0.25f;
			int i = 0;
			foreach (Vector3 item in DormLuaBridge.IterateSurroundingTile(grabingPos, 3.5f, step))
			{
				if (DormLuaBridge.TestCanSpawn(item, entity.radius, ignoreGroundTest: true, out var groundHeight2))
				{
					dropPos = new Vector3(item.x, groundHeight2, item.z);
					yield break;
				}
				i++;
				if (i == searchPerItor)
				{
					i = 0;
					yield return null;
				}
			}
		}

		private static Vector3 AdjustPos(DormPlayerEntity player, Vector3 colliderPos, Quaternion colliderRot)
		{
			Vector3 zero = Vector3.zero;
			foreach (Collider item in DormCoordinate.Instance.EnumerateObstacleColliders())
			{
				Transform transform = item.transform;
				if (Physics.ComputePenetration(item, transform.position, transform.rotation, player.MainCollider, colliderPos, colliderRot, out var direction, out var distance))
				{
					zero -= direction * distance;
				}
			}
			return zero;
		}

		private static Vector3 AdjustGrabingPos(DormPlayerEntity player, Vector3 grabPos)
		{
			Transform transform = player.MainCollider.transform;
			Vector3 vector = player.entity.ModelTrs.transform.InverseTransformPoint(transform.position);
			return AdjustPos(player, grabPos + vector, transform.rotation);
		}

		private Vector3 SnapToFurnitrue(Transform entityTrs, Vector3 grabingPos)
		{
			Collider[] componentsInChildren = entityTrs.GetComponentsInChildren<Collider>();
			if (componentsInChildren != null && componentsInChildren.Length != 0)
			{
				Bounds bounds = componentsInChildren.Select((Collider collider) => collider.bounds).Aggregate(delegate(Bounds a, Bounds b)
				{
					a.Encapsulate(b);
					return a;
				});
				Vector3 center = bounds.center;
				center.y = bounds.min.y;
				return center;
			}
			return entityTrs.position;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			if (!ignoreDragAvailable && CurDragging != null && CurDragging != executor.entity)
			{
				yield break;
			}
			LastOnFurnitrue = null;
			DormPlayerEntity player = DormEntityManager.TryGetPlayer(executor.EntityID);
			DormComplexEntity entity = player.entity;
			if (!ignoreDragAvailable)
			{
				CurDragging = entity;
			}
			ResetPlayer(player);
			if (entity == null || player == null)
			{
				yield break;
			}
			dropPos = null;
			GrabingPos = entity.GetWorldPos();
			float timerStart = Time.time;
			float? waitTimer = null;
			OnGrab(entity);
			if (cnt == 0)
			{
				DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mEditFurniture);
			}
			changedRoomStatus = true;
			cnt++;
			yield return null;
			while (IsGrabing)
			{
				GrabingPos += AdjustPos(player, GrabingPos, player.entity.ModelTrs.rotation);
				Vector3 visualPos = GrabingPos + AdjustGrabingPos(player, GrabingPos);
				UpdateDrop(entity, ref visualPos, ref dropPos);
				UpdateEntityPos(entity, visualPos, grab: true);
				UpdateGrabingAnime(entity, ref timerStart, ref waitTimer);
				yield return null;
			}
			Vector3 vector;
			if (LastOnFurnitrue == null)
			{
				IEnumerator task = SearchNearByIfCanNotDrop(entity, GrabingPos);
				while (task.MoveNext())
				{
					yield return null;
				}
				RoomWallTag floorRoomWallTag = DormCoordinate.Instance.floorRoomWallTag;
				vector = floorRoomWallTag.transform.TransformPoint(floorRoomWallTag.defaultSetPoint);
				vector = dropPos ?? DormLuaBridge.FindSpawnPos(entity.radius) ?? vector;
			}
			else
			{
				vector = dropPos ?? GrabingPos;
			}
			UpdateEntityPos(entity, vector, grab: false);
			entity.RestoreAnimeScheme();
			entity.Movable = CanDrop;
			yield return null;
			if (!ignoreDragAvailable)
			{
				CurDragging = null;
			}
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			if (changedRoomStatus)
			{
				changedRoomStatus = false;
				cnt--;
				if (cnt == 0)
				{
					DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mFreelook);
				}
			}
			DormComplexEntity entity = executor.entity;
			if (executor.PendingCmdNum == 0)
			{
				executor.SendCmd(new DormEntityAction.PlayAnimeCmd("carry01_end", null, loop: false), queue: false);
			}
			OnGrabReleasedEnd(entity, LastOnFurnitrue);
			LastOnFurnitrue = null;
			ignoreDragAvailable = false;
		}

		protected override void OnStopByExecutor(EntityCmdExecutor executor)
		{
			if (changedRoomStatus)
			{
				changedRoomStatus = false;
				cnt--;
				if (cnt == 0)
				{
					DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mFreelook);
				}
			}
			base.OnStopByExecutor(executor);
			ignoreDragAvailable = false;
		}

		private void OnGrab(DormComplexEntity entity)
		{
			DormEntityAction.Notify("ON_DORM_CHARACTER_GRAB_STARTED", entity.id);
		}

		private void OnGrabReleasedEnd(DormComplexEntity entity, IProvideInteractEntity tag = null)
		{
			if (tag != null)
			{
				int? num = tag.ProvideAction(entity, out var interactPos, out var exitPos);
				if (num.HasValue)
				{
					DormEntityAction.Notify("ON_DORM_CHARACTER_GRAB_RELEASED", entity.id, tag.EntityID, interactPos, exitPos, num.Value);
					return;
				}
			}
			DormEntityAction.Notify("ON_DORM_CHARACTER_GRAB_RELEASED", entity.id);
		}
	}

	public class GrabOutOfStuckCmdTask : CmdTask
	{
		private Vector3? dropPos;

		public GrabOutOfStuckCmdTask()
			: base(DormEntityManager.EntityCmdPriority.Force)
		{
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			IEnumerator task = SearchNearByIfCanNotDrop(entity, entity.GetWorldPos());
			float timerStart = Time.time;
			float? waitTimer = null;
			entity.faceToCamera = false;
			entity.DetachItemHost(resetFaceDir: false);
			entity.KeepInteractTo = 0;
			while (task.MoveNext())
			{
				UpdateGrabingAnime(entity, ref timerStart, ref waitTimer);
				yield return task.Current;
			}
			RoomWallTag floorRoomWallTag = DormCoordinate.Instance.floorRoomWallTag;
			Vector3 vector = floorRoomWallTag.transform.TransformPoint(floorRoomWallTag.defaultSetPoint);
			vector = dropPos ?? DormLuaBridge.FindSpawnPos(entity.radius) ?? vector;
			UpdateEntityPos(entity, vector, grab: false);
			entity.RestoreAnimeScheme();
		}

		private IEnumerator SearchNearByIfCanNotDrop(DormEntity entity, Vector3 grabingPos, int searchPerItor = 16)
		{
			if (CanDropAtPos(grabingPos) && DormLuaBridge.TestCanSpawn(grabingPos, entity.radius, ignoreGroundTest: true, out var _))
			{
				dropPos = grabingPos;
				yield break;
			}
			float step = 0.25f;
			int i = 0;
			foreach (Vector3 item in DormLuaBridge.IterateSurroundingTile(grabingPos, 7f, step))
			{
				if (DormLuaBridge.TestCanSpawn(item, entity.radius, ignoreGroundTest: true, out var groundHeight2))
				{
					dropPos = new Vector3(item.x, groundHeight2, item.z);
					yield break;
				}
				i++;
				if (i == searchPerItor)
				{
					i = 0;
					yield return null;
				}
			}
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			if (executor.PendingCmdNum == 0)
			{
				executor.SendCmd(new DormEntityAction.PlayAnimeCmd("carry01_end", null, loop: false), queue: false);
			}
		}
	}

	internal class StartPlayerClickCmd : CmdTask
	{
		internal StartPlayerClickCmd()
			: base(DormEntityManager.EntityCmdPriority.Interact)
		{
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			entity.faceToCamera = !entity.faceToCamera;
			yield break;
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			DormEntityAction.Notify("ON_PLAYER_CLICK_INTERACT", executor.entity.id);
			if ((bool)LuaHelper.CallFunction("Dorm.EntityCanFocus", executor.entity.id)[0])
			{
				DormCameraManager.Instance?.SetLookAtRoleDummy(executor.entity.ModelTrs);
			}
		}
	}

	internal DormPlayerEntity player;

	private const float GRAB_Y_OFFSET = 1f;

	internal const float GRAB_SEARCH_RANGE = 3.5f;

	private const string GRAB_START_ANI = "";

	private const string GRAB_HOLD_ANI = "carry";

	private const string GRAB_HOLD_IDLE_ANI = "carry_idle";

	private const string GRAB_RELEASE_ANI = "carry01_end";

	internal readonly PlayerGrabCmdTask grabCmd = new PlayerGrabCmdTask();

	internal readonly GrabOutOfStuckCmdTask grabOutStuckCmd = new GrabOutOfStuckCmdTask();

	private const float LONG_HOLD = 0.5f;

	private float holdInputTimer;

	private bool holdStart;

	private bool drag;

	internal static readonly StartPlayerClickCmd playerClick = new StartPlayerClickCmd();

	private uint acceptClickInteract;

	private int? pointerId;

	internal DormComplexEntity entity => player.entity;

	public int EntityID => entity?.id ?? 0;

	private Plane Ground => new Plane(Vector3.up, 0f);

	internal bool DragAvailable
	{
		get
		{
			if (DormEntityManager.EnablePlayerInput)
			{
				if (PlayerGrabCmdTask.CurDragging != null)
				{
					return PlayerGrabCmdTask.CurDragging == entity;
				}
				return true;
			}
			return false;
		}
	}

	internal bool ClickInteractAvailable
	{
		get
		{
			if (DormEntityManager.EnablePlayerInput)
			{
				return acceptClickInteract != 0;
			}
			return false;
		}
		set
		{
			if (value)
			{
				acceptClickInteract++;
			}
			else
			{
				acceptClickInteract--;
			}
		}
	}

	public int? FollowingPointer
	{
		get
		{
			return pointerId;
		}
		set
		{
			if (value.HasValue ^ pointerId.HasValue)
			{
				pointerId = value;
			}
		}
	}

	private static void UpdateGrabingAnime(DormComplexEntity entity, ref float timerStart, ref float? waitEndTime)
	{
		if (waitEndTime.HasValue)
		{
			if (Time.time - timerStart >= waitEndTime.Value)
			{
				entity.Play("carry_idle");
				waitEndTime = null;
			}
		}
		else if (!DormEntity.IsSameAnimeAction(entity.CurPlaying, "carry_idle") || (double)entity.GetCurAnimePlayNormalizedTime() >= 1.0)
		{
			entity.Play("carry", null, 0f);
			waitEndTime = entity.IdleWaitTime;
			timerStart = Time.time;
		}
	}

	private static bool CanDropAtPos(Vector3? pos)
	{
		if (pos.HasValue)
		{
			return DormLuaBridge.InDormSpawnBounds(pos.Value);
		}
		return false;
	}

	internal static void UpdateEntityPos(DormEntity player, Vector3 pos, bool grab)
	{
		Vector3 vector = -Camera.main.transform.forward;
		vector.y = 0f;
		vector.Normalize();
		Quaternion rotation = ((!(vector == Vector3.zero)) ? Quaternion.LookRotation(vector) : player.ModelTrs.rotation);
		player.PutAt(pos, rotation);
	}

	internal static int? GetAnyValidPointerCanFollow()
	{
		for (int num = UnityEngine.Input.touchCount - 1; num >= 0; num--)
		{
			Touch touch = UnityEngine.Input.GetTouch(num);
			if (touch.phase != TouchPhase.Ended && touch.phase != TouchPhase.Canceled)
			{
				return num;
			}
		}
		if (UnityEngine.Input.GetMouseButton(0))
		{
			return -1;
		}
		if (UnityEngine.Input.GetMouseButton(1))
		{
			return -2;
		}
		return null;
	}

	private void OnDestroy()
	{
		EndGrab();
		if (PlayerGrabCmdTask.CurDragging == entity)
		{
			PlayerGrabCmdTask.CurDragging = null;
		}
	}

	public bool StartPlayerClickInteract()
	{
		if (ClickInteractAvailable)
		{
			return entity.CmdExecuter.SendCmd(playerClick, queue: false);
		}
		return false;
	}

	public void BeginGrab()
	{
		if (DragAvailable)
		{
			grabCmd.IsGrabing = true;
			entity.CmdExecuter.SendCmd(grabCmd, queue: false);
		}
		else
		{
			EndGrab();
		}
	}

	public void BeginGrab(Camera cam, Vector2 screenPos)
	{
		BeginGrab();
		UpdateGrabPos(cam, screenPos, ignoreGroundCollider: true);
		UpdateEntityPos(entity, grabCmd.GrabingPos, grab: true);
	}

	private Vector3? RaycastToPlane(Ray ray, Plane plane)
	{
		float num = Vector3.Dot(ray.direction, plane.normal);
		if (num == 0f)
		{
			return null;
		}
		float num2 = (0f - plane.GetDistanceToPoint(ray.origin)) / num;
		if (num2 > 0f)
		{
			return ray.origin + num2 * ray.direction;
		}
		return null;
	}

	private void UpdateGrabPos(Camera cam, Vector2 screenPos, bool ignoreGroundCollider = false)
	{
		if (!DragAvailable)
		{
			return;
		}
		Plane ground = Ground;
		Ray ray = cam.ScreenPointToRay(screenPos);
		RaycastHit hitInfo;
		if (ignoreGroundCollider)
		{
			Vector3? vector = RaycastToPlane(ray, ground);
			grabCmd.GrabingPos = vector ?? grabCmd.GrabingPos;
			grabCmd.IsOnGround = vector.HasValue;
		}
		else if (Physics.Raycast(ray, out hitInfo, float.MaxValue, LayerMask.GetMask("ground")))
		{
			RoomWallTag component = hitInfo.collider.GetComponent<RoomWallTag>();
			if ((bool)component && component.tileType == TileType.FLOOR)
			{
				grabCmd.GrabingPos = hitInfo.point;
			}
			else
			{
				Ray ray2 = new Ray(hitInfo.point + Vector3.up, Vector3.down);
				Vector3? vector2 = RaycastToPlane(ray2, ground);
				grabCmd.GrabingPos = vector2 ?? grabCmd.GrabingPos;
			}
			grabCmd.IsOnGround = true;
		}
		else
		{
			grabCmd.IsOnGround = false;
		}
	}

	public void EndGrab()
	{
		grabCmd.IsGrabing = false;
		holdStart = false;
		drag = false;
		holdInputTimer = 0f;
	}

	public static bool IsFollowingMouse(int? pointerId)
	{
		if (pointerId != -1)
		{
			return pointerId == -2;
		}
		return true;
	}

	internal static bool IsInputActive(int? followPointer, out Vector2 inputPos, out bool moving)
	{
		inputPos = Vector2.zero;
		moving = false;
		if (!followPointer.HasValue)
		{
			return false;
		}
		if (IsFollowingMouse(followPointer))
		{
			inputPos = UnityEngine.Input.mousePosition;
			moving = true;
			return true;
		}
		if (UnityEngine.Input.touchCount > followPointer)
		{
			Touch touch = UnityEngine.Input.GetTouch(followPointer.Value);
			Vector2 deltaPosition = touch.deltaPosition;
			inputPos = touch.position;
			moving = deltaPosition.magnitude > 1E-05f;
			if (touch.phase != TouchPhase.Moved)
			{
				return touch.phase == TouchPhase.Stationary;
			}
			return true;
		}
		return false;
	}

	private void Update()
	{
		if (holdStart)
		{
			holdInputTimer += Time.deltaTime;
		}
		if (grabCmd.IsGrabing)
		{
			bool num = IsInputActive(pointerId, out var inputPos, out var moving);
			if (!num)
			{
				inputPos = Vector2.zero;
				moving = false;
				pointerId = null;
			}
			if (num && grabCmd.IsGrabing)
			{
				if (moving)
				{
					UpdateGrabPos(Camera.main, inputPos);
				}
			}
			else
			{
				EndGrab();
			}
		}
		else if (drag || holdInputTimer > 0.5f)
		{
			BeginGrab();
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		holdInputTimer = 0f;
		holdStart = true;
		FollowingPointer = eventData.pointerId;
		eventData.Use();
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		holdStart = false;
		holdInputTimer = 0f;
		FollowingPointer = null;
		eventData.Reset();
		if (grabCmd.IsGrabing)
		{
			EndGrab();
		}
		else if (PlayerGrabCmdTask.CurDragging == null)
		{
			StartPlayerClickInteract();
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		FollowingPointer = eventData.pointerId;
		drag = true;
		eventData.Use();
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		drag = false;
		FollowingPointer = null;
		eventData.Reset();
	}
}
