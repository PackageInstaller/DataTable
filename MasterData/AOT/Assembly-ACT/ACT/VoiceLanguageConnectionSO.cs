using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Sound;
using ACT.Sound.Language;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Language/VoiceLanguage")]
public class VoiceLanguageConnectionSO : OptionsConnectionSO<int>
{
	public class Connection : BaseConnectionWithOptions<int>
	{
		private readonly List<AudioLanguageType> _voiceTypes;

		private List<int> _labels;

		private static readonly List<int> EmptyLabels = new List<int>();

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
			_voiceTypes = new List<AudioLanguageType>((AudioLanguageType[])Enum.GetValues(typeof(AudioLanguageType)));
		}

		public override int GetDefault()
		{
			RefreshVoiceTypesFromTable();
			AudioLanguageType currentLanguageType = AudioLanguageManager.CurrentLanguageType;
			int num = _voiceTypes.IndexOf(currentLanguageType);
			if (num < 0)
			{
				return 0;
			}
			return num;
		}

		public override void Init(int value)
		{
			ApplyVoiceLanguage(value);
		}

		public override void Set(int value)
		{
			ApplyVoiceLanguage(value);
		}

		private void ApplyVoiceLanguage(int index)
		{
			RefreshVoiceTypesFromTable();
			if (index >= 0 && index < _voiceTypes.Count)
			{
				AudioLanguageManager.SetLanguage(_voiceTypes[index]);
			}
		}

		public override int GetOptionCount()
		{
			RefreshVoiceTypesFromTable();
			return _voiceTypes.Count;
		}

		public override bool HasOptions()
		{
			RefreshVoiceTypesFromTable();
			return _voiceTypes.Count > 0;
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

		private void BuildOptions(bool force = false)
		{
			if (_labels != null && !force)
			{
				return;
			}
			Dictionary<int, VoiceLanguageData> dictionary = RuntimeConfigs.data?.voiceLanguageDatas;
			if (dictionary == null)
			{
				return;
			}
			RefreshVoiceTypesFromTable();
			List<int> list = new List<int>(_voiceTypes.Count);
			foreach (AudioLanguageType voiceType in _voiceTypes)
			{
				list.Add(dictionary[(int)voiceType].languageName);
			}
			_labels = list;
		}

		private void RefreshVoiceTypesFromTable()
		{
			Dictionary<int, VoiceLanguageData> dictionary = RuntimeConfigs.data?.voiceLanguageDatas;
			if (dictionary == null)
			{
				return;
			}
			_voiceTypes.Clear();
			foreach (AudioLanguageType value in Enum.GetValues(typeof(AudioLanguageType)))
			{
				if (dictionary.ContainsKey((int)value))
				{
					_voiceTypes.Add(value);
				}
			}
		}
	}

	protected override IConnectionWithOptions<int> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner);
	}
}
