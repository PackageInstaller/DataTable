return {
  version = 1.0,
  ext = {ab_flag = "A"},
  dialog_infos = {
    {
      scene = "splash_wifi",
      title = "提示",
      message = "开始体验云游戏。\n您当前处于WIFI网络，已自动设置高清画质和流畅度。该体验非最终效果，下载后游戏体验更佳。\n\n体验过程中会下载约${remainBytes}M资源，祝您游戏愉快。",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "同意并试玩",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "2"
        }
      },
      desc = "WIFI闪屏"
    },
    {
      scene = "splash_4g_1",
      title = "您当前处于移动网络中",
      message = "体验云游戏，可快速了解游戏内容。\n已为您自动设置合适画质和流畅度，降低流量消耗。\n试玩每分钟消耗约10M流量，下载消耗约${remainBytes}M流量",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "试玩${remainPurePlayTimeMin}分钟，连接wifi时自动下载",
          type = "primary",
          index = "1"
        },
        {
          text = "继续下载",
          type = "normal",
          index = "2"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "3"
        }
      },
      desc = "4G闪屏，有剩余试玩时间"
    },
    {
      scene = "splash_4g_2",
      title = "您当前处于移动网络中",
      message = "继续下载预计会消耗（${remainBytes}M）流量",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "继续下载",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "2"
        }
      },
      desc = "4G闪屏，无剩余试玩时间"
    },
    {
      scene = "cloud_connect_failed",
      icon = "error",
      title = "云游戏连接失败",
      message = "可下载额外资源\n开启稳定优质的游戏体验",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "下载额外资源{$totalBytes}M",
          type = "primary",
          right_icon = "array",
          index = "1"
        },
        {
          text = "停止下载并退出",
          type = "normal",
          index = "2"
        }
      },
      desc = "连接云端失败"
    },
    {
      scene = "cloud_connect_failed_with_downloading",
      icon = "error",
      title = "云游戏连接失败",
      message = "正在下载额外资源(${stubRecvTotalBytes})\n下载完即可进行体验",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "重连游戏",
          type = "primary",
          index = "1"
        },
        {
          text = "停止下载",
          type = "normal",
          index = "2"
        }
      },
      data = {
        stubRecvTotalBytes = "正在进行资源检查..."
      },
      desc = "重连游戏"
    },
    {
      scene = "cloud_connect_failed_and_exit",
      icon = "error",
      title = "云游戏连接失败",
      message = "正在下载额外资源(${recvBytes}M/${totalBytes}M)\n下载完即可进行体验",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "重连游戏-失败"
    },
    {
      scene = "cloud_connect_failed_with_pkg_installed",
      title = "云游戏连接失败",
      message = "完整版已安装完成，游戏进度已同步",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "立即打开",
          type = "primary",
          index = "1"
        }
      },
      desc = "游戏连接失败-大包已安装"
    },
    {
      scene = "cloud_connect_failed_with_no_network",
      title = "云游戏连接失败",
      message = "当前网络不通，可尝试连接WiFi或4G网络后重试 （检测网络状态）",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重连游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "游戏连接失败-无网络"
    },
    {
      scene = "cloud_connect_failed_with_unknown_reason",
      title = "云游戏连接失败",
      message = "未知原因，请点击\"重连游戏\"重试",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重连游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "游戏连接失败-未知原因"
    },
    {
      scene = "memory_space_lower_1",
      icon = "warn",
      title = "空间存储不足",
      message = "本地客户端下载暂停\n待清理空间后自动恢复下载",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重试",
          type = "primary",
          index = "retry"
        }
      },
      desc = "连接云端失败-内存不足"
    },
    {
      scene = "exper_time_coming",
      icon = "warn",
      title = "云游戏即将结束",
      message = "试玩时间即将结束，还剩余${remainPlayTimeMin}分钟，请合理安排好您的游戏节奏。",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "知道了",
          type = "primary",
          index = "ok"
        }
      },
      desc = "试玩即将结束提示"
    },
    {
      scene = "memory_space_lower_2",
      icon = "warn",
      title = "空间存储不足",
      message = "本地客户端下载暂停\n待清理空间后自动恢复下载",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "知道了",
          type = "primary",
          index = "retry"
        }
      },
      desc = "下载场景"
    },
    {
      scene = "download_finish_1",
      icon = "success",
      title = "额外数据已下载完成",
      message = "点击确定会为您重新启动游戏，以获取更优质的游戏体验~",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "确定",
          type = "primary",
          index = "1"
        }
      },
      priority = "high"
    },
    {
      scene = "download_finish_2",
      icon = "success",
      title = "额外数据已下载完成",
      message = "重新登录即可享受更稳定优质的游戏体验",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重新登录",
          type = "primary",
          index = "1"
        },
        {
          text = "再体验30分钟",
          type = "normal",
          index = "2"
        }
      },
      priority = "high",
      desc = "下载场景-下载完成"
    },
    {
      scene = "more_exper_over",
      title = "云游戏${downloadCompleteRemainTimeMin}分钟体验已结束",
      message = "<p>感谢您的支持~<br/>重新登录即可享受更稳定优质以及更多的游戏功能</p><p style=\"font-size:12px; opacity: 0.7;\">（注：30秒后将自动重启升级体验） </p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重新登录",
          type = "primary",
          index = "1"
        }
      },
      desc = "下载场景-体验结束"
    },
    {
      scene = "network_error",
      title = "网络连接失败",
      message = "请更换网络后再次尝试",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "继续游戏",
          type = "primary",
          index = "2"
        }
      },
      desc = "网络异常"
    },
    {
      scene = "network_error_retry",
      icon = "error",
      title = "网络连接失败",
      message = "请更换网络后再次尝试",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "重试",
          type = "primary",
          index = "2"
        }
      },
      desc = "网络异常"
    },
    {
      scene = "on_cg_error",
      message = "<p>游戏连接异常，请稍后重试</p><br/><p>（资源下载进度：${downloadProgress}%）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "重试",
          type = "primary",
          index = "2"
        }
      },
      desc = "云游SDK错误"
    },
    {
      scene = "on_cg_error_kick_out",
      message = "<p>挂机太久，请重新进入游戏</p><br/><p>（资源下载进度：${downloadProgress}%）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "重新进入",
          type = "primary",
          index = "2"
        }
      },
      desc = "被踢出"
    },
    {
      scene = "network_weak",
      title = "当前网络环境不稳定",
      message = "<p>检查网络状态或下载资源完成后继续游戏</p><br/><p>（资源下载进度：${downloadProgress}%）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      desc = "网络异常-无法正常游戏"
    },
    {
      scene = "mobile_network_tips",
      icon = "pause",
      title = "已暂停下载",
      message = "您当前处于移动网络中\n继续下载预计会消耗（{$totalBytes}）流量",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "继续下载",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "1"
        }
      },
      desc = "切换网络弹窗"
    },
    {
      scene = "free_exper_time_over",
      title = "云游戏${purePlayTotalTimeMin}分钟体验已结束",
      message = "感谢您的支持~\n当前已下载进度（${recvBytes}M/${totalBytes}M），您可下载完成后重启即可",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "继续下载",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "1"
        }
      },
      desc = "纯试玩时长"
    },
    {
      scene = "download_exper_time_over",
      title = "云游戏${downloadAsPlayTotalTimeMinute}分钟体验已结束",
      message = "感谢您的支持~\n当前已下载进度（${stubRecvTotalBytes}），您可等待下载完成后登录即可",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "暂停下载并退出游戏",
          type = "normal",
          index = "1"
        }
      },
      data = {
        stubRecvTotalBytes = "正在进行资源检查..."
      },
      priority = "high",
      desc = "下载+试玩总时长"
    },
    {
      scene = "download_exper_time_over_counting",
      title = "云游戏${downloadAsPlayTotalTimeMinute}分钟体验已结束",
      message = "当前正在检查下载资源。请稍候…",
      canClose = false,
      btns = {
        {
          text = "暂停下载并退出游戏",
          type = "normal",
          index = "1"
        }
      },
      priority = "high",
      desc = "下载+试玩总时长"
    },
    {
      scene = "exper_time_over_with_download_finish",
      title = "云游戏体验时间已达${downloadAsPlayTotalTimeMinute}分钟上限",
      message = "<p>游戏已下载完额外资源<br/>重新登录即可享受更稳定丰富的游戏功能</p><p style=\"font-size:12px; opacity: 0.7;\">（注：30秒后将自动重启升级体验） </p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重新登录",
          type = "normal",
          index = "1"
        }
      },
      priority = "high",
      desc = "重连游戏-达到上限下载完成"
    },
    {
      scene = "resource_update_tips_1",
      icon = "arrowup",
      title = "检测到游戏资源有更新",
      message = "<p>更新完成后即可开启游戏之旅~</p><br/><p style=\"font-size:12px; opacity: 0.7;\">（${recvBytes}M/${totalBytes}M）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        }
      },
      desc = "资源更新"
    },
    {
      scene = "resource_update_tips_2",
      icon = "arrowup",
      title = "检测到游戏资源有更新",
      message = "<p>更新完成后即可开启游戏之旅~</p><br/><p style=\"font-size:12px; opacity: 0.7;\"> （${recvBytes}M/${totalBytes}M）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "快速游戏",
          type = "primary",
          index = "2"
        }
      },
      desc = "7_0-资源更新"
    },
    {
      scene = "game_res_checking",
      title = "资源更新检查中",
      message = "<p>资源检查需要一些时间，请稍后~</p>",
      canClose = false,
      refreshIntervalMills = -1,
      desc = "启动时检查资源耗时较长，显示此loading"
    },
    {
      scene = "exit_confirm",
      title = "确认要退出吗？",
      message = "免费云游资格将继续为您保留，期待下次相遇！",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "再玩一会",
          type = "primary",
          index = "2"
        }
      },
      desc = "确认退出"
    },
    {
      scene = "exit_confirm_with_download_finish",
      title = "确认要退出吗？",
      message = "已经为您准备好完整版本，您需要体验吗？",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "打开完整版",
          type = "primary",
          index = "2"
        }
      },
      desc = "确认退出"
    },
    {
      scene = "pkg_install_complete",
      message = "您已安装体验更好的官方完整版，并已为您同步游戏数据，是否打开？",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "继续游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "确认",
          type = "primary",
          index = "2"
        }
      },
      desc = "启动时--安装完成"
    },
    {
      scene = "pkg_install_complete_without_connect",
      message = "<p style=\"text-align: left\">当前游戏进度已同步至完整版，完整版可以获得更好的游戏体验</p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "立即打开",
          type = "primary",
          index = "2"
        }
      },
      priority = "high",
      desc = "安装完成，但是当前不是连接状态"
    },
    {
      scene = "time_end_with_installed",
      title = "免费时长已用完",
      message = "<p style=\"text-align: left\">当前游戏进度已同步至完整版，完整版可以获得更好的游戏体验</p>",
      canClose = false,
      refreshIntervalMills = -1,
      priority = "high",
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "立即打开",
          type = "primary",
          index = "2"
        }
      },
      desc = "试玩结束--安装完成"
    },
    {
      scene = "time_end_with_not_installed",
      title = "免费时长已用完",
      message = "下载官方完整版，可同步当前游戏进度。",
      canClose = false,
      refreshIntervalMills = -1,
      priority = "high",
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "前往下载",
          type = "primary",
          index = "2"
        }
      },
      desc = "试玩结束--未安装"
    },
    {
      scene = "time_coming_with_installed_tips",
      message = "免费游戏时长即将用完，完整版已准备好，并已同步游戏数据。",
      type = "tips",
      displayTime = 5,
      canClose = false,
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      },
      desc = "试玩即将到期--安装完成"
    },
    {
      scene = "time_coming_with_not_installed_tips",
      message = "免费游戏时长即将用完，下载官方完整版，可同步当前游戏进度。",
      type = "tips",
      displayTime = 5,
      canClose = false,
      btns = {
        {
          text = "前往下载",
          index = "1"
        }
      },
      desc = "试玩即将到期--未安装"
    },
    {
      scene = "pkg_installed_tips",
      type = "tips",
      canClose = false,
      displayTime = 5,
      message = "您已安装体验更好的官方完整版，并已为您同步游戏数据，是否打开？",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      }
    },
    {
      scene = "download_complete",
      type = "tips",
      canClose = true,
      displayTime = 10,
      message = "资源下载完毕，使用完整版会保留当前进度，同时获得更好体验",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      }
    },
    {
      scene = "exper_time_coming_tips_2",
      type = "tips",
      message = "云游戏模式还剩5分钟结束，请使用完整版继续游玩。",
      canClose = false,
      displayTime = 3,
      desc = "试玩即将结束提示，5分钟提示"
    },
    {
      scene = "play_time_over",
      type = "tips",
      canClose = true,
      displayTime = -1,
      message = "云游戏即将结束，倒计时${countDown}s后自动退出",
      btn_text = "立即打开",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      },
      ext_data = {countDown = 30}
    },
    {
      scene = "play_time_over_selfstart",
      type = "tips",
      canClose = true,
      displayTime = -1,
      message = "云游戏即将结束，倒计时${countDown}s后自动退出",
      ext_data = {countDown = 30}
    },
    {
      scene = "play_time_over_with_download_finish",
      type = "tips",
      canClose = true,
      displayTime = -1,
      message = "云游戏即将结束，完整版已同步当前游戏进度，${countDown}s 后自动打开完整版",
      btn_text = "立即打开",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      },
      ext_data = {countDown = 10}
    },
    {
      scene = "bluetooth_close_tips",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "关闭蓝牙和定位，可以获得更流畅的游戏体验"
    },
    {
      scene = "network_quality_low",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "当前网络不佳，手动降低画质可以获得更流畅的游戏体验"
    },
    {
      scene = "not_wifi_remain",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "当前为非Wi-Fi环境，请注意流量消耗"
    },
    {
      scene = "free_cg_tips",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "云游戏正在下载完整资源，请注意流量消耗"
    },
    {
      scene = "connect_fail_tips",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "连接失败，请检查网络状态后重试"
    },
    {
      scene = "start_download_wifi_tips",
      type = "tips",
      canClose = false,
      displayTime = 5,
      message = "官方边玩边下，无损游戏体验"
    },
    {
      scene = "start_download_mobile_tips",
      type = "tips",
      canClose = false,
      displayTime = 5,
      message = "正在使用流量下载，请注意消耗"
    }
  },
  dialog_infos_try_play = {
    {
      scene = "splash_wifi",
      title = "提示",
      message = "开始体验云游戏。\n您当前处于WIFI网络，已自动设置高清画质和流畅度。该体验非最终效果，下载后游戏体验更佳。\n\n体验过程中会下载约${remainBytes}M资源，祝您游戏愉快。",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "同意并试玩",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "2"
        }
      },
      desc = "WIFI闪屏"
    },
    {
      scene = "splash_4g_1",
      title = "您当前处于移动网络中",
      message = "体验云游戏，可快速了解游戏内容。\n已为您自动设置合适画质和流畅度，降低流量消耗。\n云游戏每分钟消耗约10M流量，下载消耗约${remainBytes}M流量",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "试玩${remainPurePlayTimeMin}分钟，连接wifi时自动下载",
          type = "primary",
          index = "1"
        },
        {
          text = "继续下载",
          type = "normal",
          index = "2"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "3"
        }
      },
      desc = "4G闪屏，有剩余试玩时间"
    },
    {
      scene = "splash_4g_2",
      title = "您当前处于移动网络中",
      message = "继续下载预计会消耗（${remainBytes}M）流量",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "继续下载",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "2"
        }
      },
      desc = "4G闪屏，无剩余试玩时间"
    },
    {
      scene = "cloud_connect_failed",
      icon = "error",
      title = "云游戏连接失败",
      message = "可下载额外资源\n开启稳定优质的游戏体验",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "下载额外资源{$totalBytes}M",
          type = "primary",
          right_icon = "array",
          index = "1"
        },
        {
          text = "停止下载并退出",
          type = "normal",
          index = "2"
        }
      },
      desc = "连接云端失败"
    },
    {
      scene = "cloud_connect_failed_with_downloading",
      icon = "error",
      title = "云游戏连接失败",
      message = "正在下载额外资源(${stubRecvTotalBytes})\n下载完即可进行体验",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "重连游戏",
          type = "primary",
          index = "1"
        },
        {
          text = "停止下载",
          type = "normal",
          index = "2"
        }
      },
      data = {
        stubRecvTotalBytes = "正在进行资源检查..."
      },
      desc = "重连游戏"
    },
    {
      scene = "cloud_connect_failed_and_exit",
      icon = "error",
      title = "云游戏连接失败",
      message = "正在下载额外资源(${recvBytes}M/${totalBytes}M)\n下载完即可进行体验",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "重连游戏-失败"
    },
    {
      scene = "memory_space_lower_1",
      icon = "warn",
      title = "空间存储不足",
      message = "本地客户端下载暂停\n待清理空间后自动恢复下载",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重试",
          type = "primary",
          index = "retry"
        }
      },
      desc = "连接云端失败-内存不足"
    },
    {
      scene = "exper_time_coming",
      icon = "warn",
      title = "试玩即将结束",
      message = "云游戏时间即将结束，还剩余${remainPlayTimeMin}分钟，请合理安排好您的游戏节奏。",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "知道了",
          type = "primary",
          index = "ok"
        }
      },
      desc = "试玩即将结束提示"
    },
    {
      scene = "memory_space_lower_2",
      icon = "warn",
      title = "空间存储不足",
      message = "本地客户端下载暂停\n待清理空间后自动恢复下载",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "知道了",
          type = "primary",
          index = "retry"
        }
      },
      desc = "下载场景"
    },
    {
      scene = "download_finish_1",
      icon = "success",
      title = "额外数据已下载完成",
      message = "点击确定会为您重新启动游戏，以获取更优质的游戏体验~",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "确定",
          type = "primary",
          index = "1"
        }
      },
      priority = "high"
    },
    {
      scene = "download_finish_2",
      icon = "success",
      title = "额外数据已下载完成",
      message = "重新登录即可享受更稳定优质的游戏体验",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重新登录",
          type = "primary",
          index = "1"
        },
        {
          text = "再体验30分钟",
          type = "normal",
          index = "2"
        }
      },
      priority = "high",
      desc = "下载场景-下载完成"
    },
    {
      scene = "more_exper_over",
      title = "云游戏${downloadCompleteRemainTimeMin}分钟体验已结束",
      message = "<p>感谢您的支持~<br/>重新登录即可享受更稳定优质以及更多的游戏功能</p><p style=\"font-size:12px; opacity: 0.7;\">（注：30秒后将自动重启升级体验） </p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重新登录",
          type = "primary",
          index = "1"
        }
      },
      desc = "下载场景-体验结束"
    },
    {
      scene = "network_error",
      title = "网络连接失败",
      message = "请更换网络后再次尝试",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "继续游戏",
          type = "primary",
          index = "2"
        }
      },
      desc = "网络异常"
    },
    {
      scene = "network_error_retry",
      icon = "error",
      title = "网络连接失败",
      message = "请更换网络后再次尝试",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "重试",
          type = "primary",
          index = "2"
        }
      },
      desc = "网络异常"
    },
    {
      scene = "on_cg_error",
      message = "<p>游戏连接异常，请稍后重试</p><br/><p>（资源下载进度：${downloadProgress}%）</p>'",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "重试",
          type = "primary",
          index = "2"
        }
      },
      desc = "云游SDK错误"
    },
    {
      scene = "on_cg_error_kick_out",
      message = "<p>挂机太久，请重新进入游戏</p><br/><p>（资源下载进度：${downloadProgress}%）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "重新进入",
          type = "primary",
          index = "2"
        }
      },
      desc = "被踢出"
    },
    {
      scene = "network_weak",
      title = "当前网络环境不稳定",
      message = "<p>检查网络状态或下载资源完成后继续游戏</p><br/><p>（资源下载进度：${downloadProgress}%）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      desc = "网络异常-无法正常游戏"
    },
    {
      scene = "mobile_network_tips",
      icon = "pause",
      title = "已暂停下载",
      message = "您当前处于移动网络中\n继续下载预计会消耗（{$totalBytes}）流量",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "继续下载",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "1"
        }
      },
      desc = "切换网络弹窗"
    },
    {
      scene = "free_exper_time_over",
      title = "云游戏${purePlayTotalTimeMin}分钟体验已结束",
      message = "感谢您的支持~\n当前已下载进度（${recvBytes}M/${totalBytes}M），您可下载完成后重启即可",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "继续下载",
          type = "primary",
          index = "1"
        },
        {
          text = "拒绝并退出",
          type = "normal",
          index = "1"
        }
      },
      desc = "纯试玩时长"
    },
    {
      scene = "download_exper_time_over",
      title = "云游戏${downloadAsPlayTotalTimeMinute}分钟体验已结束",
      message = "感谢您的支持~\n当前已下载进度（${stubRecvTotalBytes}），您可等待下载完成后登录即可",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "暂停下载并退出游戏",
          type = "normal",
          index = "1"
        }
      },
      data = {
        stubRecvTotalBytes = "正在进行资源检查..."
      },
      priority = "high",
      desc = "下载+试玩总时长"
    },
    {
      scene = "download_exper_time_over_counting",
      title = "云游戏${downloadAsPlayTotalTimeMinute}分钟体验已结束",
      message = "当前正在检查下载资源。请稍候…",
      canClose = false,
      btns = {
        {
          text = "暂停下载并退出游戏",
          type = "normal",
          index = "1"
        }
      },
      priority = "high",
      desc = "下载+试玩总时长"
    },
    {
      scene = "exper_time_over_with_download_finish",
      title = "云游戏体验时间已达${downloadAsPlayTotalTimeMinute}分钟上限",
      message = "<p>游戏已下载完额外资源<br/>重新登录即可享受更稳定丰富的游戏功能</p><p style=\"font-size:12px; opacity: 0.7;\">（注：30秒后将自动重启升级体验） </p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "重新登录",
          type = "normal",
          index = "1"
        }
      },
      priority = "high",
      desc = "重连游戏-达到上限下载完成"
    },
    {
      scene = "resource_update_tips_1",
      icon = "arrowup",
      title = "检测到游戏资源有更新",
      message = "<p>更新完成后即可开启游戏之旅~</p><br/><p style=\"font-size:12px; opacity: 0.7;\">（${recvBytes}M/${totalBytes}M）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        }
      },
      desc = "资源更新"
    },
    {
      scene = "resource_update_tips_2",
      icon = "arrowup",
      title = "检测到游戏资源有更新",
      message = "<p>更新完成后即可开启游戏之旅~</p><br/><p style=\"font-size:12px; opacity: 0.7;\"> （${recvBytes}M/${totalBytes}M）</p>",
      canClose = false,
      refreshIntervalMills = 500,
      btns = {
        {
          text = "快速游戏",
          type = "primary",
          index = "1"
        },
        {
          text = "退出游戏",
          type = "normal",
          index = "2"
        }
      },
      desc = "7_0-资源更新"
    },
    {
      scene = "game_res_checking",
      title = "资源更新检查中",
      message = "<p>资源检查需要一些时间，请稍后~</p>",
      canClose = false,
      refreshIntervalMills = -1,
      desc = "启动时检查资源耗时较长，显示此loading"
    },
    {
      scene = "exit_confirm",
      title = "确认要退出吗？",
      message = "免费云游资格将继续为您保留，期待下次相遇！",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "再玩一会",
          type = "primary",
          index = "2"
        }
      },
      desc = "确认退出"
    },
    {
      scene = "exit_confirm_with_download_finish",
      title = "确认要退出吗？",
      message = "已经为您准备好完整版本，您需要体验吗？",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "退出游戏",
          type = "normal",
          index = "1"
        },
        {
          text = "打开完整版",
          type = "primary",
          index = "2"
        }
      },
      desc = "确认退出"
    },
    {
      scene = "download_complete",
      type = "tips",
      canClose = true,
      displayTime = 10,
      message = "资源下载完毕，使用完整版会保留当前进度，同时获得更好体验",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      }
    },
    {
      scene = "exper_time_coming_tips_2",
      type = "tips",
      message = "云游戏试玩还剩5分钟结束，请使用完整版继续游玩。",
      canClose = false,
      displayTime = 3,
      desc = "试玩即将结束提示，5分钟提示"
    },
    {
      scene = "play_time_over",
      type = "tips",
      canClose = true,
      displayTime = -1,
      message = "云游戏即将结束，倒计时${countDown}s后自动退出",
      btn_text = "立即打开",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      },
      ext_data = {countDown = 30}
    },
    {
      scene = "play_time_over_selfstart",
      type = "tips",
      canClose = true,
      displayTime = -1,
      message = "云游戏即将结束，倒计时${countDown}s后自动退出",
      ext_data = {countDown = 30}
    },
    {
      scene = "play_time_over_with_download_finish",
      type = "tips",
      canClose = true,
      displayTime = -1,
      message = "云游戏即将结束，完整版已同步当前游戏进度，${countDown}s 后自动打开完整版",
      btn_text = "立即打开",
      btns = {
        {
          text = "立即打开",
          index = "1"
        }
      },
      ext_data = {countDown = 10}
    },
    {
      scene = "bluetooth_close_tips",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "关闭蓝牙和定位，可以获得更流畅的游戏体验"
    },
    {
      scene = "network_quality_low",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "当前网络不佳，手动降低画质可以获得更流畅的游戏体验"
    },
    {
      scene = "not_wifi_remain",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "当前为非Wi-Fi环境，请注意流量消耗"
    },
    {
      scene = "free_cg_tips",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "云游戏体验依赖于您的网络状态，不代表游戏最终品质"
    },
    {
      scene = "connect_fail_tips",
      type = "tips",
      canClose = false,
      displayTime = 3,
      message = "连接失败，请检查网络状态后重试"
    },
    {
      scene = "start_download_wifi_tips",
      type = "tips",
      canClose = false,
      displayTime = 5,
      message = "官方边玩边下，无损游戏体验"
    },
    {
      scene = "start_download_mobile_tips",
      type = "tips",
      canClose = false,
      displayTime = 5,
      message = "正在使用流量下载，请注意消耗"
    }
  }
}
