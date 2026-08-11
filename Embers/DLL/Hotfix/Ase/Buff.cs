#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class Buff : IReference
{
	private BaseEntity buffFrom;

	private BaseEntity buffOwner;

	private int buffId;

	private DRBuff config;

	private int buffLayer;

	private float waitTime;

	private bool isWait;

	private float curLifeTime;

	private float maxLifeTime;

	private bool isForeverTime;

	private float repeatTime;

	private float repeatTimeTemp;

	private bool isLayerRepeat;

	private float layerRepeatTime;

	private float layerRepeatTimeTemp;

	private ConditionList<BuffConditionBase> buffAddConditions;

	private ConditionList<BuffConditionBase> buffTriggerConditions;

	private ConditionList<BuffConditionBase> buffFinishConditions;

	private ConditionList<BuffConditionBase> buffClearOperationsConditions;

	private const string EFFECT_PERSISTENT = "Persistent";

	private const string EFFECT_TRIGGER = "Trigger";

	private int persistentEffectId;

	private string persistentEffectPoint;

	private bool isPersistentEffect;

	private int triggerEffectId;

	private string triggerEffectPoint;

	private bool isTriggerEffect;

	private BuffEffectEntity buffEffect;

	private BuffActionBase buffActionBase;

	private BuffRuntimeConfigData runtimeConfigData;

	private BuffRuntimeDataBase conditionRuntimeData;

	private BuffRuntimeDataBase buffRuntimeData;

	private bool hasOperations;

	private int triggerCount;

	public List<IBuffOperation> buffOperationList;

	private bool isWaitFrame;

	public DRBuff Config => config;

	public BaseEntity BuffFrom => buffFrom;

	public BaseEntity BuffOwner => buffOwner;

	public BuffEffectEntity BuffEffect => buffEffect;

	public BuffRuntimeConfigData RuntimeConfigData => runtimeConfigData;

	public BuffRuntimeDataBase ConditionRuntimeData => conditionRuntimeData;

	public BuffRuntimeDataBase BuffRuntimeData => buffRuntimeData;

	public int BuffId => buffId;

	public string Desc => config?.Desc ?? "NULL";

	public float CurLifeTime => curLifeTime;

	public float MaxLifeTime => maxLifeTime;

	public float RepeatTime => repeatTime;

	public bool HasOperations => hasOperations;

	public bool ShowUI => !string.IsNullOrEmpty(config?.BuffIcon);

	public void Init(BaseEntity from, BaseEntity target, DRBuff config)
	{
		buffFrom = from;
		buffOwner = target;
		this.config = config;
		if (this.config != null)
		{
			buffId = this.config.Id;
			InitConfigStaticData();
			OnInit();
		}
	}

	private void OnInit()
	{
		if (!(config.WaitTime < 0f))
		{
			InitData();
			if (ChekBuffSafeAction())
			{
				InitOperation();
			}
		}
	}

	private void InitConfigStaticData()
	{
		if (InitBuffCondition())
		{
			InitSFX();
			InitBuffAction();
		}
	}

	private void InitData()
	{
		buffLayer = config.InitLayer;
		waitTime = config.WaitTime;
		isWait = waitTime > 0f;
		maxLifeTime = config.Duration;
		curLifeTime = 0f;
		isForeverTime = maxLifeTime < 0f;
		repeatTime = config.RepeatTime;
		repeatTimeTemp = 0f;
		layerRepeatTime = config.LayerRepeatTime;
		layerRepeatTimeTemp = 0f;
		isLayerRepeat = layerRepeatTime >= 0f;
		if (isLayerRepeat && config.LayerRepeatNum == 0)
		{
			isLayerRepeat = false;
		}
		hasOperations = false;
		triggerCount = 0;
		isWaitFrame = false;
	}

	private void InitOperation()
	{
		if (buffOperationList != null)
		{
			buffOperationList.Clear();
		}
		else
		{
			buffOperationList = CollectionPool<List<IBuffOperation>, IBuffOperation>.Get();
		}
		BuffExtension.AnalysisBuffOperations(config.Operations, in buffOperationList);
		if (buffOperationList.IsNullOrEmpty())
		{
			return;
		}
		foreach (IBuffOperation buffOperation in buffOperationList)
		{
			buffOperation.Init(this);
		}
	}

	public void CreateOperation(BuffOperationType operationType)
	{
		if (buffOperationList != null)
		{
			buffOperationList.Clear();
		}
		else
		{
			buffOperationList = CollectionPool<List<IBuffOperation>, IBuffOperation>.Get();
		}
		IBuffOperation buffOperation = BuffExtension.AnalysisBuffOperation(operationType);
		if (buffOperation != null)
		{
			buffOperationList.Add(buffOperation);
			buffOperation.Init(this);
		}
	}

	private bool InitBuffCondition()
	{
		if (!config.AddCondition.IsNullOrEmpty())
		{
			buffAddConditions = BuffExtension.GenerateBuffConditions(BuffFrom, BuffOwner, config.AddCondition);
			if (buffAddConditions == null)
			{
				return false;
			}
		}
		if (!config.TriggerCondition.IsNullOrEmpty())
		{
			buffTriggerConditions = BuffExtension.GenerateBuffConditions(BuffFrom, BuffOwner, config.TriggerCondition);
			if (buffTriggerConditions == null)
			{
				return false;
			}
		}
		if (!config.FinishCondition.IsNullOrEmpty())
		{
			buffFinishConditions = BuffExtension.GenerateBuffConditions(BuffFrom, BuffOwner, config.FinishCondition);
			if (buffFinishConditions == null)
			{
				return false;
			}
		}
		if (!config.ClearOperationsCondition.IsNullOrEmpty())
		{
			buffClearOperationsConditions = BuffExtension.GenerateBuffConditions(BuffFrom, BuffOwner, config.ClearOperationsCondition);
			if (buffClearOperationsConditions == null)
			{
				return false;
			}
		}
		return true;
	}

	public void InitRuntimeConfigData(BuffRuntimeConfigData runtimeConfigData)
	{
		this.runtimeConfigData = runtimeConfigData;
	}

	private void InitBuffAction()
	{
		buffActionBase = BuffActionBase.GetBuffAction(config.BuffActionTypeEnum);
		buffActionBase.OnInit(this, config.BuffActionTypeParams);
	}

	private void InitSFX()
	{
		isPersistentEffect = false;
		isTriggerEffect = false;
		if (config.SFX.IsNullOrEmpty())
		{
			return;
		}
		for (int i = 0; i < config.SFX.Count; i++)
		{
			List<string> list = config.SFX[i];
			if (list.Count == 3)
			{
				if (list[0] == "Persistent")
				{
					persistentEffectId = Utility.Convert.StringToInt(list[1]);
					persistentEffectPoint = list[2];
					isPersistentEffect = true;
				}
				else if (list[0] == "Trigger")
				{
					triggerEffectId = Utility.Convert.StringToInt(list[1]);
					triggerEffectPoint = list[2];
					isTriggerEffect = true;
				}
			}
		}
	}

	public void AddConditionRuntimeData(BuffRuntimeDataBase runtimeDataBase)
	{
		conditionRuntimeData = runtimeDataBase;
	}

	public void AddBuffRuntimeData(BuffRuntimeDataBase runtimeDataBase)
	{
		if (buffRuntimeData != null)
		{
			ReferencePool.Release(buffRuntimeData);
		}
		buffRuntimeData = runtimeDataBase;
	}

	private bool ChekBuffSafeAction()
	{
		if ((BuffOwner.GetSystem<BattleSystem>()?.BattleMode ?? BattleWorldMode.SyncBattle) == BattleWorldMode.SyncBattle)
		{
			if (runtimeConfigData != null && !RuntimeConfigData.BuffLabel.IsNullOrEmpty() && RuntimeConfigData.BuffLabel.Contains("SINGLE_MODE"))
			{
				return false;
			}
			OnCheckSyncBattleSafeAction();
		}
		return true;
	}

	private void OnCheckSyncBattleSafeAction()
	{
	}

	public void ResetOperationParams(params object[] args)
	{
		if (buffOperationList == null)
		{
			return;
		}
		foreach (IBuffOperation buffOperation in buffOperationList)
		{
			buffOperation?.ResetParams(args);
		}
	}

	public void Start()
	{
		AddRecordInfo(isSurvival: true);
		if (config == null || buffId == 0)
		{
			Finish();
			return;
		}
		PlayEffectLifeTime();
		if (buffActionBase != null)
		{
			buffActionBase.OnReset(this);
		}
		DirectExecute();
	}

	private void DirectExecute()
	{
		if (!isWait)
		{
			Execute();
			if (CheckClearOperationCondition())
			{
				ClearOperations();
			}
			if (CheckFinishCondition())
			{
				Finish();
				return;
			}
		}
		if (maxLifeTime == 0f)
		{
			Finish();
		}
	}

	public void Execute()
	{
		if (CheckTriggerCondition())
		{
			OnExecute();
		}
		else
		{
			OnNotExecute();
		}
	}

	private void OnExecute()
	{
		if (buffOwner == null || buffFrom == null)
		{
			return;
		}
		ObserverExcuteBuffParams observerExcuteBuffParams = ReferencePool.Acquire<ObserverExcuteBuffParams>();
		observerExcuteBuffParams.Init(this, buffOwner, buffFrom);
		buffOwner.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.ExcuteBuff, observerExcuteBuffParams);
		ReferencePool.Release(observerExcuteBuffParams);
		if (buffOperationList != null)
		{
			IBuffOperation[] array = buffOperationList.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				array[i]?.Execute();
			}
		}
		PlayEffectExecute();
		triggerCount++;
		hasOperations = true;
	}

	private void OnNotExecute()
	{
		if (buffOperationList == null)
		{
			return;
		}
		foreach (IBuffOperation buffOperation in buffOperationList)
		{
			buffOperation.NotExecute();
		}
	}

	public void Update(float deltaTime)
	{
		if (!isWaitFrame)
		{
			isWaitFrame = true;
			return;
		}
		deltaTime = (IgnoreTimeScale() ? 0.033f : deltaTime);
		UpdateLifeTime(deltaTime);
		UpdateBuffData(deltaTime);
	}

	private void UpdateBuffData(float deltaTime)
	{
		if (isWait)
		{
			UpdateWait(deltaTime);
			return;
		}
		if (CheckFinishCondition())
		{
			Finish();
			return;
		}
		UpdateCondition(deltaTime);
		UpdateLayer(deltaTime);
		UpdateRepeatExecute(deltaTime);
		if (CheckClearOperationCondition())
		{
			ClearOperations();
		}
		if (!isForeverTime && curLifeTime >= maxLifeTime)
		{
			Finish();
		}
	}

	private void UpdateWait(float deltaTime)
	{
		waitTime -= deltaTime;
		if (waitTime <= 0f)
		{
			curLifeTime += 0f - waitTime;
			isWait = false;
			Execute();
		}
	}

	private void UpdateCondition(float deltaTime)
	{
		if (buffTriggerConditions.IsNullOrEmpty())
		{
			return;
		}
		foreach (BuffConditionBase buffTriggerCondition in buffTriggerConditions)
		{
			buffTriggerCondition.Update(deltaTime);
		}
	}

	private void UpdateRepeatExecute(float deltaTime)
	{
		if (!(repeatTime < 0f))
		{
			repeatTimeTemp += deltaTime;
			if (repeatTimeTemp >= repeatTime)
			{
				repeatTimeTemp -= repeatTime;
				Execute();
			}
		}
	}

	private void UpdateLifeTime(float deltaTime)
	{
		curLifeTime += deltaTime;
	}

	private void UpdateLayer(float deltaTime)
	{
		if (isLayerRepeat)
		{
			layerRepeatTimeTemp += deltaTime;
			if (layerRepeatTimeTemp >= layerRepeatTime)
			{
				layerRepeatTimeTemp -= layerRepeatTime;
				AddLayer(config.LayerRepeatNum);
			}
		}
	}

	private void PlayEffectLifeTime()
	{
		if (buffOwner == null)
		{
			ClearEffect();
		}
		else if (isPersistentEffect)
		{
			buffEffect = buffOwner.GetSystem<EffectSystem>().PlayBuffEffect(BuffFrom, buffOwner, -1, persistentEffectId, persistentEffectPoint, config.IgnoreGlobalTimeScale);
			if (buffEffect != null)
			{
				buffOwner.GetComponent<EffectControlComponent>()?.AddEffect(buffEffect);
			}
		}
	}

	private void PlayEffectExecute()
	{
		if (isTriggerEffect)
		{
			BuffOwner?.GetSystem<EffectSystem>()?.PlayBuffEffect(BuffFrom, BuffOwner, 1, triggerEffectId, triggerEffectPoint, config?.IgnoreGlobalTimeScale ?? true);
		}
	}

	public void AddLayer(int layer, bool isUpdate = true)
	{
		int num = buffLayer;
		buffLayer = Mathf.Clamp(buffLayer + layer, 0, config.MaxLayer);
		int num2 = buffLayer - num;
		if (num2 != 0)
		{
			OnLayerChangedEvent(num2, isUpdate);
		}
	}

	public void SetLayer(int layer, bool isUpdate = true)
	{
		int num = buffLayer;
		buffLayer = Mathf.Clamp(layer, 0, config.MaxLayer);
		int num2 = buffLayer - num;
		if (num2 != 0)
		{
			OnLayerChangedEvent(num2, isUpdate);
		}
	}

	private void OnLayerChangedEvent(int deltaLayer, bool isUpdate)
	{
		if (buffOwner == null || config == null)
		{
			return;
		}
		if (buffLayer <= 0)
		{
			BuffOwner.GetSystem<BuffSystem>()?.FinishEntityBuff(this);
		}
		else if (isUpdate)
		{
			if (config.LayerOverlying)
			{
				OnUpdateLayerChanged(deltaLayer);
			}
			ObserverBuffLayerChangedParams observerBuffLayerChangedParams = ReferencePool.Acquire<ObserverBuffLayerChangedParams>();
			observerBuffLayerChangedParams.Init(this, deltaLayer);
			BuffOwner.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.BuffLayerChanged, observerBuffLayerChangedParams);
			ReferencePool.Release(observerBuffLayerChangedParams);
			OnUpdateLayerChangedEffect(deltaLayer);
			UpdateRecordInfo(BuffUpdateRecordEnum.Layer, buffLayer);
		}
	}

	private void OnUpdateLayerChanged(int deltaLayer)
	{
		if (buffOperationList == null)
		{
			return;
		}
		foreach (IBuffOperation buffOperation in buffOperationList)
		{
			buffOperation.UpdateLayerChanged(deltaLayer);
		}
	}

	private void OnUpdateLayerChangedEffect(int deltaLayer)
	{
		if (buffActionBase != null && (buffActionBase.ContainsAction(BuffActionTypeEnum.LayerChangedEffect) || buffActionBase.ContainsAction(BuffActionTypeEnum.LayerModifyEffect)))
		{
			buffActionBase.OnExcute(this);
		}
	}

	public virtual void OnChangedEffect(int effectId)
	{
		ClearEffect();
		PlayEffectExecute();
		buffEffect = BuffOwner.GetSystem<EffectSystem>().PlayBuffEffect(BuffFrom, BuffOwner, -1, effectId, persistentEffectPoint, config.IgnoreGlobalTimeScale);
		buffOwner.GetComponent<EffectControlComponent>()?.AddEffect(buffEffect);
	}

	public int GetLayer()
	{
		return buffLayer;
	}

	public void SetDuration(float duration)
	{
		maxLifeTime = duration;
		isForeverTime = maxLifeTime < 0f;
		UpdateRecordInfo(BuffUpdateRecordEnum.MaxTime, maxLifeTime);
	}

	public void AddDuration(float duration)
	{
		maxLifeTime += duration;
		isForeverTime = maxLifeTime < 0f;
		UpdateRecordInfo(BuffUpdateRecordEnum.MaxTime, maxLifeTime);
	}

	public float GetDuration()
	{
		return maxLifeTime;
	}

	public float GetLifeTime()
	{
		return curLifeTime;
	}

	public void ResetLifeTime()
	{
		curLifeTime = 0f;
	}

	public float GetRemainingTime()
	{
		return maxLifeTime - curLifeTime;
	}

	public void Refresh()
	{
	}

	public void ClearOperations()
	{
		hasOperations = false;
		if (buffOperationList == null)
		{
			return;
		}
		foreach (IBuffOperation buffOperation in buffOperationList)
		{
			buffOperation.Dispose();
		}
	}

	public bool CheckAddCondition()
	{
		return CheckConditions(buffAddConditions, emptyCheck: true, isReset: false);
	}

	private bool CheckFinishCondition()
	{
		return CheckConditions(buffFinishConditions, emptyCheck: false);
	}

	private bool CheckTriggerCondition()
	{
		return CheckConditions(buffTriggerConditions, emptyCheck: true);
	}

	private bool CheckClearOperationCondition()
	{
		return CheckConditions(buffClearOperationsConditions, emptyCheck: false);
	}

	private bool CheckConditions(ConditionList<BuffConditionBase> conditions, bool emptyCheck, bool isReset = true)
	{
		bool result = CheckConditions(this, conditions, emptyCheck);
		if (isReset)
		{
			ResetConditions(conditions);
		}
		return result;
	}

	public static bool CheckConditions(Buff buff, ConditionList<BuffConditionBase> conditions, bool emptyCheck)
	{
		if (conditions.IsNullOrEmpty())
		{
			return emptyCheck;
		}
		if (conditions.IsOrCondition())
		{
			foreach (BuffConditionBase condition in conditions)
			{
				if (condition.OnCheck(buff))
				{
					return true;
				}
			}
			return false;
		}
		foreach (BuffConditionBase condition2 in conditions)
		{
			if (!condition2.OnCheck(buff))
			{
				return false;
			}
		}
		return true;
	}

	private void ResetConditions(List<BuffConditionBase> conditions)
	{
		if (!conditions.IsNullOrEmpty())
		{
			BuffConditionBase[] array = conditions.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Reset();
			}
		}
	}

	public int GetTriggerCount()
	{
		return triggerCount;
	}

	public List<BuffConditionBase> GetAddConditions()
	{
		return buffAddConditions;
	}

	public List<BuffConditionBase> GetTriggerConditions()
	{
		return buffTriggerConditions;
	}

	public string GetMutexTag()
	{
		return config?.BuffGroup ?? string.Empty;
	}

	public int GetMutexPriority()
	{
		return config?.BuffGroupPriority ?? 0;
	}

	public void Finish()
	{
		if (buffOwner == null)
		{
			Log.Error($"Buff结束失败,实体为空 [buffID {buffId}]");
			return;
		}
		Dispose();
		Remove();
		Release();
	}

	public void Dispose()
	{
		if (config.FinishClearOperations && hasOperations)
		{
			ClearOperations();
		}
	}

	private void ClearEffect()
	{
		if (buffEffect != null)
		{
			buffOwner?.GetComponent<EffectControlComponent>()?.RemoveEffect(buffEffect);
			buffEffect.OnBuffDispose(this);
			buffEffect = null;
		}
	}

	public void Remove()
	{
		buffOwner.GetSystem<BuffSystem>().RemoveBuff(this);
	}

	public void Release()
	{
		AddRecordInfo(isSurvival: false);
		if (buffOwner == null)
		{
			Log.Error($"Buff回收失败,实体为空 [buffID {buffId}]");
		}
		else
		{
			ReferencePool.Release(this);
		}
	}

	public void AddRecordInfo(BuffRecordEnum recordEnum, string record)
	{
	}

	public void AddRecordInfo(bool isSurvival)
	{
	}

	public void UpdateRecordInfo(BuffUpdateRecordEnum updateRecordEnum, float value)
	{
	}

	public virtual void Clear()
	{
		if (buffOperationList != null)
		{
			foreach (IBuffOperation buffOperation in buffOperationList)
			{
				ReferencePool.Release(buffOperation);
			}
			buffOperationList.Clear();
			CollectionPool<List<IBuffOperation>, IBuffOperation>.Release(buffOperationList);
			buffOperationList = null;
		}
		if (buffAddConditions != null)
		{
			foreach (BuffConditionBase buffAddCondition in buffAddConditions)
			{
				buffAddCondition.Dispose();
			}
			ConditionListPool<BuffConditionBase>.Release(buffAddConditions);
			buffAddConditions = null;
		}
		if (buffTriggerConditions != null)
		{
			foreach (BuffConditionBase buffTriggerCondition in buffTriggerConditions)
			{
				buffTriggerCondition.Dispose();
			}
			buffTriggerConditions.Clear();
			ConditionListPool<BuffConditionBase>.Release(buffTriggerConditions);
			buffTriggerConditions = null;
		}
		if (buffFinishConditions != null)
		{
			foreach (BuffConditionBase buffFinishCondition in buffFinishConditions)
			{
				buffFinishCondition.Dispose();
			}
			buffFinishConditions.Clear();
			ConditionListPool<BuffConditionBase>.Release(buffFinishConditions);
			buffFinishConditions = null;
		}
		if (buffClearOperationsConditions != null)
		{
			foreach (BuffConditionBase buffClearOperationsCondition in buffClearOperationsConditions)
			{
				buffClearOperationsCondition.Dispose();
			}
			buffClearOperationsConditions.Clear();
			ConditionListPool<BuffConditionBase>.Release(buffClearOperationsConditions);
			buffClearOperationsConditions = null;
		}
		ClearEffect();
		if (buffActionBase != null)
		{
			ReferencePool.Release(buffActionBase);
			buffActionBase = null;
		}
		conditionRuntimeData = null;
		if (buffRuntimeData != null)
		{
			ReferencePool.Release(buffRuntimeData);
			buffRuntimeData = null;
		}
		runtimeConfigData = null;
		buffFrom = null;
		buffOwner = null;
	}

	public bool IgnoreTimeScale()
	{
		return config?.IgnoreGlobalTimeScale ?? false;
	}
}
