using System.Collections;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class Exception : ISerializable, _Exception
{
	internal enum ExceptionMessageKind
	{
		ThreadAbort = 1,
		ThreadInterrupted,
		OutOfMemory
	}

	[OptionalField]
	private static object s_EDILock = new object();

	private string _className;

	internal string _message;

	private IDictionary _data;

	private Exception _innerException;

	private string _helpURL;

	private object _stackTrace;

	private string _stackTraceString;

	private string _remoteStackTraceString;

	private int _remoteStackIndex;

	private object _dynamicMethods;

	internal int _HResult;

	private string _source;

	[OptionalField(VersionAdded = 4)]
	private SafeSerializationManager _safeSerializationManager;

	internal StackTrace[] captured_traces;

	private IntPtr[] native_trace_ips;

	private int caught_in_unmanaged;

	private const int _COMPlusExceptionCode = -532462766;

	public virtual string Message
	{
		get
		{
			if (_message == null)
			{
				if (_className == null)
				{
					_className = GetClassName();
				}
				return Environment.GetResourceString("Exception of type '{0}' was thrown.", _className);
			}
			return _message;
		}
	}

	public virtual IDictionary Data
	{
		get
		{
			if (_data == null)
			{
				_data = new ListDictionaryInternal();
			}
			return _data;
		}
	}

	public Exception InnerException => _innerException;

	public MethodBase TargetSite
	{
		get
		{
			StackTrace stackTrace = new StackTrace(this, fNeedFileInfo: true);
			if (stackTrace.FrameCount > 0)
			{
				return stackTrace.GetFrame(0).GetMethod();
			}
			return null;
		}
	}

	public virtual string StackTrace => GetStackTrace(needFileInfo: true);

	public virtual string HelpLink
	{
		get
		{
			return _helpURL;
		}
		set
		{
			_helpURL = value;
		}
	}

	public virtual string Source
	{
		get
		{
			if (_source == null)
			{
				StackTrace stackTrace = new StackTrace(this, fNeedFileInfo: true);
				if (stackTrace.FrameCount > 0)
				{
					MethodBase method = stackTrace.GetFrame(0).GetMethod();
					if (method != null)
					{
						_source = method.DeclaringType.Assembly.GetName().Name;
					}
				}
			}
			return _source;
		}
		set
		{
			_source = value;
		}
	}

	internal string RemoteStackTrace => _remoteStackTraceString;

	public int HResult
	{
		get
		{
			return _HResult;
		}
		protected set
		{
			_HResult = value;
		}
	}

	internal bool IsTransient => nIsTransient(_HResult);

	protected event EventHandler<SafeSerializationEventArgs> SerializeObjectState
	{
		add
		{
			_safeSerializationManager.SerializeObjectState += value;
		}
		remove
		{
			_safeSerializationManager.SerializeObjectState -= value;
		}
	}

	private void Init()
	{
		_message = null;
		_stackTrace = null;
		_dynamicMethods = null;
		HResult = -2146233088;
		_safeSerializationManager = new SafeSerializationManager();
	}

	public Exception()
	{
		Init();
	}

	public Exception(string message)
	{
		Init();
		_message = message;
	}

	public Exception(string message, Exception innerException)
	{
		Init();
		_message = message;
		_innerException = innerException;
	}

	protected Exception(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		_className = info.GetString("ClassName");
		_message = info.GetString("Message");
		_data = (IDictionary)info.GetValueNoThrow("Data", typeof(IDictionary));
		_innerException = (Exception)info.GetValue("InnerException", typeof(Exception));
		_helpURL = info.GetString("HelpURL");
		_stackTraceString = info.GetString("StackTraceString");
		_remoteStackTraceString = info.GetString("RemoteStackTraceString");
		_remoteStackIndex = info.GetInt32("RemoteStackIndex");
		HResult = info.GetInt32("HResult");
		_source = info.GetString("Source");
		_safeSerializationManager = info.GetValueNoThrow("SafeSerializationManager", typeof(SafeSerializationManager)) as SafeSerializationManager;
		if (_className == null || HResult == 0)
		{
			throw new SerializationException(Environment.GetResourceString("Insufficient state to return the real object."));
		}
		if (context.State == StreamingContextStates.CrossAppDomain)
		{
			_remoteStackTraceString += _stackTraceString;
			_stackTraceString = null;
		}
	}

	private static bool IsImmutableAgileException(Exception e)
	{
		return false;
	}

	private string GetClassName()
	{
		if (_className == null)
		{
			_className = GetType().ToString();
		}
		return _className;
	}

	public virtual Exception GetBaseException()
	{
		Exception innerException = InnerException;
		Exception result = this;
		while (innerException != null)
		{
			result = innerException;
			innerException = innerException.InnerException;
		}
		return result;
	}

	private string GetStackTrace(bool needFileInfo)
	{
		string text = _stackTraceString;
		string text2 = _remoteStackTraceString;
		if (!needFileInfo)
		{
			text = StripFileInfo(text, isRemoteStackTrace: false);
			text2 = StripFileInfo(text2, isRemoteStackTrace: true);
		}
		if (text != null)
		{
			return text2 + text;
		}
		if (_stackTrace == null)
		{
			return text2;
		}
		string stackTrace = Environment.GetStackTrace(this, needFileInfo);
		return text2 + stackTrace;
	}

	internal void SetErrorCode(int hr)
	{
		HResult = hr;
	}

	public override string ToString()
	{
		return ToString(needFileLineInfo: true, needMessage: true);
	}

	private string ToString(bool needFileLineInfo, bool needMessage)
	{
		string text = (needMessage ? Message : null);
		string text2 = ((text != null && text.Length > 0) ? (GetClassName() + ": " + text) : GetClassName());
		if (_innerException != null)
		{
			text2 = text2 + " ---> " + _innerException.ToString(needFileLineInfo, needMessage) + Environment.NewLine + "   " + Environment.GetResourceString("--- End of inner exception stack trace ---");
		}
		string stackTrace = GetStackTrace(needFileLineInfo);
		if (stackTrace != null)
		{
			text2 = text2 + Environment.NewLine + stackTrace;
		}
		return text2;
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		string text = _stackTraceString;
		if (_stackTrace != null && text == null)
		{
			text = Environment.GetStackTrace(this, needFileInfo: true);
		}
		if (_source == null)
		{
			_source = Source;
		}
		info.AddValue("ClassName", GetClassName(), typeof(string));
		info.AddValue("Message", _message, typeof(string));
		info.AddValue("Data", _data, typeof(IDictionary));
		info.AddValue("InnerException", _innerException, typeof(Exception));
		info.AddValue("HelpURL", _helpURL, typeof(string));
		info.AddValue("StackTraceString", text, typeof(string));
		info.AddValue("RemoteStackTraceString", _remoteStackTraceString, typeof(string));
		info.AddValue("RemoteStackIndex", _remoteStackIndex, typeof(int));
		info.AddValue("ExceptionMethod", null);
		info.AddValue("HResult", HResult);
		info.AddValue("Source", _source, typeof(string));
		if (_safeSerializationManager != null && _safeSerializationManager.IsActive)
		{
			info.AddValue("SafeSerializationManager", _safeSerializationManager, typeof(SafeSerializationManager));
			_safeSerializationManager.CompleteSerialization(this, info, context);
		}
	}

	internal Exception PrepForRemoting()
	{
		string text = null;
		text = ((_remoteStackIndex != 0) ? (StackTrace + Environment.NewLine + Environment.NewLine + "Exception rethrown at [" + _remoteStackIndex + "]: " + Environment.NewLine) : (Environment.NewLine + "Server stack trace: " + Environment.NewLine + StackTrace + Environment.NewLine + Environment.NewLine + "Exception rethrown at [" + _remoteStackIndex + "]: " + Environment.NewLine));
		_remoteStackTraceString = text;
		_remoteStackIndex++;
		return this;
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext context)
	{
		_stackTrace = null;
		if (_safeSerializationManager == null)
		{
			_safeSerializationManager = new SafeSerializationManager();
		}
		else
		{
			_safeSerializationManager.CompleteDeserialization(this);
		}
	}

	internal void InternalPreserveStackTrace()
	{
		string stackTrace = StackTrace;
		if (stackTrace != null && stackTrace.Length > 0)
		{
			_remoteStackTraceString = stackTrace + Environment.NewLine;
		}
		_stackTrace = null;
		_stackTraceString = null;
	}

	private string StripFileInfo(string stackTrace, bool isRemoteStackTrace)
	{
		return stackTrace;
	}

	internal void RestoreExceptionDispatchInfo(ExceptionDispatchInfo exceptionDispatchInfo)
	{
		captured_traces = (StackTrace[])exceptionDispatchInfo.BinaryStackTraceArray;
		_stackTrace = null;
		_stackTraceString = null;
	}

	internal virtual string InternalToString()
	{
		bool flag = true;
		return ToString(flag, needMessage: true);
	}

	public new Type GetType()
	{
		return base.GetType();
	}

	private static bool nIsTransient(int hr)
	{
		throw new NotImplementedException();
	}

	internal static string GetMessageFromNativeResources(ExceptionMessageKind kind)
	{
		return kind switch
		{
			ExceptionMessageKind.ThreadAbort => "Thread was being aborted.", 
			ExceptionMessageKind.ThreadInterrupted => "Thread was interrupted from a waiting state.", 
			ExceptionMessageKind.OutOfMemory => "Insufficient memory to continue the execution of the program.", 
			_ => "", 
		};
	}

	internal void SetMessage(string s)
	{
		_message = s;
	}

	internal void SetStackTrace(string s)
	{
		_stackTraceString = s;
	}

	internal Exception FixRemotingException()
	{
		string remoteStackTraceString = string.Format((_remoteStackIndex == 0) ? "{0}{0}Server stack trace: {0}{1}{0}{0}Exception rethrown at [{2}]: {0}" : "{1}{0}{0}Exception rethrown at [{2}]: {0}", Environment.NewLine, StackTrace, _remoteStackIndex);
		_remoteStackTraceString = remoteStackTraceString;
		_remoteStackIndex++;
		_stackTraceString = null;
		return this;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void ReportUnhandledException(Exception exception);
}
