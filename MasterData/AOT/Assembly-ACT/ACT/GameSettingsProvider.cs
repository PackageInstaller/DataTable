using ACT.Battle;
using UnityEngine;

namespace ACT;

[CreateAssetMenu(fileName = "GameSettingsProvider", menuName = "ACT/Settings/SettingsProvider")]
public class GameSettingsProvider : ScriptableObject
{
	public string SavingKey;

	public GameSettingsSaver SettingsSaver;

	public bool AutoSaveOnQuit;

	[SerializeField]
	private GameSettings[] _settingsAssets;

	internal bool ShouldInitializeFromDeviceGrade
	{
		get
		{
			if (SettingsSaver == null)
			{
				return false;
			}
			return !SettingsSaver.HasSavedData(SavingKey);
		}
	}

	internal bool ShouldResetEditorLocalSettings => false;

	public SerializedSettingsData Load()
	{
		return SettingsSaver.Load(SavingKey);
	}

	public GameSettings? GetPlatformSettingsAsset(out SettingUsage usage)
	{
		usage = GetPlatformSettingUsage();
		return FindSettingAsset(usage);
	}

	private SettingUsage GetPlatformSettingUsage()
	{
		if (MonoECS.instance.ispc)
		{
			return SettingUsage.PC;
		}
		return Application.platform switch
		{
			RuntimePlatform.IPhonePlayer => SettingUsage.iOS, 
			_ => SettingUsage.Android, 
		};
	}

	internal bool TryGetEditorDeviceGradeSimulation(out SettingUsage usage, out string graphicsDeviceName)
	{
		usage = SettingUsage.Common;
		graphicsDeviceName = string.Empty;
		return false;
	}

	private GameSettings? FindSettingAsset(SettingUsage usage)
	{
		GameSettings[] settingsAssets = _settingsAssets;
		foreach (GameSettings gameSettings in settingsAssets)
		{
			if (gameSettings.IsMatchUsage(usage))
			{
				return gameSettings;
			}
		}
		return null;
	}
}
