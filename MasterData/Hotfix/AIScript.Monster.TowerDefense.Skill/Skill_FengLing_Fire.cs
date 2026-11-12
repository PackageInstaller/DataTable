using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_FengLing_Fire : TowerMonsterSkillBase
{
	public const string BULLET_TAG_PREFIX = "FengLingFire_Heat:";

	private FP searchRange = 10;

	private int fireGridCount = 1;

	private string bulletKey = "Weapon_Fire";

	private FP shootPositionY = 1.26;

	private TSVector2 ShootPos = new TSVector2(0, 0.9);

	private List<GridInfoData> cachedGrids;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		cachedGrids = null;
	}

	protected override IEnumerator DoMainLogic()
	{
		Dispatch_GetGridsInfoInCircle(_actor.tsTransform.Position, searchRange, preferNonFlame: true, (List<GridInfoData> grids) =>
		{
			cachedGrids = grids;
		});
		if (cachedGrids.Count == 0)
		{
			_skill?.Clear();
			yield break;
		}
		cachedGrids.Sort((GridInfoData a, GridInfoData b) =>
		{
			if (a.isSprayed != b.isSprayed)
			{
				return a.isSprayed.CompareTo(b.isSprayed);
			}
			return (a.isOnFire != b.isOnFire) ? a.isOnFire.CompareTo(b.isOnFire) : a.gridIndex.CompareTo(b.gridIndex);
		});
		int count = ((fireGridCount < cachedGrids.Count) ? fireGridCount : cachedGrids.Count);
		List<GridInfoData> picked = cachedGrids.GetRange(0, count);
		_actor.LookAt(picked.get_Item(0).position, 0);
		BeginAttack(1, "Shoot", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("ShootEvent");
		GridInfoData gridInfoData = picked.get_Item(0);
		TSVector2 tSVector = TransLocalPosToWorldPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, ShootPos);
		AdventureBullet adventureBullet = ILRuntimeAPI.Shoot(bulletKey, _actor, 0, tSVector, shootPositionY, gridInfoData.position, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureBullet;
		if (adventureBullet != null)
		{
			adventureBullet.bulletTag = "FengLingFire_Heat:";
			FP fP = TSVector2.Distance(gridInfoData.position, tSVector);
			adventureBullet.LiftTime = fP / adventureBullet.velocitySpeed;
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
