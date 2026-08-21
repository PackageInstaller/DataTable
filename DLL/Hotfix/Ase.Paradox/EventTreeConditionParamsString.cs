using GameFramework;

namespace Ase.Paradox;

public class EventTreeConditionParamsString : EventTreeConditionParams
{
	public new NumberContact numberContact = NumberContact.equal;

	public new string Value;

	public static EventTreeConditionParams Create(string value)
	{
		EventTreeConditionParamsString eventTreeConditionParamsString = ReferencePool.Acquire<EventTreeConditionParamsString>();
		eventTreeConditionParamsString.Value = value;
		return eventTreeConditionParamsString;
	}

	public static EventTreeConditionParams Create(string value, NumberContact numberContact)
	{
		EventTreeConditionParamsString eventTreeConditionParamsString = ReferencePool.Acquire<EventTreeConditionParamsString>();
		eventTreeConditionParamsString.Value = value;
		eventTreeConditionParamsString.numberContact = numberContact;
		return eventTreeConditionParamsString;
	}
}
