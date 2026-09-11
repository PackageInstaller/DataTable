using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace System.Net.Mail;

public class MailAddressCollection : Collection<MailAddress>
{
	public void Add(string addresses)
	{
		if (addresses == null)
		{
			throw new ArgumentNullException("addresses");
		}
		if (addresses == string.Empty)
		{
			throw new ArgumentException(global::SR.Format("The parameter '{0}' cannot be an empty string.", "addresses"), "addresses");
		}
		ParseValue(addresses);
	}

	protected override void SetItem(int index, MailAddress item)
	{
		if (item == null)
		{
			throw new ArgumentNullException("item");
		}
		base.SetItem(index, item);
	}

	protected override void InsertItem(int index, MailAddress item)
	{
		if (item == null)
		{
			throw new ArgumentNullException("item");
		}
		base.InsertItem(index, item);
	}

	internal void ParseValue(string addresses)
	{
		IList<MailAddress> list = MailAddressParser.ParseMultipleAddresses(addresses);
		for (int i = 0; i < list.Count; i++)
		{
			Add(list[i]);
		}
	}

	public override string ToString()
	{
		bool flag = true;
		StringBuilder stringBuilder = new StringBuilder();
		using (IEnumerator<MailAddress> enumerator = GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				MailAddress current = enumerator.Current;
				if (!flag)
				{
					stringBuilder.Append(", ");
				}
				stringBuilder.Append(current.ToString());
				flag = false;
			}
		}
		return stringBuilder.ToString();
	}
}
