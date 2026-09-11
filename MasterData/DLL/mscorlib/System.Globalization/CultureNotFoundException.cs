using System.Runtime.Serialization;

namespace System.Globalization;

[Serializable]
public class CultureNotFoundException : ArgumentException
{
	private string _invalidCultureName;

	private int? _invalidCultureId;

	public virtual int? InvalidCultureId => _invalidCultureId;

	public virtual string InvalidCultureName => _invalidCultureName;

	private static string DefaultMessage => "Culture is not supported.";

	private string FormatedInvalidCultureId
	{
		get
		{
			if (!InvalidCultureId.HasValue)
			{
				return InvalidCultureName;
			}
			return string.Format(CultureInfo.InvariantCulture, "{0} (0x{0:x4})", InvalidCultureId.Value);
		}
	}

	public override string Message
	{
		get
		{
			string message = base.Message;
			if (_invalidCultureId.HasValue || _invalidCultureName != null)
			{
				string text = SR.Format("{0} is an invalid culture identifier.", FormatedInvalidCultureId);
				if (message == null)
				{
					return text;
				}
				return message + Environment.NewLine + text;
			}
			return message;
		}
	}

	public CultureNotFoundException()
		: base(DefaultMessage)
	{
	}

	public CultureNotFoundException(string paramName, string message)
		: base(message, paramName)
	{
	}

	protected CultureNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_invalidCultureId = (int?)info.GetValue("InvalidCultureId", typeof(int?));
		_invalidCultureName = (string)info.GetValue("InvalidCultureName", typeof(string));
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("InvalidCultureId", _invalidCultureId, typeof(int?));
		info.AddValue("InvalidCultureName", _invalidCultureName, typeof(string));
	}
}
