using System;
using System.Runtime.ExceptionServices;

namespace Cysharp.Threading.Tasks;

internal class ExceptionHolder
{
	private ExceptionDispatchInfo exception;

	private bool calledGet;

	public ExceptionHolder(ExceptionDispatchInfo exception)
	{
		this.exception = exception;
	}

	public ExceptionDispatchInfo GetException()
	{
		if (!calledGet)
		{
			calledGet = true;
			GC.SuppressFinalize(this);
		}
		return exception;
	}

	~ExceptionHolder()
	{
		if (!calledGet)
		{
			UniTaskScheduler.PublishUnobservedTaskException(exception.SourceException);
		}
	}
}
