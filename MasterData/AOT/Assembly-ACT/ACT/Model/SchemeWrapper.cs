using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.Collections;
using Fundamental;
using Newtonsoft.Json;

namespace ACT.Model;

public class SchemeWrapper
{
	private const string _schemeConfigsPath = "CustomUISchemeConfigs";

	private AssetLoadHandle _schemeConfigsHandle;

	private Dictionary<int, CustomUIScheme> _fixedSchemes;

	private Dictionary<int, CustomUIScheme> _customPresetSchemes;

	private Dictionary<int, CustomUIScheme> _customSchemes;

	private Dictionary<int, CustomUIScheme> _deviceTypeSchemes;

	private List<int> _customSchemeIds;

	private CustomUISchemeConfigs _schemeConfigs;

	public CustomUIScheme CurScheme { get; private set; }

	public CustomUIStandard Standard { get; private set; }

	private bool IsPc => MonoECS.instance.ispc;

	public SchemeWrapper()
	{
		InitScheme();
	}

	private void InitScheme()
	{
		_schemeConfigsHandle = AssetStationManager.Root.Load<CustomUISchemeConfigs>("CustomUISchemeConfigs");
		_schemeConfigs = _schemeConfigsHandle.As<CustomUISchemeConfigs>();
		AssetStationManager.Root.Release(_schemeConfigsHandle);
		InitFixedScheme(_schemeConfigs);
		ChooseInitializeScheme(_schemeConfigs);
		Standard = new CustomUIStandard(_schemeConfigs.standardConfig);
		Model<CustomUIModel>.Interface.ChangeToTouchScreenScheme += () =>
		{
			if (!IsPc)
			{
				ChooseMoblieScheme();
				SendSchemeChangeEvent();
			}
		};
		Model<CustomUIModel>.Interface.ChangeToKeyBoardMouseScheme += () =>
		{
			if (IsPc)
			{
				ChooseCurDeviceScheme(211);
			}
			else if (MonoECS.instance.DeviceScreenType == ScreenSizeMode.LargeScreen)
			{
				ChooseCurDeviceScheme(212);
			}
			else
			{
				ChooseMoblieScheme();
			}
			SendSchemeChangeEvent();
		};
		Model<CustomUIModel>.Interface.ChangeToHandleScheme += () =>
		{
			int num = 0;
			if (IsPc)
			{
				num = 213;
			}
			else
			{
				ScreenSizeMode deviceScreenType = MonoECS.instance.DeviceScreenType;
				num = deviceScreenType switch
				{
					ScreenSizeMode.LargeScreen => 215, 
					ScreenSizeMode.SmallScreen => 214, 
				};
			}
			ChooseCurDeviceScheme(num);
			SendSchemeChangeEvent();
		};
	}

	private void InitFixedScheme(CustomUISchemeConfigs schemeConfigs)
	{
		_fixedSchemes = new Dictionary<int, CustomUIScheme>();
		if (IsPc)
		{
			_fixedSchemes[211] = new CustomUIScheme(schemeConfigs.schemeConfigs.Find((CustomUISchemeConfig _) => _.id == 211));
			_fixedSchemes[213] = new CustomUIScheme(schemeConfigs.schemeConfigs.Find((CustomUISchemeConfig _) => _.id == 213));
			return;
		}
		_fixedSchemes[212] = new CustomUIScheme(schemeConfigs.schemeConfigs.Find((CustomUISchemeConfig _) => _.id == 212));
		_fixedSchemes[215] = new CustomUIScheme(schemeConfigs.schemeConfigs.Find((CustomUISchemeConfig _) => _.id == 215));
		_fixedSchemes[214] = new CustomUIScheme(schemeConfigs.schemeConfigs.Find((CustomUISchemeConfig _) => _.id == 214));
		foreach (CustomUISchemeConfig schemeConfig in schemeConfigs.schemeConfigs)
		{
			if (DeviceCustomUISchemeId.IsValidMobileFixedId(schemeConfig.id))
			{
				_fixedSchemes[schemeConfig.id] = new CustomUIScheme(schemeConfig);
			}
		}
	}

	private void ChooseInitializeScheme(CustomUISchemeConfigs schemeConfigs)
	{
		DeviceInputMode inputMode = MonoECS.instance.InputMode;
		ScreenSizeMode deviceScreenType = MonoECS.instance.DeviceScreenType;
		if (!IsPc)
		{
			MobileInitSchemeConfigs(schemeConfigs);
			switch (inputMode)
			{
			case DeviceInputMode.KeyboardAndMouse:
				if (deviceScreenType == ScreenSizeMode.LargeScreen)
				{
					ChooseCurDeviceScheme(212);
				}
				else
				{
					ChooseMoblieScheme();
				}
				break;
			case DeviceInputMode.TouchScreen:
				ChooseMoblieScheme();
				break;
			case DeviceInputMode.Gamepad:
				ChooseCurDeviceScheme(deviceScreenType switch
				{
					ScreenSizeMode.SmallScreen => 214, 
					ScreenSizeMode.LargeScreen => 215, 
				});
				break;
			}
		}
		else
		{
			switch (inputMode)
			{
			case DeviceInputMode.TouchScreen:
			case DeviceInputMode.KeyboardAndMouse:
				ChooseCurDeviceScheme(211);
				break;
			case DeviceInputMode.Gamepad:
				ChooseCurDeviceScheme(213);
				break;
			}
		}
	}

	private void MobileInitSchemeConfigs(CustomUISchemeConfigs schemeConfigs)
	{
		_customPresetSchemes = new Dictionary<int, CustomUIScheme>();
		foreach (CustomUISchemeConfig schemeConfig in schemeConfigs.schemeConfigs)
		{
			if (DeviceCustomUISchemeId.IsValidMobileFixedId(schemeConfig.id))
			{
				int num = DeviceCustomUISchemeId.Fixed2DefaultCustomPreset(schemeConfig.id);
				_customPresetSchemes[num] = new CustomUIScheme(num, schemeConfig);
			}
		}
		_customSchemes = JsonConvert.DeserializeObject<Dictionary<int, CustomUIScheme>>(ServerPlayerPrefs.GetString("CUSTOMSCHEME")) ?? new Dictionary<int, CustomUIScheme>();
		BList<int> redundantId = BListPool<int>.Default.Get();
		DeviceCustomUISchemeId.GetRedundantMobileCustomId(_customSchemes.Keys, ref redundantId);
		foreach (int item2 in redundantId)
		{
			_customSchemes.Remove(item2);
		}
		_customSchemeIds = new List<int>();
		foreach (int item3 in JsonConvert.DeserializeObject<List<int>>(ServerPlayerPrefs.GetString("CUSTOMSCHEMEORDER")) ?? new List<int>())
		{
			if (_customSchemes.ContainsKey(item3))
			{
				_customSchemeIds.Add(item3);
			}
		}
		foreach (var (item, _) in _customSchemes)
		{
			if (!_customSchemeIds.Contains(item))
			{
				_customSchemeIds.Add(item);
			}
		}
	}

	private void ChooseCurDeviceScheme(int schemeId)
	{
		if (TryGetScheme(schemeId, out var scheme))
		{
			CurScheme = scheme;
		}
	}

	private void ChooseMoblieScheme()
	{
		SettingInt settingInt = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.BtnScheme");
		int value = settingInt.GetValue();
		if (DeviceCustomUISchemeId.IsValidMobileId(value) && TryGetScheme(value, out var scheme))
		{
			CurScheme = scheme;
			return;
		}
		int defaultMobileFixedId = DeviceCustomUISchemeId.GetDefaultMobileFixedId();
		CurScheme = _fixedSchemes[defaultMobileFixedId];
		settingInt.SetValue(defaultMobileFixedId);
	}

	public void UnInit()
	{
		_fixedSchemes = null;
		_customSchemes = null;
		_customPresetSchemes = null;
	}

	public bool TryGetScheme(int schemeId, out CustomUIScheme scheme)
	{
		if (_fixedSchemes.TryGetValue(schemeId, out var value))
		{
			scheme = value;
			return true;
		}
		if (_customPresetSchemes.TryGetValue(schemeId, out var value2))
		{
			scheme = value2;
			return true;
		}
		if (_customSchemes.TryGetValue(schemeId, out var value3))
		{
			scheme = value3;
			return true;
		}
		scheme = null;
		return false;
	}

	public void MobileSetCurScheme(int schemeId)
	{
		if (TryGetScheme(schemeId, out var scheme))
		{
			CurScheme = scheme;
			SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.BtnScheme").SetValue(schemeId);
			SendSchemeChangeEvent();
		}
	}

	private void SendSchemeChangeEvent()
	{
		UpdateCustomUISchemeEvt evt = Singleton<EventManager>.instance.GetEvt<UpdateCustomUISchemeEvt>();
		evt.scheme = CurScheme;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateCustomUIScheme, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void GetAllCustomSchemeId(out List<int> ids)
	{
		ids = new List<int>();
		foreach (int customSchemeId in _customSchemeIds)
		{
			ids.Add(customSchemeId);
		}
	}

	public int GetSchemeIdByIndex(int index)
	{
		GetAllCustomSchemeId(out var ids);
		if (index < 0 || index >= ids.Count)
		{
			return 0;
		}
		return ids[index];
	}

	public int GetIndexOfCurScheme()
	{
		GetAllCustomSchemeId(out var ids);
		return ids.IndexOf(CurScheme.Id);
	}

	public bool CanAddCustomScheme()
	{
		return _customSchemes.Count < Standard.CustomSchemeMaxNum;
	}

	public int GetCustomSchemeNum()
	{
		return _customSchemes.Count;
	}

	public void ModifyCustomScheme(CustomUISchemeModifyWrapper modifyWrapper)
	{
		if (_customSchemes.TryGetValue(modifyWrapper.SchemeId, out var value))
		{
			value.Modify(modifyWrapper);
			ServerSaveSchemes();
			MobileSetCurScheme(value.Id);
		}
	}

	public void RenameCustomScheme(int schemeId, string newName, Action onSucceed = null, Action onFilled = null)
	{
		if (!_customSchemes.TryGetValue(schemeId, out var value) || !value.CanRename)
		{
			onFilled?.Invoke();
			return;
		}
		string oldName = value.Name;
		value.Rename(newName);
		ServerSaveSchemes(onSucceed, () =>
		{
			RollbackSchemeName(schemeId, oldName, newName);
			onFilled?.Invoke();
		});
	}

	private void RollbackSchemeName(int schemeId, string oldName, string failedName)
	{
		if (_customSchemes.TryGetValue(schemeId, out var value) && !(value.Name != failedName))
		{
			value.Rename(oldName);
			SetServerSchemePrefs();
		}
	}

	public int AddCustomScheme(CustomUISchemeModifyWrapper modifyWrapper, string oldName = null, Action<int> onSucceed = null, Action<int> onFilled = null)
	{
		if (!CanAddCustomScheme())
		{
			return 0;
		}
		if (!TryGetScheme(modifyWrapper.SchemeId, out var scheme))
		{
			return 0;
		}
		int newId = GetId4AddCustom();
		if (newId == 0)
		{
			return 0;
		}
		CustomUIScheme customUIScheme = new CustomUIScheme(newId, modifyWrapper, scheme);
		_customSchemes.Add(newId, customUIScheme);
		_customSchemeIds.Insert(0, newId);
		string failedName = customUIScheme.Name;
		MobileSetCurScheme(newId);
		ServerSaveSchemes(() =>
		{
			onSucceed?.Invoke(newId);
		}, () =>
		{
			if (oldName != null)
			{
				RollbackSchemeName(newId, oldName, failedName);
			}
			onFilled?.Invoke(newId);
		});
		return newId;
	}

	private int GetId4AddCustom()
	{
		for (int i = 0; i < 4; i++)
		{
			int mobileCustomIdByIndex = DeviceCustomUISchemeId.GetMobileCustomIdByIndex(i);
			if (!_customSchemeIds.Contains(mobileCustomIdByIndex))
			{
				return mobileCustomIdByIndex;
			}
		}
		return 0;
	}

	public void DeleteCustomScheme(int id)
	{
		if (_customSchemes.TryGetValue(id, out var _))
		{
			bool num = CurScheme != null && CurScheme.Id == id;
			_customSchemes.Remove(id);
			_customSchemeIds.Remove(id);
			ServerSaveSchemes();
			if (num)
			{
				MobileSetCurScheme((_customSchemeIds.Count > 0) ? _customSchemeIds[0] : DeviceCustomUISchemeId.GetDefaultMobileFixedId());
			}
		}
	}

	private string GetCustomSchemeJson()
	{
		JsonSerializerSettings jsonSerializerSettings = new JsonSerializerSettings();
		jsonSerializerSettings.Converters.Add(new CustomUISchemeJsonConverter());
		jsonSerializerSettings.Converters.Add(new CustomUITransformJsonConverter());
		jsonSerializerSettings.Converters.Add(new CustomUISchemeDicJsonConverter());
		return JsonConvert.SerializeObject(_customSchemes, jsonSerializerSettings);
	}

	private void ServerSaveSchemes(Action onSucceed = null, Action onFilled = null)
	{
		if (!IsPc)
		{
			SetServerSchemePrefs();
			ServerPlayerPrefs.Save(onSucceed, onFilled);
		}
	}

	private void SetServerSchemePrefs()
	{
		ServerPlayerPrefs.SetString("CUSTOMSCHEME", GetCustomSchemeJson());
		ServerPlayerPrefs.SetString("CUSTOMSCHEMEORDER", JsonConvert.SerializeObject(_customSchemeIds));
	}
}
