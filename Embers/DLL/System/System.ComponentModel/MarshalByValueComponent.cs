namespace System.ComponentModel;

[TypeConverter(typeof(ComponentConverter))]
[DesignerCategory("Component")]
public class MarshalByValueComponent : IComponent, IDisposable, IServiceProvider
{
	private static readonly object s_eventDisposed = new object();

	private ISite _site;

	private EventHandlerList _events;

	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public virtual ISite Site => _site;

	~MarshalByValueComponent()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			lock (this)
			{
				_site?.Container?.Remove(this);
				((EventHandler)(_events?[s_eventDisposed]))?.Invoke(this, EventArgs.Empty);
			}
		}
	}

	public virtual object GetService(Type service)
	{
		return _site?.GetService(service);
	}

	public override string ToString()
	{
		ISite site = _site;
		if (site != null)
		{
			return site.Name + " [" + GetType().FullName + "]";
		}
		return GetType().FullName;
	}
}
