using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/完结时触发区域效果")]
public class WeaponFeatureFinishTriggerArea : WeaponFeature
{
	[Space]
	public GameObject areaEffectPrefab;

	public bool notSyncWeaponRotation;

	private FP _defaultTerrainHeight;

	public override void OnStart()
	{
		base.OnStart();
		_defaultTerrainHeight = CommonHelper.GetTerrainHeight(attachedWeapon.tsTransform.Position, attachedWeapon.tsTransform.PositionY, out var raycastHit);
		if (!raycastHit)
		{
			_defaultTerrainHeight = attachedWeapon.owner.tsTransform.PositionY;
		}
	}

	public override bool OnEnd()
	{
		OnExceute();
		return base.OnEnd();
	}

	private void OnExceute()
	{
		AdventureActor adventureActor = attachedWeapon.owner as AdventureActor;
		if (!(areaEffectPrefab == null) && !(adventureActor == null))
		{
			FP fP = CommonHelper.GetTerrainHeight(attachedWeapon.tsTransform.Position, attachedWeapon.tsTransform.PositionY, out var raycastHit);
			if (!raycastHit)
			{
				fP = _defaultTerrainHeight;
			}
			Vector3 spawnPosition = new Vector3((float)attachedWeapon.tsTransform.Position.x, (float)fP, (float)attachedWeapon.tsTransform.Position.y);
			Quaternion spawnRotation = (notSyncWeaponRotation ? Quaternion.identity : attachedWeapon.transform.rotation);
			SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(adventureActor, areaEffectPrefab, spawnPosition, spawnRotation);
		}
	}
}
