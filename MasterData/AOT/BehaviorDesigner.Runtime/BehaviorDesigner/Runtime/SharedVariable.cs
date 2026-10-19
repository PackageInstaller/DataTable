using System;
using System.Reflection;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

public abstract class SharedVariable
{
	[SerializeField]
	private bool mIsShared;

	[SerializeField]
	private bool mIsGlobal;

	[SerializeField]
	private bool mIsDynamic;

	[SerializeField]
	private string mName;

	[SerializeField]
	private string mToolTip;

	[SerializeField]
	private string mPropertyMapping;

	[SerializeField]
	private GameObject mPropertyMappingOwner;

	public bool IsShared
	{
		get
		{
			return mIsShared;
		}
		set
		{
			mIsShared = value;
		}
	}

	public bool IsGlobal
	{
		get
		{
			return mIsGlobal;
		}
		set
		{
			mIsGlobal = value;
		}
	}

	public bool IsDynamic
	{
		get
		{
			return mIsDynamic;
		}
		set
		{
			mIsDynamic = value;
		}
	}

	public string Name
	{
		get
		{
			return mName;
		}
		set
		{
			mName = value;
		}
	}

	public string Tooltip
	{
		get
		{
			return mToolTip;
		}
		set
		{
			mToolTip = value;
		}
	}

	public string PropertyMapping
	{
		get
		{
			return mPropertyMapping;
		}
		set
		{
			mPropertyMapping = value;
		}
	}

	public GameObject PropertyMappingOwner
	{
		get
		{
			return mPropertyMappingOwner;
		}
		set
		{
			mPropertyMappingOwner = value;
		}
	}

	public bool IsNone
	{
		get
		{
			if (mIsShared)
			{
				return string.IsNullOrEmpty(mName);
			}
			return false;
		}
	}

	public virtual void InitializePropertyMapping(BehaviorSource behaviorSource)
	{
	}

	public abstract object GetValue();

	public abstract void SetValue(object value);
}
public abstract class SharedVariable<T> : SharedVariable
{
	private Func<T> mGetter;

	private Action<T> mSetter;

	[SerializeField]
	protected T mValue;

	public T Value
	{
		get
		{
			if (mGetter == null)
			{
				return mValue;
			}
			return mGetter();
		}
		set
		{
			if (mSetter != null)
			{
				mSetter(value);
			}
			else
			{
				mValue = value;
			}
		}
	}

	public override void InitializePropertyMapping(BehaviorSource behaviorSource)
	{
		if (!BehaviorManager.IsPlaying || string.IsNullOrEmpty(PropertyMapping))
		{
			return;
		}
		string[] array = PropertyMapping.Split('/');
		GameObject gameObject = null;
		try
		{
			gameObject = (object.Equals(PropertyMappingOwner, null) ? (behaviorSource.Owner.GetObject() as Behavior).gameObject : PropertyMappingOwner);
		}
		catch (Exception)
		{
			Behavior behavior = behaviorSource.Owner.GetObject() as Behavior;
			if (behavior != null && behavior.AsynchronousLoad)
			{
				Debug.LogError("Error: Unable to retrieve GameObject. Properties cannot be mapped while using asynchronous load.");
				return;
			}
		}
		if (gameObject == null)
		{
			Debug.LogError("Error: Unable to find GameObject on " + behaviorSource.behaviorName + " for property mapping with variable " + Name);
			return;
		}
		Component component = gameObject.GetComponent(TaskUtility.GetTypeWithinAssembly(array[0]));
		if (component == null)
		{
			Debug.LogError("Error: Unable to find component on " + behaviorSource.behaviorName + " for property mapping with variable " + Name);
			return;
		}
		PropertyInfo property = component.GetType().GetProperty(array[1]);
		if (property != null)
		{
			MethodInfo getMethod = property.GetGetMethod();
			if (getMethod != null)
			{
				mGetter = (Func<T>)Delegate.CreateDelegate(typeof(Func<T>), component, getMethod);
			}
			getMethod = property.GetSetMethod();
			if (getMethod != null)
			{
				mSetter = (Action<T>)Delegate.CreateDelegate(typeof(Action<T>), component, getMethod);
			}
		}
	}

	public override object GetValue()
	{
		return Value;
	}

	public override void SetValue(object value)
	{
		if (mSetter != null)
		{
			mSetter((T)value);
		}
		else if (value is IConvertible)
		{
			mValue = (T)Convert.ChangeType(value, typeof(T));
		}
		else
		{
			mValue = (T)value;
		}
	}

	public override string ToString()
	{
		if (Value != null)
		{
			return Value.ToString();
		}
		return "(null)";
	}
}
