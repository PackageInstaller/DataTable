using System.Collections.Specialized;

namespace System.Net;

internal sealed class TrackingStringDictionary : StringDictionary
{
	private readonly bool _isReadOnly;

	private bool _isChanged;

	internal bool IsChanged
	{
		get
		{
			return _isChanged;
		}
		set
		{
			_isChanged = value;
		}
	}

	public override string this[string key]
	{
		get
		{
			return base[key];
		}
		set
		{
			if (_isReadOnly)
			{
				throw new InvalidOperationException("The collection is read-only.");
			}
			base[key] = value;
			_isChanged = true;
		}
	}

	internal TrackingStringDictionary()
		: this(isReadOnly: false)
	{
	}

	internal TrackingStringDictionary(bool isReadOnly)
	{
		_isReadOnly = isReadOnly;
	}

	public override void Add(string key, string value)
	{
		if (_isReadOnly)
		{
			throw new InvalidOperationException("The collection is read-only.");
		}
		base.Add(key, value);
		_isChanged = true;
	}

	public override void Remove(string key)
	{
		if (_isReadOnly)
		{
			throw new InvalidOperationException("The collection is read-only.");
		}
		base.Remove(key);
		_isChanged = true;
	}
}
