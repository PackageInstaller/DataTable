using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;

namespace GameFramework.Runtime;

public class AggregateException : Exception
{
	private ReadOnlyCollection<Exception> innerExceptions;

	public ReadOnlyCollection<Exception> InnerExceptions => innerExceptions;

	public AggregateException(IList<Exception> innerExceptions)
		: this("", innerExceptions)
	{
	}

	public AggregateException(string message, IList<Exception> innerExceptions)
		: base(message)
	{
		if (innerExceptions == null)
		{
			throw new ArgumentNullException("innerExceptions");
		}
		List<Exception> list = new List<Exception>();
		for (int i = 0; i < innerExceptions.Count; i++)
		{
			Exception ex = innerExceptions[i];
			if (ex != null)
			{
				list.Add(ex);
			}
		}
		this.innerExceptions = list.AsReadOnly();
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(base.ToString()).Append(Environment.NewLine);
		for (int i = 0; i < innerExceptions.Count; i++)
		{
			stringBuilder.Append(Environment.NewLine).Append(innerExceptions[i].ToString()).Append(Environment.NewLine);
		}
		return stringBuilder.ToString();
	}
}
