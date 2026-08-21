#define ENABLE_WARNING_AND_ABOVE_LOG
#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Threading;
using GameFramework.Runtime.Proxy;
using UnityEngine;
using UnityEngine.Events;

namespace GameFramework.Runtime;

public class Binding : AbstractBinding
{
	private readonly ISourceProxyFactory sourceProxyFactory;

	private readonly ITargetProxyFactory targetProxyFactory;

	private bool disposed = false;

	private BindingMode bindingMode = BindingMode.Default;

	private BindingDescription bindingDescription;

	private ISourceProxy sourceProxy;

	private ITargetProxy targetProxy;

	private EventHandler sourceValueChangedHandler;

	private EventHandler targetValueChangedHandler;

	private IConverter converter;

	private object _lock = new object();

	private bool isUpdatingSource;

	private bool isUpdatingTarget;

	private string targetTypeName;

	private SendOrPostCallback updateTargetAction;

	protected BindingMode BindingMode
	{
		get
		{
			if (bindingMode != BindingMode.Default)
			{
				return bindingMode;
			}
			bindingMode = bindingDescription.Mode;
			if (bindingMode == BindingMode.Default)
			{
				bindingMode = targetProxy.DefaultMode;
			}
			if (bindingMode == BindingMode.Default)
			{
				Log.Warning("Not set the BindingMode!");
			}
			return bindingMode;
		}
	}

	public Binding(IBindingContext bindingContext, object source, object target, BindingDescription bindingDescription, ISourceProxyFactory sourceProxyFactory, ITargetProxyFactory targetProxyFactory)
		: base(bindingContext, source, target)
	{
		targetTypeName = target.GetType().Name;
		this.bindingDescription = bindingDescription;
		converter = bindingDescription.Converter;
		this.sourceProxyFactory = sourceProxyFactory;
		this.targetProxyFactory = targetProxyFactory;
		CreateTargetProxy(target, this.bindingDescription);
		CreateSourceProxy(DataContext, this.bindingDescription.Source);
		UpdateDataOnBind();
	}

	protected virtual string GetViewName()
	{
		if (BindingContext == null)
		{
			return "unknown";
		}
		object owner = BindingContext.Owner;
		if (owner == null)
		{
			return "unknown";
		}
		string name = owner.GetType().Name;
		string text = ((owner is Behaviour) ? ((Behaviour)owner).name : "");
		return string.IsNullOrEmpty(text) ? name : $"{name}[{text}]";
	}

	protected override void OnDataContextChanged()
	{
		if (!bindingDescription.Source.IsStatic)
		{
			CreateSourceProxy(DataContext, bindingDescription.Source);
			UpdateDataOnBind();
		}
	}

	protected void UpdateDataOnBind()
	{
		try
		{
			if (UpdateTargetOnFirstBind(BindingMode) && sourceProxy != null)
			{
				UpdateTargetFromSource();
			}
			if (UpdateSourceOnFirstBind(BindingMode) && targetProxy != null && targetProxy is IObtainable)
			{
				UpdateSourceFromTarget();
			}
		}
		catch (Exception arg)
		{
			Log.Warning("An exception occurs in UpdateTargetOnBind.exception: {0}", arg);
		}
	}

	protected void CreateSourceProxy(object source, SourceDescription description)
	{
		DisposeSourceProxy();
		sourceProxy = sourceProxyFactory.CreateProxy(description.IsStatic ? null : source, description);
		if (IsSubscribeSourceValueChanged(BindingMode) && sourceProxy is INotifiable)
		{
			sourceValueChangedHandler = delegate
			{
				UpdateTargetFromSource();
			};
			(sourceProxy as INotifiable).ValueChanged += sourceValueChangedHandler;
		}
	}

	protected void DisposeSourceProxy()
	{
		try
		{
			if (sourceProxy != null)
			{
				if (sourceValueChangedHandler != null)
				{
					(sourceProxy as INotifiable).ValueChanged -= sourceValueChangedHandler;
					sourceValueChangedHandler = null;
				}
				sourceProxy.Dispose();
				sourceProxy = null;
			}
		}
		catch (Exception)
		{
		}
	}

	protected void CreateTargetProxy(object target, BindingDescription description)
	{
		DisposeTargetProxy();
		targetProxy = targetProxyFactory.CreateProxy(target, description);
		if (IsSubscribeTargetValueChanged(BindingMode) && targetProxy is INotifiable)
		{
			targetValueChangedHandler = delegate
			{
				UpdateSourceFromTarget();
			};
			(targetProxy as INotifiable).ValueChanged += targetValueChangedHandler;
		}
	}

	protected void DisposeTargetProxy()
	{
		try
		{
			if (targetProxy != null)
			{
				if (targetValueChangedHandler != null)
				{
					(targetProxy as INotifiable).ValueChanged -= targetValueChangedHandler;
					targetValueChangedHandler = null;
				}
				targetProxy.Dispose();
				targetProxy = null;
			}
		}
		catch (Exception)
		{
		}
	}

	protected virtual void UpdateTargetFromSource()
	{
		lock (_lock)
		{
			if (updateTargetAction == null)
			{
				updateTargetAction = DoUpdateTargetFromSource;
			}
			UISynchronizationContext.Post(updateTargetAction, null);
		}
	}

	protected void DoUpdateTargetFromSource(object state)
	{
		try
		{
			if (isUpdatingSource)
			{
				return;
			}
			isUpdatingTarget = true;
			if (!(sourceProxy is IObtainable obtainable) || !(targetProxy is IModifiable modifier))
			{
				return;
			}
			switch (sourceProxy.TypeCode)
			{
			case TypeCode.Boolean:
			{
				bool value20 = obtainable.GetValue<bool>();
				SetTargetValue(modifier, value20);
				break;
			}
			case TypeCode.Byte:
			{
				byte value19 = obtainable.GetValue<byte>();
				SetTargetValue(modifier, value19);
				break;
			}
			case TypeCode.Char:
			{
				char value18 = obtainable.GetValue<char>();
				SetTargetValue(modifier, value18);
				break;
			}
			case TypeCode.DateTime:
			{
				DateTime value17 = obtainable.GetValue<DateTime>();
				SetTargetValue(modifier, value17);
				break;
			}
			case TypeCode.Decimal:
			{
				decimal value16 = obtainable.GetValue<decimal>();
				SetTargetValue(modifier, value16);
				break;
			}
			case TypeCode.Double:
			{
				double value15 = obtainable.GetValue<double>();
				SetTargetValue(modifier, value15);
				break;
			}
			case TypeCode.Int16:
			{
				short value14 = obtainable.GetValue<short>();
				SetTargetValue(modifier, value14);
				break;
			}
			case TypeCode.Int32:
			{
				int value13 = obtainable.GetValue<int>();
				SetTargetValue(modifier, value13);
				break;
			}
			case TypeCode.Int64:
			{
				long value12 = obtainable.GetValue<long>();
				SetTargetValue(modifier, value12);
				break;
			}
			case TypeCode.SByte:
			{
				sbyte value11 = obtainable.GetValue<sbyte>();
				SetTargetValue(modifier, value11);
				break;
			}
			case TypeCode.Single:
			{
				float value10 = obtainable.GetValue<float>();
				SetTargetValue(modifier, value10);
				break;
			}
			case TypeCode.String:
			{
				string value9 = obtainable.GetValue<string>();
				SetTargetValue(modifier, value9);
				break;
			}
			case TypeCode.UInt16:
			{
				ushort value23 = obtainable.GetValue<ushort>();
				SetTargetValue(modifier, value23);
				break;
			}
			case TypeCode.UInt32:
			{
				uint value22 = obtainable.GetValue<uint>();
				SetTargetValue(modifier, value22);
				break;
			}
			case TypeCode.UInt64:
			{
				ulong value21 = obtainable.GetValue<ulong>();
				SetTargetValue(modifier, value21);
				break;
			}
			case TypeCode.Object:
			{
				Type type = sourceProxy.Type;
				if (type.Equals(typeof(Vector2)))
				{
					Vector2 value2 = obtainable.GetValue<Vector2>();
					SetTargetValue(modifier, value2);
				}
				else if (type.Equals(typeof(Vector3)))
				{
					Vector3 value3 = obtainable.GetValue<Vector3>();
					SetTargetValue(modifier, value3);
				}
				else if (type.Equals(typeof(Vector4)))
				{
					Vector4 value4 = obtainable.GetValue<Vector4>();
					SetTargetValue(modifier, value4);
				}
				else if (type.Equals(typeof(Color)))
				{
					Color value5 = obtainable.GetValue<Color>();
					SetTargetValue(modifier, value5);
				}
				else if (type.Equals(typeof(Rect)))
				{
					Rect value6 = obtainable.GetValue<Rect>();
					SetTargetValue(modifier, value6);
				}
				else if (type.Equals(typeof(Quaternion)))
				{
					Quaternion value7 = obtainable.GetValue<Quaternion>();
					SetTargetValue(modifier, value7);
				}
				else
				{
					object value8 = obtainable.GetValue();
					SetTargetValue(modifier, value8);
				}
				break;
			}
			default:
			{
				object value = obtainable.GetValue();
				SetTargetValue(modifier, value);
				break;
			}
			}
		}
		catch (Exception arg)
		{
			Log.Error("An exception occurs when the target property is updated.Please check the binding \"{0}{1}\" in the view \"{2}\".exception: {3}", targetTypeName, bindingDescription.ToString(), GetViewName(), arg);
		}
		finally
		{
			isUpdatingTarget = false;
		}
	}

	protected virtual void UpdateSourceFromTarget()
	{
		try
		{
			if (isUpdatingTarget)
			{
				return;
			}
			isUpdatingSource = true;
			if (!(targetProxy is IObtainable obtainable) || !(sourceProxy is IModifiable modifier))
			{
				return;
			}
			switch (targetProxy.TypeCode)
			{
			case TypeCode.Boolean:
			{
				bool value20 = obtainable.GetValue<bool>();
				SetSourceValue(modifier, value20);
				break;
			}
			case TypeCode.Byte:
			{
				byte value19 = obtainable.GetValue<byte>();
				SetSourceValue(modifier, value19);
				break;
			}
			case TypeCode.Char:
			{
				char value18 = obtainable.GetValue<char>();
				SetSourceValue(modifier, value18);
				break;
			}
			case TypeCode.DateTime:
			{
				DateTime value17 = obtainable.GetValue<DateTime>();
				SetSourceValue(modifier, value17);
				break;
			}
			case TypeCode.Decimal:
			{
				decimal value16 = obtainable.GetValue<decimal>();
				SetSourceValue(modifier, value16);
				break;
			}
			case TypeCode.Double:
			{
				double value15 = obtainable.GetValue<double>();
				SetSourceValue(modifier, value15);
				break;
			}
			case TypeCode.Int16:
			{
				short value14 = obtainable.GetValue<short>();
				SetSourceValue(modifier, value14);
				break;
			}
			case TypeCode.Int32:
			{
				int value13 = obtainable.GetValue<int>();
				SetSourceValue(modifier, value13);
				break;
			}
			case TypeCode.Int64:
			{
				long value12 = obtainable.GetValue<long>();
				SetSourceValue(modifier, value12);
				break;
			}
			case TypeCode.SByte:
			{
				sbyte value11 = obtainable.GetValue<sbyte>();
				SetSourceValue(modifier, value11);
				break;
			}
			case TypeCode.Single:
			{
				float value10 = obtainable.GetValue<float>();
				SetSourceValue(modifier, value10);
				break;
			}
			case TypeCode.String:
			{
				string value9 = obtainable.GetValue<string>();
				SetSourceValue(modifier, value9);
				break;
			}
			case TypeCode.UInt16:
			{
				ushort value23 = obtainable.GetValue<ushort>();
				SetSourceValue(modifier, value23);
				break;
			}
			case TypeCode.UInt32:
			{
				uint value22 = obtainable.GetValue<uint>();
				SetSourceValue(modifier, value22);
				break;
			}
			case TypeCode.UInt64:
			{
				ulong value21 = obtainable.GetValue<ulong>();
				SetSourceValue(modifier, value21);
				break;
			}
			case TypeCode.Object:
			{
				Type type = targetProxy.Type;
				if (type.Equals(typeof(Vector2)))
				{
					Vector2 value2 = obtainable.GetValue<Vector2>();
					SetSourceValue(modifier, value2);
				}
				else if (type.Equals(typeof(Vector3)))
				{
					Vector3 value3 = obtainable.GetValue<Vector3>();
					SetSourceValue(modifier, value3);
				}
				else if (type.Equals(typeof(Vector4)))
				{
					Vector4 value4 = obtainable.GetValue<Vector4>();
					SetSourceValue(modifier, value4);
				}
				else if (type.Equals(typeof(Color)))
				{
					Color value5 = obtainable.GetValue<Color>();
					SetSourceValue(modifier, value5);
				}
				else if (type.Equals(typeof(Rect)))
				{
					Rect value6 = obtainable.GetValue<Rect>();
					SetSourceValue(modifier, value6);
				}
				else if (type.Equals(typeof(Quaternion)))
				{
					Quaternion value7 = obtainable.GetValue<Quaternion>();
					SetSourceValue(modifier, value7);
				}
				else
				{
					object value8 = obtainable.GetValue();
					SetSourceValue(modifier, value8);
				}
				break;
			}
			default:
			{
				object value = obtainable.GetValue();
				SetSourceValue(modifier, value);
				break;
			}
			}
		}
		catch (Exception arg)
		{
			Log.Error("An exception occurs when the source property is updated.Please check the binding \"{0}{1}\" in the view \"{2}\".exception: {3}", targetTypeName, bindingDescription.ToString(), GetViewName(), arg);
		}
		finally
		{
			isUpdatingSource = false;
		}
	}

	protected void SetTargetValue<T>(IModifiable modifier, T value)
	{
		if (converter == null && typeof(T).Equals(targetProxy.Type))
		{
			modifier.SetValue(value);
			return;
		}
		object value2 = value;
		if (converter != null)
		{
			value2 = converter.Convert(value);
		}
		if (!typeof(UnityEventBase).IsAssignableFrom(targetProxy.Type))
		{
			value2 = targetProxy.Type.ToSafe(value2);
		}
		modifier.SetValue(value2);
	}

	private void SetSourceValue<T>(IModifiable modifier, T value)
	{
		if (converter == null && typeof(T).Equals(sourceProxy.Type))
		{
			modifier.SetValue(value);
			return;
		}
		object value2 = value;
		if (converter != null)
		{
			value2 = converter.ConvertBack(value2);
		}
		value2 = sourceProxy.Type.ToSafe(value2);
		modifier.SetValue(value2);
	}

	protected bool IsSubscribeSourceValueChanged(BindingMode bindingMode)
	{
		switch (bindingMode)
		{
		case BindingMode.Default:
			return true;
		case BindingMode.TwoWay:
		case BindingMode.OneWay:
			return true;
		case BindingMode.OneTime:
		case BindingMode.OneWayToSource:
			return false;
		default:
			throw new BindingException("Unexpected BindingMode");
		}
	}

	protected bool IsSubscribeTargetValueChanged(BindingMode bindingMode)
	{
		switch (bindingMode)
		{
		case BindingMode.Default:
			return true;
		case BindingMode.OneWay:
		case BindingMode.OneTime:
			return false;
		case BindingMode.TwoWay:
		case BindingMode.OneWayToSource:
			return true;
		default:
			throw new BindingException("Unexpected BindingMode");
		}
	}

	protected bool UpdateTargetOnFirstBind(BindingMode bindingMode)
	{
		switch (bindingMode)
		{
		case BindingMode.Default:
			return true;
		case BindingMode.TwoWay:
		case BindingMode.OneWay:
		case BindingMode.OneTime:
			return true;
		case BindingMode.OneWayToSource:
			return false;
		default:
			throw new BindingException("Unexpected BindingMode");
		}
	}

	protected bool UpdateSourceOnFirstBind(BindingMode bindingMode)
	{
		switch (bindingMode)
		{
		case BindingMode.OneWayToSource:
			return true;
		case BindingMode.Default:
			return false;
		case BindingMode.TwoWay:
		case BindingMode.OneWay:
		case BindingMode.OneTime:
			return false;
		default:
			throw new BindingException("Unexpected BindingMode");
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			DisposeSourceProxy();
			DisposeTargetProxy();
			bindingDescription = null;
			disposed = true;
			base.Dispose(disposing);
		}
	}
}
