using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Runtime.ExceptionServices;

namespace System.Threading.Tasks;

internal class TaskExceptionHolder
{
	private static readonly bool s_failFastOnUnobservedException = ShouldFailFastOnUnobservedException();

	private readonly Task m_task;

	private volatile LowLevelListWithIList<ExceptionDispatchInfo> m_faultExceptions;

	private ExceptionDispatchInfo m_cancellationException;

	private volatile bool m_isHandled;

	internal bool ContainsFaultList => m_faultExceptions != null;

	internal TaskExceptionHolder(Task task)
	{
		m_task = task;
	}

	private static bool ShouldFailFastOnUnobservedException()
	{
		return false;
	}

	~TaskExceptionHolder()
	{
		if (m_faultExceptions != null && (!m_isHandled && !Environment.HasShutdownStarted))
		{
			AggregateException ex = new AggregateException("A Task's exception(s) were not observed either by Waiting on the Task or accessing its Exception property. As a result, the unobserved exception was rethrown by the finalizer thread.", m_faultExceptions);
			UnobservedTaskExceptionEventArgs e = new UnobservedTaskExceptionEventArgs(ex);
			TaskScheduler.PublishUnobservedTaskException(m_task, e);
			if (s_failFastOnUnobservedException && !e.m_observed)
			{
				throw ex;
			}
		}
	}

	internal void Add(object exceptionObject, bool representsCancellation)
	{
		if (representsCancellation)
		{
			SetCancellationException(exceptionObject);
		}
		else
		{
			AddFaultException(exceptionObject);
		}
	}

	private void SetCancellationException(object exceptionObject)
	{
		if (exceptionObject is OperationCanceledException source)
		{
			m_cancellationException = ExceptionDispatchInfo.Capture(source);
		}
		else
		{
			ExceptionDispatchInfo cancellationException = exceptionObject as ExceptionDispatchInfo;
			m_cancellationException = cancellationException;
		}
		MarkAsHandled(calledFromFinalizer: false);
	}

	private void AddFaultException(object exceptionObject)
	{
		LowLevelListWithIList<ExceptionDispatchInfo> lowLevelListWithIList = m_faultExceptions;
		if (lowLevelListWithIList == null)
		{
			lowLevelListWithIList = (m_faultExceptions = new LowLevelListWithIList<ExceptionDispatchInfo>(1));
		}
		if (exceptionObject is Exception source)
		{
			lowLevelListWithIList.Add(ExceptionDispatchInfo.Capture(source));
		}
		else if (exceptionObject is ExceptionDispatchInfo item)
		{
			lowLevelListWithIList.Add(item);
		}
		else if (exceptionObject is IEnumerable<Exception> enumerable)
		{
			foreach (Exception item2 in enumerable)
			{
				lowLevelListWithIList.Add(ExceptionDispatchInfo.Capture(item2));
			}
		}
		else
		{
			if (!(exceptionObject is IEnumerable<ExceptionDispatchInfo> collection))
			{
				throw new ArgumentException("(Internal)Expected an Exception or an IEnumerable<Exception>", "exceptionObject");
			}
			lowLevelListWithIList.AddRange(collection);
		}
		if (lowLevelListWithIList.Count > 0)
		{
			MarkAsUnhandled();
		}
	}

	private void MarkAsUnhandled()
	{
		if (m_isHandled)
		{
			GC.ReRegisterForFinalize(this);
			m_isHandled = false;
		}
	}

	internal void MarkAsHandled(bool calledFromFinalizer)
	{
		if (!m_isHandled)
		{
			if (!calledFromFinalizer)
			{
				GC.SuppressFinalize(this);
			}
			m_isHandled = true;
		}
	}

	internal AggregateException CreateExceptionObject(bool calledFromFinalizer, Exception includeThisException)
	{
		LowLevelListWithIList<ExceptionDispatchInfo> faultExceptions = m_faultExceptions;
		MarkAsHandled(calledFromFinalizer);
		if (includeThisException == null)
		{
			return new AggregateException(faultExceptions);
		}
		Exception[] array = new Exception[faultExceptions.Count + 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array[i] = faultExceptions[i].SourceException;
		}
		array[array.Length - 1] = includeThisException;
		return new AggregateException(array);
	}

	internal ReadOnlyCollection<ExceptionDispatchInfo> GetExceptionDispatchInfos()
	{
		LowLevelListWithIList<ExceptionDispatchInfo> faultExceptions = m_faultExceptions;
		MarkAsHandled(calledFromFinalizer: false);
		return new ReadOnlyCollection<ExceptionDispatchInfo>(faultExceptions);
	}

	internal ExceptionDispatchInfo GetCancellationExceptionDispatchInfo()
	{
		return m_cancellationException;
	}
}
