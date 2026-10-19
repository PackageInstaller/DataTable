using System;
using UnityEngine.Localization.SmartFormat.Extensions;

namespace UnityEngine.Localization.SmartFormat;

public static class Smart
{
	public static SmartFormatter Default { get; set; } = CreateDefaultSmartFormat();

	public static string Format(string format, params object[] args)
	{
		return Default.Format(format, args);
	}

	public static string Format(IFormatProvider provider, string format, params object[] args)
	{
		return Default.Format(provider, format, args);
	}

	public static string Format(string format, object arg0, object arg1, object arg2)
	{
		return Format(format, new object[3] { arg0, arg1, arg2 });
	}

	public static string Format(string format, object arg0, object arg1)
	{
		return Format(format, new object[2] { arg0, arg1 });
	}

	public static string Format(string format, object arg0)
	{
		return Default.Format(format, arg0);
	}

	public static SmartFormatter CreateDefaultSmartFormat()
	{
		SmartFormatter smartFormatter = new SmartFormatter();
		ListFormatter listFormatter = new ListFormatter(smartFormatter);
		smartFormatter.AddExtensions(listFormatter, new PersistentVariablesSource(smartFormatter), new DictionarySource(smartFormatter), new ValueTupleSource(smartFormatter), new XmlSource(smartFormatter), new ReflectionSource(smartFormatter), new DefaultSource(smartFormatter));
		smartFormatter.AddExtensions(listFormatter, new PluralLocalizationFormatter(), new ConditionalFormatter(), new TimeFormatter(), new XElementFormatter(), new ChooseFormatter(), new SubStringFormatter(), new IsMatchFormatter(), new DefaultFormatter());
		return smartFormatter;
	}
}
