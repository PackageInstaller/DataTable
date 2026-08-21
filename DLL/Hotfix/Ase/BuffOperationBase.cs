using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public abstract class BuffOperationBase<T> : IBuffOperation, IReference where T : BuffDataBase
{
	public T dataBase;

	protected Buff buff { get; private set; }

	protected DRBuff config => buff.Config;

	protected BaseEntity buffFrom => buff.BuffFrom;

	protected BaseEntity buffOwner => buff.BuffOwner;

	protected int buffId => buff.BuffId;

	public void Create(BuffOperationType effectType, List<string> paramList)
	{
		BuffDataBase buffData = BuffSystem.GetBuffData(effectType);
		if (buffData != null)
		{
			dataBase = buffData as T;
			if (dataBase != null)
			{
				buffData.Init(paramList);
			}
		}
	}

	public BuffDataBase GetData()
	{
		return dataBase;
	}

	public void ResetParams(params object[] args)
	{
		dataBase?.ResetParams(args);
	}

	public void Init(Buff buff)
	{
		this.buff = buff;
		if (buff != null)
		{
			InitDataBase();
			OnInit();
		}
	}

	protected virtual void InitDataBase()
	{
	}

	protected virtual void OnInit()
	{
	}

	public void Update(float deltaTime)
	{
		OnUpdate(deltaTime);
	}

	public virtual void OnUpdate(float deltaTime)
	{
	}

	public void Execute()
	{
		if (!dataBase.IsVaild)
		{
			OnRecordOperation("触发操作");
			if (buffOwner != null)
			{
				OnExecute();
			}
		}
	}

	protected virtual void OnExecute()
	{
	}

	public void NotExecute()
	{
		OnNotExecute();
	}

	protected virtual void OnNotExecute()
	{
	}

	public void UpdateLayerChanged(int deltaLayer)
	{
		OnUpdateLayerChanged(deltaLayer);
	}

	protected virtual void OnUpdateLayerChanged(int deltaLayer)
	{
	}

	protected virtual void OnRecordOperation(string record)
	{
		AddBuffOperationRecord(record);
	}

	protected void AddBuffOperationRecord(string record)
	{
		buff?.AddRecordInfo(BuffRecordEnum.Operation, FormatOperationType() + "\t" + record);
	}

	protected string FormatOperationType()
	{
		return $"当前 Operation [{(int)dataBase.EffectType}]";
	}

	protected void LogWarning(string msg)
	{
	}

	public void Dispose()
	{
		if (buffOwner != null)
		{
			OnDispose();
		}
	}

	protected virtual void OnDispose()
	{
	}

	public void Clear()
	{
		if (dataBase != null)
		{
			ReferencePool.Release(dataBase);
			dataBase = null;
		}
		OnClear();
		buff = null;
	}

	protected virtual void OnClear()
	{
	}
}
