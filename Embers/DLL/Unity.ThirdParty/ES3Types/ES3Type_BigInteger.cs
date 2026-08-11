using System.Numerics;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "bytes" })]
[Preserve]
public class ES3Type_BigInteger : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_BigInteger()
		: base(typeof(BigInteger))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WriteProperty("bytes", ((BigInteger)obj).ToByteArray(), ES3Type_byteArray.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return new BigInteger(reader.ReadProperty<byte[]>(ES3Type_byteArray.Instance));
	}
}
