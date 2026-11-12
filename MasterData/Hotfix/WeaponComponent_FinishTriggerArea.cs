using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器组件/武器通用_结束时释放区域效果组件(目前仅炸弹可用)")]
[DisallowMultipleComponent]
public class WeaponComponent_FinishTriggerArea : LogicMonoComponent, IBombComponent
{
	public GameObject areaEffectPrefab;

	public bool notSyncWeaponRotation;

	protected AdventureWeapon _context;

	public bool KeepAlive { get; set; } = true;

	public void Setup()
	{
		_context = Entity as AdventureWeapon;
	}

	public void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		KeepAlive = true;
	}

	public void Finish()
	{
		if (!(_context == null))
		{
			AdventureActor adventureActor = _context.owner as AdventureActor;
			if (!(areaEffectPrefab == null) && !(adventureActor == null))
			{
				FP terrainHeight = CommonHelper.GetTerrainHeight(_context.tsTransform.Position, _context.tsTransform.PositionY);
				Vector3 spawnPosition = new Vector3((float)_context.tsTransform.Position.x, (float)terrainHeight, (float)_context.tsTransform.Position.y);
				Quaternion spawnRotation = (notSyncWeaponRotation ? Quaternion.identity : _context.transform.rotation);
				SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(adventureActor, areaEffectPrefab, spawnPosition, spawnRotation);
				KeepAlive = false;
			}
		}
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_context = null;
	}
}
