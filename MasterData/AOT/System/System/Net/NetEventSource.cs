using System.Collections;
using System.Diagnostics.Tracing;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Net;

internal sealed class NetEventSource : EventSource
{
	public class Keywords
	{
		public const EventKeywords Default = (EventKeywords)1L;

		public const EventKeywords Debug = (EventKeywords)2L;

		public const EventKeywords EnterExit = (EventKeywords)4L;
	}

	public static readonly NetEventSource Log = new NetEventSource();

	public new static bool IsEnabled => Log.IsEnabled();

	[NonEvent]
	public static void Enter(object thisOrContextObject, FormattableString formattableString = null, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Enter(IdOf(thisOrContextObject), memberName, (formattableString != null) ? Format(formattableString) : "");
		}
	}

	[NonEvent]
	public static void Enter(object thisOrContextObject, object arg0, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Enter(IdOf(thisOrContextObject), memberName, $"({Format(arg0)})");
		}
	}

	[NonEvent]
	public static void Enter(object thisOrContextObject, object arg0, object arg1, object arg2, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Enter(IdOf(thisOrContextObject), memberName, $"({Format(arg0)}, {Format(arg1)}, {Format(arg2)})");
		}
	}

	[Event(1, Level = EventLevel.Informational, Keywords = (EventKeywords)4L)]
	private void Enter(string thisOrContextObject, string memberName, string parameters)
	{
		WriteEvent(1, thisOrContextObject, memberName ?? "(?)", parameters);
	}

	[NonEvent]
	public static void Exit(object thisOrContextObject, FormattableString formattableString = null, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Exit(IdOf(thisOrContextObject), memberName, (formattableString != null) ? Format(formattableString) : "");
		}
	}

	[NonEvent]
	public static void Exit(object thisOrContextObject, object arg0, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Exit(IdOf(thisOrContextObject), memberName, Format(arg0).ToString());
		}
	}

	[Event(2, Level = EventLevel.Informational, Keywords = (EventKeywords)4L)]
	private void Exit(string thisOrContextObject, string memberName, string result)
	{
		WriteEvent(2, thisOrContextObject, memberName ?? "(?)", result);
	}

	[NonEvent]
	public static void Info(object thisOrContextObject, FormattableString formattableString = null, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Info(IdOf(thisOrContextObject), memberName, (formattableString != null) ? Format(formattableString) : "");
		}
	}

	[NonEvent]
	public static void Info(object thisOrContextObject, object message, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Info(IdOf(thisOrContextObject), memberName, Format(message).ToString());
		}
	}

	[Event(4, Level = EventLevel.Informational, Keywords = (EventKeywords)1L)]
	private void Info(string thisOrContextObject, string memberName, string message)
	{
		WriteEvent(4, thisOrContextObject, memberName ?? "(?)", message);
	}

	[NonEvent]
	public static void Error(object thisOrContextObject, object message, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.ErrorMessage(IdOf(thisOrContextObject), memberName, Format(message).ToString());
		}
	}

	[Event(5, Level = EventLevel.Warning, Keywords = (EventKeywords)1L)]
	private void ErrorMessage(string thisOrContextObject, string memberName, string message)
	{
		WriteEvent(5, thisOrContextObject, memberName ?? "(?)", message);
	}

	[NonEvent]
	public static void Fail(object thisOrContextObject, FormattableString formattableString, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.CriticalFailure(IdOf(thisOrContextObject), memberName, Format(formattableString));
		}
	}

	[NonEvent]
	public static void Fail(object thisOrContextObject, object message, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.CriticalFailure(IdOf(thisOrContextObject), memberName, Format(message).ToString());
		}
	}

	[Event(6, Level = EventLevel.Critical, Keywords = (EventKeywords)2L)]
	private void CriticalFailure(string thisOrContextObject, string memberName, string message)
	{
		WriteEvent(6, thisOrContextObject, memberName ?? "(?)", message);
	}

	[NonEvent]
	public static void Associate(object first, object second, [CallerMemberName] string memberName = null)
	{
		if (IsEnabled)
		{
			Log.Associate(IdOf(first), memberName, IdOf(first), IdOf(second));
		}
	}

	[Event(3, Level = EventLevel.Informational, Keywords = (EventKeywords)1L, Message = "[{2}]<-->[{3}]")]
	private void Associate(string thisOrContextObject, string memberName, string first, string second)
	{
		WriteEvent(3, thisOrContextObject, memberName ?? "(?)", first, second);
	}

	[NonEvent]
	public static string IdOf(object value)
	{
		if (value == null)
		{
			return "(null)";
		}
		return value.GetType().Name + "#" + GetHashCode(value);
	}

	[NonEvent]
	public static int GetHashCode(object value)
	{
		return value?.GetHashCode() ?? 0;
	}

	[NonEvent]
	public static object Format(object value)
	{
		if (value == null)
		{
			return "(null)";
		}
		string text = null;
		if (text != null)
		{
			return text;
		}
		if (value is Array array)
		{
			return $"{array.GetType().GetElementType()}[{((Array)value).Length}]";
		}
		if (value is ICollection collection)
		{
			return $"{collection.GetType().Name}({collection.Count})";
		}
		if (value is SafeHandle safeHandle)
		{
			return $"{safeHandle.GetType().Name}:{safeHandle.GetHashCode()}(0x{safeHandle.DangerousGetHandle():X})";
		}
		if (value is IntPtr)
		{
			return $"0x{value:X}";
		}
		string text2 = value.ToString();
		if (text2 == null || text2 == value.GetType().FullName)
		{
			return IdOf(value);
		}
		return value;
	}

	[NonEvent]
	private static string Format(FormattableString s)
	{
		switch (s.ArgumentCount)
		{
		case 0:
			return s.Format;
		case 1:
			return string.Format(s.Format, Format(s.GetArgument(0)));
		case 2:
			return string.Format(s.Format, Format(s.GetArgument(0)), Format(s.GetArgument(1)));
		case 3:
			return string.Format(s.Format, Format(s.GetArgument(0)), Format(s.GetArgument(1)), Format(s.GetArgument(2)));
		default:
		{
			object[] arguments = s.GetArguments();
			object[] array = new object[arguments.Length];
			for (int i = 0; i < arguments.Length; i++)
			{
				array[i] = Format(arguments[i]);
			}
			return string.Format(s.Format, array);
		}
		}
	}

	[NonEvent]
	private unsafe void WriteEvent(int eventId, string arg1, string arg2, string arg3, string arg4)
	{
		if (!IsEnabled())
		{
			return;
		}
		if (arg1 == null)
		{
			arg1 = "";
		}
		if (arg2 == null)
		{
			arg2 = "";
		}
		if (arg3 == null)
		{
			arg3 = "";
		}
		if (arg4 == null)
		{
			arg4 = "";
		}
		fixed (char* ptr = arg1)
		{
			fixed (char* ptr2 = arg2)
			{
				fixed (char* ptr3 = arg3)
				{
					fixed (char* ptr4 = arg4)
					{
						EventData* ptr5 = stackalloc EventData[4];
						*ptr5 = new EventData
						{
							DataPointer = (IntPtr)ptr,
							Size = (arg1.Length + 1) * 2
						};
						ptr5[1] = new EventData
						{
							DataPointer = (IntPtr)ptr2,
							Size = (arg2.Length + 1) * 2
						};
						ptr5[2] = new EventData
						{
							DataPointer = (IntPtr)ptr3,
							Size = (arg3.Length + 1) * 2
						};
						ptr5[3] = new EventData
						{
							DataPointer = (IntPtr)ptr4,
							Size = (arg4.Length + 1) * 2
						};
						WriteEventCore(eventId, 4, ptr5);
					}
				}
			}
		}
	}
}
