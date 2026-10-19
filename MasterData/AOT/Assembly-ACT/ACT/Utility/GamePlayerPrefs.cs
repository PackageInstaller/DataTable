using System.Collections.Generic;
using ACT.Model;
using Fundamental;

namespace ACT.Utility;

public class GamePlayerPrefs : Model<GamePlayerPrefs>
{
	private const string emptyString = "";

	private static Dictionary<string, int> m_IntPrefers;

	private static Dictionary<string, bool> m_BoolPrefers;

	private static Dictionary<string, string> m_StringPrefers;

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
}
