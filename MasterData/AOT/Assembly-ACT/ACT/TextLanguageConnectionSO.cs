using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Settings;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Language/TextLanguage")]
public class TextLanguageConnectionSO : OptionsConnectionSO<int>
{
	public class Connection : BaseConnectionWithOptions<int>
	{
		private List<int> _labels;

		private const int FallbackOptionCount = 3;

		private static readonly List<int> EmptyLabels = new List<int>();

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override int GetDefault()
		{
			Locale selectedLocale = LocalizationSettings.SelectedLocale;
			if (selectedLocale == null)
			{
				return 0;
			}
			TextMeshProUGUI.rubyTextEnabled = IsJapaneseLocale(selectedLocale);
			Dictionary<int, TextLanguageData> dictionary = RuntimeConfigs.data?.textLanguageDatas;
			if (dictionary == null)
			{
				return GetFallbackDefaultIndex(selectedLocale.Identifier.Code);
			}
			int num = 0;
			bool flag = false;
			foreach (KeyValuePair<int, TextLanguageData> item in dictionary)
			{
				if (item.Value.languageMarker == selectedLocale.Identifier.Code && (!flag || item.Key < num))
				{
					num = item.Key;
					flag = true;
				}
			}
			if (!flag)
			{
				return 0;
			}
			int num2 = 0;
			foreach (KeyValuePair<int, TextLanguageData> item2 in dictionary)
			{
				if (item2.Key < num)
				{
					num2++;
				}
			}
			return num2;
		}

		public override void Init(int value)
		{
			ApplyLanguage(value);
		}

		public override void Set(int value)
		{
			ApplyLanguage(value);
		}

		private void ApplyLanguage(int index)
		{
			string languageMarker;
			if (RuntimeConfigs.data?.textLanguageDatas == null)
			{
				if (!TryGetFallbackLanguageMarker(index, out languageMarker))
				{
					return;
				}
			}
			else
			{
				if (!TryGetLanguageData(index, out var data))
				{
					return;
				}
				languageMarker = data.languageMarker;
			}
			ILocalesProvider availableLocales = LocalizationSettings.AvailableLocales;
			if (availableLocales == null)
			{
				return;
			}
			Locale locale = availableLocales.GetLocale(languageMarker);
			if (locale == null)
			{
				Debug.LogWarning("[TextLanguageConnectionSO] Locale is unavailable: " + languageMarker);
				return;
			}
			TextMeshProUGUI.rubyTextEnabled = IsJapaneseLocale(locale);
			if (!(LocalizationSettings.SelectedLocale == locale))
			{
				LocalizationSettings.SelectedLocale = locale;
				TextLanguageChangeTracker.NotifyLanguageChanged();
			}
		}

		private static bool IsJapaneseLocale(Locale locale)
		{
			string text = ((locale == null) ? null : locale.Identifier.Code);
			if (!string.Equals(text, "ja", StringComparison.OrdinalIgnoreCase))
			{
				return text?.StartsWith("ja-", StringComparison.OrdinalIgnoreCase) ?? false;
			}
			return true;
		}

		public override int GetOptionCount()
		{
			if (_labels != null && _labels.Count > 0)
			{
				return _labels.Count;
			}
			return RuntimeConfigs.data?.textLanguageDatas?.Count ?? 3;
		}

		public override bool HasOptions()
		{
			if (_labels != null)
			{
				return _labels.Count > 0;
			}
			Dictionary<int, TextLanguageData> dictionary = RuntimeConfigs.data?.textLanguageDatas;
			if (dictionary != null)
			{
				return dictionary.Count > 0;
			}
			return false;
		}

		public override List<int> GetOptionLabels()
		{
			BuildOptions();
			return _labels ?? EmptyLabels;
		}

		public override void RefreshOptions()
		{
			BuildOptions(force: true);
		}

		private bool BuildOptions(bool force = false)
		{
			if (_labels != null && !force)
			{
				return true;
			}
			Dictionary<int, TextLanguageData> dictionary = RuntimeConfigs.data?.textLanguageDatas;
			if (dictionary == null)
			{
				return false;
			}
			List<int> list = new List<int>(dictionary.Count);
			foreach (KeyValuePair<int, TextLanguageData> item in dictionary)
			{
				list.Add(item.Key);
			}
			list.Sort();
			_labels = list;
			return true;
		}

		private bool TryGetLanguageData(int index, out TextLanguageData data)
		{
			data = null;
			if (index < 0)
			{
				return false;
			}
			Dictionary<int, TextLanguageData> dictionary = RuntimeConfigs.data?.textLanguageDatas;
			if (dictionary == null)
			{
				return false;
			}
			if (_labels != null && index < _labels.Count)
			{
				return dictionary.TryGetValue(_labels[index], out data);
			}
			bool flag = false;
			int num = 0;
			for (int i = 0; i <= index; i++)
			{
				bool flag2 = false;
				int num2 = 0;
				foreach (KeyValuePair<int, TextLanguageData> item in dictionary)
				{
					if ((!flag || item.Key > num) && (!flag2 || item.Key < num2))
					{
						num2 = item.Key;
						flag2 = true;
					}
				}
				if (!flag2)
				{
					return false;
				}
				num = num2;
				flag = true;
			}
			return dictionary.TryGetValue(num, out data);
		}

		private static bool TryGetFallbackLanguageMarker(int index, out string languageMarker)
		{
			languageMarker = index switch
			{
				0 => "zh-CN", 
				1 => "en-US", 
				2 => "ja-JP", 
				_ => null, 
			};
			return languageMarker != null;
		}

		private static int GetFallbackDefaultIndex(string localeCode)
		{
			if (string.IsNullOrEmpty(localeCode))
			{
				return 0;
			}
			if (localeCode.StartsWith("en", StringComparison.OrdinalIgnoreCase))
			{
				return 1;
			}
			if (localeCode.StartsWith("ja", StringComparison.OrdinalIgnoreCase))
			{
				return 2;
			}
			return 0;
		}
	}

	protected override IConnectionWithOptions<int> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner);
	}
}
