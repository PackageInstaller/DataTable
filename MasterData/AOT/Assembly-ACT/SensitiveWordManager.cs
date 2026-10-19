using System.Collections.Generic;
using System.Text;
using ACT.Config;
using ACT.Core;
using Fundamental;

public class SensitiveWordManager : Singleton<SensitiveWordManager>
{
	public class TrieNode
	{
		private bool _isEnd;

		private Dictionary<char, TrieNode> subNodes = new Dictionary<char, TrieNode>();

		public bool isKeyWordEnd
		{
			get
			{
				return _isEnd;
			}
			set
			{
				_isEnd = value;
			}
		}

		public void AddSubNode(char key, TrieNode node)
		{
			subNodes.Add(key, node);
		}

		public TrieNode GetSubNode(char key)
		{
			if (subNodes.ContainsKey(key))
			{
				return subNodes[key];
			}
			return null;
		}
	}

	public class Trie
	{
		private const string DEFAULT_REPLACEMENT = "***";

		private TrieNode rootNode = new TrieNode();

		private bool IsSymbol(char c)
		{
			if ((c < '0' || c > '9') && (c < 'a' || c > 'z') && (c < 'A' || c > 'Z'))
			{
				if (c >= '⺀')
				{
					return c > '鿿';
				}
				return true;
			}
			return false;
		}

		public void AddWords(List<string> words)
		{
			if (words != null && words.Count != 0)
			{
				int i = 0;
				for (int count = words.Count; i < count; i++)
				{
					AddWord(words[i]);
				}
			}
		}

		public void AddWord(string word)
		{
			if (string.IsNullOrEmpty(word))
			{
				return;
			}
			TrieNode trieNode = rootNode;
			for (int i = 0; i < word.Length; i++)
			{
				char key = word[i];
				TrieNode trieNode2 = trieNode.GetSubNode(key);
				if (trieNode2 == null)
				{
					trieNode2 = new TrieNode();
					trieNode.AddSubNode(key, trieNode2);
				}
				trieNode = trieNode2;
				if (i == word.Length - 1)
				{
					trieNode.isKeyWordEnd = true;
				}
			}
		}

		public string Filter(string text)
		{
			if (string.IsNullOrEmpty(text))
			{
				return text;
			}
			string value = "***";
			StringBuilder stringBuilder = new StringBuilder();
			TrieNode subNode = rootNode;
			int num = 0;
			int num2 = 0;
			while (num2 < text.Length)
			{
				char key = text[num2];
				subNode = subNode.GetSubNode(key);
				if (subNode == null)
				{
					stringBuilder.Append(text[num]);
					num2 = num + 1;
					num = num2;
					subNode = rootNode;
				}
				else if (subNode.isKeyWordEnd)
				{
					stringBuilder.Append(value);
					num2++;
					num = num2;
					subNode = rootNode;
				}
				else
				{
					num2++;
				}
			}
			stringBuilder.Append(text.Substring(num));
			return stringBuilder.ToString();
		}

		public bool Check(string text)
		{
			if (string.IsNullOrEmpty(text))
			{
				return false;
			}
			TrieNode subNode = rootNode;
			int num = 0;
			int num2 = 0;
			while (num2 < text.Length)
			{
				char key = text[num2];
				subNode = subNode.GetSubNode(key);
				if (subNode == null)
				{
					num2 = num + 1;
					num = num2;
					subNode = rootNode;
					continue;
				}
				if (subNode.isKeyWordEnd)
				{
					return true;
				}
				num2++;
			}
			return false;
		}
	}

	public Trie _Trie;

	private Dictionary<int, SensitiveWord> DicSensitiveWord;

	public override void Init()
	{
		_Trie = new Trie();
		DicSensitiveWord = RuntimeConfigs.data.sensitiveWords;
		if (DicSensitiveWord == null)
		{
			return;
		}
		foreach (KeyValuePair<int, SensitiveWord> item in DicSensitiveWord)
		{
			_Trie.AddWord(item.Value.sensitiveWordDetection);
		}
	}

	public override void UnInit()
	{
	}
}
