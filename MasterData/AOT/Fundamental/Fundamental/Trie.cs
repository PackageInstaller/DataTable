using System.Collections.Generic;

namespace Fundamental;

public class Trie
{
	public Dictionary<char, Trie> childen;

	public string val;

	public Trie()
	{
		childen = new Dictionary<char, Trie>();
	}

	public void Insert(string word)
	{
		int length = word.Length;
		Dictionary<char, Trie> dictionary = childen;
		for (int i = 0; i < length - 1; i++)
		{
			if (!dictionary.ContainsKey(word[i]))
			{
				dictionary.Add(word[i], new Trie());
			}
			dictionary = dictionary[word[i]].childen;
		}
		if (!dictionary.ContainsKey(word[length - 1]))
		{
			dictionary.Add(word[length - 1], new Trie());
		}
		dictionary[word[length - 1]].val = word;
	}

	public bool Search(string word)
	{
		int length = word.Length;
		Dictionary<char, Trie> dictionary = childen;
		for (int i = 0; i < length - 1; i++)
		{
			if (!dictionary.ContainsKey(word[i]))
			{
				return false;
			}
			dictionary = dictionary[word[i]].childen;
		}
		if (!dictionary.ContainsKey(word[length - 1]))
		{
			return false;
		}
		return dictionary[word[length - 1]].val == word;
	}

	public bool StartsWith(string prefix)
	{
		int length = prefix.Length;
		Dictionary<char, Trie> dictionary = childen;
		for (int i = 0; i < length - 1; i++)
		{
			if (!dictionary.ContainsKey(prefix[i]))
			{
				return false;
			}
			dictionary = dictionary[prefix[i]].childen;
		}
		if (!dictionary.ContainsKey(prefix[length - 1]))
		{
			return false;
		}
		return true;
	}
}
