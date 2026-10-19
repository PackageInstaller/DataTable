using System.Runtime.Serialization;

namespace System.Runtime.CompilerServices;

[Serializable]
public sealed class SwitchExpressionException : InvalidOperationException
{
	public object UnmatchedValue { get; }

	public override string Message
	{
		get
		{
			if (UnmatchedValue == null)
			{
				return base.Message;
			}
			string text = SR.Format("Unmatched value was {0}.", UnmatchedValue.ToString());
			return base.Message + Environment.NewLine + text;
		}
	}

	public SwitchExpressionException()
		: base("Non-exhaustive switch expression failed to match its input.")
	{
	}

	public SwitchExpressionException(Exception innerException)
		: base("Non-exhaustive switch expression failed to match its input.", innerException)
	{
	}

	public SwitchExpressionException(object unmatchedValue)
		: this()
	{
		UnmatchedValue = unmatchedValue;
	}

	private SwitchExpressionException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		UnmatchedValue = info.GetValue("UnmatchedValue", typeof(object));
	}

	public SwitchExpressionException(string message)
		: base(message)
	{
	}

	public SwitchExpressionException(string message, Exception innerException)
		: base(message, innerException)
	{
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("UnmatchedValue", UnmatchedValue, typeof(object));
	}
}
