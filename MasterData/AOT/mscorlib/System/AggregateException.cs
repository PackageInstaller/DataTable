using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Globalization;
using System.Runtime.ExceptionServices;
using System.Runtime.Serialization;
using System.Text;

namespace System;

[Serializable]
[DebuggerDisplay("Count = {InnerExceptionCount}")]
public class AggregateException : Exception
{
	private ReadOnlyCollection<Exception> m_innerExceptions;

	public ReadOnlyCollection<Exception> InnerExceptions => m_innerExceptions;

	public override string Message
	{
		get
		{
			if (m_innerExceptions.Count == 0)
			{
				return base.Message;
			}
			StringBuilder stringBuilder = StringBuilderCache.Acquire();
			stringBuilder.Append(base.Message);
			stringBuilder.Append(' ');
			for (int i = 0; i < m_innerExceptions.Count; i++)
			{
				stringBuilder.Append('(');
				stringBuilder.Append(m_innerExceptions[i].Message);
				stringBuilder.Append(") ");
			}
			stringBuilder.Length--;
			return StringBuilderCache.GetStringAndRelease(stringBuilder);
		}
	}

	public AggregateException()
		: base("One or more errors occurred.")
	{
		m_innerExceptions = new ReadOnlyCollection<Exception>(Array.Empty<Exception>());
	}

	public AggregateException(IEnumerable<Exception> innerExceptions)
		: this("One or more errors occurred.", innerExceptions)
	{
	}

	public AggregateException(params Exception[] innerExceptions)
		: this("One or more errors occurred.", innerExceptions)
	{
	}

	public AggregateException(string message, IEnumerable<Exception> innerExceptions)
		: this(message, (innerExceptions as IList<Exception>) ?? ((innerExceptions == null) ? null : new List<Exception>(innerExceptions)))
	{
	}

	public AggregateException(string message, params Exception[] innerExceptions)
		: this(message, (IList<Exception>)innerExceptions)
	{
	}

	private AggregateException(string message, IList<Exception> innerExceptions)
		: base(message, (innerExceptions != null && innerExceptions.Count > 0) ? innerExceptions[0] : null)
	{
		if (innerExceptions == null)
		{
			throw new ArgumentNullException("innerExceptions");
		}
		Exception[] array = new Exception[innerExceptions.Count];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = innerExceptions[i];
			if (array[i] == null)
			{
				throw new ArgumentException("An element of innerExceptions was null.");
			}
		}
		m_innerExceptions = new ReadOnlyCollection<Exception>(array);
	}

	internal AggregateException(IEnumerable<ExceptionDispatchInfo> innerExceptionInfos)
		: this("One or more errors occurred.", innerExceptionInfos)
	{
	}

	internal AggregateException(string message, IEnumerable<ExceptionDispatchInfo> innerExceptionInfos)
		: this(message, (innerExceptionInfos as IList<ExceptionDispatchInfo>) ?? ((innerExceptionInfos == null) ? null : new List<ExceptionDispatchInfo>(innerExceptionInfos)))
	{
	}

	private AggregateException(string message, IList<ExceptionDispatchInfo> innerExceptionInfos)
		: base(message, (innerExceptionInfos != null && innerExceptionInfos.Count > 0 && innerExceptionInfos[0] != null) ? innerExceptionInfos[0].SourceException : null)
	{
		if (innerExceptionInfos == null)
		{
			throw new ArgumentNullException("innerExceptionInfos");
		}
		Exception[] array = new Exception[innerExceptionInfos.Count];
		for (int i = 0; i < array.Length; i++)
		{
			ExceptionDispatchInfo exceptionDispatchInfo = innerExceptionInfos[i];
			if (exceptionDispatchInfo != null)
			{
				array[i] = exceptionDispatchInfo.SourceException;
			}
			if (array[i] == null)
			{
				throw new ArgumentException("An element of innerExceptions was null.");
			}
		}
		m_innerExceptions = new ReadOnlyCollection<Exception>(array);
	}

	protected AggregateException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		if (!(info.GetValue("InnerExceptions", typeof(Exception[])) is Exception[] list))
		{
			throw new SerializationException("The serialization stream contains no inner exceptions.");
		}
		m_innerExceptions = new ReadOnlyCollection<Exception>(list);
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		Exception[] array = new Exception[m_innerExceptions.Count];
		m_innerExceptions.CopyTo(array, 0);
		info.AddValue("InnerExceptions", array, typeof(Exception[]));
	}

	public override Exception GetBaseException()
	{
		Exception ex = this;
		AggregateException ex2 = this;
		while (ex2 != null && ex2.InnerExceptions.Count == 1)
		{
			ex = ex.InnerException;
			ex2 = ex as AggregateException;
		}
		return ex;
	}

	public AggregateException Flatten()
	{
		List<Exception> list = new List<Exception>();
		List<AggregateException> list2 = new List<AggregateException>();
		list2.Add(this);
		int num = 0;
		while (list2.Count > num)
		{
			IList<Exception> innerExceptions = list2[num++].InnerExceptions;
			for (int i = 0; i < innerExceptions.Count; i++)
			{
				Exception ex = innerExceptions[i];
				if (ex != null)
				{
					if (ex is AggregateException item)
					{
						list2.Add(item);
					}
					else
					{
						list.Add(ex);
					}
				}
			}
		}
		return new AggregateException(Message, list);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(base.ToString());
		for (int i = 0; i < m_innerExceptions.Count; i++)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("---> ");
			stringBuilder.AppendFormat(CultureInfo.InvariantCulture, "(Inner Exception #{0}) ", i);
			stringBuilder.Append(m_innerExceptions[i].ToString());
			stringBuilder.Append("<---");
			stringBuilder.AppendLine();
		}
		return stringBuilder.ToString();
	}
}
