using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct GameSettingKey
{
	public const string GraphicsSetting = "画质预设";

	public const string FrameRateLock = "帧率";

	public const string RenderAccuracy = "渲染精度";

	public const string Resolution = "分辨率";

	public const string Shadow = "阴影";

	public const string EffectLevel = "特效等级";

	public const string AntiAliasing = "抗锯齿";

	public const string HDR = "HDR";

	public const string Bloom = "Bloom";

	public const string Vignetting = "暗角";

	public const string MainVolume = "主声音";

	public const string MusicVolume = "音乐音量";

	public const string SoundVolume = "音效音量";

	public const string VoiceVolume = "语音音量";

	public const string AudioLanguage = "语音语言";

	public const string BattleCameraFollow = "摄像机跟随";

	public const string TeammateSkillEffectAlpha = "队友技能特效强度";

	public const string TeammateFitEffectAlpha = "队友击中特效强度";

	public const string SkillDragSensitivity = "技能拖拽灵敏度";

	public const string RoleShakeScreenSetting = "角色震屏强度";

	public const string EnemyShakeScreenSetting = "敌人震屏强度";

	public const string CombatDamageNumber = "伤害数字显示";

	public const string TeammateCombatDamageNumber = "队友战斗伤害数字";

	public const string TeammateSkillEffect = "队友技能特效";

	public const string RockerSetting = "摇杆设置";

	public const string TargetLocking = "目标锁定";

	public const string SkillIconName = "技能图标名称";

	public const string SkillDescDisplay = "技能描述显示";

	public const string PlayEffectPermissions = "播放特效权限";

	public const string LogEnable = "开启日志打印";

	public const string AutoLockPurpleWeapon = "自动锁定紫色武魂";

	public const string AutoRefusePlayerInvitation = "自动拒绝玩家邀请";

	public const string AutoRefuseFriendApplication = "自动拒绝好友申请";

	public const string VersionInfo = "版本信息";

	public const string PreServiceStatus = "先行服资格";

	public const string StreamerMode = "主播模式";

	public const string SkinTransitionAnimation = "幻衣特殊转场";

	public const string AutomaticBattleProp = "自动战斗时使用战斗道具";

	public const string AutomaticBattle = "沿用自动战斗设置";

	public const string Account = "账号";

	public const string Language = "语言";

	public const string StoryAutoSetting = "剧情自动";

	public const string StoryFastSetting = "剧情倍速";
}
