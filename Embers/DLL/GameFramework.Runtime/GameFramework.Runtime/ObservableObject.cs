#define ENABLE_LOG
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace GameFramework.Runtime;

[Serializable]
public abstract class ObservableObject : INotifyPropertyChanged
{
	private static readonly PropertyChangedEventArgs NULL_EVENT_ARGS = new PropertyChangedEventArgs(null);

	private static readonly Dictionary<string, PropertyChangedEventArgs> PROPERTY_EVENT_ARGS = new Dictionary<string, PropertyChangedEventArgs>();

	private readonly object _lock = new object();

	private PropertyChangedEventHandler propertyChanged;

	public event PropertyChangedEventHandler PropertyChanged
	{
		add
		{
			lock (_lock)
			{
				propertyChanged = (PropertyChangedEventHandler)Delegate.Combine(propertyChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				propertyChanged = (PropertyChangedEventHandler)Delegate.Remove(propertyChanged, value);
			}
		}
	}

	private static PropertyChangedEventArgs GetPropertyChangedEventArgs(string propertyName)
	{
		if (propertyName == null)
		{
			return NULL_EVENT_ARGS;
		}
		if (PROPERTY_EVENT_ARGS.TryGetValue(propertyName, out var value))
		{
			return value;
		}
		value = new PropertyChangedEventArgs(propertyName);
		PROPERTY_EVENT_ARGS[propertyName] = value;
		return value;
	}

	protected virtual void RaisePropertyChanged(string propertyName = null)
	{
		RaisePropertyChanged(GetPropertyChangedEventArgs(propertyName));
	}

	protected virtual void RaisePropertyChanged(PropertyChangedEventArgs eventArgs)
	{
		try
		{
			if (propertyChanged != null)
			{
				propertyChanged(this, eventArgs);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("Set property '{0}', raise PropertyChanged failure.Exception:{1}", eventArgs.PropertyName, arg);
		}
	}

	protected virtual void RaisePropertyChanged(params PropertyChangedEventArgs[] eventArgs)
	{
		foreach (PropertyChangedEventArgs e in eventArgs)
		{
			try
			{
				if (propertyChanged != null)
				{
					propertyChanged(this, e);
				}
			}
			catch (Exception arg)
			{
				Log.Warning("Set property '{0}', raise PropertyChanged failure.Exception:{1}", e.PropertyName, arg);
			}
		}
	}

	protected virtual string ParserPropertyName(LambdaExpression propertyExpression)
	{
		if (propertyExpression == null)
		{
			throw new ArgumentNullException("propertyExpression");
		}
		if (!(propertyExpression.Body is MemberExpression memberExpression))
		{
			throw new ArgumentException("Invalid argument", "propertyExpression");
		}
		PropertyInfo propertyInfo = memberExpression.Member as PropertyInfo;
		if (propertyInfo == null)
		{
			throw new ArgumentException("Argument is not a property", "propertyExpression");
		}
		return propertyInfo.Name;
	}

	protected bool Set<T>(ref T field, T newValue, Expression<Func<T>> propertyExpression)
	{
		if (object.Equals(field, newValue))
		{
			return false;
		}
		field = newValue;
		string propertyName = ParserPropertyName(propertyExpression);
		RaisePropertyChanged(propertyName);
		return true;
	}

	protected bool Set<T>(ref T field, T newValue, [CallerMemberName] string propertyName = null)
	{
		if (object.Equals(field, newValue))
		{
			return false;
		}
		field = newValue;
		RaisePropertyChanged(propertyName);
		return true;
	}

	protected bool Set(ref bool field, bool newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref byte field, byte newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref sbyte field, sbyte newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref char field, char newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref DateTime field, DateTime newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref short field, short newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref ushort field, ushort newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref int field, int newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref uint field, uint newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref long field, long newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref ulong field, ulong newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref float field, float newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref double field, double newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref decimal field, decimal newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref Vector2 field, Vector2 newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref Vector3 field, Vector3 newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref Vector4 field, Vector4 newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref Color field, Color newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref Rect field, Rect newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set(ref Quaternion field, Quaternion newValue, [CallerMemberName] string propertyName = null)
	{
		return SetValue(ref field, newValue, propertyName);
	}

	protected bool Set<T>(ref T field, T newValue, PropertyChangedEventArgs eventArgs)
	{
		if (object.Equals(field, newValue))
		{
			return false;
		}
		field = newValue;
		RaisePropertyChanged(eventArgs);
		return true;
	}

	protected bool Set(ref bool field, bool newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref char field, char newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref DateTime field, DateTime newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref byte field, byte newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref sbyte field, sbyte newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref short field, short newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref ushort field, ushort newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref int field, int newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref uint field, uint newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref long field, long newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref ulong field, ulong newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref float field, float newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref double field, double newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref decimal field, decimal newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref Color field, Color newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref Vector2 field, Vector2 newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref Vector3 field, Vector3 newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref Vector4 field, Vector4 newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref Quaternion field, Quaternion newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool Set(ref Rect field, Rect newValue, PropertyChangedEventArgs eventArgs)
	{
		return SetValue(ref field, newValue, eventArgs);
	}

	protected bool SetValue<T>(ref T field, T newValue, [CallerMemberName] string propertyName = null) where T : IEquatable<T>
	{
		if ((field != null && field.Equals(newValue)) || (field == null && newValue == null))
		{
			return false;
		}
		field = newValue;
		RaisePropertyChanged(propertyName);
		return true;
	}

	protected bool SetValue<T>(ref T field, T newValue, PropertyChangedEventArgs eventArgs) where T : IEquatable<T>
	{
		if ((field != null && field.Equals(newValue)) || (field == null && newValue == null))
		{
			return false;
		}
		field = newValue;
		RaisePropertyChanged(eventArgs);
		return true;
	}
}
