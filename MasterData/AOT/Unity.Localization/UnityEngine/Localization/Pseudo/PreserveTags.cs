using System;
using System.Collections.Generic;
using UnityEngine.Pool;

namespace UnityEngine.Localization.Pseudo;

[Serializable]
public class PreserveTags : IPseudoLocalizationMethod
{
	[SerializeField]
	private char m_Opening = '<';

	[SerializeField]
	private char m_Closing = '>';

	public char Opening
	{
		get
		{
			return m_Opening;
		}
		set
		{
			m_Opening = value;
		}
	}

	public char Closing
	{
		get
		{
			return m_Closing;
		}
		set
		{
			m_Closing = value;
		}
	}

	public void Transform(Message message)
	{
		List<MessageFragment> value;
		using (CollectionPool<List<MessageFragment>, MessageFragment>.Get(out value))
		{
			for (int i = 0; i < message.Fragments.Count; i++)
			{
				int num = 0;
				int num2 = -1;
				MessageFragment messageFragment = message.Fragments[i];
				if (messageFragment is WritableMessageFragment writableMessageFragment)
				{
					for (int j = 0; j < messageFragment.Length; j++)
					{
						if (messageFragment[j] == m_Opening)
						{
							num2 = j;
						}
						else if (messageFragment[j] == m_Closing && num2 != -1)
						{
							int end = j + 1;
							if (num != num2)
							{
								value.Add(writableMessageFragment.CreateTextFragment(num, num2));
							}
							value.Add(writableMessageFragment.CreateReadonlyTextFragment(num2, end));
							num2 = -1;
							num = j + 1;
						}
					}
					message.ReleaseFragment(messageFragment);
					if (num != messageFragment.Length)
					{
						value.Add(writableMessageFragment.CreateTextFragment(num, messageFragment.Length));
					}
				}
				else
				{
					value.Add(messageFragment);
				}
			}
			message.Fragments.Clear();
			message.Fragments.AddRange(value);
		}
	}
}
