namespace System.ComponentModel;

public abstract class CustomTypeDescriptor : ICustomTypeDescriptor
{
	private readonly ICustomTypeDescriptor _parent;

	public virtual AttributeCollection GetAttributes()
	{
		if (_parent != null)
		{
			return _parent.GetAttributes();
		}
		return AttributeCollection.Empty;
	}

	public virtual string GetClassName()
	{
		return _parent?.GetClassName();
	}

	public virtual string GetComponentName()
	{
		return _parent?.GetComponentName();
	}

	public virtual TypeConverter GetConverter()
	{
		if (_parent != null)
		{
			return _parent.GetConverter();
		}
		return new TypeConverter();
	}

	public virtual EventDescriptor GetDefaultEvent()
	{
		return _parent?.GetDefaultEvent();
	}

	public virtual PropertyDescriptor GetDefaultProperty()
	{
		return _parent?.GetDefaultProperty();
	}

	public virtual object GetEditor(Type editorBaseType)
	{
		return _parent?.GetEditor(editorBaseType);
	}

	public virtual EventDescriptorCollection GetEvents()
	{
		if (_parent != null)
		{
			return _parent.GetEvents();
		}
		return EventDescriptorCollection.Empty;
	}

	public virtual EventDescriptorCollection GetEvents(Attribute[] attributes)
	{
		if (_parent != null)
		{
			return _parent.GetEvents(attributes);
		}
		return EventDescriptorCollection.Empty;
	}

	public virtual PropertyDescriptorCollection GetProperties()
	{
		if (_parent != null)
		{
			return _parent.GetProperties();
		}
		return PropertyDescriptorCollection.Empty;
	}

	public virtual PropertyDescriptorCollection GetProperties(Attribute[] attributes)
	{
		if (_parent != null)
		{
			return _parent.GetProperties(attributes);
		}
		return PropertyDescriptorCollection.Empty;
	}

	public virtual object GetPropertyOwner(PropertyDescriptor pd)
	{
		return _parent?.GetPropertyOwner(pd);
	}
}
