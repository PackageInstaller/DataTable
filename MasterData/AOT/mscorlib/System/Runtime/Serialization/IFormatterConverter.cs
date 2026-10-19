namespace System.Runtime.Serialization;

[CLSCompliant(false)]
public interface IFormatterConverter
{
	object Convert(object value, Type type);

	bool ToBoolean(object value);

	int ToInt32(object value);

	long ToInt64(object value);

	float ToSingle(object value);

	string ToString(object value);
}
