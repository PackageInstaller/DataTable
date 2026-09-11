using System.Collections.ObjectModel;

namespace System.Net.Mail;

public sealed class AlternateViewCollection : Collection<AlternateView>, IDisposable
{
	internal AlternateViewCollection()
	{
	}

	public void Dispose()
	{
	}

	protected override void ClearItems()
	{
		base.ClearItems();
	}

	protected override void InsertItem(int index, AlternateView item)
	{
		base.InsertItem(index, item);
	}

	protected override void RemoveItem(int index)
	{
		base.RemoveItem(index);
	}

	protected override void SetItem(int index, AlternateView item)
	{
		base.SetItem(index, item);
	}
}
