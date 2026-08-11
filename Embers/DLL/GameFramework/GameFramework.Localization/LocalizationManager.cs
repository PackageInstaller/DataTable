using Cysharp.Threading.Tasks;
using GameFramework.Resource;
using UnityEngine;

namespace GameFramework.Localization;

internal sealed class LocalizationManager : GameFrameworkModule, ILocalizationManager
{
	private IResourceManager m_ResourceManager;

	private ILocalizationHelper m_LocalizationHelper;

	public Language Language
	{
		get
		{
			if (m_LocalizationHelper == null)
			{
				throw new GameFrameworkException("You must set localization helper first.");
			}
			return m_LocalizationHelper.Language;
		}
		set
		{
			if (value == Language.Unspecified)
			{
				throw new GameFrameworkException("Language is invalid.");
			}
			if (m_LocalizationHelper == null)
			{
				throw new GameFrameworkException("You must set localization helper first.");
			}
			m_LocalizationHelper.Language = value;
		}
	}

	public Language SystemLanguage
	{
		get
		{
			if (m_LocalizationHelper == null)
			{
				throw new GameFrameworkException("You must set localization helper first.");
			}
			return m_LocalizationHelper.SystemLanguage;
		}
	}

	public LocalizationManager()
	{
		m_ResourceManager = null;
		m_LocalizationHelper = null;
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
	}

	internal override void Shutdown()
	{
	}

	public void SetResourceManager(IResourceManager resourceManager)
	{
		if (resourceManager == null)
		{
			throw new GameFrameworkException("Resource manager is invalid.");
		}
		m_ResourceManager = resourceManager;
	}

	public void SetLocalizationHelper(ILocalizationHelper localizationHelper)
	{
		if (localizationHelper == null)
		{
			throw new GameFrameworkException("Localization helper is invalid.");
		}
		m_LocalizationHelper = localizationHelper;
	}

	public async UniTask UpdateGlobalSource()
	{
		await m_ResourceManager.LoadAssetAsync<TextAsset>(AssetUtility.GetLanguagesSource("I2Languages"));
	}

	public string GetString(string key)
	{
		if (string.IsNullOrEmpty(key))
		{
			throw new GameFrameworkException("Key is invalid.");
		}
		if (m_LocalizationHelper == null)
		{
			throw new GameFrameworkException("Localization Helper is invalid.");
		}
		return m_LocalizationHelper.GetString(key);
	}

	public string GetString(string key, object arg0)
	{
		if (string.IsNullOrEmpty(key))
		{
			throw new GameFrameworkException("Key is invalid.");
		}
		if (m_LocalizationHelper == null)
		{
			throw new GameFrameworkException("Localization Helper is invalid.");
		}
		return m_LocalizationHelper.GetString(key, arg0);
	}

	public string GetString(string key, object arg0, object arg1)
	{
		if (string.IsNullOrEmpty(key))
		{
			throw new GameFrameworkException("Key is invalid.");
		}
		if (m_LocalizationHelper == null)
		{
			throw new GameFrameworkException("Localization Helper is invalid.");
		}
		return m_LocalizationHelper.GetString(key, arg0, arg1);
	}

	public string GetString(string key, object arg0, object arg1, object arg2)
	{
		if (string.IsNullOrEmpty(key))
		{
			throw new GameFrameworkException("Key is invalid.");
		}
		if (m_LocalizationHelper == null)
		{
			throw new GameFrameworkException("Localization Helper is invalid.");
		}
		return m_LocalizationHelper.GetString(key, arg0, arg1, arg2);
	}

	public string GetString(string key, params object[] args)
	{
		if (string.IsNullOrEmpty(key))
		{
			throw new GameFrameworkException("Key is invalid.");
		}
		if (m_LocalizationHelper == null)
		{
			throw new GameFrameworkException("Localization Helper is invalid.");
		}
		return m_LocalizationHelper.GetString(key, args);
	}
}
