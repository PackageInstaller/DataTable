using System.Reflection;
using System.Runtime.Serialization;

namespace System;

[Serializable]
internal class DelegateSerializationHolder : ISerializable, IObjectReference
{
	[Serializable]
	private class DelegateEntry
	{
		private string type;

		private string assembly;

		private object target;

		private string targetTypeAssembly;

		private string targetTypeName;

		private string methodName;

		public DelegateEntry delegateEntry;

		public DelegateEntry(Delegate del, string targetLabel)
		{
			type = del.GetType().FullName;
			assembly = del.GetType().Assembly.FullName;
			target = targetLabel;
			targetTypeAssembly = del.Method.DeclaringType.Assembly.FullName;
			targetTypeName = del.Method.DeclaringType.FullName;
			methodName = del.Method.Name;
		}

		public Delegate DeserializeDelegate(SerializationInfo info, int index)
		{
			object obj = null;
			if (target != null)
			{
				obj = info.GetValue(target.ToString(), typeof(object));
			}
			string name = "method" + index;
			MethodInfo methodInfo = (MethodInfo)info.GetValueNoThrow(name, typeof(MethodInfo));
			Type type = Assembly.Load(assembly).GetType(this.type);
			if (obj != null)
			{
				if (!(methodInfo == null))
				{
					return Delegate.CreateDelegate(type, obj, methodInfo);
				}
				return Delegate.CreateDelegate(type, obj, methodName);
			}
			if (methodInfo != null)
			{
				return Delegate.CreateDelegate(type, obj, methodInfo);
			}
			Type type2 = Assembly.Load(targetTypeAssembly).GetType(targetTypeName);
			return Delegate.CreateDelegate(type, type2, methodName);
		}
	}

	private Delegate _delegate;

	private DelegateSerializationHolder(SerializationInfo info, StreamingContext ctx)
	{
		DelegateEntry delegateEntry = (DelegateEntry)info.GetValue("Delegate", typeof(DelegateEntry));
		int num = 0;
		DelegateEntry delegateEntry2 = delegateEntry;
		while (delegateEntry2 != null)
		{
			delegateEntry2 = delegateEntry2.delegateEntry;
			num++;
		}
		if (num == 1)
		{
			_delegate = delegateEntry.DeserializeDelegate(info, 0);
			return;
		}
		Delegate[] array = new Delegate[num];
		delegateEntry2 = delegateEntry;
		for (int i = 0; i < num; i++)
		{
			array[i] = delegateEntry2.DeserializeDelegate(info, i);
			delegateEntry2 = delegateEntry2.delegateEntry;
		}
		_delegate = Delegate.Combine(array);
	}

	public static void GetDelegateData(Delegate instance, SerializationInfo info, StreamingContext ctx)
	{
		Delegate[] invocationList = instance.GetInvocationList();
		DelegateEntry delegateEntry = null;
		for (int i = 0; i < invocationList.Length; i++)
		{
			Delegate obj = invocationList[i];
			string text = ((obj.Target != null) ? ("target" + i) : null);
			DelegateEntry delegateEntry2 = new DelegateEntry(obj, text);
			if (delegateEntry == null)
			{
				info.AddValue("Delegate", delegateEntry2);
			}
			else
			{
				delegateEntry.delegateEntry = delegateEntry2;
			}
			delegateEntry = delegateEntry2;
			if (obj.Target != null)
			{
				info.AddValue(text, obj.Target);
			}
			info.AddValue("method" + i, obj.Method);
		}
		info.SetType(typeof(DelegateSerializationHolder));
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw new NotSupportedException();
	}

	public object GetRealObject(StreamingContext context)
	{
		return _delegate;
	}
}
