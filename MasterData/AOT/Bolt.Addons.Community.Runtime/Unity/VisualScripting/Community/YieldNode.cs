using System.Collections;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitTitle("Yield")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.WaitForEnumerator")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.YieldUnit")]
[UnitCategory("Community/Time")]
public sealed class YieldNode : WaitUnit
{
	public enum EnumeratorType
	{
		YieldInstruction,
		Enumerator,
		Coroutine
	}

	[UnitHeaderInspectable]
	public EnumeratorType type;

	[DoNotSerialize]
	public ValueInput enumerator;

	[DoNotSerialize]
	public ValueInput instruction;

	[DoNotSerialize]
	public ValueInput coroutine;

	protected override void Definition()
	{
		base.Definition();
		switch (type)
		{
		case EnumeratorType.YieldInstruction:
			instruction = ValueInput<YieldInstruction>("instruction");
			break;
		case EnumeratorType.Enumerator:
			enumerator = ValueInput<IEnumerator>("enumerator");
			break;
		case EnumeratorType.Coroutine:
			coroutine = ValueInput<Coroutine>("coroutine");
			break;
		}
	}

	protected override IEnumerator Await(Flow flow)
	{
		switch (type)
		{
		case EnumeratorType.YieldInstruction:
			yield return flow.GetValue<YieldInstruction>(instruction);
			break;
		case EnumeratorType.Enumerator:
		{
			IEnumerator _enumerator = flow.GetValue<IEnumerator>(enumerator);
			while (_enumerator.MoveNext())
			{
				yield return _enumerator.Current;
			}
			break;
		}
		case EnumeratorType.Coroutine:
			yield return flow.GetValue<Coroutine>(coroutine);
			break;
		}
		yield return exit;
	}
}
