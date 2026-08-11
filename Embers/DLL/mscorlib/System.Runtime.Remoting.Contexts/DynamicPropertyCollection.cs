using System.Collections;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Contexts;

internal class DynamicPropertyCollection
{
	private class DynamicPropertyReg
	{
		public IDynamicProperty Property;

		public IDynamicMessageSink Sink;
	}

	private ArrayList _properties = new ArrayList();

	public bool HasProperties => _properties.Count > 0;

	public bool RegisterDynamicProperty(IDynamicProperty prop)
	{
		lock (this)
		{
			if (FindProperty(prop.Name) != -1)
			{
				throw new InvalidOperationException("Another property by this name already exists");
			}
			ArrayList arrayList = new ArrayList(_properties);
			DynamicPropertyReg dynamicPropertyReg = new DynamicPropertyReg();
			dynamicPropertyReg.Property = prop;
			if (prop is IContributeDynamicSink contributeDynamicSink)
			{
				dynamicPropertyReg.Sink = contributeDynamicSink.GetDynamicSink();
			}
			arrayList.Add(dynamicPropertyReg);
			_properties = arrayList;
			return true;
		}
	}

	public bool UnregisterDynamicProperty(string name)
	{
		lock (this)
		{
			int num = FindProperty(name);
			if (num == -1)
			{
				throw new RemotingException("A property with the name " + name + " was not found");
			}
			_properties.RemoveAt(num);
			return true;
		}
	}

	public void NotifyMessage(bool start, IMessage msg, bool client_site, bool async)
	{
		ArrayList properties = _properties;
		if (start)
		{
			foreach (DynamicPropertyReg item in properties)
			{
				if (item.Sink != null)
				{
					item.Sink.ProcessMessageStart(msg, client_site, async);
				}
			}
			return;
		}
		foreach (DynamicPropertyReg item2 in properties)
		{
			if (item2.Sink != null)
			{
				item2.Sink.ProcessMessageFinish(msg, client_site, async);
			}
		}
	}

	private int FindProperty(string name)
	{
		for (int i = 0; i < _properties.Count; i++)
		{
			if (((DynamicPropertyReg)_properties[i]).Property.Name == name)
			{
				return i;
			}
		}
		return -1;
	}
}
