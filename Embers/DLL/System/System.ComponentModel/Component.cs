using System.Runtime.InteropServices;

namespace System.ComponentModel;

[ComVisible(true)]
[DesignerCategory("Component")]
[ClassInterface(ClassInterfaceType.AutoDispatch)]
public class Component : MarshalByRefObject, IComponent, IDisposable
{
	private static readonly object EventDisposed = new object();

	private ISite site;

	private EventHandlerList events;

	protected virtual bool CanRaiseEvents => true;

	internal bool CanRaiseEventsInternal => CanRaiseEvents;

	[Browsable(false)]
	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	public virtual ISite Site => site;

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
	[Browsable(false)]
	protected bool DesignMode => site?.DesignMode ?? false;

	~Component()
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
		if (!disposing)
		{
			return;
		}
		lock (this)
		{
			if (site != null && site.Container != null)
			{
				site.Container.Remove(this);
			}
			if (events != null)
			{
				((EventHandler)events[EventDisposed])?.Invoke(this, EventArgs.Empty);
			}
		}
	}

	protected virtual object GetService(Type service)
	{
		return site?.GetService(service);
	}

	public override string ToString()
	{
		ISite site = this.site;
		if (site != null)
		{
			return site.Name + " [" + GetType().FullName + "]";
		}
		return GetType().FullName;
	}
}
