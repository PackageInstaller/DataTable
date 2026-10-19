using System;
using System.Collections.Generic;

namespace UnityEngine.Localization.Pseudo;

[Serializable]
public class Expander : IPseudoLocalizationMethod
{
	public enum InsertLocation
	{
		Start,
		End,
		Both
	}

	[Serializable]
	public struct ExpansionRule : IComparable<ExpansionRule>
	{
		[SerializeField]
		private int m_MinCharacters;

		[SerializeField]
		private int m_MaxCharacters;

		[SerializeField]
		private float m_ExpansionAmount;

		public int MinCharacters
		{
			get
			{
				return m_MinCharacters;
			}
			set
			{
				m_MinCharacters = Mathf.Max(0, value);
			}
		}

		public int MaxCharacters
		{
			get
			{
				return m_MaxCharacters;
			}
			set
			{
				m_MaxCharacters = Mathf.Max(0, value);
			}
		}

		public float ExpansionAmount
		{
			get
			{
				return m_ExpansionAmount;
			}
			set
			{
				m_ExpansionAmount = Mathf.Max(0f, value);
			}
		}

		public ExpansionRule(int minCharacters, int maxCharacters, float expansion)
		{
			m_MinCharacters = Mathf.Max(0, minCharacters);
			m_MaxCharacters = Mathf.Max(0, maxCharacters);
			m_ExpansionAmount = Mathf.Max(0f, expansion);
		}

		internal bool InRange(int length)
		{
			if (length >= MinCharacters)
			{
				return length < MaxCharacters;
			}
			return false;
		}

		public int CompareTo(ExpansionRule other)
		{
			return MinCharacters.CompareTo(other.MinCharacters);
		}
	}

	[SerializeField]
	private List<ExpansionRule> m_ExpansionRules = new List<ExpansionRule>
	{
		new ExpansionRule(0, 10, 2f),
		new ExpansionRule(10, 20, 1f),
		new ExpansionRule(20, 30, 0.8f),
		new ExpansionRule(30, 50, 0.6f),
		new ExpansionRule(50, 70, 0.7f),
		new ExpansionRule(70, int.MaxValue, 0.3f)
	};

	[SerializeField]
	private InsertLocation m_Location = InsertLocation.End;

	[SerializeField]
	private int m_MinimumStringLength = 1;

	[SerializeField]
	private List<char> m_PaddingCharacters = new List<char>();

	public List<ExpansionRule> ExpansionRules => m_ExpansionRules;

	public InsertLocation Location
	{
		get
		{
			return m_Location;
		}
		set
		{
			m_Location = value;
		}
	}

	public List<char> PaddingCharacters => m_PaddingCharacters;

	public int MinimumStringLength
	{
		get
		{
			return m_MinimumStringLength;
		}
		set
		{
			m_MinimumStringLength = Mathf.Max(0, value);
		}
	}

	public Expander()
	{
		AddCharacterRange('!', '~');
	}

	public Expander(char paddingCharacter)
	{
		PaddingCharacters.Add(paddingCharacter);
	}

	public Expander(char start, char end)
	{
		AddCharacterRange(start, end);
	}

	public void AddCharacterRange(char start, char end)
	{
		for (char c = start; c < end; c = (char)(c + 1))
		{
			PaddingCharacters.Add(c);
		}
	}

	public void SetConstantExpansion(float expansion)
	{
		if (m_ExpansionRules != null)
		{
			m_ExpansionRules.Clear();
		}
		AddExpansionRule(0, int.MaxValue, expansion);
	}

	public void AddExpansionRule(int minCharacters, int maxCharacters, float expansion)
	{
		if (m_ExpansionRules == null)
		{
			m_ExpansionRules = new List<ExpansionRule>();
		}
		m_ExpansionRules.Add(new ExpansionRule(minCharacters, maxCharacters, expansion));
	}

	internal float GetExpansionForLength(int length)
	{
		foreach (ExpansionRule expansionRule in ExpansionRules)
		{
			if (expansionRule.InRange(length))
			{
				return expansionRule.ExpansionAmount;
			}
		}
		return 0f;
	}

	public void Transform(Message message)
	{
		int length = message.Length;
		int num = Mathf.Max(length, MinimumStringLength);
		int num2 = Mathf.CeilToInt(GetExpansionForLength(num) * (float)num);
		if (num2 > 0)
		{
			num2 += num - length;
			char[] array = new char[num2];
			Random.InitState(GetRandomSeed(message.Original));
			for (int i = 0; i < num2; i++)
			{
				array[i] = PaddingCharacters[Random.Range(0, PaddingCharacters.Count)];
			}
			AddPaddingToMessage(message, array);
		}
	}

	private void AddPaddingToMessage(Message message, char[] padding)
	{
		MessageFragment messageFragment = null;
		MessageFragment messageFragment2 = null;
		string original = new string(padding);
		if (Location == InsertLocation.Start)
		{
			messageFragment = message.CreateTextFragment(original);
		}
		else if (Location == InsertLocation.End)
		{
			messageFragment2 = message.CreateTextFragment(original);
		}
		else
		{
			int num = Mathf.FloorToInt((float)padding.Length * 0.5f);
			messageFragment = message.CreateTextFragment(original, 0, num);
			messageFragment2 = message.CreateTextFragment(original, num, padding.Length - 1);
		}
		if (messageFragment != null)
		{
			message.Fragments.Insert(0, messageFragment);
		}
		if (messageFragment2 != null)
		{
			message.Fragments.Add(messageFragment2);
		}
	}

	private int GetRandomSeed(string input)
	{
		return input.GetHashCode();
	}
}
