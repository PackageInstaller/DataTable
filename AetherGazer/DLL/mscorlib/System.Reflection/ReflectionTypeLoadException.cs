using System.Runtime.Serialization;
using System.Text;

namespace System.Reflection;

[Serializable]
public sealed class ReflectionTypeLoadException : SystemException, ISerializable
{
	public Type[] Types { get; }

	public Exception[] LoaderExceptions { get; }

	public override string Message => CreateString(isMessage: true);

	public ReflectionTypeLoadException(Type[] classes, Exception[] exceptions)
		: base(null)
	{
		Types = classes;
		LoaderExceptions = exceptions;
		base.HResult = -2146232830;
	}

	private ReflectionTypeLoadException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		LoaderExceptions = (Exception[])info.GetValue("Exceptions", typeof(Exception[]));
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("Types", null, typeof(Type[]));
		info.AddValue("Exceptions", LoaderExceptions, typeof(Exception[]));
	}

	public override string ToString()
	{
		return CreateString(isMessage: false);
	}

	private string CreateString(bool isMessage)
	{
		string text = (isMessage ? base.Message : base.ToString());
		Exception[] loaderExceptions = LoaderExceptions;
		if (loaderExceptions == null || loaderExceptions.Length == 0)
		{
			return text;
		}
		StringBuilder stringBuilder = new StringBuilder(text);
		Exception[] array = loaderExceptions;
		foreach (Exception ex in array)
		{
			if (ex != null)
			{
				stringBuilder.AppendLine();
				stringBuilder.Append(isMessage ? ex.Message : ex.ToString());
			}
		}
		return stringBuilder.ToString();
	}
}
