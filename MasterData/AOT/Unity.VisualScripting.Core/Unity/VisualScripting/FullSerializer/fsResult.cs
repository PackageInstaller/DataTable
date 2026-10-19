using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting.FullSerializer;

public struct fsResult
{
	private static readonly string[] EmptyStringArray = new string[0];

	private bool _success;

	private List<string> _messages;

	public static fsResult Success = new fsResult
	{
		_success = true
	};

	public bool Failed => !_success;

	public bool Succeeded => _success;

	public bool HasWarnings
	{
		get
		{
			if (_messages != null)
			{
				return _messages.Any();
			}
			return false;
		}
	}

	public Exception AsException
	{
		get
		{
			if (!Failed && !RawMessages.Any())
			{
				throw new Exception("Only a failed result can be converted to an exception");
			}
			return new Exception(FormattedMessages);
		}
	}

	public IEnumerable<string> RawMessages
	{
		get
		{
			if (_messages != null)
			{
				return _messages;
			}
			return EmptyStringArray;
		}
	}

	public string FormattedMessages => string.Join(",\n", RawMessages.ToArray());

	public void AddMessage(string message)
	{
		if (_messages == null)
		{
			_messages = new List<string>();
		}
		_messages.Add(message);
	}

	public void AddMessages(fsResult result)
	{
		if (result._messages != null)
		{
			if (_messages == null)
			{
				_messages = new List<string>();
			}
			_messages.AddRange(result._messages);
		}
	}

	public fsResult Merge(fsResult other)
	{
		_success = _success && other._success;
		if (other._messages != null)
		{
			if (_messages == null)
			{
				_messages = new List<string>(other._messages);
			}
			else
			{
				_messages.AddRange(other._messages);
			}
		}
		return this;
	}

	public static fsResult Warn(string warning)
	{
		return new fsResult
		{
			_success = true,
			_messages = new List<string> { warning }
		};
	}

	public static fsResult Fail(string warning)
	{
		return new fsResult
		{
			_success = false,
			_messages = new List<string> { warning }
		};
	}

	public static fsResult operator +(fsResult a, fsResult b)
	{
		return a.Merge(b);
	}

	public fsResult AssertSuccess()
	{
		if (Failed)
		{
			throw AsException;
		}
		return this;
	}

	public fsResult AssertSuccessWithoutWarnings()
	{
		if (Failed || RawMessages.Any())
		{
			throw AsException;
		}
		return this;
	}
}
