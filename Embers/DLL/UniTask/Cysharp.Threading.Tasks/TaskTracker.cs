using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks;

public static class TaskTracker
{
	private static List<KeyValuePair<IUniTaskSource, (string formattedType, int trackingId, DateTime addTime, string stackTrace)>> listPool = new List<KeyValuePair<IUniTaskSource, (string, int, DateTime, string)>>();

	private static readonly WeakDictionary<IUniTaskSource, (string formattedType, int trackingId, DateTime addTime, string stackTrace)> tracking = new WeakDictionary<IUniTaskSource, (string, int, DateTime, string)>();

	private static bool dirty;

	[Conditional("UNITY_EDITOR")]
	public static void TrackActiveTask(IUniTaskSource task, int skipFrame)
	{
	}

	[Conditional("UNITY_EDITOR")]
	public static void RemoveTracking(IUniTaskSource task)
	{
	}

	public static bool CheckAndResetDirty()
	{
		bool result = dirty;
		dirty = false;
		return result;
	}

	public static void ForEachActiveTask(Action<int, string, UniTaskStatus, DateTime, string> action)
	{
		lock (listPool)
		{
			int num = tracking.ToList(ref listPool, clear: false);
			try
			{
				for (int i = 0; i < num; i++)
				{
					action(listPool[i].Value.trackingId, listPool[i].Value.formattedType, listPool[i].Key.UnsafeGetStatus(), listPool[i].Value.addTime, listPool[i].Value.stackTrace);
					listPool[i] = default(KeyValuePair<IUniTaskSource, (string, int, DateTime, string)>);
				}
			}
			catch
			{
				listPool.Clear();
				throw;
			}
		}
	}

	private static void TypeBeautify(Type type, StringBuilder sb)
	{
		if (type.IsNested)
		{
			sb.Append(type.DeclaringType.Name.ToString());
			sb.Append(".");
		}
		if (type.IsGenericType)
		{
			int num = type.Name.IndexOf("`");
			if (num != -1)
			{
				sb.Append(type.Name.Substring(0, num));
			}
			else
			{
				sb.Append(type.Name);
			}
			sb.Append("<");
			bool flag = true;
			Type[] genericArguments = type.GetGenericArguments();
			foreach (Type type2 in genericArguments)
			{
				if (!flag)
				{
					sb.Append(", ");
				}
				flag = false;
				TypeBeautify(type2, sb);
			}
			sb.Append(">");
		}
		else
		{
			sb.Append(type.Name);
		}
	}
}
