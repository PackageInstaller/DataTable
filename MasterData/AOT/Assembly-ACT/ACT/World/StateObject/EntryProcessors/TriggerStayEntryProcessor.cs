using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;

namespace ACT.World.StateObject.EntryProcessors;

public class TriggerStayEntryProcessor : CommonEntryProcessor
{
	protected override void OnEnter(ICommonInteractEntrySetting entry)
	{
		entry.TriggerStatDisposable?.Dispose();
		entry.TriggerStatDisposable = UniTaskAsyncEnumerable.EveryUpdate().Subscribe((AsyncUnit asyncUnit) =>
		{
			TriggerStaySubscribe(entry, asyncUnit);
		});
	}

	private void TriggerStaySubscribe(ICommonInteractEntrySetting entry, AsyncUnit _)
	{
		if (entry.Interactable && entry.EnterState)
		{
			NetInteract(entry);
		}
	}

	protected override void OnDeinit(ICommonInteractEntrySetting entry)
	{
		entry.TriggerStatDisposable?.Dispose();
	}

	protected override void OnLeave(ICommonInteractEntrySetting entry)
	{
		entry.TriggerStatDisposable?.Dispose();
	}
}
