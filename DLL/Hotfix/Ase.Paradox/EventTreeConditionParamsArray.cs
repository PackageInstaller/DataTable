using System.Collections.Generic;
using GameFramework;

namespace Ase.Paradox;

public class EventTreeConditionParamsArray<T> : EventTreeConditionParams
{
	public new NumberContact numberContact = NumberContact.contains;

	public new ICollection<T> Value;

	public static EventTreeConditionParams Create(ICollection<T> value)
	{
		EventTreeConditionParamsArray<T> eventTreeConditionParamsArray = ReferencePool.Acquire<EventTreeConditionParamsArray<T>>();
		eventTreeConditionParamsArray.Value = value;
		return eventTreeConditionParamsArray;
	}

	public static EventTreeConditionParams Create(ICollection<T> value, NumberContact numberContact)
	{
		EventTreeConditionParamsArray<T> eventTreeConditionParamsArray = ReferencePool.Acquire<EventTreeConditionParamsArray<T>>();
		eventTreeConditionParamsArray.Value = value;
		eventTreeConditionParamsArray.numberContact = numberContact;
		return eventTreeConditionParamsArray;
	}
}
