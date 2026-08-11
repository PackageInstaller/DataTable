#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Threading.Tasks;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class MechanismNode : BaseMapDataNode
{
	public bool isActive;

	public bool IsSaveData;

	public int mapItemId;

	[SerializeField]
	public string desc;

	public string InteractiveName;

	private MechanismRunState runState;

	private bool initActive;

	private GameObject mechanismObj;

	private BaseMechanism mechanismExcute;

	private BulletEntity bulletEntity;

	private Vector3 bulletOriginPos;

	public override bool IsMechanismNode => true;

	public MechanismRunState RunState => runState;

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		initActive = isActive;
	}

	protected override bool CheckLoadingCondition()
	{
		if (!base.TaskConditionResult || mapItemId == 0 || mechanismObj != null || !isActive || base.isKilled)
		{
			return false;
		}
		return true;
	}

	protected override void OnForceLoadNode()
	{
		base.OnForceLoadNode();
		LoadMechanism();
	}

	protected override void OnLoadNode()
	{
		base.OnLoadNode();
		LoadMechanism();
	}

	public override void OnUnLoadNode()
	{
		base.OnUnLoadNode();
		DestoryMechanism();
	}

	public override void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		base.OnReceiveMapDataEvent(eventType, otherEntity);
		if (eventType == LevelMapDataEvent.RestLevel)
		{
			OnRestLevel();
		}
	}

	public void OnRestLevel()
	{
		DestoryMechanism();
		isActive = initActive;
		mapDataNodeState = MapDataNodeState.Unsummoned;
	}

	public override void OnDisposed()
	{
		mapDataNodeState = MapDataNodeState.Unsummoned;
		DestoryMechanism();
	}

	private void DestoryMechanism()
	{
		if ((Object)(object)mechanismExcute != null)
		{
			mechanismExcute.ResetData();
		}
		if (mechanismObj != null)
		{
			if (mechanismObj.TryGetComponent<IPooledObject>(out var component))
			{
				component.Free();
			}
			else
			{
				Object.Destroy(mechanismObj);
			}
		}
		if (bulletEntity != null && bulletEntity.IsSurvival)
		{
			bulletEntity.DoEntityDead();
		}
		entity = null;
		mechanismObj = null;
		mechanismExcute = null;
		bulletEntity = null;
		bulletOriginPos = Vector3.zero;
	}

	private async Task<BaseEntity> LoadMechanism()
	{
		DRMapMechanism dataRow = GameEntry.DataTable.GetDataRow<DRMapMechanism>(mapItemId);
		if (dataRow == null)
		{
			Log.Error($"没有找到编号 = {mapItemId}的交互物配置..");
			return null;
		}
		mapDataNodeState = MapDataNodeState.Summoning;
		mechanismObj = await LoadMechanismObj(mapItemId, dataRow.AssetPath);
		mechanismObj.SetActive(value: true);
		mechanismObj.transform.parent = ((Component)(object)this).transform;
		mechanismObj.transform.localPosition = Vector3.zero;
		mechanismObj.transform.localRotation = Quaternion.identity;
		entity = base.World.WorldEntity;
		mechanismExcute = mechanismObj.GetComponentInChildren<BaseMechanism>();
		LevelSaveService.MechanismData mechanismData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMechanismData(sceneSystem.GetLevelId(), base.Uid);
		if (mechanismData == null)
		{
			runState = MechanismRunState.Running;
		}
		else
		{
			runState = (MechanismRunState)mechanismData.RunState;
		}
		if ((Object)(object)mechanismExcute != null)
		{
			mechanismExcute?.OnInit(this);
		}
		mapDataNodeState = MapDataNodeState.Summoned;
		return entity;
	}

	public async void CreateBullet(int bulletId, Vector3 rotate, Vector3 pos)
	{
		BulletMapExData bulletMapExData = new BulletMapExData();
		DRMapMechanism dataRow = GameEntry.DataTable.GetDataRow<DRMapMechanism>(mapItemId);
		bulletMapExData.Damage = dataRow.Damage;
		await sceneSystem.GetSystem<BulletSystem>().CreateMapBulletEntity(entity, bulletId, pos, rotate, bulletMapExData);
	}

	public async Task<BulletEntity> CreateLaserBullet(int bulletId, Vector3 rotate, Vector3 pos)
	{
		if (GameEntry.DataTable.GetDataRow<DRBullet>(bulletId) != null)
		{
			BulletMapExData bulletMapExData = new BulletMapExData();
			DRMapMechanism dataRow = GameEntry.DataTable.GetDataRow<DRMapMechanism>(mapItemId);
			bulletMapExData.Damage = dataRow.Damage;
			bulletEntity = await sceneSystem.GetSystem<BulletSystem>().CreateMapBulletEntity(entity, bulletId, useSelfPoint: false, pos, 0f, OffsetConfigurationType.Offset, Vector3.zero, 0f, 0f, 0f, bulletMapExData);
			bulletOriginPos = bulletEntity.transform.position;
			return bulletEntity;
		}
		return null;
	}

	private void Update()
	{
		if (bulletEntity != null && bulletEntity.IsSurvival && (Object)(object)mechanismExcute != null)
		{
			bulletEntity.GetComponent<BulletMoveComponent>().SetPosition(CustomRotateAround(((Component)(object)mechanismExcute).transform.position, bulletOriginPos, ((Component)(object)mechanismExcute).transform.rotation));
			bulletEntity.GetComponent<BulletMoveComponent>().SetRotation(((Component)(object)mechanismExcute).transform.rotation);
		}
	}

	public void SwitchMechanism()
	{
		if (!((Object)(object)mechanismExcute == null))
		{
			if (runState == MechanismRunState.Running)
			{
				CloseMechanism();
			}
			else if (runState == MechanismRunState.Close)
			{
				OpenMechanism();
			}
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SetMechanismData(sceneSystem.GetLevelId(), base.Uid, (int)runState);
		}
	}

	public void CloseMechanism()
	{
		if (bulletEntity != null)
		{
			bulletEntity.DoEntityDead();
		}
		bulletEntity = null;
		bulletOriginPos = Vector3.zero;
		mechanismExcute.OnClose();
		runState = MechanismRunState.Close;
	}

	public void OpenMechanism()
	{
		mechanismExcute.OnOpen();
		runState = MechanismRunState.Running;
	}

	public void SetMechanismDie()
	{
		runState = MechanismRunState.Die;
		Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SetMechanismData(sceneSystem.GetLevelId(), base.Uid, (int)runState);
	}

	public Vector3 CustomRotateAround(Vector3 originPos, Vector3 rotateCenterPos, Quaternion rotation)
	{
		Vector3 vector = originPos - rotateCenterPos;
		Vector3 vector2 = rotation * vector;
		return originPos + vector2;
	}

	public void OnGameSpeedChanged(float gameSpeed)
	{
		if ((Object)(object)mechanismExcute != null)
		{
			mechanismExcute.OnGameSpeedChanged(gameSpeed);
		}
	}
}
