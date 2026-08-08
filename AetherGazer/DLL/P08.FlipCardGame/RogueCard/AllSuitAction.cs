using UnityEngine;

namespace RogueCard;

public class AllSuitAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		Debug.Log("触发了AllSuitAction");
	}
}
