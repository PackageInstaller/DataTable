using System.Collections;
using System.Collections.Specialized;
using System.ComponentModel.Design;
using System.Diagnostics;
using System.Reflection;

namespace System.ComponentModel;

internal sealed class ReflectPropertyDescriptor : PropertyDescriptor
{
	private static readonly Type[] argsNone = new Type[0];

	private static readonly object noValue = new object();

	private static TraceSwitch PropDescCreateSwitch = new TraceSwitch("PropDescCreate", "ReflectPropertyDescriptor: Dump errors when creating property info");

	private static TraceSwitch PropDescUsageSwitch = new TraceSwitch("PropDescUsage", "ReflectPropertyDescriptor: Debug propertydescriptor usage");

	private static readonly int BitDefaultValueQueried = BitVector32.CreateMask();

	private static readonly int BitGetQueried = BitVector32.CreateMask(BitDefaultValueQueried);

	private static readonly int BitSetQueried = BitVector32.CreateMask(BitGetQueried);

	private static readonly int BitShouldSerializeQueried = BitVector32.CreateMask(BitSetQueried);

	private static readonly int BitResetQueried = BitVector32.CreateMask(BitShouldSerializeQueried);

	private static readonly int BitChangedQueried = BitVector32.CreateMask(BitResetQueried);

	private static readonly int BitIPropChangedQueried = BitVector32.CreateMask(BitChangedQueried);

	private static readonly int BitReadOnlyChecked = BitVector32.CreateMask(BitIPropChangedQueried);

	private static readonly int BitAmbientValueQueried = BitVector32.CreateMask(BitReadOnlyChecked);

	private static readonly int BitSetOnDemand = BitVector32.CreateMask(BitAmbientValueQueried);

	private BitVector32 state;

	private Type componentClass;

	private Type type;

	private object defaultValue;

	private object ambientValue;

	private PropertyInfo propInfo;

	private MethodInfo getMethod;

	private MethodInfo setMethod;

	private MethodInfo shouldSerializeMethod;

	private MethodInfo resetMethod;

	private EventDescriptor realChangedEvent;

	private Type receiverType;

	private object AmbientValue
	{
		get
		{
			if (!state[BitAmbientValueQueried])
			{
				state[BitAmbientValueQueried] = true;
				Attribute attribute = Attributes[typeof(AmbientValueAttribute)];
				if (attribute != null)
				{
					ambientValue = ((AmbientValueAttribute)attribute).Value;
				}
				else
				{
					ambientValue = noValue;
				}
			}
			return ambientValue;
		}
	}

	public override Type ComponentType => componentClass;

	private object DefaultValue
	{
		get
		{
			if (!state[BitDefaultValueQueried])
			{
				state[BitDefaultValueQueried] = true;
				Attribute attribute = Attributes[typeof(DefaultValueAttribute)];
				if (attribute != null)
				{
					defaultValue = ((DefaultValueAttribute)attribute).Value;
					if (defaultValue != null && PropertyType.IsEnum && PropertyType.GetEnumUnderlyingType() == defaultValue.GetType())
					{
						defaultValue = Enum.ToObject(PropertyType, defaultValue);
					}
				}
				else
				{
					defaultValue = noValue;
				}
			}
			return defaultValue;
		}
	}

	private MethodInfo GetMethodValue
	{
		get
		{
			if (!state[BitGetQueried])
			{
				state[BitGetQueried] = true;
				if (receiverType == null)
				{
					if (propInfo == null)
					{
						BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.GetProperty;
						propInfo = componentClass.GetProperty(Name, bindingAttr, null, PropertyType, new Type[0], new ParameterModifier[0]);
					}
					if (propInfo != null)
					{
						getMethod = propInfo.GetGetMethod(nonPublic: true);
					}
					if (getMethod == null)
					{
						throw new InvalidOperationException(global::SR.GetString("Accessor methods for the {0} property are missing.", componentClass.FullName + "." + Name));
					}
				}
				else
				{
					getMethod = MemberDescriptor.FindMethod(componentClass, "Get" + Name, new Type[1] { receiverType }, type);
					if (getMethod == null)
					{
						throw new ArgumentException(global::SR.GetString("Accessor methods for the {0} property are missing.", Name));
					}
				}
			}
			return getMethod;
		}
	}

	private bool IsExtender => receiverType != null;

	public override bool IsReadOnly
	{
		get
		{
			if (!(SetMethodValue == null))
			{
				return ((ReadOnlyAttribute)Attributes[typeof(ReadOnlyAttribute)]).IsReadOnly;
			}
			return true;
		}
	}

	public override Type PropertyType => type;

	private MethodInfo ResetMethodValue
	{
		get
		{
			if (!state[BitResetQueried])
			{
				state[BitResetQueried] = true;
				resetMethod = MemberDescriptor.FindMethod(args: (!(receiverType == null)) ? new Type[1] { receiverType } : argsNone, componentClass: componentClass, name: "Reset" + Name, returnType: typeof(void), publicOnly: false);
			}
			return resetMethod;
		}
	}

	private MethodInfo SetMethodValue
	{
		get
		{
			if (!state[BitSetQueried] && state[BitSetOnDemand])
			{
				state[BitSetQueried] = true;
				BindingFlags bindingAttr = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;
				string text = propInfo.Name;
				if (setMethod == null)
				{
					Type baseType = ComponentType.BaseType;
					while (baseType != null && baseType != typeof(object) && !(baseType == null))
					{
						PropertyInfo property = baseType.GetProperty(text, bindingAttr, null, PropertyType, new Type[0], null);
						if (property != null)
						{
							setMethod = property.GetSetMethod();
							if (setMethod != null)
							{
								break;
							}
						}
						baseType = baseType.BaseType;
					}
				}
			}
			if (!state[BitSetQueried])
			{
				state[BitSetQueried] = true;
				if (receiverType == null)
				{
					if (propInfo == null)
					{
						BindingFlags bindingAttr2 = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.GetProperty;
						propInfo = componentClass.GetProperty(Name, bindingAttr2, null, PropertyType, new Type[0], new ParameterModifier[0]);
					}
					if (propInfo != null)
					{
						setMethod = propInfo.GetSetMethod(nonPublic: true);
					}
				}
				else
				{
					setMethod = MemberDescriptor.FindMethod(componentClass, "Set" + Name, new Type[2] { receiverType, type }, typeof(void));
				}
			}
			return setMethod;
		}
	}

	private MethodInfo ShouldSerializeMethodValue
	{
		get
		{
			if (!state[BitShouldSerializeQueried])
			{
				state[BitShouldSerializeQueried] = true;
				shouldSerializeMethod = MemberDescriptor.FindMethod(args: (!(receiverType == null)) ? new Type[1] { receiverType } : argsNone, componentClass: componentClass, name: "ShouldSerialize" + Name, returnType: typeof(bool), publicOnly: false);
			}
			return shouldSerializeMethod;
		}
	}

	public ReflectPropertyDescriptor(Type componentClass, string name, Type type, Attribute[] attributes)
		: base(name, attributes)
	{
		try
		{
			if (type == null)
			{
				throw new ArgumentException(global::SR.GetString("Invalid type for the {0} property.", name));
			}
			if (componentClass == null)
			{
				throw new ArgumentException(global::SR.GetString("Null is not a valid value for {0}.", "componentClass"));
			}
			this.type = type;
			this.componentClass = componentClass;
		}
		catch (Exception ex)
		{
			throw ex;
		}
	}

	public ReflectPropertyDescriptor(Type componentClass, string name, Type type, PropertyInfo propInfo, MethodInfo getMethod, MethodInfo setMethod, Attribute[] attrs)
		: this(componentClass, name, type, attrs)
	{
		this.propInfo = propInfo;
		this.getMethod = getMethod;
		this.setMethod = setMethod;
		if (getMethod != null && propInfo != null && setMethod == null)
		{
			state[BitGetQueried | BitSetOnDemand] = true;
		}
		else
		{
			state[BitGetQueried | BitSetQueried] = true;
		}
	}

	public ReflectPropertyDescriptor(Type componentClass, string name, Type type, Type receiverType, MethodInfo getMethod, MethodInfo setMethod, Attribute[] attrs)
		: this(componentClass, name, type, attrs)
	{
		this.receiverType = receiverType;
		this.getMethod = getMethod;
		this.setMethod = setMethod;
		state[BitGetQueried | BitSetQueried] = true;
	}

	internal bool ExtenderCanResetValue(IExtenderProvider provider, object component)
	{
		if (DefaultValue != noValue)
		{
			return !object.Equals(ExtenderGetValue(provider, component), defaultValue);
		}
		if (ResetMethodValue != null)
		{
			MethodInfo shouldSerializeMethodValue = ShouldSerializeMethodValue;
			if (shouldSerializeMethodValue != null)
			{
				try
				{
					provider = (IExtenderProvider)GetInvocationTarget(componentClass, provider);
					return (bool)shouldSerializeMethodValue.Invoke(provider, new object[1] { component });
				}
				catch
				{
				}
			}
			return true;
		}
		return false;
	}

	internal Type ExtenderGetReceiverType()
	{
		return receiverType;
	}

	internal Type ExtenderGetType(IExtenderProvider provider)
	{
		return PropertyType;
	}

	internal object ExtenderGetValue(IExtenderProvider provider, object component)
	{
		if (provider != null)
		{
			provider = (IExtenderProvider)GetInvocationTarget(componentClass, provider);
			return GetMethodValue.Invoke(provider, new object[1] { component });
		}
		return null;
	}

	internal void ExtenderResetValue(IExtenderProvider provider, object component, PropertyDescriptor notifyDesc)
	{
		if (DefaultValue != noValue)
		{
			ExtenderSetValue(provider, component, DefaultValue, notifyDesc);
		}
		else if (AmbientValue != noValue)
		{
			ExtenderSetValue(provider, component, AmbientValue, notifyDesc);
		}
		else
		{
			if (!(ResetMethodValue != null))
			{
				return;
			}
			ISite site = MemberDescriptor.GetSite(component);
			IComponentChangeService componentChangeService = null;
			object oldValue = null;
			if (site != null)
			{
				componentChangeService = (IComponentChangeService)site.GetService(typeof(IComponentChangeService));
			}
			if (componentChangeService != null)
			{
				oldValue = ExtenderGetValue(provider, component);
				try
				{
					componentChangeService.OnComponentChanging(component, notifyDesc);
				}
				catch (CheckoutException ex)
				{
					if (ex == CheckoutException.Canceled)
					{
						return;
					}
					throw ex;
				}
			}
			provider = (IExtenderProvider)GetInvocationTarget(componentClass, provider);
			if (ResetMethodValue != null)
			{
				ResetMethodValue.Invoke(provider, new object[1] { component });
				if (componentChangeService != null)
				{
					object newValue = ExtenderGetValue(provider, component);
					componentChangeService.OnComponentChanged(component, notifyDesc, oldValue, newValue);
				}
			}
		}
	}

	internal void ExtenderSetValue(IExtenderProvider provider, object component, object value, PropertyDescriptor notifyDesc)
	{
		if (provider == null)
		{
			return;
		}
		ISite site = MemberDescriptor.GetSite(component);
		IComponentChangeService componentChangeService = null;
		object oldValue = null;
		if (site != null)
		{
			componentChangeService = (IComponentChangeService)site.GetService(typeof(IComponentChangeService));
		}
		if (componentChangeService != null)
		{
			oldValue = ExtenderGetValue(provider, component);
			try
			{
				componentChangeService.OnComponentChanging(component, notifyDesc);
			}
			catch (CheckoutException ex)
			{
				if (ex == CheckoutException.Canceled)
				{
					return;
				}
				throw ex;
			}
		}
		provider = (IExtenderProvider)GetInvocationTarget(componentClass, provider);
		if (SetMethodValue != null)
		{
			SetMethodValue.Invoke(provider, new object[2] { component, value });
			componentChangeService?.OnComponentChanged(component, notifyDesc, oldValue, value);
		}
	}

	internal bool ExtenderShouldSerializeValue(IExtenderProvider provider, object component)
	{
		provider = (IExtenderProvider)GetInvocationTarget(componentClass, provider);
		if (IsReadOnly)
		{
			if (ShouldSerializeMethodValue != null)
			{
				try
				{
					return (bool)ShouldSerializeMethodValue.Invoke(provider, new object[1] { component });
				}
				catch
				{
				}
			}
			return Attributes.Contains(DesignerSerializationVisibilityAttribute.Content);
		}
		if (DefaultValue == noValue)
		{
			if (ShouldSerializeMethodValue != null)
			{
				try
				{
					return (bool)ShouldSerializeMethodValue.Invoke(provider, new object[1] { component });
				}
				catch
				{
				}
			}
			return true;
		}
		return !object.Equals(DefaultValue, ExtenderGetValue(provider, component));
	}

	public override bool CanResetValue(object component)
	{
		if (IsExtender || IsReadOnly)
		{
			return false;
		}
		if (DefaultValue != noValue)
		{
			return !object.Equals(GetValue(component), DefaultValue);
		}
		if (ResetMethodValue != null)
		{
			if (ShouldSerializeMethodValue != null)
			{
				component = GetInvocationTarget(componentClass, component);
				try
				{
					return (bool)ShouldSerializeMethodValue.Invoke(component, null);
				}
				catch
				{
				}
			}
			return true;
		}
		if (AmbientValue != noValue)
		{
			return ShouldSerializeValue(component);
		}
		return false;
	}

	protected override void FillAttributes(IList attributes)
	{
		foreach (Attribute attribute in TypeDescriptor.GetAttributes(PropertyType))
		{
			attributes.Add(attribute);
		}
		BindingFlags bindingAttr = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
		Type baseType = componentClass;
		int num = 0;
		while (baseType != null && baseType != typeof(object))
		{
			num++;
			baseType = baseType.BaseType;
		}
		if (num > 0)
		{
			baseType = componentClass;
			Attribute[][] array = new Attribute[num][];
			while (baseType != null && baseType != typeof(object))
			{
				MemberInfo memberInfo = null;
				memberInfo = ((!IsExtender) ? ((MemberInfo)baseType.GetProperty(Name, bindingAttr, null, PropertyType, new Type[0], new ParameterModifier[0])) : ((MemberInfo)baseType.GetMethod("Get" + Name, bindingAttr, null, new Type[1] { receiverType }, null)));
				if (memberInfo != null)
				{
					array[--num] = ReflectTypeDescriptionProvider.ReflectGetAttributes(memberInfo);
				}
				baseType = baseType.BaseType;
			}
			Attribute[][] array2 = array;
			foreach (Attribute[] array3 in array2)
			{
				if (array3 == null)
				{
					continue;
				}
				Attribute[] array4 = array3;
				for (int j = 0; j < array4.Length; j++)
				{
					if (!(array4[j] is AttributeProviderAttribute attributeProviderAttribute))
					{
						continue;
					}
					Type type = Type.GetType(attributeProviderAttribute.TypeName);
					if (!(type != null))
					{
						continue;
					}
					Attribute[] array5 = null;
					if (!string.IsNullOrEmpty(attributeProviderAttribute.PropertyName))
					{
						MemberInfo[] member = type.GetMember(attributeProviderAttribute.PropertyName);
						if (member.Length != 0 && member[0] != null)
						{
							array5 = ReflectTypeDescriptionProvider.ReflectGetAttributes(member[0]);
						}
					}
					else
					{
						array5 = ReflectTypeDescriptionProvider.ReflectGetAttributes(type);
					}
					if (array5 != null)
					{
						Attribute[] array6 = array5;
						foreach (Attribute value2 in array6)
						{
							attributes.Add(value2);
						}
					}
				}
			}
			array2 = array;
			foreach (Attribute[] array7 in array2)
			{
				if (array7 != null)
				{
					Attribute[] array4 = array7;
					foreach (Attribute value3 in array4)
					{
						attributes.Add(value3);
					}
				}
			}
		}
		base.FillAttributes(attributes);
		if (SetMethodValue == null)
		{
			attributes.Add(ReadOnlyAttribute.Yes);
		}
	}

	public override object GetValue(object component)
	{
		if (IsExtender)
		{
			return null;
		}
		if (component != null)
		{
			component = GetInvocationTarget(componentClass, component);
			try
			{
				return SecurityUtils.MethodInfoInvoke(GetMethodValue, component, null);
			}
			catch (Exception innerException)
			{
				string text = null;
				if (component is IComponent { Site: { Name: not null } site })
				{
					text = site.Name;
				}
				if (text == null)
				{
					text = component.GetType().FullName;
				}
				if (innerException is TargetInvocationException)
				{
					innerException = innerException.InnerException;
				}
				string message = innerException.Message;
				if (message == null)
				{
					message = innerException.GetType().Name;
				}
				throw new TargetInvocationException(global::SR.GetString("Property accessor '{0}' on object '{1}' threw the following exception:'{2}'", Name, text, message), innerException);
			}
		}
		return null;
	}

	protected override void OnValueChanged(object component, EventArgs e)
	{
		if (state[BitChangedQueried] && realChangedEvent == null)
		{
			base.OnValueChanged(component, e);
		}
	}

	public override void ResetValue(object component)
	{
		object invocationTarget = GetInvocationTarget(componentClass, component);
		if (DefaultValue != noValue)
		{
			SetValue(component, DefaultValue);
		}
		else if (AmbientValue != noValue)
		{
			SetValue(component, AmbientValue);
		}
		else
		{
			if (!(ResetMethodValue != null))
			{
				return;
			}
			ISite site = MemberDescriptor.GetSite(component);
			IComponentChangeService componentChangeService = null;
			object oldValue = null;
			if (site != null)
			{
				componentChangeService = (IComponentChangeService)site.GetService(typeof(IComponentChangeService));
			}
			if (componentChangeService != null)
			{
				oldValue = SecurityUtils.MethodInfoInvoke(GetMethodValue, invocationTarget, null);
				try
				{
					componentChangeService.OnComponentChanging(component, this);
				}
				catch (CheckoutException ex)
				{
					if (ex == CheckoutException.Canceled)
					{
						return;
					}
					throw ex;
				}
			}
			if (ResetMethodValue != null)
			{
				SecurityUtils.MethodInfoInvoke(ResetMethodValue, invocationTarget, null);
				if (componentChangeService != null)
				{
					object newValue = SecurityUtils.MethodInfoInvoke(GetMethodValue, invocationTarget, null);
					componentChangeService.OnComponentChanged(component, this, oldValue, newValue);
				}
			}
		}
	}

	public override void SetValue(object component, object value)
	{
		if (component == null)
		{
			return;
		}
		ISite site = MemberDescriptor.GetSite(component);
		IComponentChangeService componentChangeService = null;
		object obj = null;
		object invocationTarget = GetInvocationTarget(componentClass, component);
		if (IsReadOnly)
		{
			return;
		}
		if (site != null)
		{
			componentChangeService = (IComponentChangeService)site.GetService(typeof(IComponentChangeService));
		}
		if (componentChangeService != null)
		{
			obj = SecurityUtils.MethodInfoInvoke(GetMethodValue, invocationTarget, null);
			try
			{
				componentChangeService.OnComponentChanging(component, this);
			}
			catch (CheckoutException ex)
			{
				if (ex == CheckoutException.Canceled)
				{
					return;
				}
				throw ex;
			}
		}
		try
		{
			SecurityUtils.MethodInfoInvoke(SetMethodValue, invocationTarget, new object[1] { value });
			OnValueChanged(invocationTarget, EventArgs.Empty);
		}
		catch (Exception ex2)
		{
			value = obj;
			if (ex2 is TargetInvocationException && ex2.InnerException != null)
			{
				throw ex2.InnerException;
			}
			throw ex2;
		}
		finally
		{
			componentChangeService?.OnComponentChanged(component, this, obj, value);
		}
	}

	public override bool ShouldSerializeValue(object component)
	{
		component = GetInvocationTarget(componentClass, component);
		if (IsReadOnly)
		{
			if (ShouldSerializeMethodValue != null)
			{
				try
				{
					return (bool)ShouldSerializeMethodValue.Invoke(component, null);
				}
				catch
				{
				}
			}
			return Attributes.Contains(DesignerSerializationVisibilityAttribute.Content);
		}
		if (DefaultValue == noValue)
		{
			if (ShouldSerializeMethodValue != null)
			{
				try
				{
					return (bool)ShouldSerializeMethodValue.Invoke(component, null);
				}
				catch
				{
				}
			}
			return true;
		}
		return !object.Equals(DefaultValue, GetValue(component));
	}
}
