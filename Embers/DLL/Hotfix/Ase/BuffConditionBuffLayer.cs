using System.Collections.Generic;
using Ase.ECS;
using UnityEngine.Pool;

namespace Ase;

public class BuffConditionBuffLayer : BuffConditionBase
{
	private int buffId;

	private CompareMethodType methodType;

	private int layer;

	private EntityTeamType teamType;

	private List<BaseEntity> damageEntityList = new List<BaseEntity>();

	public override BuffConditionType BuffConditionType => BuffConditionType.BuffLayer;

	protected override int paramsMinCount => 5;

	protected override BattleObserverEventEnum EventType
	{
		get
		{
			return base.EventType;
		}
		set
		{
			base.EventType = value;
		}
	}

	protected override void OnInit(List<string> paramList)
	{
		EventType = Utility.Convert.StringToEnum<BattleObserverEventEnum>(paramList[0]);
		buffId = Utility.Convert.StringToInt(paramList[1]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[2]);
		layer = Utility.Convert.StringToInt(paramList[3]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[4]);
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{buffId},{methodType},{layer},{teamType}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		return CompareBuffLayer();
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		if (teamType != EntityTeamType.DamageTarget || observerDamageProgressParams.Attacker == null || observerDamageProgressParams.Attacker.Id != entityTarget.Id)
		{
			return;
		}
		for (int i = 0; i < damageEntityList.Count; i++)
		{
			if (damageEntityList[i].Id == observerDamageProgressParams.Defender.Id)
			{
				return;
			}
		}
		damageEntityList.Add(observerDamageProgressParams.Defender);
	}

	private bool CompareBuffLayer()
	{
		List<Buff> list = BuffExtension.FindTargetBuffByTeamType(entityFrom, entityTarget, teamType, buffId, damageEntityList);
		int v = 0;
		if (list.Count > 0)
		{
			v = list[0].GetLayer();
			CollectionPool<List<Buff>, Buff>.Release(list);
		}
		return ConditionExtensions.CompareValueMethod(methodType, v, layer);
	}

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType != EntityTeamType.Actor)
		{
			_ = teamType;
			_ = 12;
		}
	}

	protected override void OnReset()
	{
		damageEntityList?.Clear();
	}

	protected override void OnDispose()
	{
		damageEntityList?.Clear();
	}
}
