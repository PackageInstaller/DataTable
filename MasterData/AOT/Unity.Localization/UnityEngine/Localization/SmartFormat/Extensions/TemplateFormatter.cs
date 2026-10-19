using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class TemplateFormatter : FormatterBase
{
	[Serializable]
	private class Template
	{
		public string name;

		public string text;

		public Format Format { get; set; }
	}

	[SerializeField]
	private List<Template> m_Templates = new List<Template>();

	private IDictionary<string, Format> m_TemplatesDict;

	[NonSerialized]
	private SmartFormatter m_Formatter;

	private IDictionary<string, Format> Templates
	{
		get
		{
			if (m_TemplatesDict == null)
			{
				IEqualityComparer<string> caseSensitivityComparer = Formatter.Settings.GetCaseSensitivityComparer();
				m_TemplatesDict = new Dictionary<string, Format>(caseSensitivityComparer);
				foreach (Template template in m_Templates)
				{
					if (!string.IsNullOrEmpty(template.name))
					{
						try
						{
							m_TemplatesDict[template.name] = Formatter.Parser.ParseFormat(template.text, Formatter.GetNotEmptyFormatterExtensionNames());
						}
						catch (Exception exception)
						{
							Debug.LogException(exception);
						}
					}
				}
			}
			return m_TemplatesDict;
		}
	}

	public SmartFormatter Formatter
	{
		get
		{
			return m_Formatter ?? LocalizationSettings.StringDatabase.SmartFormatter;
		}
		set
		{
			m_Formatter = value;
		}
	}

	public override string[] DefaultNames => new string[2] { "template", "t" };

	public TemplateFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		string text = formattingInfo.FormatterOptions;
		if (text == string.Empty)
		{
			if (formattingInfo.Format.HasNested)
			{
				return false;
			}
			text = formattingInfo.Format.RawText;
		}
		if (!Templates.TryGetValue(text, out var value))
		{
			if (Names.Contains(formattingInfo.Placeholder.FormatterName))
			{
				throw new FormatException("Formatter '" + formattingInfo.Placeholder.FormatterName + "' found no registered template named '" + text + "'");
			}
			return false;
		}
		formattingInfo.Write(value, formattingInfo.CurrentValue);
		return true;
	}

	public void Register(string templateName, string template)
	{
		Format value = Formatter.Parser.ParseFormat(template, Formatter.GetNotEmptyFormatterExtensionNames());
		Templates.Add(templateName, value);
	}

	public bool Remove(string templateName)
	{
		return Templates.Remove(templateName);
	}

	public override void OnAfterDeserialize()
	{
		base.OnAfterDeserialize();
		m_TemplatesDict = null;
	}

	public void Clear()
	{
		Templates.Clear();
	}
}
