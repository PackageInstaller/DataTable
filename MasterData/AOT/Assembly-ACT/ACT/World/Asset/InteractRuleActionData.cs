using System;
using System.Collections.Generic;
using ACT.Event;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public abstract class InteractRuleActionData : IServiceAction, IDataToBake
{
	public static Color gizmosColor = Color.red;

	public static float gizmosDuration = 2f;

	public abstract IEnumerable<StateWorldUid> checkedSwid { get; }

	public abstract void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent);

	public virtual void Bake(InteractRuleActionComp interactRuleActionComp)
	{
	}
}
