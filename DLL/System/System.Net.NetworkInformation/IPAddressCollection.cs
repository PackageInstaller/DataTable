using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;

namespace System.Net.NetworkInformation;

[DefaultMember("Item")]
public class IPAddressCollection : ICollection<IPAddress>, IEnumerable<IPAddress>, IEnumerable
{
	private Collection<IPAddress> addresses = new Collection<IPAddress>();

	public virtual int Count => addresses.Count;

	public virtual bool IsReadOnly => true;

	protected internal IPAddressCollection()
	{
	}

	public virtual void CopyTo(IPAddress[] array, int offset)
	{
		addresses.CopyTo(array, offset);
	}

	public virtual void Add(IPAddress address)
	{
		throw new NotSupportedException(global::SR.GetString("The collection is read-only."));
	}

	internal void InternalAdd(IPAddress address)
	{
		addresses.Add(address);
	}

	public virtual bool Contains(IPAddress address)
	{
		return addresses.Contains(address);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public virtual IEnumerator<IPAddress> GetEnumerator()
	{
		return addresses.GetEnumerator();
	}

	public virtual bool Remove(IPAddress address)
	{
		throw new NotSupportedException(global::SR.GetString("The collection is read-only."));
	}

	public virtual void Clear()
	{
		throw new NotSupportedException(global::SR.GetString("The collection is read-only."));
	}
}
