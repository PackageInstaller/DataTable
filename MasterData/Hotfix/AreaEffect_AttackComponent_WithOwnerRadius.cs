using System;
using TrueSync;
using UnityEngine;

[Serializable]
[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_攻击_以持有者半径为攻击半径")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_AttackComponent_WithOwnerRadius : AreaEffect_AttackComponent
{
	public FP hitRadiusAmend = 0;

	public override void Hit()
	{
		if (hitEffectPrefab != null)
		{
			AdventureFXPlayer.PlayFX(hitEffectPrefab, (float)_context.logicTimeScale, _context.cTrans.position, _context.cTrans.transform.rotation, _context.transform.localScale.x);
		}
		int num = GetHitDamageId();
		_context.HitWithOwnerRadius(hitRadiusAmend, num, hitFlags, hitFeatureData, hurtAnimType, hittedEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale, damageImmuneDuration, haveFeedbackEffect, playerfeedbackEffectConfigureData, this);
		if (blockBullet)
		{
			_context.BlockBullet(blockBulletCriteriaInfo, blockFinishFx, checkTargetWithTag ? _checkTagHashCode : 0);
		}
		_hitIndex++;
	}
}
