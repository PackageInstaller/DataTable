using System.Collections.Generic;
using System.Globalization;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class CureProgressBase : IReference
{
	protected FormulaResultData resultData;

	protected CureFormulaDataParams cureDataParams;

	protected List<FormulaZoneDataBase> cureFormulaDataList;

	protected BaseEntity cureEntity;

	protected BaseEntity doctorEntity;

	private readonly FormulaZoneBase[] _cureFormulaZones = new FormulaZoneBase[4]
	{
		new BaseCureFormulaZone(),
		new BeCureFormulaZone(),
		new CureAdditionFormulaZone(),
		new AIBeCureFormulaZone()
	};

	public void ProgressStart(CureFormulaDataParams cureDataParams)
	{
		if (cureDataParams != null)
		{
			this.cureDataParams = cureDataParams;
			cureEntity = this.cureDataParams.cureEntity;
			doctorEntity = this.cureDataParams.doctorEntity;
			resultData = default(FormulaResultData);
			OnExecuteProgressLogic();
			OnExcuteSettlementProcess();
			OnExcuteProgressLogicEnd();
		}
	}

	protected void OnExecuteProgressLogic()
	{
		cureFormulaDataList = CollectionPool<List<FormulaZoneDataBase>, FormulaZoneDataBase>.Get();
		float num = 1f;
		for (int i = 0; i < _cureFormulaZones.Length; i++)
		{
			FormulaZoneDataBase formulaZoneDataBase = _cureFormulaZones[i].CalcFormulaZone(cureDataParams);
			num *= formulaZoneDataBase.result;
			cureFormulaDataList.Add(formulaZoneDataBase);
		}
		num = Mathf.Clamp(num, 0f, float.MaxValue);
		resultData.recover = Mathf.CeilToInt(num);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"治疗公式流程计算： 被治疗实体ID:{cureEntity.Id} => 医生实体ID:{doctorEntity.Id} ------------>", cureEntity);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId("治疗公式流程计算结束 ------------>", cureEntity);
		}
	}

	protected virtual void OnExcuteProgressLogicEnd()
	{
		BattleObserverSystem system = cureEntity.GetSystem<BattleObserverSystem>();
		if (system != null)
		{
			ObserverRecoverParams observerRecoverParams = ReferencePool.Acquire<ObserverRecoverParams>();
			observerRecoverParams.Init(doctorEntity, cureEntity, resultData.recover, cureDataParams.belongToSkillId);
			system.Notify(BattleObserverEventEnum.Recover, observerRecoverParams);
			ReferencePool.Release(observerRecoverParams);
		}
	}

	protected void OnExcuteSettlementProcess()
	{
		if (cureDataParams.isLayerEffect)
		{
			resultData.recover *= cureDataParams.layer;
		}
		cureEntity.GetComponent<HpComponent>().RecoveryHp(doctorEntity, resultData.recover, out var cureHp);
		int num = Mathf.FloorToInt(cureHp);
		resultData.recover = num;
		if (num > 0 && cureEntity.GetEntityType() == EntityType.HERO && (cureEntity.IsActorEntity || doctorEntity.IsActorEntity))
		{
			UIDamageTextSystem system = cureEntity.GetSystem<UIDamageTextSystem>();
			if (system != null)
			{
				TextDamageParam textDamageParam = ReferencePool.Acquire<TextDamageParam>();
				textDamageParam.showContent = num.ToString(CultureInfo.InvariantCulture);
				system.ShowStackDamageText(textDamageParam, cureEntity, "health");
			}
		}
	}

	public void Clear()
	{
		CollectionPool<List<FormulaZoneDataBase>, FormulaZoneDataBase>.Release(cureFormulaDataList);
		cureDataParams = null;
	}
}
