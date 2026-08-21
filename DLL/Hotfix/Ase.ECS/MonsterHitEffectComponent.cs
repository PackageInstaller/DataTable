using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class MonsterHitEffectComponent : BaseComponent
{
	private Dictionary<int, ForeverEffectEntity> playingEffectDic = new Dictionary<int, ForeverEffectEntity>();

	public override void Init(int index, BaseEntity entity, object data = null)
	{
		base.Init(index, entity, data);
	}

	public void PlayHitEffect(BaseEntity releaseEntity, Vector3 position, Vector3 rotation, int damageBeforeStateId, int damageStateId, int hitEffectIndex, int weakAttackPower)
	{
		if (!mBaseEntity.IsSurvival)
		{
			return;
		}
		DRGeneralHit dataRow = GameEntry.DataTable.GetDataRow<DRGeneralHit>(hitEffectIndex);
		if (dataRow == null)
		{
			return;
		}
		List<List<int>> stateHitEffects = GetStateHitEffects(dataRow, damageBeforeStateId, damageStateId);
		if (!stateHitEffects.IsNullOrEmpty() && weakAttackPower >= 1 && weakAttackPower <= stateHitEffects.Count)
		{
			List<int> list = stateHitEffects[weakAttackPower - 1];
			if (!list.IsNullOrEmpty() && list.Count == 2)
			{
				position += dataRow.PositionOffset.ToVector3();
				HandleEffect(releaseEntity, list[0], position, rotation, dataRow.EffectScale, isClear: true);
				HandleEffect(releaseEntity, list[1], position, rotation, 1f, isClear: false);
			}
		}
	}

	private void HandleEffect(BaseEntity releaseEntity, int effectId, Vector3 position, Vector3 rotation, float scale, bool isClear)
	{
		if (playingEffectDic.TryGetValue(effectId, out var value))
		{
			DREffect config = value.Config;
			if (mBaseEntity.GetSystem<EffectSystem>().EffectDataCtrlPlayEffect(releaseEntity, mBaseEntity, config))
			{
				value.RePlay(position, rotation, scale, isClear);
			}
		}
		else
		{
			value = PlayForeverHitEffect(releaseEntity, effectId, position, rotation, scale);
			if (value != null)
			{
				playingEffectDic.Add(effectId, value);
			}
		}
	}

	private List<List<int>> GetStateHitEffects(DRGeneralHit config, int damageBeforeStateId, int damageStateId)
	{
		switch (damageStateId)
		{
		case 0:
			return config.HitEffect0;
		case 1111:
			if (damageStateId == damageBeforeStateId)
			{
				return config.HitEffectAfter1111;
			}
			return config.HitEffect1111;
		case 1112:
			if (damageStateId == damageBeforeStateId)
			{
				return config.HitEffectAfter1112;
			}
			return config.HitEffect1112;
		case 1118:
			if (damageStateId == damageBeforeStateId)
			{
				return config.HitEffectAfter1118;
			}
			return config.HitEffect1118;
		case 2001:
			if (damageStateId == damageBeforeStateId)
			{
				return config.HitEffectAfter2001;
			}
			return config.HitEffect2001;
		case 2000:
			if (damageStateId == damageBeforeStateId)
			{
				return config.HitEffectAfter2000;
			}
			return config.HitEffect2000;
		case 3001:
			if (damageStateId == damageBeforeStateId)
			{
				return config.HitEffectAfter3001;
			}
			return config.HitEffect3001;
		default:
			return null;
		}
	}

	private EffectEntity PlayHitEffect(BaseEntity releaseEntity, int effectId, Vector3 position, Vector3 rotation, float scale)
	{
		return mBaseEntity.GetSystem<EffectSystem>().PlayEffect(releaseEntity, mBaseEntity, effectId, position, rotation, scale, isHitEffect: true) as EffectEntity;
	}

	private ForeverEffectEntity PlayForeverHitEffect(BaseEntity releaseEntity, int effectId, Vector3 position, Vector3 rotation, float scale)
	{
		return mBaseEntity.GetSystem<EffectSystem>().PlayForeverEffect(releaseEntity, mBaseEntity, effectId, position, rotation, scale, isHitEffect: true) as ForeverEffectEntity;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (ForeverEffectEntity value in playingEffectDic.Values)
		{
			value.DoEntityDead();
		}
		playingEffectDic.Clear();
	}
}
