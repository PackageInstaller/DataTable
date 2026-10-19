using System.Runtime.Serialization;

namespace System.Threading.Tasks;

[Serializable]
public class TaskSchedulerException : Exception
{
	public TaskSchedulerException()
		: base("An exception was thrown by a TaskScheduler.")
	{
	}

	public TaskSchedulerException(Exception innerException)
		: base("An exception was thrown by a TaskScheduler.", innerException)
	{
	}

	protected TaskSchedulerException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
