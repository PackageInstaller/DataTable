using System;
using System.Collections.Generic;

namespace UnityEngine.Localization.Pseudo;

[Serializable]
public class CharacterSubstitutor : IPseudoLocalizationMethod, ISerializationCallbackReceiver
{
	public enum SubstitutionMethod
	{
		ToUpper,
		ToLower,
		List,
		Map
	}

	[Serializable]
	private struct CharReplacement
	{
		public char original;

		public char replacement;
	}

	public enum ListSelectionMethod
	{
		Random,
		LoopFromPrevious,
		LoopFromStart
	}

	[SerializeField]
	private SubstitutionMethod m_SubstitutionMethod;

	[SerializeField]
	private ListSelectionMethod m_ListMode;

	[SerializeField]
	private List<CharReplacement> m_ReplacementsMap;

	[SerializeField]
	private List<char> m_ReplacementList = new List<char> { '_' };

	internal int m_ReplacementsPosition;

	public SubstitutionMethod Method
	{
		get
		{
			return m_SubstitutionMethod;
		}
		set
		{
			m_SubstitutionMethod = value;
		}
	}

	public Dictionary<char, char> ReplacementMap { get; private set; } = new Dictionary<char, char>();

	public ListSelectionMethod ListMode
	{
		get
		{
			return m_ListMode;
		}
		set
		{
			m_ListMode = value;
		}
	}

	public List<char> ReplacementList => m_ReplacementList;

	private int GetRandomSeed(string input)
	{
		return input.GetHashCode();
	}

	internal char ReplaceCharFromMap(char value)
	{
		if (ReplacementMap != null && ReplacementMap.TryGetValue(value, out var value2))
		{
			return value2;
		}
		return value;
	}

	public void OnBeforeSerialize()
	{
		if (m_ReplacementsMap == null)
		{
			m_ReplacementsMap = new List<CharReplacement>();
		}
		m_ReplacementsMap.Clear();
		foreach (KeyValuePair<char, char> item in ReplacementMap)
		{
			m_ReplacementsMap.Add(new CharReplacement
			{
				original = item.Key,
				replacement = item.Value
			});
		}
	}

	public void OnAfterDeserialize()
	{
		if (ReplacementMap == null)
		{
			ReplacementMap = new Dictionary<char, char>();
		}
		ReplacementMap.Clear();
		foreach (CharReplacement item in m_ReplacementsMap)
		{
			ReplacementMap[item.original] = item.replacement;
		}
	}

	private void TransformFragment(WritableMessageFragment writableFragment)
	{
		switch (Method)
		{
		case SubstitutionMethod.Map:
		{
			char[] array2 = new char[writableFragment.Length];
			for (int j = 0; j < array2.Length; j++)
			{
				array2[j] = ReplaceCharFromMap(writableFragment[j]);
			}
			writableFragment.Text = new string(array2);
			break;
		}
		case SubstitutionMethod.ToUpper:
			writableFragment.Text = writableFragment.Text.ToUpper();
			break;
		case SubstitutionMethod.ToLower:
			writableFragment.Text = writableFragment.Text.ToLower();
			break;
		case SubstitutionMethod.List:
		{
			if (m_ReplacementList == null || m_ReplacementList.Count == 0)
			{
				break;
			}
			if (m_ReplacementList.Count == 1)
			{
				writableFragment.Text = new string(m_ReplacementList[0], writableFragment.Length);
				break;
			}
			char[] array = new char[writableFragment.Length];
			if (ListMode == ListSelectionMethod.Random)
			{
				Random.InitState(GetRandomSeed(writableFragment.Message.Original));
				for (int i = 0; i < array.Length; i++)
				{
					array[i] = m_ReplacementList[Random.Range(0, m_ReplacementList.Count)];
				}
			}
			else
			{
				if (ListMode == ListSelectionMethod.LoopFromStart)
				{
					m_ReplacementsPosition = 0;
				}
				int num = 0;
				while (num < array.Length)
				{
					array[num] = m_ReplacementList[m_ReplacementsPosition % m_ReplacementList.Count];
					num++;
					m_ReplacementsPosition++;
				}
			}
			writableFragment.Text = new string(array);
			break;
		}
		}
	}

	public void Transform(Message message)
	{
		foreach (MessageFragment fragment in message.Fragments)
		{
			if (fragment is WritableMessageFragment writableFragment)
			{
				TransformFragment(writableFragment);
			}
		}
	}
}
