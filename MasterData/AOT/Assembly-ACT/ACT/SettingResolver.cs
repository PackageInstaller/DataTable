using System.Collections.Generic;
using ACT.UI;
using UnityEngine;

namespace ACT;

public abstract class SettingResolver<TValue> : MonoBehaviour, ISettingResolver
{
	[SerializeField]
	private string m_Id;

	private bool m_Initialized;

	private ISettingWithValue<TValue> m_Setting;

	private Dictionary<string, ISetting> m_DependsOnSettings;

	private SettingCellBindings.DependsOn[] _dependsOn;

	public string Id => m_Id;

	public ISettingWithValue<TValue> Setting
	{
		get
		{
			if (m_Initialized)
			{
				return m_Setting;
			}
			GameSettings gameSettings = SettingsManager.Instance?.RuntimeSettings;
			if (gameSettings != null)
			{
				m_Initialized = true;
				m_Setting = gameSettings.GetSetting(m_Id) as ISettingWithValue<TValue>;
			}
			return m_Setting;
		}
	}

	protected virtual void OnStart()
	{
	}

	private void Start()
	{
		ISettingWithValue<TValue> setting = Setting;
		bool flag = setting?.Usable ?? false;
		if (flag)
		{
			m_DependsOnSettings = new Dictionary<string, ISetting>();
			if (_dependsOn != null)
			{
				SettingCellBindings.DependsOn[] dependsOn = _dependsOn;
				foreach (SettingCellBindings.DependsOn dependsOn2 in dependsOn)
				{
					if (SettingsManager.Instance.RuntimeSettings.GetSetting(dependsOn2.Id) == null)
					{
						flag = false;
					}
				}
			}
		}
		if (flag)
		{
			setting.AddChangedListener(OnSettingChanged);
			UpdateVisible();
			Refresh();
			OnStart();
		}
		else
		{
			gameObject.SetActive(value: false);
			m_DependsOnSettings?.Clear();
		}
	}

	protected virtual void OnDestroy()
	{
		Setting?.RemoveChangedListener(OnSettingChanged);
	}

	private void UpdateVisible()
	{
		bool active = Setting?.Usable ?? false;
		gameObject.SetActive(active);
	}

	private void OnSettingChanged(TValue newValue)
	{
		Refresh();
	}

	protected virtual void Refresh()
	{
	}

	public void Init(string id, SettingCellBindings.DependsOn[] bindingDependsOnSettings)
	{
		m_Id = id;
		_dependsOn = bindingDependsOnSettings;
		OnInit();
	}

	protected virtual void OnInit()
	{
	}

	public string GetSettingsId()
	{
		return m_Id;
	}
}
