#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class ChainedObjectSourceProxy : NotifiableSourceProxyBase, IObtainable, IModifiable, INotifiable
{
	public class ProxyEntry : IDisposable
	{
		private ISourceProxy proxy;

		private EventHandler handler;

		private bool disposedValue = false;

		public ISourceProxy Proxy
		{
			get
			{
				return proxy;
			}
			set
			{
				if (proxy == value)
				{
					return;
				}
				if (handler != null)
				{
					if (proxy is INotifiable notifiable)
					{
						notifiable.ValueChanged -= handler;
					}
					if (value is INotifiable notifiable2)
					{
						notifiable2.ValueChanged += handler;
					}
				}
				proxy = value;
			}
		}

		public PathToken Token { get; set; }

		public EventHandler Handler
		{
			get
			{
				return handler;
			}
			set
			{
				if (handler == value)
				{
					return;
				}
				if (proxy is INotifiable notifiable)
				{
					if (handler != null)
					{
						notifiable.ValueChanged -= handler;
					}
					if (value != null)
					{
						notifiable.ValueChanged += value;
					}
				}
				handler = value;
			}
		}

		public ProxyEntry(ISourceProxy proxy, PathToken token)
		{
			Proxy = proxy;
			Token = token;
		}

		protected virtual void Dispose(bool disposing)
		{
			if (!disposedValue)
			{
				Handler = null;
				if (proxy != null)
				{
					proxy.Dispose();
				}
				proxy = null;
				Token = null;
				disposedValue = true;
			}
		}

		~ProxyEntry()
		{
			Dispose(disposing: false);
		}

		public void Dispose()
		{
			Dispose(disposing: true);
			GC.SuppressFinalize(this);
		}
	}

	private INodeProxyFactory factory;

	private ProxyEntry[] proxies;

	private int count;

	private bool disposedValue = false;

	public override Type Type
	{
		get
		{
			ISourceProxy proxy = GetProxy();
			if (proxy == null)
			{
				return typeof(object);
			}
			return proxy.Type;
		}
	}

	public override TypeCode TypeCode => GetProxy()?.TypeCode ?? TypeCode.Object;

	public ChainedObjectSourceProxy(object source, PathToken token, INodeProxyFactory factory)
		: base(source)
	{
		this.factory = factory;
		count = token.Path.Count;
		proxies = new ProxyEntry[count];
		Bind(source, token);
	}

	protected ISourceProxy GetProxy()
	{
		return proxies[count - 1]?.Proxy;
	}

	protected IObtainable GetObtainable()
	{
		ProxyEntry proxyEntry = proxies[count - 1];
		if (proxyEntry == null)
		{
			return null;
		}
		return proxyEntry.Proxy as IObtainable;
	}

	protected IModifiable GetModifiable()
	{
		ProxyEntry proxyEntry = proxies[count - 1];
		if (proxyEntry == null)
		{
			return null;
		}
		return proxyEntry.Proxy as IModifiable;
	}

	public virtual object GetValue()
	{
		return GetObtainable()?.GetValue();
	}

	public virtual TValue GetValue<TValue>()
	{
		IObtainable obtainable = GetObtainable();
		if (obtainable == null)
		{
			return default(TValue);
		}
		return obtainable.GetValue<TValue>();
	}

	public virtual void SetValue(object value)
	{
		GetModifiable()?.SetValue(value);
	}

	public virtual void SetValue<TValue>(TValue value)
	{
		GetModifiable()?.SetValue(value);
	}

	private void Bind(object source, PathToken token)
	{
		int index = token.Index;
		ISourceProxy sourceProxy = factory.Create(source, token);
		if (sourceProxy == null)
		{
			IPathNode current = token.Current;
			if (current is MemberNode)
			{
				MemberNode memberNode = current as MemberNode;
				string text = ((source != null) ? source.GetType().Name : memberNode.Type.Name);
				throw new ProxyException("Not found the member named '{0}' in the class '{1}'.", memberNode.Name, text);
			}
			throw new ProxyException("Failed to create proxy for \"{0}\".Not found available proxy factory.", token.ToString());
		}
		ProxyEntry proxyEntry = new ProxyEntry(sourceProxy, token);
		proxies[index] = proxyEntry;
		if (token.HasNext())
		{
			if (sourceProxy is INotifiable)
			{
				proxyEntry.Handler = delegate(object sender, EventArgs args)
				{
					lock (_lock)
					{
						try
						{
							ProxyEntry proxyEntry2 = proxies[index];
							if (proxyEntry2 != null && sender == proxyEntry2.Proxy)
							{
								Rebind(index);
							}
						}
						catch (Exception arg)
						{
							Log.Error("{0}", arg);
						}
					}
				};
			}
			object value = (sourceProxy as IObtainable).GetValue();
			if (value != null)
			{
				Bind(value, token.NextToken());
			}
			else
			{
				RaiseValueChanged();
			}
			return;
		}
		if (sourceProxy is INotifiable)
		{
			proxyEntry.Handler = delegate
			{
				RaiseValueChanged();
			};
		}
		RaiseValueChanged();
	}

	private void Rebind(int index)
	{
		for (int num = proxies.Length - 1; num > index; num--)
		{
			ProxyEntry proxyEntry = proxies[num];
			if (proxyEntry != null)
			{
				ISourceProxy proxy = proxyEntry.Proxy;
				proxyEntry.Proxy = null;
				proxy?.Dispose();
			}
		}
		ProxyEntry proxyEntry2 = proxies[index];
		if (!(proxyEntry2.Proxy is IObtainable obtainable))
		{
			RaiseValueChanged();
			return;
		}
		object value = obtainable.GetValue();
		if (value == null)
		{
			RaiseValueChanged();
		}
		else
		{
			Bind(value, proxyEntry2.Token.NextToken());
		}
	}

	private void Unbind()
	{
		for (int num = proxies.Length - 1; num >= 0; num--)
		{
			ProxyEntry proxyEntry = proxies[num];
			if (proxyEntry != null)
			{
				proxyEntry.Dispose();
				proxies[num] = null;
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			Unbind();
			disposedValue = true;
			base.Dispose(disposing);
		}
	}
}
