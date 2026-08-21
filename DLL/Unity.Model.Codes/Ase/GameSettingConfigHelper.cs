using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public static class GameSettingConfigHelper
{
	public class SettingData
	{
		public GameSettingConfig Config;

		public float Value;

		public bool Modifyed;

		public bool SwitchTag;

		private string remoteSettingKey;

		public SettingData(GameSettingConfig config)
		{
			Config = config;
			Value = config.DefaultValue;
			Modifyed = false;
			SwitchTag = config.DefaultSwitchTag;
			remoteSettingKey = string.Empty;
		}

		public void LoadCacheSetting()
		{
			if (!Config.RemoteSetting)
			{
				if (PlayerPrefs.HasKey(Config.Name))
				{
					Value = PlayerPrefs.GetFloat(Config.Name, Config.DefaultValue);
				}
				else
				{
					Value = Config.DefaultValue;
				}
				if (PlayerPrefs.HasKey(Config.Name + "_SwitchTag"))
				{
					SwitchTag = PlayerPrefs.GetInt(Config.Name + "_SwitchTag", Config.DefaultSwitchTag ? 1 : 0) > 0;
				}
			}
		}

		public void SaveCacheSetting()
		{
			if (Config.RemoteSetting)
			{
				if (string.IsNullOrEmpty(remoteSettingKey))
				{
					return;
				}
				PlayerPrefs.SetFloat(remoteSettingKey, Value);
				PlayerPrefs.SetInt(remoteSettingKey + "_SwitchTag", SwitchTag ? 1 : 0);
			}
			else
			{
				PlayerPrefs.SetFloat(Config.Name, Value);
				PlayerPrefs.SetInt(Config.Name + "_SwitchTag", SwitchTag ? 1 : 0);
			}
			Modifyed = false;
		}

		public void ResetSetting()
		{
			Value = Config.DefaultValue;
			SwitchTag = Config.DefaultSwitchTag;
			SaveCacheSetting();
		}

		public void SetValue(float value)
		{
			Value = value;
			Modifyed = true;
		}

		public void InitDefaultValue(float value)
		{
			Config.DefaultValue = value;
		}

		public void SetSwitchTag(bool switchTag)
		{
			SwitchTag = switchTag;
			Modifyed = true;
		}

		public void LoadRemoteSetting(long playerUid)
		{
			if (Config.RemoteSetting)
			{
				remoteSettingKey = "GameSettingData";
				if (playerUid != 0L)
				{
					remoteSettingKey += $"_{playerUid}_{Config.Name}";
				}
				if (PlayerPrefs.HasKey(remoteSettingKey))
				{
					Value = PlayerPrefs.GetFloat(remoteSettingKey, Config.DefaultValue);
				}
				else
				{
					Value = Config.DefaultValue;
				}
				if (PlayerPrefs.HasKey(remoteSettingKey + "_SwitchTag"))
				{
					SwitchTag = PlayerPrefs.GetInt(remoteSettingKey + "_SwitchTag", Config.DefaultSwitchTag ? 1 : 0) > 0;
				}
			}
		}
	}

	private const string PrefName = "GameSettingData";

	public const string MessageTag = "GameSetting_";

	public static Dictionary<string, GameSettingConfig> gameSettingConfigs = new Dictionary<string, GameSettingConfig>
	{
		["先行服资格"] = new GameSettingConfig("先行服资格", 0f, blockInBattle: true),
		["画质预设"] = new GameSettingConfig("画质预设", 1f, blockInBattle: true, remoteSetting: false, 0f, 2f),
		["帧率"] = new GameSettingConfig("帧率", 1f, blockInBattle: false, remoteSetting: false, 0f, 1f),
		["渲染精度"] = new GameSettingConfig("渲染精度", 2f, blockInBattle: false, remoteSetting: false, 0f, 3f),
		["分辨率"] = new GameSettingConfig("分辨率", 1f),
		["阴影"] = new GameSettingConfig("阴影", 1f),
		["特效等级"] = new GameSettingConfig("特效等级", 1f, blockInBattle: true),
		["抗锯齿"] = new GameSettingConfig("抗锯齿", 1f),
		["HDR"] = new GameSettingConfig("HDR", 1f),
		["Bloom"] = new GameSettingConfig("Bloom", 1f),
		["暗角"] = new GameSettingConfig("暗角", 1f),
		["主声音"] = new GameSettingConfig("主声音", 1f, blockInBattle: false, remoteSetting: false, 0f, 1f),
		["音乐音量"] = new GameSettingConfig("音乐音量", 1f, blockInBattle: false, remoteSetting: false, 0f, 1f),
		["音效音量"] = new GameSettingConfig("音效音量", 1f, blockInBattle: false, remoteSetting: false, 0f, 1f),
		["语音音量"] = new GameSettingConfig("语音音量", 1f, blockInBattle: false, remoteSetting: false, 0f, 1f),
		["语音语言"] = new GameSettingConfig("语音语言", 0f),
		["语言"] = new GameSettingConfig("语言", 0f),
		["角色震屏强度"] = new GameSettingConfig("角色震屏强度", 1f, blockInBattle: false, remoteSetting: false, 0f, 2f),
		["敌人震屏强度"] = new GameSettingConfig("敌人震屏强度", 1f, blockInBattle: false, remoteSetting: false, 0f, 2f),
		["伤害数字显示"] = new GameSettingConfig("伤害数字显示", 1f, blockInBattle: false, remoteSetting: true, 0f, 2f),
		["摄像机跟随"] = new GameSettingConfig("摄像机跟随", 1f, blockInBattle: false, remoteSetting: true),
		["队友技能特效强度"] = new GameSettingConfig("队友技能特效强度", 1f, blockInBattle: false, remoteSetting: true),
		["队友击中特效强度"] = new GameSettingConfig("队友击中特效强度", 0f, blockInBattle: false, remoteSetting: true),
		["自动锁定紫色武魂"] = new GameSettingConfig("自动锁定紫色武魂", 1f, blockInBattle: false, remoteSetting: true),
		["自动拒绝玩家邀请"] = new GameSettingConfig("自动拒绝玩家邀请", 0f, blockInBattle: false, remoteSetting: true),
		["自动拒绝好友申请"] = new GameSettingConfig("自动拒绝好友申请", 0f, blockInBattle: false, remoteSetting: true),
		["剧情自动"] = new GameSettingConfig("剧情自动", 0f, blockInBattle: false, remoteSetting: true),
		["剧情倍速"] = new GameSettingConfig("剧情倍速", 0f, blockInBattle: false, remoteSetting: true),
		["主播模式"] = new GameSettingConfig("主播模式", 0f),
		["幻衣特殊转场"] = new GameSettingConfig("幻衣特殊转场", 0f, blockInBattle: false, remoteSetting: false, 0f, 2f),
		["自动战斗时使用战斗道具"] = new GameSettingConfig("自动战斗时使用战斗道具", 0f, blockInBattle: true, remoteSetting: false, 0f, 1f),
		["沿用自动战斗设置"] = new GameSettingConfig("沿用自动战斗设置", 0f, blockInBattle: false, remoteSetting: false, 0f, 1f)
	};

	public static Dictionary<string, List<string>> SettingEnum = new Dictionary<string, List<string>>
	{
		[SettingTypeEnum.GraphicsSetting] = new List<string> { "画质预设", "帧率", "渲染精度", "分辨率", "阴影", "特效等级", "抗锯齿", "HDR", "Bloom", "暗角" },
		[SettingTypeEnum.AudioSetting] = new List<string> { "主声音", "音乐音量", "音效音量", "语音音量" },
		[SettingTypeEnum.CombatSetting] = new List<string>
		{
			"角色震屏强度", "敌人震屏强度", "技能拖拽灵敏度", "伤害数字显示", "队友战斗伤害数字", "队友技能特效", "摇杆设置", "目标锁定", "技能图标名称", "技能描述显示",
			"队友技能特效强度", "队友击中特效强度", "摄像机跟随"
		},
		[SettingTypeEnum.OtherSetting] = new List<string> { "自动锁定紫色武魂", "自动拒绝玩家邀请", "自动拒绝好友申请", "主播模式", "幻衣特殊转场", "自动战斗时使用战斗道具", "沿用自动战斗设置" },
		[SettingTypeEnum.AccountSetting] = new List<string> { "账号" }
	};

	public static Dictionary<string, List<float>> SettingEnumValues = new Dictionary<string, List<float>>
	{
		{
			"渲染精度",
			new List<float> { 0.5f, 0.8f, 1f, 1.2f }
		},
		{
			"阴影",
			new List<float> { 0f, 1024f, 2048f }
		},
		{
			"队友技能特效强度",
			new List<float> { 0f, 0.2f, 1f }
		},
		{
			"队友击中特效强度",
			new List<float> { 0f, 0.2f, 1f }
		}
	};

	public static Dictionary<string, SettingData> Settings = new Dictionary<string, SettingData>();

	public static bool GetStreamerMode()
	{
		if (GameEntry.BuiltinData.OpenTestFlight)
		{
			return true;
		}
		return GameEntry.Setting.GetBool("主播模式");
	}

	public static bool ShowStreamerModeUi()
	{
		return !GameEntry.BuiltinData.OpenTestFlight;
	}
}
