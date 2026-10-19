using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine.Pool;

namespace UnityEngine.Localization.Pseudo;

public class Message
{
	public string Original { get; private set; }

	public List<MessageFragment> Fragments { get; private set; } = new List<MessageFragment>();

	public int Length
	{
		get
		{
			int num = 0;
			foreach (MessageFragment fragment in Fragments)
			{
				num += fragment.Length;
			}
			return num;
		}
	}

	public WritableMessageFragment CreateTextFragment(string original, int start, int end)
	{
		WritableMessageFragment writableMessageFragment = GenericPool<WritableMessageFragment>.Get();
		writableMessageFragment.Initialize(this, original, start, end);
		return writableMessageFragment;
	}

	public WritableMessageFragment CreateTextFragment(string original)
	{
		WritableMessageFragment writableMessageFragment = GenericPool<WritableMessageFragment>.Get();
		writableMessageFragment.Initialize(this, original);
		return writableMessageFragment;
	}

	public ReadOnlyMessageFragment CreateReadonlyTextFragment(string original, int start, int end)
	{
		ReadOnlyMessageFragment readOnlyMessageFragment = GenericPool<ReadOnlyMessageFragment>.Get();
		readOnlyMessageFragment.Initialize(this, original, start, end);
		return readOnlyMessageFragment;
	}

	public ReadOnlyMessageFragment CreateReadonlyTextFragment(string original)
	{
		ReadOnlyMessageFragment readOnlyMessageFragment = GenericPool<ReadOnlyMessageFragment>.Get();
		readOnlyMessageFragment.Initialize(this, original);
		return readOnlyMessageFragment;
	}

	public void ReplaceFragment(MessageFragment original, MessageFragment replacement)
	{
		int num = Fragments.IndexOf(original);
		if (num == -1)
		{
			throw new Exception("Can not replace Fragment " + original.ToString() + " that is not part of the message.");
		}
		Fragments[num] = replacement;
		ReleaseFragment(original);
	}

	public void ReleaseFragment(MessageFragment fragment)
	{
		if (fragment is WritableMessageFragment toRelease)
		{
			GenericPool<WritableMessageFragment>.Release(toRelease);
		}
		else if (fragment is ReadOnlyMessageFragment toRelease2)
		{
			GenericPool<ReadOnlyMessageFragment>.Release(toRelease2);
		}
	}

	internal static Message CreateMessage(string text)
	{
		Message message = GenericPool<Message>.Get();
		message.Fragments.Add(message.CreateTextFragment(text));
		message.Original = text;
		return message;
	}

	internal void Release()
	{
		foreach (MessageFragment fragment in Fragments)
		{
			ReleaseFragment(fragment);
		}
		Fragments.Clear();
		GenericPool<Message>.Release(this);
	}

	public override string ToString()
	{
		StringBuilder value;
		using (StringBuilderPool.Get(out value))
		{
			foreach (MessageFragment fragment in Fragments)
			{
				fragment.BuildString(value);
			}
			return value.ToString();
		}
	}
}
