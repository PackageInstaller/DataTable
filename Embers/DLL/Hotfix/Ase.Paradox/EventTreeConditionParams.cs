using GameFramework;

namespace Ase.Paradox;

public class EventTreeConditionParams : IReference
{
	public NumberContact numberContact = NumberContact.equal;

	public float Value;

	public static EventTreeConditionParams Create(float value)
	{
		EventTreeConditionParams eventTreeConditionParams = ReferencePool.Acquire<EventTreeConditionParams>();
		eventTreeConditionParams.Value = value;
		return eventTreeConditionParams;
	}

	public static EventTreeConditionParams Create(float value, NumberContact contact)
	{
		EventTreeConditionParams eventTreeConditionParams = ReferencePool.Acquire<EventTreeConditionParams>();
		eventTreeConditionParams.Value = value;
		eventTreeConditionParams.numberContact = contact;
		return eventTreeConditionParams;
	}

	public void Clear()
	{
		ReferencePool.Release(this);
	}
}
