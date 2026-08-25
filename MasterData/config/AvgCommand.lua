local System = require("System.System")
local readonly = System.readonly
local AvgCommand = readonly({
  Delay = {
    Command = "Delay",
    Arg1Desc = "延迟时间 秒"
  },
  ChangeBg = {
    Command = "ChangeBg",
    Arg1Desc = "背景ID",
    Arg2Desc = "切换方式"
  },
  PlayAudio = {
    Command = "PlayAudio",
    Arg1Desc = "wwise音频事件(@杨天暘)"
  },
  BgTransition = {
    Command = "BgTransition",
    Arg1Desc = "转场动画Id"
  },
  HideRole = {Command = "HideRole", Arg1Desc = "角色名"},
  SetRole = {
    Command = "SetRole",
    Arg1Desc = "角色名",
    Arg2Desc = "立绘位置"
  },
  RoleHurt = {Command = "RoleHurt"},
  PlayVideo = {
    Command = "PlayVideo",
    Arg1Desc = "视频url",
    Arg2Desc = "字幕配置"
  },
  VideoPlay = {
    Command = "VideoPlay",
    Arg1Desc = "视频url",
    Arg2Desc = "字幕配置"
  },
  VideoFrame = {
    Command = "VideoFrame",
    Arg1Desc = "视频url",
    Arg2Desc = "时间A",
    Arg3Desc = "时间B"
  },
  VideoLoop = {
    Command = "VideoLoop",
    Arg1Desc = "视频url",
    Arg2Desc = "时间A",
    Arg3Desc = "时间B",
    Arg4Desc = "字幕配置"
  },
  Keep = {Command = "Keep"},
  KeepPre = {Command = "KeepPre"},
  ["快速字幕"] = {
    Command = "快速字幕"
  },
  ["中速字幕"] = {
    Command = "中速字幕"
  },
  ["慢速字幕"] = {
    Command = "慢速字幕"
  },
  ["循环选项结束"] = {
    Command = "循环选项结束",
    Arg1Desc = "chatId"
  },
  ["不可跳过选项"] = {
    Command = "不可跳过选项"
  },
  ["结束过渡"] = {
    Command = "结束过渡"
  },
  ["背景缩放"] = {
    Command = "背景缩放"
  },
  ["替换背景"] = {
    Command = "替换背景",
    Arg1Desc = "男/女",
    Arg2Desc = "替换内容"
  },
  ["替换动画"] = {
    Command = "替换动画",
    Arg1Desc = "男/女",
    Arg2Desc = "替换内容"
  },
  ["替换结尾动画"] = {
    Command = "替换结尾动画",
    Arg1Desc = "男/女",
    Arg2Desc = "替换内容"
  },
  ["替换视频"] = {
    Command = "替换视频",
    Arg1Desc = "男/女",
    Arg2Desc = "替换内容"
  },
  ["重置选项"] = {
    Command = "重置选项"
  }
})
return AvgCommand
