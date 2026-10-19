using System;

namespace ACT.UI;

public class TaskContext
{
	public enum TaskResult
	{
		Unknown,
		Succeed,
		Failed,
		Cancelled
	}

	private bool m_finished;

	private TaskResult m_result;

	private Exception m_exception;

	public bool Finished => m_finished;

	public TaskResult Result => m_result;

	public Exception Exception => m_exception;

	public void Finish(TaskResult result = TaskResult.Succeed, Exception exception = null)
	{
		if (!m_finished)
		{
			m_finished = true;
			m_result = result;
			m_exception = exception;
		}
	}
}
