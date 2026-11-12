using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_修改子弹移动速度")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_ModifyBulletSpeedComponent : AreaEffect_Component
{
	public TargetFilterCriteriaInfo criteriaInfo;

	public FP modifySpeedPercent;

	public bool modifyBulletDamage;

	public int additionalAttrId;

	public GameObject triggerFx;

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (entity is AdventureBulletBase adventureBulletBase && _context.CheckTarget(adventureBulletBase.owner, criteriaInfo) && (!(adventureBulletBase.owner is AdventureActor adventureActor) || !checkTargetWithTag || _checkTagHashCode == 0 || adventureActor.CheckTag(_checkTagHashCode)))
		{
			adventureBulletBase.velocitySpeed *= 1 + modifySpeedPercent / 100;
			if (modifyBulletDamage && additionalAttrId > 0)
			{
				adventureBulletBase.AddAdditionalAttr(additionalAttrId);
			}
			if (triggerFx != null)
			{
				AdventureFXPlayer.PlayFX(triggerFx, 1f, adventureBulletBase.transform.position, Quaternion.identity);
			}
		}
	}
}
