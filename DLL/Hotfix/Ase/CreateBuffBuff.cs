#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class CreateBuffBuff : BuffOperationBase<BuffDataCreateBuff>, IObserverHandler
{
	private List<BaseEntity> damageEntityList = new List<BaseEntity>();

	protected override void OnInit()
	{
		if (dataBase.teamType == EntityTeamType.DamageTarget)
		{
			base.buffOwner.GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.DamageBefore, this);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		ObserverDamageProgressParams buffMessage = (ObserverDamageProgressParams)param;
		OnMessage(buffMessage);
	}

	private void OnMessage(ObserverDamageProgressParams buffMessage)
	{
		if (base.buff == null)
		{
			Log.Error("Buff 11 事件出错，已特殊处理");
			OnClear();
		}
		else
		{
			if (buffMessage.Defender == null || !buffMessage.Defender.IsSurvival || buffMessage.Attacker == null || buffMessage.Attacker.Id != base.buffOwner.Id)
			{
				return;
			}
			for (int i = 0; i < damageEntityList.Count; i++)
			{
				if (damageEntityList[i].Id == buffMessage.Defender.Id)
				{
					return;
				}
			}
			damageEntityList.Add(buffMessage.Defender);
		}
	}

	protected override void OnExecute()
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(dataBase.createBuffId);
		if (dataRow == null)
		{
			return;
		}
		dataBase.buffConfig = dataRow;
		List<BaseEntity> targetByTeamTypeList = BuffExtension.GetTargetByTeamTypeList(base.buffFrom, base.buffOwner, dataBase.teamType, damageEntityList, isCreateNewList: false);
		if (targetByTeamTypeList.Count == 0)
		{
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
			return;
		}
		BuffSystem system = base.buffOwner.GetSystem<BuffSystem>();
		for (int i = 0; i < targetByTeamTypeList.Count; i++)
		{
			system.CheckAndAcquireCreateBuff(base.buffFrom, targetByTeamTypeList[i], dataBase);
			OnRecordCreateBuff(targetByTeamTypeList[i], dataRow.Id);
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(targetByTeamTypeList);
		damageEntityList.Clear();
	}

	protected void OnRecordCreateBuff(BaseEntity target, int buffId)
	{
	}

	protected override void OnRecordOperation(string record)
	{
	}

	protected override void OnClear()
	{
		base.buffOwner.GetSystem<BattleObserverSystem>().Detach(BattleObserverEventEnum.DamageBefore, this);
	}
}
