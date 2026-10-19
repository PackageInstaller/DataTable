using System.Collections.Generic;
using ACT.Event;
using ACT.World;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class DamageStatisticsManager
{
	private Dictionary<int, int> damageStatistics = new Dictionary<int, int>();

	public int MonsterDamage { get; private set; }

	public DamageStatisticsManager()
	{
		Singleton<GameManager>.instance.worldManager.RegisterOnWorldChangedCallback(OnOnSceneChanged);
	}

	private void OnOnSceneChanged(IConfigWorldPartition partition)
	{
		UnRegister();
		Register();
	}

	private void Register()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, OnDamage);
	}

	private void OnDamage(BaseEventContent obj)
	{
		if (!(obj is DamageEvt { AttackData: not null } damageEvt))
		{
			return;
		}
		if (damageEvt.AttackData.attacker.IsCharacter())
		{
			int tableId = damageEvt.AttackData.attacker.GetTableId();
			if (!damageStatistics.TryAdd(tableId, 0))
			{
				damageStatistics[tableId] += damageEvt.AttackData.actualDamage;
			}
			if (damageEvt.AttackData.attackee.TryGetCompMonster(out CompMonster component))
			{
				component.totalDamage += damageEvt.AttackData.actualDamage;
			}
		}
		else
		{
			MonsterDamage += damageEvt.AttackData.actualDamage;
		}
	}

	private void UnRegister()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnDamage, OnDamage);
		ResetRecording();
	}

	public int GetDamageStatistics(int tableSourceId)
	{
		return damageStatistics.GetValueOrDefault(tableSourceId, 0);
	}

	public void ResetRecording()
	{
		damageStatistics.Clear();
		MonsterDamage = 0;
	}
}
