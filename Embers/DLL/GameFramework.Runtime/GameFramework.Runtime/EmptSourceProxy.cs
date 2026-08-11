#define DEBUG
#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Diagnostics;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class EmptSourceProxy : SourceProxyBase, IObtainable, IModifiable
{
	private SourceDescription description;

	public override Type Type => typeof(object);

	public EmptSourceProxy(SourceDescription description)
		: base(null)
	{
		this.description = description;
	}

	public virtual object GetValue()
	{
		DebugWarning();
		return null;
	}

	public virtual TValue GetValue<TValue>()
	{
		DebugWarning();
		return default(TValue);
	}

	public virtual void SetValue(object value)
	{
		DebugWarning();
	}

	public virtual void SetValue<TValue>(TValue value)
	{
		DebugWarning();
	}

	[Conditional("DEBUG")]
	private void DebugWarning()
	{
		Log.Warning("this is an empty source proxy,If you see this, then the DataContext is null.The SourceDescription is \"{0}\"", description.ToString());
	}
}
