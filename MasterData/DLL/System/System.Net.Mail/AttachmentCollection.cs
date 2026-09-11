using System.Collections.ObjectModel;

namespace System.Net.Mail;

public sealed class AttachmentCollection : Collection<Attachment>, IDisposable
{
	internal AttachmentCollection()
	{
	}

	public void Dispose()
	{
		for (int i = 0; i < base.Count; i++)
		{
			base[i].Dispose();
		}
	}

	protected override void ClearItems()
	{
		base.ClearItems();
	}

	protected override void InsertItem(int index, Attachment item)
	{
		base.InsertItem(index, item);
	}

	protected override void RemoveItem(int index)
	{
		base.RemoveItem(index);
	}

	protected override void SetItem(int index, Attachment item)
	{
		base.SetItem(index, item);
	}
}
