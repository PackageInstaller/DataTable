using UnityEngine;

namespace ACT.World.Asset;

public abstract class InteractRuleActionComp : MonoBehaviour
{
}
public abstract class InteractRuleActionComp<T> : InteractRuleActionComp where T : InteractRuleActionData, new()
{
	[SerializeField]
	public T configData = new T();
}
