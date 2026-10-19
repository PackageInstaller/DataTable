using System;

namespace Fundamental;

public struct LogData : IEquatable<LogData>
{
	public object message;

	public object context;

	public string stackTrace;

	public TimeSpan logTime;

	public byte logLevel;

	public int count;

	public int index;

	public string category;

	public bool IsSameContent(LogData other)
	{
		if (object.Equals(message, other.message))
		{
			return object.Equals(context, other.context);
		}
		return false;
	}

	public bool Equals(LogData other)
	{
		if (object.Equals(message, other.message) && object.Equals(context, other.context) && stackTrace == other.stackTrace && logTime.Equals(other.logTime))
		{
			return logLevel == other.logLevel;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is LogData other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(message, context, stackTrace, logTime, logLevel);
	}
}
