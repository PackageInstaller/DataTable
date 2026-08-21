using System.Collections;

namespace System.ComponentModel;

public abstract class TypeDescriptionProvider
{
	private sealed class EmptyCustomTypeDescriptor : CustomTypeDescriptor
	{
	}

	private readonly TypeDescriptionProvider _parent;

	private EmptyCustomTypeDescriptor _emptyDescriptor;

	public virtual object CreateInstance(IServiceProvider provider, Type objectType, Type[] argTypes, object[] args)
	{
		if (_parent != null)
		{
			return _parent.CreateInstance(provider, objectType, argTypes, args);
		}
		if (objectType == null)
		{
			throw new ArgumentNullException("objectType");
		}
		return Activator.CreateInstance(objectType, args);
	}

	public virtual IDictionary GetCache(object instance)
	{
		return _parent?.GetCache(instance);
	}

	public virtual ICustomTypeDescriptor GetExtendedTypeDescriptor(object instance)
	{
		if (_parent != null)
		{
			return _parent.GetExtendedTypeDescriptor(instance);
		}
		return _emptyDescriptor ?? (_emptyDescriptor = new EmptyCustomTypeDescriptor());
	}

	protected internal virtual IExtenderProvider[] GetExtenderProviders(object instance)
	{
		if (_parent != null)
		{
			return _parent.GetExtenderProviders(instance);
		}
		if (instance == null)
		{
			throw new ArgumentNullException("instance");
		}
		return Array.Empty<IExtenderProvider>();
	}

	public Type GetReflectionType(Type objectType)
	{
		return GetReflectionType(objectType, null);
	}

	public virtual Type GetReflectionType(Type objectType, object instance)
	{
		if (_parent != null)
		{
			return _parent.GetReflectionType(objectType, instance);
		}
		return objectType;
	}

	public ICustomTypeDescriptor GetTypeDescriptor(Type objectType)
	{
		return GetTypeDescriptor(objectType, null);
	}

	public ICustomTypeDescriptor GetTypeDescriptor(object instance)
	{
		if (instance == null)
		{
			throw new ArgumentNullException("instance");
		}
		return GetTypeDescriptor(instance.GetType(), instance);
	}

	public virtual ICustomTypeDescriptor GetTypeDescriptor(Type objectType, object instance)
	{
		if (_parent != null)
		{
			return _parent.GetTypeDescriptor(objectType, instance);
		}
		return _emptyDescriptor ?? (_emptyDescriptor = new EmptyCustomTypeDescriptor());
	}
}
