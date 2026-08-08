using System;
using System.Collections.Generic;
using Cinemachine;
using Dorm.Character;
using LuaInterface;
using Pathfinding;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace Dorm;

public class DormEntityManager : SerializedMonoBehaviour
{
	public enum EntityCmdPriority
	{
		Low = 1,
		Normal = 2,
		Interact = 3,
		Force = int.MaxValue
	}

	public class WaitForNotify : CustomYieldInstruction
	{
		private bool wait = true;

		public bool canceled { get; private set; }

		public override bool keepWaiting
		{
			get
			{
				if (wait)
				{
					return !canceled;
				}
				return false;
			}
		}

		public bool success { get; private set; }

		public void Notify(bool success = true)
		{
			this.success = success;
			wait = false;
		}

		internal void Cancel()
		{
			success = false;
			canceled = true;
		}
	}

	[SerializeField]
	internal DormAnimeCfg defaultAnimeScheme;

	[SerializeField]
	private Dictionary<string, DormAnimeCfg> animeSchemeDict = new Dictionary<string, DormAnimeCfg>();

	[SerializeField]
	private Dictionary<int, DormEntity> entityDict = new Dictionary<int, DormEntity>();

	public const int INVALID_ENTITY_ID = 0;

	public const int ENTITY_ID_START = 1;

	private int nextEntityID = 1;

	private static DormEntityManager _manager;

	[SerializeField]
	[Range(0f, 1f)]
	private float playerInteractChance = 0.5f;

	public const string INTERACT_TYPE_VFX = "interact";

	private Dictionary<int, DormPlayerEntity> playerEntityDict = new Dictionary<int, DormPlayerEntity>();

	[SerializeField]
	private bool enablePlayerInput;

	public static DormEntityManager Instance
	{
		get
		{
			if (!_manager)
			{
				return null;
			}
			return _manager;
		}
	}

	public static float GlobalPlayerInteractChance
	{
		get
		{
			return Instance?.playerInteractChance ?? 0f;
		}
		set
		{
			value = Mathf.Clamp01(value);
			if ((bool)Instance && Instance.playerInteractChance != value)
			{
				Instance.playerInteractChance = value;
				Instance.SetPlayerInteractChance(value);
			}
		}
	}

	public static bool EnablePlayerInput
	{
		get
		{
			return Instance?.enablePlayerInput ?? false;
		}
		set
		{
			if ((bool)Instance)
			{
				Instance.enablePlayerInput = value;
			}
		}
	}

	internal int AllocEntityID()
	{
		while (entityDict.ContainsKey(nextEntityID))
		{
			nextEntityID++;
		}
		return nextEntityID;
	}

	internal void RegisterEntity(DormEntity entity)
	{
		entityDict.Add(entity.id, entity);
	}

	private void Awake()
	{
		_manager = this;
	}

	private void OnDestroy()
	{
		_manager = null;
	}

	[NoToLua]
	public DormEntity Get(int entityID)
	{
		return entityDict[entityID];
	}

	[NoToLua]
	public DormEntity TryGet(int? entityID)
	{
		if (entityID.HasValue && entityDict.TryGetValue(entityID.Value, out var value))
		{
			return value;
		}
		return null;
	}

	internal void SetPlayerInteractChance(float value)
	{
		if (!Instance)
		{
			return;
		}
		foreach (DormPlayerEntity value2 in Instance.playerEntityDict.Values)
		{
			value2.entity.Scanner.rndPickChance = value;
		}
	}

	public static bool IsValidEntityID(int entityID)
	{
		return Instance?.TryGet(entityID) != null;
	}

	public static Vector3 QueryForwardDir(int entityID)
	{
		return (Instance?.Get(entityID)).GetForward();
	}

	public static Vector3 QueryPosition(int entityID)
	{
		return (Instance?.Get(entityID)).GetWorldPos();
	}

	public static Vector3 QueryEntityAttachPointWorldPos(int entityID, string attachPoint)
	{
		return (Instance?.Get(entityID)).FindAttachPoint(attachPoint).position;
	}

	public static Transform GetEntityInteractPoint(int entityID, int interactID)
	{
		DormEntity dormEntity = Instance?.Get(entityID);
		IInteractProvider component = dormEntity.ModelTrs.GetComponent<IInteractProvider>();
		if (component != null)
		{
			foreach (InteractAction action in component.Actions)
			{
				if (action.id == interactID && action.interactPos != null)
				{
					return action.interactPos.transform;
				}
			}
		}
		return dormEntity.ModelTrs;
	}

	public static int GetFurnitureInteractID(int entityID)
	{
		FurnitureTag component = (Instance?.Get(entityID)).ModelTrs.GetComponent<FurnitureTag>();
		if (component != null && component.interactActions.Length != 0)
		{
			return component.interactActions[0].id;
		}
		return -1;
	}

	public static Vector3 QueryGridPos(int entityID)
	{
		return GetGridPos((Instance?.Get(entityID)).GetWorldPos());
	}

	public static float QueryRadius(int entityID)
	{
		return (Instance?.Get(entityID)).radius;
	}

	public static bool QueryProvideInteraction(int hostID, int entityID)
	{
		DormEntity dormEntity = Instance.TryGet(hostID);
		int valueOrDefault = (dormEntity?.interactProvider?.InteractEntityCountLimit).GetValueOrDefault();
		return dormEntity.WaitInteractCount < valueOrDefault;
	}

	public static bool QueryMobility(int entityID)
	{
		return Instance?.TryGet(entityID).Movable ?? false;
	}

	public static float QuerySpeed(int entityID)
	{
		return Instance?.TryGet(entityID).Speed ?? (-1f);
	}

	public static int GetGridIndex(Vector3 pos)
	{
		return GetGridIndex(GetGridPos(pos));
	}

	internal static int GetGridIndex(Vector3Int pos)
	{
		int depth = (DormCoordinate.Instance.astarPath.data.graphs[0] as GridGraph).Depth;
		return pos.x * depth + pos.z;
	}

	public static Vector3Int GetGridPos(Vector3 pos)
	{
		GridNode gridNode = DormCoordinate.Instance.astarPath.GetNearest((Int3)pos).node as GridNode;
		return new Vector3Int(gridNode.XCoordinateInGrid, 0, gridNode.ZCoordinateInGrid);
	}

	public static Vector3 GetRelativePointWorldPos(Vector3 pos, int entityID)
	{
		return GetRelativePointWorldPos(pos, Instance?.Get(entityID).ModelTrs);
	}

	internal static Vector3 GetRelativePointWorldPos(Vector3 pos, Transform origin)
	{
		return origin.TransformDirection(pos) + origin.position;
	}

	public static void KeepAsInteractNotEnd(int entityID, int targetID, bool value)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			if (value)
			{
				dormComplexEntity.KeepInteractTo = targetID;
			}
			else
			{
				dormComplexEntity.KeepInteractTo = 0;
			}
		}
	}

	internal static void RemoveKeepAsInteract(int targetID, int entityID)
	{
		DormEntity dormEntity = Instance?.TryGet(targetID);
		if (dormEntity != null)
		{
			dormEntity.interactProvider?.OnInteractBeingCanceled();
			dormEntity.countAsWaitInteract.Remove(entityID);
		}
	}

	internal static void AddKeepAsInteract(int targetID, int entityID)
	{
		Instance?.TryGet(targetID)?.countAsWaitInteract.Add(entityID);
	}

	public static bool TestDuringInteract(int entityID, bool considerKeepAsInteract = false)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			if (dormComplexEntity.CmdExecuter.CurCmdTask is DormEntityAction.InteractCmdTask)
			{
				return true;
			}
			if (considerKeepAsInteract && dormComplexEntity.KeepInteractTo != 0)
			{
				return true;
			}
		}
		return false;
	}

	public static void SetCurInteractToLowPriority(int entityID)
	{
		if ((Instance?.TryGet(entityID) as DormComplexEntity)?.CmdExecuter.CurCmdTask is DormEntityAction.InteractCmdTask interactCmdTask)
		{
			interactCmdTask.SetPriotity(EntityCmdPriority.Low);
		}
	}

	internal static void PutEntityAt(int entityID, Vector3 position, Quaternion rotation)
	{
		(Instance?.TryGet(entityID))?.PutAt(position, rotation);
	}

	public static void PutEntityAtWithRot(int entityID, Vector3 position, Quaternion rotation)
	{
		(Instance?.TryGet(entityID))?.PutAt(position, rotation);
	}

	public static void PutEntityAtWithScale(int entityID, Vector3 position, Vector3 scale)
	{
		DormEntity obj = Instance?.TryGet(entityID);
		obj?.PutAt(position);
		obj.ModelTrs.localScale = scale;
	}

	public static void PutEntityAt(int entityID, Vector3 referancePoint)
	{
		(Instance?.TryGet(entityID))?.PutAt(referancePoint);
	}

	public static void PutEntityAt(int entityID, Transform referancePoint)
	{
		PutEntityAt(entityID, referancePoint.position, referancePoint.rotation);
	}

	public static void PutEntityAt(int entityID, int referaceTarget, string attachPoint)
	{
		PutEntityAt(entityID, (Instance?.TryGet(referaceTarget))?.FindAttachPoint(attachPoint));
	}

	public static void PutEntityLookToDir(int entityID, Vector3 position, Vector3 lookDir)
	{
		if (lookDir == Vector3.zero)
		{
			PutEntityAt(entityID, position);
		}
		else
		{
			PutEntityAt(entityID, position, Quaternion.LookRotation(lookDir, Vector3.up));
		}
	}

	public static void PutEntityLookAt(int entityID, Vector3 position, Vector3 lookAt)
	{
		Vector3 vector = lookAt - position;
		if (vector == Vector3.zero)
		{
			PutEntityAt(entityID, position);
		}
		else
		{
			PutEntityAt(entityID, position, Quaternion.LookRotation(vector, Vector3.up));
		}
	}

	public static void IlluSetWallMaterial(int entityID, string path)
	{
		(Instance?.Get(entityID).ModelTrs).GetChild(0).GetComponent<MeshRenderer>().material = Asset.Load<Material>(path);
	}

	public static Transform GetTransform(int entityID)
	{
		return Instance?.Get(entityID).ModelTrs;
	}

	public static void PlayerControlEntity(int entityID)
	{
		PlayerControlEntity(entityID, null);
	}

	public static void PlayerControlEntity(int entityID, Vector3 fixedLookingDir)
	{
		DormComplexEntity entity = Instance?.TryGet(entityID) as DormComplexEntity;
		if (entity == null)
		{
			return;
		}
		if (!Instance.playerEntityDict.TryGetValue(entityID, out var value))
		{
			value = new DormPlayerEntity(entity);
			Instance.playerEntityDict.Add(entityID, value);
		}
		CharacterController roleController = value.RoleController;
		if ((bool)roleController)
		{
			DormEntityAction.MoveByControllerCmd cmd = new DormEntityAction.MoveByControllerCmd(roleController, Camera.main.transform);
			cmd.lookingDir = fixedLookingDir;
			DormLuaBridge.SetJoystickControl(entity.ModelTrs, (DormStickController sticker) => entity.Movable && entity.CmdExecuter.SendCmd(cmd.UseStickController(sticker), queue: false));
		}
	}

	public static void PlayerControlEntity(int entityID, Transform lookingTarget)
	{
		DormComplexEntity entity = Instance?.TryGet(entityID) as DormComplexEntity;
		if (entity == null)
		{
			return;
		}
		if (!Instance.playerEntityDict.TryGetValue(entityID, out var value))
		{
			value = new DormPlayerEntity(entity);
			Instance.playerEntityDict.Add(entityID, value);
		}
		CharacterController roleController = value.RoleController;
		if ((bool)roleController)
		{
			DormEntityAction.MoveByControllerCmd cmd = new DormEntityAction.MoveByControllerCmd(roleController, Camera.main.transform);
			cmd.lookingTarget = lookingTarget;
			DormLuaBridge.SetJoystickControl(entity.ModelTrs, (DormStickController sticker) => entity.Movable && entity.CmdExecuter.SendCmd(cmd.UseStickController(sticker), queue: false));
		}
	}

	public static void TryTriggerResetAnimeDuringMove(int entityID)
	{
		(Instance?.TryGet(entityID) as DormComplexEntity)?.TriggerResetAnimeDuringMove();
	}

	internal static DormPlayerEntity TryGetPlayer(int entityID)
	{
		if ((bool)Instance && Instance.playerEntityDict.TryGetValue(entityID, out var value))
		{
			return value;
		}
		return null;
	}

	public static void StopAllCmd(int entityID)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.CmdExecuter.StopAllCmdTask();
		}
	}

	public static void StopCurRunningCmd(int entityID)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.CmdExecuter.Abort(treatCurCmdAsFinished: false);
		}
	}

	public static bool SendMoveCMD(int entityID, Vector3 targetPos, bool ignorePathFinding = false, bool queue = true)
	{
		return Instance?.SendMoveLookToDir(entityID, targetPos, Vector3.zero, ignorePathFinding, queue) ?? false;
	}

	public static bool SendMoveLookAtCMD(int entityID, Vector3 targetPos, Vector3 lookAt, bool ignorePathFinding = false, bool queue = true)
	{
		return Instance?.SendMoveLookAt(entityID, targetPos, lookAt, ignorePathFinding, queue) ?? false;
	}

	public static bool SendMoveLookToDirCMD(int entityID, Vector3 targetPos, Vector3 lookToDir, bool ignorePathFinding = false, bool queue = true)
	{
		return Instance?.SendMoveLookToDir(entityID, targetPos, lookToDir, ignorePathFinding, queue) ?? false;
	}

	public static bool SendMoveLookToDirCMD(int entityID, Transform target, bool ignorePathFinding = false, bool queue = true)
	{
		return Instance?.SendMoveLookToDir(entityID, target.position, target.forward, ignorePathFinding, queue) ?? false;
	}

	public static bool SendRndWanderMoveCMD(int entityID, float maxDistance, bool queue = true)
	{
		return Instance?.SendRndWanderMove(resumeLastWander: false, entityID, maxDistance, queue) ?? false;
	}

	public static bool SendRndResumeWanderCMD(int entityID, float maxDistance, bool queue = true)
	{
		return Instance?.SendRndWanderMove(resumeLastWander: true, entityID, maxDistance, queue) ?? false;
	}

	public static bool SendPatrolCMD(int entityID, CinemachinePathBase path, bool reverse, float offset, bool queue)
	{
		return Instance?.SendPatrol(entityID, path, reverse, offset, queue) ?? false;
	}

	public static bool SendPatrolCMD(int entityID, CinemachinePathBase path, bool reverse, bool queue)
	{
		return Instance?.SendPatrol(entityID, path, reverse, null, queue) ?? false;
	}

	public static bool SendInteractToEntityCMD(int entityID, int otherEntity, bool queue)
	{
		return Instance?.SendInteractToEntity(entityID, otherEntity, null, queue) ?? false;
	}

	public static bool SendInteractToEntityCMD(int entityID, int otherEntity, int action, bool queue)
	{
		return Instance?.SendInteractToEntity(entityID, otherEntity, action, queue) ?? false;
	}

	public static bool TryExecuteInteractToEntityImmediate(int entityID, int otherEntity)
	{
		return Instance?.TryExecuteInteractImmediate(entityID, otherEntity, null) ?? false;
	}

	public static bool TryExecuteInteractToEntityImmediate(int entityID, int otherEntity, int action)
	{
		return Instance?.TryExecuteInteractImmediate(entityID, otherEntity, action) ?? false;
	}

	internal bool TryExecuteInteractImmediate(int entityID, int otherEntity, int? action)
	{
		if (Instance.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			DormEntity otherEntity2 = Instance.Get(otherEntity);
			EntityCmdPriority priority = EntityCmdPriority.Interact;
			dormComplexEntity.CmdExecuter.ExecuteCmdImmediate(new DormEntityAction.InteractCmdTask(otherEntity2, priority, action));
		}
		return false;
	}

	public static bool SendDoActionCMD(int entityID, string animeName, bool queue)
	{
		return SendDoActionCMD(entityID, animeName, null, loop: false, 0.05f, queue);
	}

	public static bool SendDoActionCMD(int entityID, string animeName, string animeSubType, bool queue)
	{
		return SendDoActionCMD(entityID, animeName, animeSubType, loop: false, 0.05f, queue);
	}

	public static bool SendDoActionCMD(int entityID, string animeName, string animeSubType, bool loop, bool queue)
	{
		return SendDoActionCMD(entityID, animeName, animeSubType, loop, 0.05f, queue);
	}

	public static bool SendDoActionCMD(int entityID, string animeName, string animeSubType, bool loop, float crossFade, bool queue)
	{
		return Instance?.SendDoAction(entityID, animeName, animeSubType, loop, crossFade, queue) ?? false;
	}

	public static void PlayAnimeDuringInteract(int entityID, string animeName, string animeSubName = null, float transDuration = 0.05f)
	{
		(Instance?.Get(entityID)).PlayAnime(animeName, animeSubName, transDuration);
	}

	public static bool IsSameAnimeAction(string action1, string action2)
	{
		return DormEntity.IsSameAnimeAction(action1, action2);
	}

	public static bool IsStandAnime(int entityID, string action)
	{
		return Instance.Get(entityID).IsStandAnime(action);
	}

	public static bool IsIdleAnime(int entityID, string action)
	{
		return Instance.Get(entityID).IsIdleAnime(action);
	}

	public static bool IsMoveAnime(int entityID, string action)
	{
		return Instance.Get(entityID).IsMoveAnime(action);
	}

	public static void AttachToEntityCMD(int child, int parent, string attachPoint, bool setAsChild = false)
	{
		Instance?.AttachToEntity(child, parent, attachPoint, setAsChild);
	}

	public static void DetachFromEntityCMD(int item)
	{
		Instance?.DetachFromEntity(item);
	}

	public static void GrabItemPartCMD(int entity, int itemHost, string itemPart, string attachPoint = null)
	{
		Instance?.GrabItemAttachTo(entity, itemHost, itemPart, attachPoint);
	}

	public static void RestoreItemPartCMD(int itemHost, string itemPart)
	{
		Instance?.RestoreItemPart(itemHost, itemPart);
	}

	public static void SetPartVisible(int itemHost, string itemPart, bool value, bool modifyRenderer = false)
	{
		Instance?.TryGet(itemHost)?.SetPartVisible(itemPart, value, modifyRenderer);
	}

	public static void SetEntityMobility(int entityID, bool movable)
	{
		(Instance?.Get(entityID)).Movable = movable;
	}

	public static void SetEntitySpeed(int entityID, float speed)
	{
		(Instance?.Get(entityID)).Speed = speed;
	}

	public static void SetNextIdleNoCrossFade(int entityID, bool value)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.NextIdleNoCrossFade = value;
		}
	}

	public static void SetResumeWanderIgnoreScan(int entityID, int ignore)
	{
		(Instance?.TryGet(entityID) as DormComplexEntity)?.Scanner?.SetEntityAsScaned(ignore);
	}

	private static SDCharacter GetSdCharaCom(int? entityID)
	{
		DormEntity dormEntity = Instance?.TryGet(entityID);
		object obj = (dormEntity as DormComplexEntity)?.sdChara;
		if (obj == null)
		{
			if (dormEntity == null)
			{
				return null;
			}
			obj = dormEntity.ModelTrs.GetComponent<SDCharacter>();
		}
		return (SDCharacter)obj;
	}

	private static FadeBehaviour GetFadeBehaviour(int entityID)
	{
		DormEntity dormEntity = Instance?.TryGet(entityID);
		return (dormEntity as DormComplexEntity)?.Fade ?? dormEntity.ModelTrs.GetComponent<FadeBehaviour>();
	}

	private static FlashBehaviour GetFlashBehaviour(int entityID)
	{
		DormEntity dormEntity = Instance?.TryGet(entityID);
		return (dormEntity as DormComplexEntity)?.Flash ?? dormEntity.ModelTrs.GetComponent<FlashBehaviour>();
	}

	public static void SetFadeCMD(int entityID, float value)
	{
		GetFadeBehaviour(entityID)?.SetFade(value);
	}

	public static void StartFadeInCMD(int entityID, float duration, Action afterFadeIn = null)
	{
		GetFadeBehaviour(entityID)?.StartFadeIn(duration, afterFadeIn);
	}

	public static void StartFadeOutCMD(int entityID, float duration, Action afterFadeOut = null)
	{
		GetFadeBehaviour(entityID)?.StartFadeOut(duration, afterFadeOut);
	}

	public static void SetFlashColor(int entityID, Color outer, Color inner, float soft)
	{
		GetFlashBehaviour(entityID)?.SetFlashColor(outer, inner, soft);
	}

	public static void SetFlashRatio(int entityID, float ratio)
	{
		GetFlashBehaviour(entityID)?.SetFlash(ratio);
	}

	public static void StartFlash(int entityID, float duration, AnimationCurve curve = null)
	{
		GetFlashBehaviour(entityID)?.Flash(duration, curve);
	}

	public static void SetDefaultMouth(int entityID, int mouth)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.defaultMouth = mouth;
		}
	}

	public static bool RestoreFacialExpression(int entityID)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.sdChara.sheetFaceId = dormComplexEntity.DefaultMouth;
			return true;
		}
		return false;
	}

	public static bool SetFacialExpression(int? entityID, int faceExprID)
	{
		SDCharacter sdCharaCom = GetSdCharaCom(entityID);
		if ((bool)sdCharaCom)
		{
			sdCharaCom.sheetFaceId = faceExprID;
			return true;
		}
		return false;
	}

	[NoToLua]
	public static bool SetFacialExpression(Transform entityMainModelTrs, int faceExprID)
	{
		SDCharacter component = entityMainModelTrs.GetComponent<SDCharacter>();
		if ((bool)component)
		{
			component.sheetFaceId = faceExprID;
			return true;
		}
		return false;
	}

	public static void PlaySpacialFacileExpression(int entityID, string faceFxPath, float duration)
	{
		(Instance?.TryGet(entityID) as DormComplexEntity)?.PlaySpecialFaceExpression(faceFxPath, duration);
	}

	public static void PlayNormalFacileExpression(int entityID, string faceEmoteState, string faceEmoteSubState, float crossFade)
	{
		(Instance?.TryGet(entityID) as DormComplexEntity)?.PlayNormalFaceExpression(faceEmoteState, faceEmoteSubState, crossFade);
	}

	public static void PlayEffect(int entityID, string attachPoint, string efxPath, float duration)
	{
		PlayEffect(entityID, attachPoint, "interact", efxPath, duration);
	}

	public static void PlayEffect(int entityID, string attachPoint, string vfxType, string efxPath, float duration)
	{
		PlayEffect(entityID, attachPoint, vfxType, efxPath, Vector3.zero, Quaternion.identity, Vector3.one, duration);
	}

	public static void PlayEffect(int entityID, string attachPoint, string efxPath, Vector3 offset, Quaternion rotation, Vector3 localScale, float duration)
	{
		PlayEffect(entityID, attachPoint, "interact", efxPath, offset, rotation, localScale, duration);
	}

	public static void PlayEffect(int entityID, string attachPoint, string vfxType, string efxPath, Vector3 offset, Quaternion rotation, Vector3 localScale, float duration)
	{
		Instance?.TryGet(entityID)?.PlayEffect(vfxType, efxPath, attachPoint, offset, rotation, localScale, duration);
	}

	public static void PlayEffectDetached(int entityID, string attachPoint, string efxPath, float duration)
	{
		DormEntity dormEntity = Instance?.TryGet(entityID);
		if (dormEntity != null)
		{
			Transform attach = dormEntity.FindAttachPoint(attachPoint);
			EntityVfxController.PlayEffectEx(efxPath, attach, attachOnEntity: false, duration, Vector3.zero, Quaternion.identity, Vector3.one, EEffectQuality.Low, null);
		}
	}

	public static bool CheckIsVariant(int entityID)
	{
		if (Instance != null)
		{
			DormEntity dormEntity = Instance.TryGet(entityID);
			if (dormEntity != null)
			{
				return dormEntity.name.Contains("_1_tpose");
			}
		}
		return false;
	}

	public static void ClearAllEffect(int entityID, string vfxType)
	{
		Instance?.TryGet(entityID)?.RestoreAttachedEfx(vfxType);
	}

	public static void ClearAllEffectOnAttachPoint(int entityID, string attachPoint)
	{
		Instance?.TryGet(entityID)?.ClearAllEffectOnAttachPoint(attachPoint);
	}

	public static void ClearInteractEffectOnAttachPoint(int entityID, string attachPoint)
	{
		Instance?.TryGet(entityID)?.ClearInteractEffectOnAttachPoint(attachPoint);
	}

	public static void FadeOutNearPoint(int entityID, Transform point, float fadeStart = 1f, float fadeEnd = 0f)
	{
		GetFadeBehaviour(entityID)?.SetFadeOutAt(point, fadeStart, fadeEnd);
	}

	public static void FadeOutNearPoint(int entityID, Vector3 point, float fadeStart = 1f, float fadeEnd = 0f)
	{
		GetFadeBehaviour(entityID)?.SetFadeOutAt(point, fadeStart, fadeEnd);
	}

	public static void ClearFadeOutPoint(int entityID)
	{
		GetFadeBehaviour(entityID)?.ClearFadeOutAt();
	}

	public static void SetEntityVisible(int entityID, bool visible)
	{
		GetFadeBehaviour(entityID)?.SetVisible(visible);
	}

	public static void ChangeEntityAnimeScheme(int entityID, string scheme)
	{
		DormEntityManager manager = _manager;
		if ((bool)manager)
		{
			DormEntity dormEntity = manager.Get(entityID);
			if (manager.animeSchemeDict.TryGetValue(scheme, out var value))
			{
				dormEntity.UseAnimeCfg(value);
			}
			else
			{
				dormEntity.UseAnimeCfg(manager.defaultAnimeScheme);
			}
		}
	}

	public static void RestoreEntityAnimeScheme(int entityID)
	{
		DormEntityManager manager = _manager;
		if ((bool)manager)
		{
			manager.Get(entityID).RestoreAnimeScheme();
		}
	}

	public static void SetEntityDefaultAnimeScheme(int entityID, string scheme)
	{
		DormEntityManager manager = _manager;
		if ((bool)manager)
		{
			DormEntity dormEntity = manager.Get(entityID);
			if (manager.animeSchemeDict.TryGetValue(scheme, out var value))
			{
				dormEntity.defaultScheme = value;
			}
		}
	}

	internal void RestoreEntityAnimeSchemeInternal(DormEntity entity)
	{
		entity.UseAnimeCfg(defaultAnimeScheme);
	}

	public static void SetHighlighted(int entityID, bool highlight, int highlightLayer = 0)
	{
		DormEntity dormEntity = Instance?.TryGet(entityID);
		if (dormEntity != null)
		{
			dormEntity.HighlightLayer = highlightLayer;
			dormEntity.Highlighted = highlight;
		}
	}

	private bool SendMoveLookAt(int entityID, Vector3 targetPos, Vector3 lookAt, bool ignorePathFinding, bool queue)
	{
		if (TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			return dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.MoveAndLookAtPosCmdTask(targetPos, lookAt, ignorePathFinding), queue);
		}
		return false;
	}

	private bool SendMoveLookToDir(int entityID, Vector3 targetPos, Vector3 lookDir, bool ignorePathFinding, bool queue)
	{
		if (TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			return dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.MoveAndLookToDirCmdTask(targetPos, lookDir, ignorePathFinding), queue);
		}
		return false;
	}

	private bool SendRndWanderMove(bool resumeLastWander, int entityID, float maxDistance, bool queue)
	{
		if (TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			return dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.RndWanderMoveCmd(resumeLastWander, resumeLastWander ? 1 : UnityEngine.Random.Range(1, 4), maxDistance), queue);
		}
		return false;
	}

	private bool SendPatrol(int entityID, CinemachinePathBase path, bool reverse, float? offset, bool queue)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			return dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.PatrolCmdTask(path, reverse, offset), queue);
		}
		return false;
	}

	private bool SendInteractToEntity(int entityID, int otherEntity, int? action, bool queue)
	{
		if (TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			DormEntity otherEntity2 = Get(otherEntity);
			EntityCmdPriority priority = EntityCmdPriority.Interact;
			return dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.InteractCmdTask(otherEntity2, priority, action), queue);
		}
		return false;
	}

	private bool SendDoAction(int entityID, string animeName, string animeSubType, bool loop, bool queue)
	{
		return SendDoAction(entityID, animeName, animeSubType, loop, 0.05f, queue);
	}

	private bool SendDoAction(int entityID, string animeName, string animeSubType, bool loop, float crossFade, bool queue)
	{
		if (TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			return dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.PlayAnimeCmd(animeName, animeSubType, loop, crossFade), queue);
		}
		return false;
	}

	private GameObject LoadModel(string modelPath, bool pooled)
	{
		GameObject gameObject = ((!pooled) ? Asset.InstantiateWithoutCache(modelPath) : Asset.Instantiate(modelPath));
		if (gameObject == null)
		{
			throw new NullReferenceException("model from path " + modelPath + " is NULL!");
		}
		gameObject.SetActive(value: false);
		return gameObject;
	}

	public void SendCmd(int entityID, CmdTask cmd, bool queue)
	{
		if (Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.CmdExecuter.SendCmd(cmd, queue);
		}
	}

	public static void SetPlayerEntityFaceToCam(int entityID, bool value)
	{
		if (Instance.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.faceToCamera = value;
		}
	}

	public static void SetPlayerMainColliderEnabled(int entityID, bool value)
	{
		if ((bool)Instance && Instance.playerEntityDict.TryGetValue(entityID, out var value2))
		{
			value2.MainCollider.enabled = value;
		}
	}

	internal DormEntity SpawnEntityInternal(string modelPath, Transform spawn, bool complex, bool pooled)
	{
		int id = AllocEntityID();
		return SpawnEntityInternal(id, modelPath, spawn, complex, pooled);
	}

	internal DormEntity SpawnEntityInternal(int id, string modelPath, Transform spawn, bool complex, bool pooled)
	{
		GameObject model = LoadModel(modelPath, pooled);
		DormEntity dormEntity = ((!complex) ? new DormEntity(id, model, needDestoryModelOnDispose: true, pooled) : new DormComplexEntity(id, model, needDestoryModelOnDispose: true, pooled));
		RegisterEntity(dormEntity);
		dormEntity.name = $"{dormEntity.id} {dormEntity.name}";
		if ((bool)spawn)
		{
			dormEntity.PutAt(spawn.position, spawn.rotation);
		}
		dormEntity.SetActive(active: true);
		dormEntity.UseAnimeCfg(defaultAnimeScheme);
		return dormEntity;
	}

	public int SpawnPlayerEntity(string modelPath, Transform spawn = null)
	{
		DormComplexEntity dormComplexEntity = SpawnEntityInternal(modelPath, spawn, complex: true, pooled: false) as DormComplexEntity;
		playerEntityDict.Add(dormComplexEntity.id, new DormPlayerEntity(dormComplexEntity));
		return dormComplexEntity.id;
	}

	public int SpawnEntity(string modelPath, Transform spawn, bool complex, bool pooled)
	{
		return SpawnEntityInternal(modelPath, spawn, complex, pooled).id;
	}

	public void SpawnEntityAndReplace(int eid, string modelPath, bool complex, bool pooled)
	{
		Vector3 position = Vector3.zero;
		Quaternion rotation = Quaternion.identity;
		if (entityDict.ContainsKey(eid))
		{
			Transform modelTrs = entityDict[eid].ModelTrs;
			position = modelTrs.position;
			rotation = modelTrs.rotation;
			RemoveEntity(eid);
		}
		SpawnEntityInternal(eid, modelPath, null, complex, pooled).PutAt(position, rotation);
	}

	[NoToLua]
	public int MakeModelEntity(Transform dstModel, out DormEntity entity)
	{
		dstModel.gameObject.SetActive(value: false);
		int id = AllocEntityID();
		entity = new DormEntity(id, dstModel.gameObject, needDestoryModelOnDispose: false, dstModel.GetComponent<PooledAsset>() != null);
		RegisterEntity(entity);
		entity.SetActive(active: true);
		entity.UseAnimeCfg(defaultAnimeScheme);
		return entity.id;
	}

	public int MakeModelEntity(Transform dstModel)
	{
		DormEntity entity;
		return MakeModelEntity(dstModel, out entity);
	}

	public void ClearEntity()
	{
		foreach (DormEntity value in entityDict.Values)
		{
			value.DestoryEntity(0f);
		}
		entityDict.Clear();
		playerEntityDict.Clear();
		nextEntityID = 1;
	}

	public void RemoveEntity(int entityID, float delay = 0f)
	{
		entityDict[entityID].DestoryEntity(delay);
		entityDict.Remove(entityID);
		playerEntityDict.Remove(entityID);
	}

	internal void RemoveEntity(IEnumerable<int> entityList)
	{
		foreach (int entity in entityList)
		{
			RemoveEntity(entity);
		}
	}

	public void RemoveEntity(int[] entityArray)
	{
		RemoveEntity((IEnumerable<int>)entityArray);
	}

	internal void AttachToEntity(int child, int parent, string attachPoint, bool setAsChild)
	{
		DormEntity itemEntity = Get(child);
		Get(parent).AttachAsItem(itemEntity, attachPoint, setAsChild);
	}

	internal void DetachFromEntity(int item, bool resetFaceDir = true)
	{
		Get(item).DetachItemHost(resetFaceDir);
	}

	internal void GrabItemAttachTo(int entityID, int itemHost, string item, string attachPoint)
	{
		DormEntity dormEntity = TryGet(entityID);
		DormEntity owner = Get(itemHost);
		dormEntity?.AttachItemPart(owner, item, attachPoint);
	}

	internal void RestoreItemPart(int itemHost, string item)
	{
		TryGet(itemHost)?.RestoreSelfItemPart(item);
	}
}
