using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[ComVisible(true)]
public class WeakReference : ISerializable
{
	private bool isLongReference;

	private GCHandle gcHandle;

	public virtual bool IsAlive => Target != null;

	public virtual object Target
	{
		get
		{
			if (!gcHandle.IsAllocated)
			{
				return null;
			}
			return gcHandle.Target;
		}
		set
		{
			gcHandle.Target = value;
		}
	}

	public virtual bool TrackResurrection => isLongReference;

	private void AllocateHandle(object target)
	{
		if (isLongReference)
		{
			gcHandle = GCHandle.Alloc(target, GCHandleType.WeakTrackResurrection);
		}
		else
		{
			gcHandle = GCHandle.Alloc(target, GCHandleType.Weak);
		}
	}

	protected WeakReference()
	{
	}

	public WeakReference(object target)
		: this(target, trackResurrection: false)
	{
	}

	public WeakReference(object target, bool trackResurrection)
	{
		isLongReference = trackResurrection;
		AllocateHandle(target);
	}

	protected WeakReference(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		isLongReference = info.GetBoolean("TrackResurrection");
		object value = info.GetValue("TrackedObject", typeof(object));
		AllocateHandle(value);
	}

	~WeakReference()
	{
		gcHandle.Free();
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("TrackResurrection", TrackResurrection);
		try
		{
			info.AddValue("TrackedObject", Target);
		}
		catch (Exception)
		{
			info.AddValue("TrackedObject", null);
		}
	}
}
[Serializable]
public sealed class WeakReference<T> : ISerializable where T : class
{
	private GCHandle handle;

	private bool trackResurrection;

	public WeakReference(T target)
		: this(target, false)
	{
	}

	public WeakReference(T target, bool trackResurrection)
	{
		this.trackResurrection = trackResurrection;
		handle = GCHandle.Alloc(target, trackResurrection ? GCHandleType.WeakTrackResurrection : GCHandleType.Weak);
	}

	private WeakReference(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		trackResurrection = info.GetBoolean("TrackResurrection");
		object value = info.GetValue("TrackedObject", typeof(T));
		handle = GCHandle.Alloc(value, trackResurrection ? GCHandleType.WeakTrackResurrection : GCHandleType.Weak);
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("TrackResurrection", trackResurrection);
		if (handle.IsAllocated)
		{
			info.AddValue("TrackedObject", handle.Target);
		}
		else
		{
			info.AddValue("TrackedObject", null);
		}
	}

	public void SetTarget(T target)
	{
		handle.Target = target;
	}

	public bool TryGetTarget(out T target)
	{
		if (!handle.IsAllocated)
		{
			target = null;
			return false;
		}
		target = (T)handle.Target;
		return target != null;
	}

	~WeakReference()
	{
		handle.Free();
	}
}
