using System;
using System.Collections.Generic;
using System.Data;
using ACT.Game;
using ACT.Model;
using Fundamental;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT.Utility;

public class ServerPlayerPrefs : Model<ServerPlayerPrefs>
{
	private const string emptyString = "";

	private static Dictionary<string, int> m_IntPrefers;

	private static Dictionary<string, bool> m_BoolPrefers;

	private static Dictionary<string, string> m_StringPrefers;

	private static JObject m_Object;

	protected override void Init()
	{
		if (m_IntPrefers == null)
		{
			m_IntPrefers = DictionaryPool<string, int>.Get();
		}
		if (m_BoolPrefers == null)
		{
			m_BoolPrefers = DictionaryPool<string, bool>.Get();
		}
		if (m_StringPrefers == null)
		{
			m_StringPrefers = DictionaryPool<string, string>.Get();
		}
		m_Object = new JObject();
		DeserializeFromJson();
	}

	protected override void UnInit()
	{
		m_IntPrefers.Clear();
		m_BoolPrefers.Clear();
		m_StringPrefers.Clear();
	}

	protected override void OnDestroy()
	{
		DictionaryPool<string, int>.Release(m_IntPrefers);
		DictionaryPool<string, bool>.Release(m_BoolPrefers);
		DictionaryPool<string, string>.Release(m_StringPrefers);
	}

	private void DeserializeFromJson()
	{
		string settingOptions = G.localPlayer.Profile.SettingOptions;
		if (string.IsNullOrEmpty(settingOptions))
		{
			return;
		}
		foreach (KeyValuePair<string, JToken> item in JObject.Parse(settingOptions))
		{
			string key = item.Key;
			JToken value = item.Value;
			JTokenType type = value.Type;
			try
			{
				switch (type)
				{
				case JTokenType.Integer:
				{
					int value3 = (int)value;
					if (m_IntPrefers.TryAdd(key, value3))
					{
						break;
					}
					m_IntPrefers[key] = value3;
					throw new DuplicateNameException("服务器数据中有重复Key？" + key);
				}
				case JTokenType.Boolean:
				{
					bool value4 = (bool)value;
					if (m_BoolPrefers.TryAdd(key, value4))
					{
						break;
					}
					m_BoolPrefers[key] = value4;
					throw new DuplicateNameException("服务器数据中有重复Key？" + key);
				}
				case JTokenType.String:
				{
					string value2 = (string?)value;
					if (m_StringPrefers.TryAdd(key, value2))
					{
						break;
					}
					m_StringPrefers[key] = value2;
					throw new DuplicateNameException("服务器数据中有重复Key？" + key);
				}
				}
			}
			catch (DuplicateNameException exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
	}

	private static string SerializeToJson()
	{
		m_Object.RemoveAll();
		foreach (KeyValuePair<string, int> intPrefer in m_IntPrefers)
		{
			m_Object.Add(intPrefer.Key, intPrefer.Value);
		}
		foreach (KeyValuePair<string, bool> boolPrefer in m_BoolPrefers)
		{
			m_Object.Add(boolPrefer.Key, boolPrefer.Value);
		}
		foreach (KeyValuePair<string, string> stringPrefer in m_StringPrefers)
		{
			m_Object.Add(stringPrefer.Key, stringPrefer.Value);
		}
		return m_Object.ToString();
	}

	public static void SetInt(string key, int value)
	{
		if (!m_IntPrefers.TryAdd(key, value))
		{
			m_IntPrefers[key] = value;
		}
	}

	public static void SetBool(string key, bool value)
	{
		if (!m_BoolPrefers.TryAdd(key, value))
		{
			m_BoolPrefers[key] = value;
		}
	}

	public static void SetString(string key, string value)
	{
		if (!m_StringPrefers.TryAdd(key, value))
		{
			m_StringPrefers[key] = value;
		}
	}

	public static int GetInt(string key, int defaultValue = 0)
	{
		return m_IntPrefers.GetValueOrDefault(key, defaultValue);
	}

	public static bool GetBool(string key, bool defaultValue = false)
	{
		return m_BoolPrefers.GetValueOrDefault(key, defaultValue);
	}

	public static string GetString(string key, string defaultValue = "")
	{
		return m_StringPrefers.GetValueOrDefault(key, defaultValue);
	}

	public static void Save(Action onSucceed = null, Action onFilled = null)
	{
		G.service.SaveSettingOptions(SerializeToJson(), (bool x) =>
		{
			if (x)
			{
				onSucceed?.Invoke();
			}
			else
			{
				onFilled?.Invoke();
			}
		});
	}
}
