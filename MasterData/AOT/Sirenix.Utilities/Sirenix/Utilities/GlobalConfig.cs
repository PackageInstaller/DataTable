using UnityEngine;

namespace Sirenix.Utilities;

public abstract class GlobalConfig<T> : ScriptableObject, IGlobalConfigEvents where T : GlobalConfig<T>, new()
{
	private static GlobalConfigAttribute configAttribute;

	private static T instance;

	public static GlobalConfigAttribute ConfigAttribute
	{
		get
		{
			if (configAttribute == null)
			{
				configAttribute = typeof(T).GetCustomAttribute<GlobalConfigAttribute>();
				if (configAttribute == null)
				{
					configAttribute = new GlobalConfigAttribute(typeof(T).GetNiceName());
				}
			}
			return configAttribute;
		}
	}

	public static bool HasInstanceLoaded => GlobalConfigUtility<T>.HasInstanceLoaded;

	public static T Instance => GlobalConfigUtility<T>.GetInstance(ConfigAttribute.AssetPath);

	public static void LoadInstanceIfAssetExists()
	{
		GlobalConfigUtility<T>.LoadInstanceIfAssetExists(ConfigAttribute.AssetPath);
	}

	public void OpenInEditor()
	{
		Debug.Log("Downloading, installing and launching the Unity Editor so we can open this config window in the editor, please stand by until pigs can fly and hell has frozen over...");
	}

	protected virtual void OnConfigInstanceFirstAccessed()
	{
	}

	protected virtual void OnConfigAutoCreated()
	{
	}

	void IGlobalConfigEvents.OnConfigAutoCreated()
	{
		OnConfigAutoCreated();
	}

	void IGlobalConfigEvents.OnConfigInstanceFirstAccessed()
	{
		OnConfigInstanceFirstAccessed();
	}
}
