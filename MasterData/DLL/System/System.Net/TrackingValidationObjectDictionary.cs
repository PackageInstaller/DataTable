using System.Collections.Generic;
using System.Collections.Specialized;

namespace System.Net;

internal sealed class TrackingValidationObjectDictionary : StringDictionary
{
	internal delegate object ValidateAndParseValue(object valueToValidate);

	private readonly Dictionary<string, ValidateAndParseValue> _validators;

	private Dictionary<string, object> _internalObjects;

	internal bool IsChanged { get; set; }

	public override string this[string key]
	{
		get
		{
			return base[key];
		}
		set
		{
			PersistValue(key, value, addValue: false);
		}
	}

	internal TrackingValidationObjectDictionary(Dictionary<string, ValidateAndParseValue> validators)
	{
		IsChanged = false;
		_validators = validators;
	}

	private void PersistValue(string key, string value, bool addValue)
	{
		key = key.ToLowerInvariant();
		if (string.IsNullOrEmpty(value))
		{
			return;
		}
		if (_validators != null && _validators.TryGetValue(key, out var value2))
		{
			object obj = value2(value);
			if (_internalObjects == null)
			{
				_internalObjects = new Dictionary<string, object>();
			}
			if (addValue)
			{
				_internalObjects.Add(key, obj);
				base.Add(key, obj.ToString());
			}
			else
			{
				_internalObjects[key] = obj;
				base[key] = obj.ToString();
			}
		}
		else if (addValue)
		{
			base.Add(key, value);
		}
		else
		{
			base[key] = value;
		}
		IsChanged = true;
	}

	public override void Add(string key, string value)
	{
		PersistValue(key, value, addValue: true);
	}

	public override void Remove(string key)
	{
		if (_internalObjects != null)
		{
			_internalObjects.Remove(key);
		}
		base.Remove(key);
		IsChanged = true;
	}
}
