using System.Collections;
using System.IO;
using System.Runtime.Remoting.Channels;

namespace System.Runtime.Remoting.Messaging;

internal class CADMethodCallMessage : CADMessageBase
{
	private string _uri;

	internal string Uri => _uri;

	internal int PropertiesCount => _propertyCount;

	internal static CADMethodCallMessage Create(IMessage callMsg)
	{
		if (!(callMsg is IMethodCallMessage callMsg2))
		{
			return null;
		}
		return new CADMethodCallMessage(callMsg2);
	}

	internal CADMethodCallMessage(IMethodCallMessage callMsg)
		: base(callMsg)
	{
		_uri = callMsg.Uri;
		ArrayList args = null;
		_propertyCount = CADMessageBase.MarshalProperties(callMsg.Properties, ref args);
		_args = MarshalArguments(callMsg.Args, ref args);
		SaveLogicalCallContext(callMsg, ref args);
		if (args != null)
		{
			MemoryStream memoryStream = CADSerializer.SerializeObject(args.ToArray());
			_serializedArgs = memoryStream.GetBuffer();
		}
	}

	internal ArrayList GetArguments()
	{
		ArrayList result = null;
		if (_serializedArgs != null)
		{
			byte[] array = new byte[_serializedArgs.Length];
			Array.Copy(_serializedArgs, array, _serializedArgs.Length);
			result = new ArrayList((object[])CADSerializer.DeserializeObject(new MemoryStream(array)));
			_serializedArgs = null;
		}
		return result;
	}

	internal object[] GetArgs(ArrayList args)
	{
		return UnmarshalArguments(_args, args);
	}
}
