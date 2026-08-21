using System.Collections;
using System.Reflection;

namespace System.ComponentModel;

internal sealed class ReflectEventDescriptor : EventDescriptor
{
	private Type _type;

	private readonly Type _componentClass;

	private MethodInfo _addMethod;

	private MethodInfo _removeMethod;

	private EventInfo _realEvent;

	private bool _filledMethods;

	public ReflectEventDescriptor(Type componentClass, EventInfo eventInfo)
		: base(eventInfo.Name, Array.Empty<Attribute>())
	{
		if (componentClass == null)
		{
			throw new ArgumentException(global::SR.Format("Null is not a valid value for {0}.", "componentClass"));
		}
		_componentClass = componentClass;
		_realEvent = eventInfo;
	}

	protected override void FillAttributes(IList attributes)
	{
		FillMethods();
		if (_realEvent != null)
		{
			FillEventInfoAttribute(_realEvent, attributes);
		}
		else
		{
			FillSingleMethodAttribute(_removeMethod, attributes);
			FillSingleMethodAttribute(_addMethod, attributes);
		}
		base.FillAttributes(attributes);
	}

	private void FillEventInfoAttribute(EventInfo realEventInfo, IList attributes)
	{
		string text = realEventInfo.Name;
		BindingFlags bindingAttr = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;
		Type type = realEventInfo.ReflectedType;
		int num = 0;
		while (type != typeof(object))
		{
			num++;
			type = type.BaseType;
		}
		if (num <= 0)
		{
			return;
		}
		type = realEventInfo.ReflectedType;
		Attribute[][] array = new Attribute[num][];
		while (type != typeof(object))
		{
			MemberInfo memberInfo = type.GetEvent(text, bindingAttr);
			if (memberInfo != null)
			{
				array[--num] = ReflectTypeDescriptionProvider.ReflectGetAttributes(memberInfo);
			}
			type = type.BaseType;
		}
		Attribute[][] array2 = array;
		foreach (Attribute[] array3 in array2)
		{
			if (array3 != null)
			{
				Attribute[] array4 = array3;
				foreach (Attribute value in array4)
				{
					attributes.Add(value);
				}
			}
		}
	}

	private void FillMethods()
	{
		if (_filledMethods)
		{
			return;
		}
		if (_realEvent != null)
		{
			_addMethod = _realEvent.GetAddMethod();
			_removeMethod = _realEvent.GetRemoveMethod();
			EventInfo eventInfo = null;
			if (_addMethod == null || _removeMethod == null)
			{
				Type baseType = _componentClass.BaseType;
				while (baseType != null && baseType != typeof(object))
				{
					BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
					EventInfo eventInfo2 = baseType.GetEvent(_realEvent.Name, bindingAttr);
					if (eventInfo2.GetAddMethod() != null)
					{
						eventInfo = eventInfo2;
						break;
					}
				}
			}
			if (eventInfo != null)
			{
				_addMethod = eventInfo.GetAddMethod();
				_removeMethod = eventInfo.GetRemoveMethod();
				_type = eventInfo.EventHandlerType;
			}
			else
			{
				_type = _realEvent.EventHandlerType;
			}
		}
		else
		{
			_realEvent = _componentClass.GetEvent(Name);
			if (_realEvent != null)
			{
				FillMethods();
				return;
			}
			Type[] args = new Type[1] { _type };
			_addMethod = MemberDescriptor.FindMethod(_componentClass, "AddOn" + Name, args, typeof(void));
			_removeMethod = MemberDescriptor.FindMethod(_componentClass, "RemoveOn" + Name, args, typeof(void));
			if (_addMethod == null || _removeMethod == null)
			{
				throw new ArgumentException(global::SR.Format("Accessor methods for the {0} event are missing.", Name));
			}
		}
		_filledMethods = true;
	}

	private void FillSingleMethodAttribute(MethodInfo realMethodInfo, IList attributes)
	{
		string text = realMethodInfo.Name;
		BindingFlags bindingAttr = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;
		Type type = realMethodInfo.ReflectedType;
		int num = 0;
		while (type != null && type != typeof(object))
		{
			num++;
			type = type.BaseType;
		}
		if (num <= 0)
		{
			return;
		}
		type = realMethodInfo.ReflectedType;
		Attribute[][] array = new Attribute[num][];
		while (type != null && type != typeof(object))
		{
			MemberInfo method = type.GetMethod(text, bindingAttr);
			if (method != null)
			{
				array[--num] = ReflectTypeDescriptionProvider.ReflectGetAttributes(method);
			}
			type = type.BaseType;
		}
		Attribute[][] array2 = array;
		foreach (Attribute[] array3 in array2)
		{
			if (array3 != null)
			{
				Attribute[] array4 = array3;
				foreach (Attribute value in array4)
				{
					attributes.Add(value);
				}
			}
		}
	}
}
