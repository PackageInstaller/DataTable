using System;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[fsMigrateTo(typeof(CheckCSharpEvent))]
internal class CheckStaticCSharpEvent
{
	[SerializeField]
	public Type targetType;

	[SerializeField]
	public string eventName;
}
[fsMigrateTo(typeof(CheckCSharpEvent<>))]
internal class CheckStaticCSharpEvent<T>
{
	[SerializeField]
	public Type targetType;

	[SerializeField]
	public string eventName;
}
