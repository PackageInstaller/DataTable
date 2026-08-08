using System.Collections.ObjectModel;

namespace System.Net.Mail;

public sealed class LinkedResourceCollection : Collection<LinkedResource>, IDisposable
{
	internal LinkedResourceCollection()
	{
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
	}

	protected override void ClearItems()
	{
		base.ClearItems();
	}

	protected override void InsertItem(int index, LinkedResource item)
	{
		base.InsertItem(index, item);
	}

	protected override void RemoveItem(int index)
	{
		base.RemoveItem(index);
	}

	protected override void SetItem(int index, LinkedResource item)
	{
		base.SetItem(index, item);
	}
}
