using System.Globalization;
using System.Runtime.Serialization;

namespace System.Collections;

[Serializable]
public sealed class Comparer : IComparer, ISerializable
{
	private CompareInfo _compareInfo;

	public static readonly Comparer Default = new Comparer(CultureInfo.CurrentCulture);

	public static readonly Comparer DefaultInvariant = new Comparer(CultureInfo.InvariantCulture);

	public Comparer(CultureInfo culture)
	{
		if (culture == null)
		{
			throw new ArgumentNullException("culture");
		}
		_compareInfo = culture.CompareInfo;
	}

	private Comparer(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		_compareInfo = (CompareInfo)info.GetValue("CompareInfo", typeof(CompareInfo));
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("CompareInfo", _compareInfo);
	}

	public int Compare(object a, object b)
	{
		if (a == b)
		{
			return 0;
		}
		if (a == null)
		{
			return -1;
		}
		if (b == null)
		{
			return 1;
		}
		string text = a as string;
		string text2 = b as string;
		if (text != null && text2 != null)
		{
			return _compareInfo.Compare(text, text2);
		}
		if (a is IComparable comparable)
		{
			return comparable.CompareTo(b);
		}
		if (b is IComparable comparable2)
		{
			return -comparable2.CompareTo(a);
		}
		throw new ArgumentException("At least one object must implement IComparable.");
	}
}
