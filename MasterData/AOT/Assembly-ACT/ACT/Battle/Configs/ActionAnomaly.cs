using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行异常", "Action", new string[] { "anomaly" })]
public class ActionAnomaly : ConfigAction
{
	public AnomalyType anomalyType;

	public DynamicFloat anomalyValue;

	public bool use;

	private void DoAnomaly(ActionMemory memory)
	{
		if (!memory.target.entity.HasCompAbility())
		{
			int num = Mathf.RoundToInt(anomalyValue.GetFloat(memory.ability));
			if (num > 0)
			{
				SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
				EvtAnomaly evt = systemAbility.GetEvt<EvtAnomaly>(memory.owner, memory.ability);
				evt.mainEntity = memory.target.entity;
				evt.anomalyValue = num;
				evt.anomalyType = anomalyType;
				systemAbility.FireEvt(evt);
				systemAbility.ReleaseEvt(evt);
			}
		}
	}

	public override void Do(ActionMemory memory)
	{
		if (use)
		{
			DoAnomaly(memory);
		}
	}
}
