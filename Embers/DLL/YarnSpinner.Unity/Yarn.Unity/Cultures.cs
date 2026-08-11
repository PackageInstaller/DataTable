using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace Yarn.Unity;

public static class Cultures
{
	private static Lazy<IEnumerable<Culture>> _allCultures = new Lazy<IEnumerable<Culture>>(() => MakeCultureList());

	private static Lazy<Dictionary<string, Culture>> _allCulturesTable = new Lazy<Dictionary<string, Culture>>(delegate
	{
		Dictionary<string, Culture> dictionary = new Dictionary<string, Culture>();
		foreach (Culture item in _allCultures.Value)
		{
			dictionary[item.Name] = item;
		}
		return dictionary;
	});

	public static Culture CurrentNeutralCulture
	{
		get
		{
			CultureInfo cultureInfo = CultureInfo.CurrentCulture;
			if (!cultureInfo.IsNeutralCulture)
			{
				cultureInfo = cultureInfo.Parent;
			}
			return GetCulture(cultureInfo.Name);
		}
	}

	private static IEnumerable<Culture> MakeCultureList()
	{
		return from c in (from c in CultureInfo.GetCultures(CultureTypes.AllCultures)
				where c.Name != ""
				select new Culture
				{
					Name = c.Name,
					DisplayName = c.DisplayName,
					NativeName = c.NativeName,
					IsNeutralCulture = c.IsNeutralCulture
				}).Append(new Culture
			{
				Name = "mi",
				DisplayName = "Maori",
				NativeName = "Māori",
				IsNeutralCulture = true
			})
			orderby c.DisplayName
			select c;
	}

	public static IEnumerable<Culture> GetCultures()
	{
		return _allCultures.Value;
	}

	[Obsolete("Use TryGetCulture, which does not throw if the culture can't be found.")]
	public static Culture GetCulture(string name)
	{
		if (_allCulturesTable.Value.TryGetValue(name, out var value))
		{
			return value;
		}
		throw new ArgumentException("Culture " + name + " not found", name);
	}

	public static bool TryGetCulture(string name, out Culture culture)
	{
		return _allCulturesTable.Value.TryGetValue(name, out culture);
	}

	public static bool HasCulture(string name)
	{
		return _allCulturesTable.Value.ContainsKey(name);
	}
}
