using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
internal class MonoMethodMessage : IMethodCallMessage, IMethodMessage, IMessage, IMethodReturnMessage, IInternalMessage
{
	private RuntimeMethodInfo method;

	private object[] args;

	private string[] names;

	private byte[] arg_types;

	public LogicalCallContext ctx;

	public object rval;

	public Exception exc;

	private AsyncResult asyncResult;

	private CallType call_type;

	private string uri;

	private MCMDictionary properties;

	private Identity identity;

	private Type[] methodSignature;

	public IDictionary Properties
	{
		get
		{
			if (properties == null)
			{
				properties = new MCMDictionary(this);
			}
			return properties;
		}
	}

	public int ArgCount
	{
		get
		{
			if (CallType == CallType.EndInvoke)
			{
				return -1;
			}
			if (args == null)
			{
				return 0;
			}
			return args.Length;
		}
	}

	public object[] Args => args;

	public LogicalCallContext LogicalCallContext
	{
		get
		{
			return ctx;
		}
		set
		{
			ctx = value;
		}
	}

	public MethodBase MethodBase => method;

	public string MethodName
	{
		get
		{
			if (null == method)
			{
				return string.Empty;
			}
			return method.Name;
		}
	}

	public object MethodSignature
	{
		get
		{
			if (methodSignature == null)
			{
				ParameterInfo[] parameters = method.GetParameters();
				methodSignature = new Type[parameters.Length];
				for (int i = 0; i < parameters.Length; i++)
				{
					methodSignature[i] = parameters[i].ParameterType;
				}
			}
			return methodSignature;
		}
	}

	public string TypeName
	{
		get
		{
			if (null == method)
			{
				return string.Empty;
			}
			return method.DeclaringType.AssemblyQualifiedName;
		}
	}

	public string Uri
	{
		get
		{
			return uri;
		}
		set
		{
			uri = value;
		}
	}

	public Exception Exception => exc;

	public int OutArgCount
	{
		get
		{
			if (args == null)
			{
				return 0;
			}
			int num = 0;
			byte[] array = arg_types;
			for (int i = 0; i < array.Length; i++)
			{
				if ((array[i] & 2) != 0)
				{
					num++;
				}
			}
			return num;
		}
	}

	public object[] OutArgs
	{
		get
		{
			if (args == null)
			{
				return null;
			}
			object[] array = new object[OutArgCount];
			int num2;
			int num = (num2 = 0);
			byte[] array2 = arg_types;
			for (int i = 0; i < array2.Length; i++)
			{
				if ((array2[i] & 2) != 0)
				{
					array[num2++] = args[num];
				}
				num++;
			}
			return array;
		}
	}

	public object ReturnValue => rval;

	Identity IInternalMessage.TargetIdentity
	{
		get
		{
			return identity;
		}
		set
		{
			identity = value;
		}
	}

	public AsyncResult AsyncResult => asyncResult;

	internal CallType CallType
	{
		get
		{
			if (call_type == CallType.Sync && RemotingServices.IsOneWay(method))
			{
				call_type = CallType.OneWay;
			}
			return call_type;
		}
	}

	internal void InitMessage(RuntimeMethodInfo method, object[] out_args)
	{
		this.method = method;
		ParameterInfo[] parametersInternal = method.GetParametersInternal();
		int num = parametersInternal.Length;
		args = new object[num];
		arg_types = new byte[num];
		asyncResult = null;
		call_type = CallType.Sync;
		names = new string[num];
		for (int i = 0; i < num; i++)
		{
			names[i] = parametersInternal[i].Name;
		}
		bool flag = out_args != null;
		int num2 = 0;
		for (int j = 0; j < num; j++)
		{
			bool isOut = parametersInternal[j].IsOut;
			byte b;
			if (parametersInternal[j].ParameterType.IsByRef)
			{
				if (flag)
				{
					args[j] = out_args[num2++];
				}
				b = 2;
				if (!isOut)
				{
					b |= 1;
				}
			}
			else
			{
				b = 1;
				if (isOut)
				{
					b |= 4;
				}
			}
			arg_types[j] = b;
		}
	}

	public MonoMethodMessage(MethodBase method, object[] out_args)
	{
		if (method != null)
		{
			InitMessage((RuntimeMethodInfo)method, out_args);
		}
		else
		{
			args = null;
		}
	}

	internal MonoMethodMessage(MethodInfo minfo, object[] in_args, object[] out_args)
	{
		InitMessage((RuntimeMethodInfo)minfo, out_args);
		int num = in_args.Length;
		for (int i = 0; i < num; i++)
		{
			args[i] = in_args[i];
		}
	}

	private static MethodInfo GetMethodInfo(Type type, string methodName)
	{
		MethodInfo methodInfo = type.GetMethod(methodName);
		if (methodInfo == null)
		{
			throw new ArgumentException($"Could not find '{methodName}' in {type}", "methodName");
		}
		return methodInfo;
	}

	public MonoMethodMessage(Type type, string methodName, object[] in_args)
		: this(GetMethodInfo(type, methodName), in_args, null)
	{
	}

	public object GetArg(int arg_num)
	{
		if (args == null)
		{
			return null;
		}
		return args[arg_num];
	}

	public bool NeedsOutProcessing(out int outCount)
	{
		bool flag = false;
		outCount = 0;
		byte[] array = arg_types;
		foreach (byte b in array)
		{
			if ((b & 2) != 0)
			{
				outCount++;
			}
			else if ((b & 4) != 0)
			{
				flag = true;
			}
		}
		return (outCount > 0) | flag;
	}
}
