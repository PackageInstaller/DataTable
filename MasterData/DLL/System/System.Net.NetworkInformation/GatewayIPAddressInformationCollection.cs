using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;

namespace System.Net.NetworkInformation;

[DefaultMember("Item")]
public class GatewayIPAddressInformationCollection : ICollection<GatewayIPAddressInformation>, IEnumerable<GatewayIPAddressInformation>, IEnumerable
{
	private Collection<GatewayIPAddressInformation> addresses = new Collection<GatewayIPAddressInformation>();

	public virtual int Count => addresses.Count;

	public virtual bool IsReadOnly => true;

	protected internal GatewayIPAddressInformationCollection()
	{
	}

	public virtual void CopyTo(GatewayIPAddressInformation[] array, int offset)
	{
		addresses.CopyTo(array, offset);
	}

	public virtual void Add(GatewayIPAddressInformation address)
	{
		throw new NotSupportedException(global::SR.GetString("The collection is read-only."));
	}

	internal void InternalAdd(GatewayIPAddressInformation address)
	{
		addresses.Add(address);
	}

	public virtual bool Contains(GatewayIPAddressInformation address)
	{
		return addresses.Contains(address);
	}

	public virtual IEnumerator<GatewayIPAddressInformation> GetEnumerator()
	{
		return addresses.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public virtual bool Remove(GatewayIPAddressInformation address)
	{
		throw new NotSupportedException(global::SR.GetString("The collection is read-only."));
	}

	public virtual void Clear()
	{
		throw new NotSupportedException(global::SR.GetString("The collection is read-only."));
	}
}
