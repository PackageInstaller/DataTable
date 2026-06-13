local SettingConst = {}

ConfigHelper = require "Config.ConfigHelper"

local SettingTabType=
{
    Voice = 1,
    Graphic = 2,
    Battle = 3,
    Dorm =4,
    CV=5,
    Account=6
}

local Tab = {
    Voice = {
        Index = SettingTabType.Voice,
        --labels = ConfigHelper.GetLocalString(277)
    },
    Graphic = {
        Index = SettingTabType.Graphic,
        --labels = ConfigHelper.GetLocalString(278)
    },
    Battle = {
        Index = SettingTabType.Battle,
        --labels = ConfigHelper.GetLocalString(279)
    },
    Dorm = {
        Index = SettingTabType.Dorm,
        --labels = ConfigHelper.GetLocalString(280)
    },
    CV = {
        Index = SettingTabType.CV,
        --labels = ConfigHelper.GetLocalString(280)
    }
}

local Voice =
{
    MainOpen = "voice_open",--总开关
    BackGround = "voice_bg",--背景音效开关
    BackgroundValue = "voice_bg_value",--背景音效数值
    Sound = "voice_sound",--普通音效开关
    SoundValue = "voice_sound_value",--普通音效数值
    Speech = "voice_speech",--语音音效开关
    SpeechValue = "voice_speech_value",--语音音效数值
}



local Graphics =
{
    QualityLevel = "quality_level",--high=0 medium=1 low =2
    TargetFrame = "target_frame",--目标帧率
    BattleTargetFrame = "battle_target_frame",--目标帧率
    AntiAliasing  ="anti_aliasing", --抗锯齿 Open
    ScreenFit = "screen_fit", -- 异形屏适配
}

local Battle = 
{
    OperationView = "operation_view",--操作视角开关 open
    ShakeCamera = "shake_camera",--是否开启震屏
    SkillShow = "skill_show",--是否开启技能表演
    CameraFocus = "camera_focus",--是否开启镜头聚焦
    MonsterSpawnShowHpBar = "monster_spawnshowhp", --怪物入场显示血条
    ShowDeployAllways = "show_deploy_allways" --永久显示推荐上阵位
}

local Dorm =
{
    CabinEnterAnim = "cabin_enter_anim",--边仓入场动画。默认为开
    CabinCameraTrackIn = "cabin_camera_trackIn" --边仓镜头推进开关
}

SettingConst.SettingTabType = SettingTabType
SettingConst.Tab = Tab
SettingConst.Voice = Voice
SettingConst.Graphics = Graphics
SettingConst.Battle = Battle
SettingConst.Dorm = Dorm

return SettingConst
