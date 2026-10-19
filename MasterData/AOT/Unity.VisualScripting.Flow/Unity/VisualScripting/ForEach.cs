using System;
using System.Collections;

namespace Unity.VisualScripting;

[UnitTitle("For Each Loop")]
[UnitCategory("Control")]
[UnitOrder(10)]
public class ForEach : LoopUnit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput collection { get; private set; }

	[DoNotSerialize]
	[PortLabel("Index")]
	public ValueOutput currentIndex { get; private set; }

	[DoNotSerialize]
	[PortLabel("Key")]
	public ValueOutput currentKey { get; private set; }

	[DoNotSerialize]
	[PortLabel("Item")]
	public ValueOutput currentItem { get; private set; }

	[Serialize]
	[InspectorToggleLeft]
	[UnitHeaderInspectable("Dictionary")]
	[Inspectable]
	public bool dictionary { get; set; }

	protected override void Definition()
	{
		base.Definition();
		if (dictionary)
		{
			collection = ValueInput<IDictionary>("collection");
		}
		else
		{
			collection = ValueInput<IEnumerable>("collection");
		}
		currentIndex = ValueOutput<int>("currentIndex");
		if (dictionary)
		{
			currentKey = ValueOutput<object>("currentKey");
		}
		currentItem = ValueOutput<object>("currentItem");
		Requirement(collection, enter);
		Assignment(enter, currentIndex);
		Assignment(enter, currentItem);
		if (dictionary)
		{
			Assignment(enter, currentKey);
		}
	}

	private int Start(Flow flow, out IEnumerator enumerator, out IDictionaryEnumerator dictionaryEnumerator, out int currentIndex)
	{
		if (dictionary)
		{
			dictionaryEnumerator = flow.GetValue<IDictionary>(collection).GetEnumerator();
			enumerator = dictionaryEnumerator;
		}
		else
		{
			enumerator = flow.GetValue<IEnumerable>(collection).GetEnumerator();
			dictionaryEnumerator = null;
		}
		currentIndex = -1;
		return flow.EnterLoop();
	}

	private bool MoveNext(Flow flow, IEnumerator enumerator, IDictionaryEnumerator dictionaryEnumerator, ref int currentIndex)
	{
		bool flag = enumerator.MoveNext();
		if (flag)
		{
			if (dictionary)
			{
				flow.SetValue(currentKey, dictionaryEnumerator.Key);
				flow.SetValue(currentItem, dictionaryEnumerator.Value);
			}
			else
			{
				flow.SetValue(currentItem, enumerator.Current);
			}
			currentIndex++;
			flow.SetValue(this.currentIndex, currentIndex);
		}
		return flag;
	}

	protected override ControlOutput Loop(Flow flow)
	{
		int loop = Start(flow, out var enumerator, out var dictionaryEnumerator, out var num);
		GraphStack stack = flow.PreserveStack();
		try
		{
			while (flow.LoopIsNotBroken(loop) && MoveNext(flow, enumerator, dictionaryEnumerator, ref num))
			{
				flow.Invoke(body);
				flow.RestoreStack(stack);
			}
		}
		finally
		{
			(enumerator as IDisposable)?.Dispose();
		}
		flow.DisposePreservedStack(stack);
		flow.ExitLoop(loop);
		return exit;
	}

	protected override IEnumerator LoopCoroutine(Flow flow)
	{
		int loop = Start(flow, out var enumerator, out var dictionaryEnumerator, out var currentIndex);
		GraphStack stack = flow.PreserveStack();
		try
		{
			while (flow.LoopIsNotBroken(loop) && MoveNext(flow, enumerator, dictionaryEnumerator, ref currentIndex))
			{
				yield return body;
				flow.RestoreStack(stack);
			}
		}
		finally
		{
			(enumerator as IDisposable)?.Dispose();
		}
		flow.DisposePreservedStack(stack);
		flow.ExitLoop(loop);
		yield return exit;
	}
}
