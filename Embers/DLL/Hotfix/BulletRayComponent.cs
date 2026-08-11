using System.Collections.Generic;
using System.Threading.Tasks;
using Ase;
using Ase.ECS;
using UnityEngine;

public class BulletRayComponent : BaseComponent
{
	public class ReflexTaskData
	{
		public int reflexID;

		public Task<BulletEntity> task;
	}

	public struct RayCutReflexData
	{
		public bool isCut;

		public bool isReflex;

		public Vector3 point;

		public void Reset()
		{
			isCut = false;
			isReflex = false;
			point = Vector3.zero;
		}
	}

	protected BulletData _bulletData;

	protected BulletEntity reflexBullet;

	private bool isExcuteHiting;

	private bool isCut;

	private bool isReflex;

	private bool isCuting;

	private bool isReflexing;

	protected int reflexCount = 3;

	protected Vector3 originBulletPos;

	protected InteractiveEntity interactiveEntity;

	protected float breakType;

	protected BaseEntity reflexRoot;

	protected BulletRayData rayData;

	protected RayCutReflexData rayCutReflexData;

	protected float originLength;

	protected List<ReflexTaskData> reflexTaskList;

	private int reflexTaskID;

	public override void Init(int index, BaseEntity entity, object data = null)
	{
		base.Init(index, entity, data);
		reflexTaskList = new List<ReflexTaskData>();
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_bulletData = GetData<BulletData>("bulletData");
		if (_bulletData != null)
		{
			if (_bulletData.cfg != null)
			{
				BulletExtraHitEnum bulletExtraHitEnum = _bulletData.cfg.BulletExtraHitEnum;
				isCut = bulletExtraHitEnum == BulletExtraHitEnum.Cut || bulletExtraHitEnum == BulletExtraHitEnum.Reflex || bulletExtraHitEnum == BulletExtraHitEnum.CutReflex;
				isReflex = bulletExtraHitEnum == BulletExtraHitEnum.Reflex || bulletExtraHitEnum == BulletExtraHitEnum.CutReflex;
			}
			if (_bulletData.extraData != null && _bulletData.extraData.moveData is BulletRayData bulletRayData && bulletRayData != null)
			{
				rayData = bulletRayData;
				reflexRoot = rayData.reflexRoot;
				reflexCount = rayData.reflexCount;
			}
			else
			{
				reflexRoot = mBaseEntity.Parent;
			}
		}
		rayCutReflexData = default(RayCutReflexData);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if (!isCut && !isReflex)
		{
			return;
		}
		if (rayData != null)
		{
			BulletMoveComponent component = mBaseEntity.GetComponent<BulletMoveComponent>();
			if (component != null)
			{
				component.SetRayState(state: true);
				component.SetPosition(mBaseEntity.transform.position);
			}
		}
		BulletViewComponent component2 = mBaseEntity.GetComponent<BulletViewComponent>();
		if (component2 != null)
		{
			component2.SetPosition(mBaseEntity.transform.position);
			component2.ShowEntityView();
		}
	}

	public void ExcuteHit(BaseEntity baseEntity)
	{
		if (_bulletData == null || _bulletData.cfg == null || (!isCut && !isReflex))
		{
			return;
		}
		isExcuteHiting = true;
		if (baseEntity is InteractiveEntity interactiveEntity && this.interactiveEntity == null && reflexRoot != interactiveEntity)
		{
			this.interactiveEntity = interactiveEntity;
			breakType = interactiveEntity.GetData<int>(Constant.InteractiveConstant.BREAKTYPE);
			if (breakType == 2f && isReflex)
			{
				EnterReflexLogic(interactiveEntity);
			}
			else if ((breakType == 1f || breakType == 2f) && isCut)
			{
				EnterCutLogic();
			}
		}
	}

	protected virtual void ChangeReflexInteractiveEntity(InteractiveEntity entity)
	{
		ExitHit(interactiveEntity);
		ExcuteHit(entity);
	}

	protected void EnterCutLogic()
	{
		if (reflexRoot != null)
		{
			originLength = GetOriginBulletLength();
			if (originLength != 0f)
			{
				isCuting = true;
				CheckRayCutingReflexing();
			}
		}
	}

	protected void UpdateCutLogic()
	{
		if (!isCuting)
		{
			return;
		}
		if (!rayCutReflexData.isCut)
		{
			OnExitHit();
			return;
		}
		Vector3 vector = ((rayData != null) ? rayData.inPoint : reflexRoot.transform.position);
		float len = Vector3.Distance(vector, rayCutReflexData.point) + 0.01f;
		Vector3 position = Vector3.Lerp(rayCutReflexData.point, vector, 0.5f);
		List<float> cutPrimitiviParam = GetCutPrimitiviParam(len);
		HitVolume hitVolume = mBaseEntity.GetComponent<BulletTriggerComponent>()?.ResetBulletVolume(cutPrimitiviParam);
		mBaseEntity.GetComponent<BulletMoveComponent>()?.SetPosition(position);
		BulletViewComponent component = mBaseEntity.GetComponent<BulletViewComponent>();
		if (component != null)
		{
			component.OnRefreshViewSize(hitVolume);
			component.SetPosition(position);
		}
		if (isReflex && reflexBullet != null)
		{
			reflexBullet.GetComponent<BulletRayComponent>().UpdateReflexInPoint(rayCutReflexData.point);
		}
	}

	protected void EnterReflexLogic(InteractiveEntity interactiveEntity)
	{
		if (reflexRoot != null && reflexCount > 0)
		{
			EnterCutLogic();
			ClearReflexData();
			if (rayCutReflexData.isReflex)
			{
				originLength = GetOriginBulletLength();
				Vector3 vector = ((rayData != null) ? rayData.inPoint : reflexRoot.transform.position);
				Vector3 normalized = (interactiveEntity.transform.rotation * Vector3.forward).normalized;
				Vector3 toDirection = Vector3.Reflect((rayCutReflexData.point - vector).normalized, normalized.normalized);
				Vector3 position = rayCutReflexData.point + toDirection.normalized * (originLength / 2f);
				position -= _bulletData.cfg.PositionOffset.ToVector3();
				position.y -= _bulletData.cfg.OffsetHeight;
				Vector3 eulerAngles = Quaternion.FromToRotation(Vector3.forward, toDirection).eulerAngles;
				CreateReflexBullet(rayCutReflexData.point, position, eulerAngles, interactiveEntity);
				isReflexing = true;
			}
		}
	}

	protected void CreateReflexBullet(Vector3 hitPoint, Vector3 position, Vector3 rotation, InteractiveEntity interactiveEntity)
	{
		if (mBaseEntity.Parent != null && _bulletData != null && _bulletData.cfg != null)
		{
			BulletExtraData bulletExtraData = mBaseEntity.GetSystem<BulletSystem>().CreateBulletExtraData(mBaseEntity.Parent.Id, _bulletData.cfg);
			bulletExtraData.moveData = new BulletRayData
			{
				reflexRoot = interactiveEntity,
				reflexCount = reflexCount - 1,
				inPoint = hitPoint
			};
			bulletExtraData.viewData = new BulletViewData
			{
				isActive = false
			};
			Task<BulletEntity> task = mBaseEntity.GetSystem<BulletSystem>().CreateBulletEntity(mBaseEntity.Parent, _bulletData.configId, position, rotation, mBaseEntity.EntityData.currentTickCreate, bulletExtraData);
			reflexTaskID++;
			if (reflexTaskID > 9999)
			{
				reflexTaskID = 0;
			}
			ReflexTaskData item = new ReflexTaskData
			{
				reflexID = reflexTaskID,
				task = task
			};
			reflexTaskList.Add(item);
		}
	}

	protected void UpdateReflexLogic()
	{
		if (isCuting && isReflexing && reflexBullet != null)
		{
			originLength = GetOriginBulletLength();
			Vector3 vector = ((rayData != null) ? rayData.inPoint : reflexRoot.transform.position);
			Vector3 normalized = (interactiveEntity.transform.rotation * Vector3.forward).normalized;
			Vector3 toDirection = Vector3.Reflect((rayCutReflexData.point - vector).normalized, normalized.normalized);
			Vector3 position = rayCutReflexData.point + toDirection.normalized * (originLength / 2f);
			Quaternion rotation = Quaternion.FromToRotation(Vector3.forward, toDirection);
			BulletMoveComponent component = reflexBullet.GetComponent<BulletMoveComponent>();
			if (component != null)
			{
				component.SetPosition(position);
				component.SetRotation(rotation);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if ((isExcuteHiting && isReflex) || isCut)
		{
			CheckRayCutingReflexing();
			if (isReflex)
			{
				if (!isReflexing && rayCutReflexData.isReflex)
				{
					EnterReflexLogic(interactiveEntity);
					return;
				}
				if (isReflexing && !rayCutReflexData.isReflex)
				{
					ExitReflexLogic(isExitCut: false);
				}
			}
			if (isCut && !isCuting && rayCutReflexData.isCut)
			{
				EnterCutLogic();
				return;
			}
		}
		UpdateCutLogic();
		UpdateReflexLogic();
		for (int num = reflexTaskList.Count - 1; num >= 0; num--)
		{
			ReflexTaskData reflexTaskData = reflexTaskList[num];
			if (reflexTaskData.task.IsCompleted)
			{
				reflexTaskList.RemoveAt(num);
				if (reflexTaskData.reflexID != reflexTaskID)
				{
					reflexTaskData.task.Result.DoEntityDead();
				}
				else
				{
					reflexBullet = reflexTaskData.task.Result;
				}
			}
			else if (reflexTaskData.task.IsCanceled || reflexTaskData.task.IsFaulted)
			{
				reflexTaskList.RemoveAt(num);
			}
		}
	}

	protected virtual void CheckRayCutingReflexing()
	{
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		rayCutReflexData.Reset();
		if (interactiveEntity == null)
		{
			return;
		}
		Vector3 vector = ((rayData != null) ? rayData.inPoint : reflexRoot.transform.position);
		Vector3 vector2 = mBaseEntity.transform.position - vector;
		Vector3 normalized = (interactiveEntity.transform.rotation * Vector3.forward).normalized;
		RaycastHit[] array = Physics.RaycastAll(vector, vector2, GetOriginBulletLength());
		if (array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				if (((Component)(object)((RaycastHit)(ref array[i])).collider).gameObject == interactiveEntity.GetEntityObject())
				{
					rayCutReflexData.isCut = breakType == 1f || breakType == 2f;
					rayCutReflexData.point = ((RaycastHit)(ref array[i])).point;
					float num = Vector3.Dot(((RaycastHit)(ref array[i])).normal, normalized);
					rayCutReflexData.isReflex = num > 0.01f && breakType == 2f;
					if (HitVolumeLog.isLog)
					{
						DrawDebugTools.DrawRaycastHit(vector, reflexRoot.transform.rotation * Vector3.forward, originLength, array[i], 0.03f);
					}
					break;
				}
			}
		}
		if (HitVolumeLog.isLog)
		{
			DrawDebugTools.DrawLine(vector, vector + vector2 * 5f, Color.blue, rayCutReflexData.isCut ? Time.fixedDeltaTime : 5f);
			DrawDebugTools.DrawLine(interactiveEntity.transform.position, interactiveEntity.transform.position + normalized * 2f, Color.black, rayCutReflexData.isCut ? Time.fixedDeltaTime : 5f);
		}
	}

	public void ExitHit(BaseEntity interactiveEntity)
	{
		if (interactiveEntity is InteractiveEntity && this.interactiveEntity == interactiveEntity)
		{
			OnExitHit();
			this.interactiveEntity = null;
			isExcuteHiting = false;
		}
	}

	protected void OnExitHit()
	{
		if (isCuting || isReflexing)
		{
			int data = interactiveEntity.GetData<int>(Constant.InteractiveConstant.BREAKTYPE);
			if (data == 1 && isCuting)
			{
				ExitCutLogic();
			}
			else if (data == 2 && (isCuting || isReflexing))
			{
				ExitReflexLogic();
			}
		}
	}

	protected void ExitCutLogic()
	{
		if (isCuting)
		{
			ClearCutData();
			isCuting = false;
		}
	}

	protected void ExitReflexLogic(bool isExitCut = true)
	{
		if (isExitCut)
		{
			ExitCutLogic();
		}
		if (isReflexing)
		{
			ClearReflexData();
			isReflexing = false;
		}
	}

	protected void ClearCutData()
	{
		mBaseEntity.GetComponent<BulletMoveComponent>()?.SetRayState();
		HitVolume hitVolume = mBaseEntity.GetComponent<BulletTriggerComponent>()?.ResetBulletVolume();
		mBaseEntity.GetComponent<BulletViewComponent>()?.OnRefreshViewSize(hitVolume);
	}

	protected void ClearReflexData()
	{
		if (reflexBullet != null)
		{
			reflexBullet = null;
		}
	}

	protected void UpdateReflexInPoint(Vector3 inPoint)
	{
		if (rayData != null)
		{
			rayData.inPoint = inPoint;
		}
	}

	protected float GetOriginBulletLength()
	{
		if (originLength != 0f)
		{
			return originLength;
		}
		if (_bulletData == null || _bulletData.cfg == null)
		{
			return 0f;
		}
		PrimitiveEnum primitiveEnum = _bulletData.cfg.PrimitiveEnum;
		if ((uint)(primitiveEnum - 1) <= 2u)
		{
			return _bulletData.cfg.PrimitiveParam[2];
		}
		return 0f;
	}

	protected List<float> GetCutPrimitiviParam(float len)
	{
		List<float> list = new List<float>(_bulletData.cfg.PrimitiveParam);
		int count = list.Count;
		switch (_bulletData.cfg.PrimitiveEnum)
		{
		case PrimitiveEnum.CapsulePrimitive:
		case PrimitiveEnum.SpherePrimitive:
		case PrimitiveEnum.BoxPrimitive:
			if (count != 3)
			{
				return null;
			}
			list[2] = len;
			break;
		case PrimitiveEnum.SectorPrimitive:
		case PrimitiveEnum.AnnulusPrimitive:
			return null;
		}
		return list;
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		if (isCut)
		{
			ClearCutData();
		}
		if (isReflex)
		{
			ClearReflexData();
		}
	}

	public override void OnDispose()
	{
		_bulletData = null;
	}
}
