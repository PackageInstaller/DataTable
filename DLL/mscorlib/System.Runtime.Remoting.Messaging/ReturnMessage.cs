using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[ComVisible(true)]
public class ReturnMessage : IMethodReturnMessage, IMethodMessage, IMessage, IInternalMessage
{
	private object[] _outArgs;

	private object[] _args;

	private LogicalCallContext _callCtx;

	private object _returnValue;

	private string _uri;

	private Exception _exception;

	private MethodBase _methodBase;

	private string _methodName;

	private Type[] _methodSignature;

	private string _typeName;

	private MethodReturnDictionary _properties;

	private Identity _targetIdentity;

	private ArgInfo _inArgInfo;

	public int ArgCount => _args.Length;

	public object[] Args => _args;

	public LogicalCallContext LogicalCallContext
	{
		get
		{
			if (_callCtx == null)
			{
				_callCtx = new LogicalCallContext();
			}
			return _callCtx;
		}
	}

	public MethodBase MethodBase => _methodBase;

	public string MethodName
	{
		get
		{
			if (_methodBase != null && _methodName == null)
			{
				_methodName = _methodBase.Name;
			}
			return _methodName;
		}
	}

	public object MethodSignature
	{
		get
		{
			if (_methodBase != null && _methodSignature == null)
			{
				ParameterInfo[] parameters = _methodBase.GetParameters();
				_methodSignature = new Type[parameters.Length];
				for (int i = 0; i < parameters.Length; i++)
				{
					_methodSignature[i] = parameters[i].ParameterType;
				}
			}
			return _methodSignature;
		}
	}

	public virtual IDictionary Properties
	{
		get
		{
			if (_properties == null)
			{
				_properties = new MethodReturnDictionary(this);
			}
			return _properties;
		}
	}

	public string TypeName
	{
		get
		{
			if (_methodBase != null && _typeName == null)
			{
				_typeName = _methodBase.DeclaringType.AssemblyQualifiedName;
			}
			return _typeName;
		}
	}

	public string Uri
	{
		get
		{
			return _uri;
		}
		set
		{
			_uri = value;
		}
	}

	string IInternalMessage.Uri
	{
		get
		{
			return Uri;
		}
		set
		{
			Uri = value;
		}
	}

	public Exception Exception => _exception;

	public object[] OutArgs
	{
		get
		{
			if (_outArgs == null && _args != null)
			{
				if (_inArgInfo == null)
				{
					_inArgInfo = new ArgInfo(MethodBase, ArgInfoType.Out);
				}
				_outArgs = _inArgInfo.GetInOutArgs(_args);
			}
			return _outArgs;
		}
	}

	public virtual object ReturnValue => _returnValue;

	Identity IInternalMessage.TargetIdentity
	{
		get
		{
			return _targetIdentity;
		}
		set
		{
			_targetIdentity = value;
		}
	}

	public ReturnMessage(object ret, object[] outArgs, int outArgsCount, LogicalCallContext callCtx, IMethodCallMessage mcm)
	{
		_returnValue = ret;
		_args = outArgs;
		_callCtx = callCtx;
		if (mcm != null)
		{
			_uri = mcm.Uri;
			_methodBase = mcm.MethodBase;
		}
		if (_args == null)
		{
			_args = new object[outArgsCount];
		}
	}

	public ReturnMessage(Exception e, IMethodCallMessage mcm)
	{
		_exception = e;
		if (mcm != null)
		{
			_methodBase = mcm.MethodBase;
			_callCtx = mcm.LogicalCallContext;
		}
		_args = new object[0];
	}

	public object GetArg(int argNum)
	{
		return _args[argNum];
	}
}
