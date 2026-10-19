using System;
using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

public class ParsingErrors : Exception
{
	public class ParsingIssue
	{
		public int Index { get; }

		public int Length { get; }

		public string Issue { get; }

		public ParsingIssue(string issue, int index, int length)
		{
			Issue = issue;
			Index = index;
			Length = length;
		}
	}

	private Format result;

	public List<ParsingIssue> Issues { get; } = new List<ParsingIssue>();

	public bool HasIssues => Issues.Count > 0;

	public string MessageShort => string.Format("The format string has {0} issue{1}: {2}", Issues.Count, (Issues.Count == 1) ? "" : "s", string.Join(", ", Issues.Select((ParsingIssue i) => i.Issue).ToArray()));

	public override string Message
	{
		get
		{
			string text = "";
			int num = 0;
			foreach (ParsingIssue issue in Issues)
			{
				text += new string('-', issue.Index - num);
				if (issue.Length > 0)
				{
					text += new string('^', Math.Max(issue.Length, 1));
					num = issue.Index + issue.Length;
				}
				else
				{
					text += "^";
					num = issue.Index + 1;
				}
			}
			return string.Format("The format string has {0} issue{1}:\n{2}\nIn: \"{3}\"\nAt:  {4} ", Issues.Count, (Issues.Count == 1) ? "" : "s", string.Join(", ", Issues.Select((ParsingIssue i) => i.Issue).ToArray()), result.baseString, text);
		}
	}

	public void Init(Format result)
	{
		this.result = result;
	}

	public void Clear()
	{
		Issues.Clear();
	}

	public void AddIssue(string issue, int startIndex, int endIndex)
	{
		Issues.Add(new ParsingIssue(issue, startIndex, endIndex - startIndex));
	}
}
