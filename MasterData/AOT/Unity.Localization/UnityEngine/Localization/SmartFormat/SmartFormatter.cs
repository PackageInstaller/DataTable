using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Output;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Localization.SmartFormat.Core.Settings;

namespace UnityEngine.Localization.SmartFormat;

[Serializable]
public class SmartFormatter : ISerializationCallbackReceiver
{
	[SerializeReference]
	private SmartSettings m_Settings;

	[SerializeReference]
	private Parser m_Parser;

	[SerializeReference]
	private List<ISource> m_Sources;

	[SerializeReference]
	private List<IFormatter> m_Formatters;

	private List<string> m_NotEmptyFormatterExtensionNames;

	private static readonly object[] k_Empty = new object[1];

	public List<ISource> SourceExtensions => m_Sources;

	public List<IFormatter> FormatterExtensions => m_Formatters;

	public Parser Parser
	{
		get
		{
			return m_Parser;
		}
		set
		{
			m_Parser = value;
		}
	}

	public SmartSettings Settings
	{
		get
		{
			return m_Settings;
		}
		set
		{
			m_Settings = value;
		}
	}

	public event EventHandler<FormattingErrorEventArgs> OnFormattingFailure;

	public SmartFormatter()
	{
		m_Settings = new SmartSettings();
		m_Parser = new Parser(m_Settings);
		m_Sources = new List<ISource>();
		m_Formatters = new List<IFormatter>();
	}

	public List<string> GetNotEmptyFormatterExtensionNames()
	{
		if (m_NotEmptyFormatterExtensionNames != null)
		{
			return m_NotEmptyFormatterExtensionNames;
		}
		m_NotEmptyFormatterExtensionNames = new List<string>();
		foreach (IFormatter formatterExtension in FormatterExtensions)
		{
			if (formatterExtension?.Names == null)
			{
				continue;
			}
			string[] names = formatterExtension.Names;
			foreach (string text in names)
			{
				if (!string.IsNullOrEmpty(text))
				{
					m_NotEmptyFormatterExtensionNames.Add(text);
				}
			}
		}
		return m_NotEmptyFormatterExtensionNames;
	}

	public void AddExtensions(params ISource[] sourceExtensions)
	{
		SourceExtensions.InsertRange(0, sourceExtensions);
	}

	public void AddExtensions(params IFormatter[] formatterExtensions)
	{
		m_NotEmptyFormatterExtensionNames = null;
		FormatterExtensions.InsertRange(0, formatterExtensions);
	}

	public T GetSourceExtension<T>() where T : class, ISource
	{
		return SourceExtensions.OfType<T>().FirstOrDefault();
	}

	public T GetFormatterExtension<T>() where T : class, IFormatter
	{
		return FormatterExtensions.OfType<T>().FirstOrDefault();
	}

	public string Format(string format, params object[] args)
	{
		return Format(null, args, format);
	}

	public string Format(IList<object> args, string format)
	{
		return Format(null, args, format);
	}

	public string Format(IFormatProvider provider, string format, params object[] args)
	{
		return Format(provider, args, format);
	}

	public string Format(IFormatProvider provider, IList<object> args, string format)
	{
		args = args ?? k_Empty;
		StringOutput value;
		using (StringOutputPool.Get(format.Length + args.Count * 8, out value))
		{
			Format format2 = Parser.ParseFormat(format, GetNotEmptyFormatterExtensionNames());
			object current = ((args.Count > 0) ? args[0] : args);
			FormatDetails formatDetails = FormatDetailsPool.Get(this, format2, args, null, provider, value);
			Format(formatDetails, format2, current);
			FormatDetailsPool.Release(formatDetails);
			FormatItemPool.ReleaseFormat(format2);
			return value.ToString();
		}
	}

	public void FormatInto(IOutput output, string format, params object[] args)
	{
		args = args ?? k_Empty;
		Format format2 = Parser.ParseFormat(format, GetNotEmptyFormatterExtensionNames());
		object current = ((args.Length != 0) ? args[0] : args);
		FormatDetails formatDetails = FormatDetailsPool.Get(this, format2, args, null, null, output);
		Format(formatDetails, format2, current);
		FormatDetailsPool.Release(formatDetails);
		FormatItemPool.ReleaseFormat(format2);
	}

	public string FormatWithCache(ref FormatCache cache, string format, IList<object> args)
	{
		return FormatWithCache(ref cache, format, null, args);
	}

	public string FormatWithCache(ref FormatCache cache, string format, IFormatProvider formatProvider, IList<object> args)
	{
		args = args ?? k_Empty;
		StringOutput value;
		using (StringOutputPool.Get(format.Length + args.Count * 8, out value))
		{
			if (cache == null)
			{
				cache = FormatCachePool.Get(Parser.ParseFormat(format, GetNotEmptyFormatterExtensionNames()));
			}
			object current = ((args.Count > 0) ? args[0] : args);
			FormatDetails formatDetails = FormatDetailsPool.Get(this, cache.Format, args, cache, formatProvider, value);
			Format(formatDetails, cache.Format, current);
			FormatDetailsPool.Release(formatDetails);
			return value.ToString();
		}
	}

	public void FormatWithCacheInto(ref FormatCache cache, IOutput output, string format, params object[] args)
	{
		args = args ?? k_Empty;
		if (cache == null)
		{
			cache = FormatCachePool.Get(Parser.ParseFormat(format, GetNotEmptyFormatterExtensionNames()));
		}
		object current = ((args.Length != 0) ? args[0] : args);
		FormatDetails formatDetails = FormatDetailsPool.Get(this, cache.Format, args, cache, null, output);
		Format(formatDetails, cache.Format, current);
		FormatDetailsPool.Release(formatDetails);
	}

	private void Format(FormatDetails formatDetails, Format format, object current)
	{
		FormattingInfo formattingInfo = FormattingInfoPool.Get(formatDetails, format, current);
		Format(formattingInfo);
		FormattingInfoPool.Release(formattingInfo);
	}

	public virtual void Format(FormattingInfo formattingInfo)
	{
		if (formattingInfo.Format == null)
		{
			return;
		}
		CheckForExtensions();
		foreach (FormatItem item in formattingInfo.Format.Items)
		{
			if (item is LiteralText literalText)
			{
				formattingInfo.Write(literalText.ToString());
				continue;
			}
			Placeholder placeholder = (Placeholder)item;
			FormattingInfo formattingInfo2 = formattingInfo.CreateChild(placeholder);
			try
			{
				EvaluateSelectors(formattingInfo2);
			}
			catch (Exception innerException)
			{
				int startIndex = placeholder.Format?.startIndex ?? placeholder.Selectors.Last().endIndex;
				FormatError(item, innerException, startIndex, formattingInfo2);
				continue;
			}
			try
			{
				EvaluateFormatters(formattingInfo2);
			}
			catch (Exception innerException2)
			{
				int startIndex2 = placeholder.Format?.startIndex ?? placeholder.Selectors.Last().endIndex;
				FormatError(item, innerException2, startIndex2, formattingInfo2);
			}
		}
	}

	private void FormatError(FormatItem errorItem, Exception innerException, int startIndex, FormattingInfo formattingInfo)
	{
		OnFormattingFailure?.Invoke(this, new FormattingErrorEventArgs(errorItem.RawText, startIndex, Settings.FormatErrorAction != ErrorAction.ThrowError));
		switch (Settings.FormatErrorAction)
		{
		case ErrorAction.Ignore:
			break;
		case ErrorAction.ThrowError:
			throw (innerException as FormattingException) ?? new FormattingException(errorItem, innerException, startIndex);
		case ErrorAction.OutputErrorInResult:
			formattingInfo.FormatDetails.FormattingException = (innerException as FormattingException) ?? new FormattingException(errorItem, innerException, startIndex);
			formattingInfo.Write(innerException.Message);
			formattingInfo.FormatDetails.FormattingException = null;
			break;
		case ErrorAction.MaintainTokens:
			formattingInfo.Write(formattingInfo.Placeholder.RawText);
			break;
		}
	}

	private void CheckForExtensions()
	{
		if (SourceExtensions.Count == 0)
		{
			throw new InvalidOperationException("No source extensions are available. Please add at least one source extension, such as the DefaultSource.");
		}
		if (FormatterExtensions.Count == 0)
		{
			throw new InvalidOperationException("No formatter extensions are available. Please add at least one formatter extension, such as the DefaultFormatter.");
		}
	}

	private void EvaluateSelectors(FormattingInfo formattingInfo)
	{
		if (formattingInfo.Placeholder == null)
		{
			return;
		}
		bool flag = true;
		foreach (Selector selector2 in formattingInfo.Placeholder.Selectors)
		{
			Selector selector = (formattingInfo.Selector = selector2);
			formattingInfo.Result = null;
			bool flag2 = InvokeSourceExtensions(formattingInfo);
			if (flag2)
			{
				formattingInfo.CurrentValue = formattingInfo.Result;
			}
			if (flag)
			{
				flag = false;
				FormattingInfo formattingInfo2 = formattingInfo;
				while (!flag2 && formattingInfo2.Parent != null)
				{
					formattingInfo2 = formattingInfo2.Parent;
					formattingInfo2.Selector = selector;
					formattingInfo2.Result = null;
					flag2 = InvokeSourceExtensions(formattingInfo2);
					if (flag2)
					{
						formattingInfo.CurrentValue = formattingInfo2.Result;
					}
				}
			}
			if (!flag2)
			{
				throw formattingInfo.FormattingException("Could not evaluate the selector \"" + selector.RawText + "\"", selector);
			}
		}
	}

	private bool InvokeSourceExtensions(FormattingInfo formattingInfo)
	{
		foreach (ISource sourceExtension in SourceExtensions)
		{
			if (sourceExtension.TryEvaluateSelector(formattingInfo))
			{
				return true;
			}
		}
		return false;
	}

	private void EvaluateFormatters(FormattingInfo formattingInfo)
	{
		if (!InvokeFormatterExtensions(formattingInfo))
		{
			throw formattingInfo.FormattingException("No suitable Formatter could be found", formattingInfo.Format);
		}
	}

	private bool InvokeFormatterExtensions(FormattingInfo formattingInfo)
	{
		if (formattingInfo.Placeholder == null)
		{
			return false;
		}
		string formatterName = formattingInfo.Placeholder.FormatterName;
		foreach (IFormatter formatterExtension in FormatterExtensions)
		{
			if (formatterExtension.Names.Contains(formatterName) && formatterExtension.TryEvaluateFormat(formattingInfo))
			{
				return true;
			}
		}
		return false;
	}

	public void OnBeforeSerialize()
	{
		m_NotEmptyFormatterExtensionNames = null;
	}

	public void OnAfterDeserialize()
	{
		m_NotEmptyFormatterExtensionNames = null;
	}
}
