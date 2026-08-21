using System;

public abstract class SimVariable
{
	private string _name;

	private string _id;

	private bool _protected;

	public string name
	{
		get
		{
			return _name;
		}
		set
		{
			if (_name != value)
			{
				_name = value;
				if (onNameChanged != null)
				{
					onNameChanged(value);
				}
			}
		}
	}

	public string ID
	{
		get
		{
			if (string.IsNullOrEmpty(_id))
			{
				_id = Guid.NewGuid().ToString();
			}
			return _id;
		}
	}

	public object value
	{
		get
		{
			return objectValue;
		}
		set
		{
			objectValue = value;
		}
	}

	public bool isProtected
	{
		get
		{
			return _protected;
		}
		set
		{
			_protected = value;
		}
	}

	protected abstract object objectValue { get; set; }

	public abstract Type varType { get; }

	public abstract bool hasBinding { get; }

	public abstract string propertyPath { get; set; }

	public event Action<string> onNameChanged;

	public event Action<string, object> onValueChanged;

	protected bool HasValueChangeEvent()
	{
		return onValueChanged != null;
	}

	protected void OnValueChanged(string name, object value)
	{
		onValueChanged(name, value);
	}

	public SimVariable()
	{
	}

	public override string ToString()
	{
		return name;
	}

	public abstract SimVariable Cpoy();
}
public class SimVariable<T> : SimVariable
{
	private T _value;

	private string _propertyPath;

	private Func<T> getter;

	private Action<T> setter;

	public override string propertyPath
	{
		get
		{
			return _propertyPath;
		}
		set
		{
			_propertyPath = value;
		}
	}

	public override bool hasBinding => !string.IsNullOrEmpty(_propertyPath);

	protected override object objectValue
	{
		get
		{
			return value;
		}
		set
		{
			this.value = (T)value;
		}
	}

	public override Type varType => typeof(T);

	public new T value
	{
		get
		{
			if (getter == null)
			{
				return _value;
			}
			return getter();
		}
		set
		{
			if (HasValueChangeEvent())
			{
				if (!object.Equals(_value, value))
				{
					_value = value;
					if (setter != null)
					{
						setter(value);
					}
					OnValueChanged(base.name, value);
				}
			}
			else if (setter != null)
			{
				setter(value);
			}
			else
			{
				_value = value;
			}
		}
	}

	public T GetValue()
	{
		return value;
	}

	public void SetValue(T newValue)
	{
		value = newValue;
	}

	public override SimVariable Cpoy()
	{
		SimVariable<T> simVariable = new SimVariable<T>();
		simVariable.SetValue(_value);
		return simVariable;
	}
}
