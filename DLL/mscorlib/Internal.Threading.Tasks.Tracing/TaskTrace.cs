using Internal.Runtime.Augments;

namespace Internal.Threading.Tasks.Tracing;

internal static class TaskTrace
{
	private static TaskTraceCallbacks s_callbacks;

	public static bool Enabled
	{
		get
		{
			TaskTraceCallbacks taskTraceCallbacks = s_callbacks;
			if (taskTraceCallbacks == null)
			{
				return false;
			}
			if (!taskTraceCallbacks.Enabled)
			{
				return false;
			}
			return true;
		}
	}

	public static void TaskWaitBegin_Asynchronous(int OriginatingTaskSchedulerID, int OriginatingTaskID, int TaskID)
	{
		s_callbacks?.TaskWaitBegin_Asynchronous(OriginatingTaskSchedulerID, OriginatingTaskID, TaskID);
	}

	public static void TaskWaitBegin_Synchronous(int OriginatingTaskSchedulerID, int OriginatingTaskID, int TaskID)
	{
		s_callbacks?.TaskWaitBegin_Synchronous(OriginatingTaskSchedulerID, OriginatingTaskID, TaskID);
	}

	public static void TaskWaitEnd(int OriginatingTaskSchedulerID, int OriginatingTaskID, int TaskID)
	{
		s_callbacks?.TaskWaitEnd(OriginatingTaskSchedulerID, OriginatingTaskID, TaskID);
	}

	public static void TaskScheduled(int OriginatingTaskSchedulerID, int OriginatingTaskID, int TaskID, int CreatingTaskID, int TaskCreationOptions)
	{
		s_callbacks?.TaskScheduled(OriginatingTaskSchedulerID, OriginatingTaskID, TaskID, CreatingTaskID, TaskCreationOptions);
	}
}
