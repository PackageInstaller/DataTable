using System;
using System.IO;
using System.Reflection;

public class EventPoster<T> : EventPosterBase where T : NEventBase
{
	public override bool IsEmpty => mListeners == null;

	public override int ReceiverCount => mListeners.GetInvocationList().Length;

	public event EventHandler<T> Listen
	{
		add
		{
			mListeners += value;
		}
		remove
		{
			mListeners -= value;
		}
	}

	private event EventHandler<T> mListeners;

	public override void DeliverEvent(NEventBase evt)
	{
		if (mListeners != null)
		{
			mListeners((T)evt);
		}
	}

	public override void LogListeners(TextWriter writer)
	{
		writer.Write("<");
		writer.Write(typeof(T).Name);
		writer.WriteLine(">");
		if (mListeners == null)
		{
			return;
		}
		Delegate[] invocationList = mListeners.GetInvocationList();
		foreach (Delegate obj in invocationList)
		{
			writer.Write("  ");
			if (obj.Target != null)
			{
				writer.Write("(");
				writer.Write(obj.Target.ToString());
				writer.Write(").");
			}
			MethodInfo method = obj.Method;
			writer.Write(method.DeclaringType.FullName);
			writer.Write('.');
			writer.Write(method.Name);
			writer.WriteLine();
		}
	}
}
