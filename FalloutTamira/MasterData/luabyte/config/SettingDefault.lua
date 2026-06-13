local SettingDefault = {}

ConfigHelper = require "Config.ConfigHelper"

local Voice =
{
    MainOpen = 1,--总开关
    BackGround = 1,--背景音效开关
    BackgroundValue = 100,--背景音效数值
    Sound = 1,--普通音效开关
    SoundValue = 100,--普通音效数值
    Speech = 1,--语音音效开关
    SpeechValue = 100,--语音音效数值
}


local Graphics =
{
    QualityLevel = 0,--high=0 medium=1 low =2
    TargetFrame = 60,--目标帧率
    BattleTargetFrame = 45,--目标帧率
    AntiAliasing = 4, --抗锯齿 4倍
    ScreenFit = 0, -- 异形屏适配
}

local Battle = 
{
    CameraActionWithClickActor = 1,--点击角色后的镜头效果
    OperationView = 0,--操作视角开关 open
    ShakeCamera = 1,--是否开启震屏
    SkillShow = 1,--是否开启技能表演
    CameraFocus = 1,--是否开启镜头聚焦
    MonsterSpawnShowHpBar = 0, --怪物入场显示血条
    ShowDeployAllways = 0 --永久显示上阵位
}

local Dorm =
{
    CabinEnterAnim = 1,--边仓入场动画。默认为开
    CabinCameraTrackIn = 1 --边仓镜头推进开关
}

SettingDefault.Voice = Voice
SettingDefault.Graphics = Graphics
SettingDefault.Battle = Battle
SettingDefault.Dorm = Dorm

return SettingDefault
