return {
  version = 1.0,
  dialog_infos = {
    {
      scene = "user_auth",
      title = "领取流量",
      message = "<p>为您赠送【${dataPkgName}】，<span style=\"color:red\">领取后即可享受游戏app内免流量体验（含下载）。</p><p style=\"text-align: left; margin: 10px 0 6px 0;\">当前入网手机号：</p><p style=\"font-weight: bold; font-size: 20px\">${phoneMask}</p>",
      canClose = true,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "确认领取流量",
          type = "primary",
          index = "1"
        }
      },
      desc = "领取流量包"
    },
    {
      scene = "loading",
      title = "",
      message = "<div class='loadEffect'><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>领取流量中…请耐心等待，约2s-60s左右",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "后台等待，继续游戏",
          type = "normal",
          index = "1"
        }
      },
      desc = "等待领取流量包结果"
    },
    {
      scene = "receive_success",
      title = "领取流量成功",
      message = "<i class=\"icon success\" style=\"width:40px; height:40px; margin: 0 auto 10px;\"></i><p>领取免费流量套餐【${dataPkgName}】成功，稍后可查收套餐短信。<span style=\"color:red\">免流服务已即时生效</span>。</p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "开始免流量体验",
          type = "primary",
          index = "1"
        }
      },
      desc = "领取流量成功"
    },
    {
      scene = "receive_fail_1",
      title = "领取失败",
      message = "<i class=\"icon error\" style=\"width:40px; height:40px; margin: 0 auto 10px;\"></i><p>抱歉，本次流量套餐【${dataPkgName}】领取失败。请查询该手机号码的运营状态。</p>",
      canClose = false,
      canBack = true,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "开始游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "领取失败"
    },
    {
      scene = "receive_fail_2",
      title = "领取失败",
      message = "<i class=\"icon error\" style=\"width:40px; height:40px; margin: 0 auto 10px;\"></i><p>抱歉，本次流量套餐【${dataPkgName}】领取失败。</p>",
      canClose = false,
      canBack = true,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "开始游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "领取失败"
    },
    {
      scene = "already_receive",
      title = "领取失败",
      message = "<i class=\"icon error\" style=\"width:40px; height:40px; margin: 0 auto 10px;\"></i><p>该灵犀账号已领取过一次，不可重复领取~</p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "开始游戏",
          type = "primary",
          index = "1"
        }
      },
      desc = "领取失败"
    },
    {
      scene = "switch_free_flow",
      title = "免流模式已开启",
      message = "已为您自动设置合适画质和码率。下载完游戏资源后，还可享受原生游戏体验。",
      canClose = false,
      refreshIntervalMills = -1,
      desc = "开启免流模式"
    },
    {
      scene = "switch_pay_flow",
      title = "非免流量模式",
      message = "已为您自动设置合适画质和码率。",
      canClose = false,
      refreshIntervalMills = -1,
      desc = "非免流模式"
    },
    {
      scene = "splash_4g_ctcc",
      title = "您当前处于移动网络中",
      message = "<p>欢迎体验极速版，已为您自动设置合适画质和码率。</p><p><span style=\"color:red\">登录游戏后，您可领取游戏专属流量包，</span>免费畅玩极速版，并在下载完游戏资源后，享受原生体验。</p>",
      canClose = false,
      refreshIntervalMills = -1,
      btns = {
        {
          text = "前往登录",
          type = "primary",
          index = "1"
        }
      },
      desc = "中国电信闪屏"
    }
  }
}
