using System;
using System.Collections.Generic;
using System.Linq;
using Google.Protobuf.Collections;
using UnityEngine;

namespace Yarn.Unity;

[HelpURL("https://yarnspinner.dev/docs/unity/components/yarn-programs/")]
public class YarnProject : ScriptableObject
{
	[SerializeField]
	[HideInInspector]
	public byte[] compiledYarnProgram;

	[SerializeField]
	[HideInInspector]
	public Localization baseLocalization;

	[HideInInspector]
	[SerializeField]
	public List<Localization> localizations = new List<Localization>();

	[HideInInspector]
	[SerializeField]
	public LineMetadata lineMetadata;

	[HideInInspector]
	[SerializeField]
	public LocalizationType localizationType;

	private Program cachedProgram;

	[SerializeField]
	[HideInInspector]
	public List<string> searchAssembliesForActions = new List<string>();

	private Dictionary<string, IConvertible> initialValues;

	private Dictionary<string, Dictionary<string, List<string>>> nodeHeaders = new Dictionary<string, Dictionary<string, List<string>>>();

	public string[] NodeNames => Program.Nodes.Keys.ToArray();

	public Dictionary<string, IConvertible> InitialValues
	{
		get
		{
			//IL_0040: Unknown result type (might be due to invalid IL or missing references)
			//IL_0045: Unknown result type (might be due to invalid IL or missing references)
			//IL_0046: Unknown result type (might be due to invalid IL or missing references)
			//IL_0048: Unknown result type (might be due to invalid IL or missing references)
			//IL_005a: Expected I4, but got Unknown
			//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
			if (initialValues != null)
			{
				return initialValues;
			}
			initialValues = new Dictionary<string, IConvertible>();
			foreach (KeyValuePair<string, Operand> initialValue in Program.InitialValues)
			{
				Operand value = initialValue.Value;
				ValueOneofCase valueCase = value.ValueCase;
				switch (valueCase - 1)
				{
				case 0:
					initialValues[initialValue.Key] = value.StringValue;
					break;
				case 1:
					initialValues[initialValue.Key] = value.BoolValue;
					break;
				case 2:
					initialValues[initialValue.Key] = value.FloatValue;
					break;
				default:
					Debug.LogWarning($"{initialValue.Key} is of an invalid type: {value.ValueCase}");
					break;
				}
			}
			return initialValues;
		}
	}

	public Program Program
	{
		get
		{
			if (cachedProgram == null)
			{
				cachedProgram = Program.Parser.ParseFrom(compiledYarnProgram);
			}
			return cachedProgram;
		}
	}

	public Dictionary<string, List<string>> GetHeaders(string nodeName)
	{
		if (nodeHeaders.TryGetValue(nodeName, out var value))
		{
			return value;
		}
		Node val = default(Node);
		if (!Program.Nodes.TryGetValue(nodeName, ref val))
		{
			return new Dictionary<string, List<string>>();
		}
		RepeatedField<Header> headers = val.Headers;
		if (headers == null || headers.Count == 0)
		{
			return new Dictionary<string, List<string>>();
		}
		Dictionary<string, List<string>> dictionary = new Dictionary<string, List<string>>();
		foreach (Header item in headers)
		{
			if (dictionary.TryGetValue(item.Key, out var value2))
			{
				value2.Add(item.Value);
			}
			else
			{
				value2 = new List<string>();
				value2.Add(item.Value);
			}
			dictionary[item.Key] = value2;
		}
		return dictionary;
	}

	public Localization GetLocalization(string localeCode)
	{
		if (localeCode == null)
		{
			return baseLocalization;
		}
		foreach (Localization localization in localizations)
		{
			if (localization.LocaleCode == localeCode)
			{
				return localization;
			}
		}
		return baseLocalization;
	}

	public IEnumerable<string> GetLineIDsForNodes(IEnumerable<string> nodes)
	{
		List<string> list = new List<string>();
		foreach (string node in nodes)
		{
			List<string> list2 = Program.LineIDsForNode(node);
			if (list2 != null)
			{
				list.AddRange(list2);
			}
		}
		return list;
	}

	private void Awake()
	{
		cachedProgram = null;
	}
}
