local E = require("Game.UI.Avg.AvgCmdEnum")
local P = require("Game.UI.Avg.AvgCmdParamOptionDefine")
local ST, BB, BT, CG, PM, GD, DP = E.ConfigType.ST, E.ConfigType.BB, E.ConfigType.BT, E.ConfigType.CG, E.ConfigType.PM, E.ConfigType.GD, E.ConfigType.DP
local stage, character, talk, phone, bubble, choice, audio, etc = E.Category.stage, E.Category.character, E.Category.talk, E.Category.phone, E.Category.bubble, E.Category.choice, E.Category.audio, E.Category.etc
local blue, gray, green, pink, purpel, white, yellow, cyan = E.BgColor.blue, E.BgColor.gray, E.BgColor.green, E.BgColor.pink, E.BgColor.purpel, E.BgColor.white, E.BgColor.yellow, E.BgColor.cyan
local bol, num, str = E.ParamType.bol, E.ParamType.num, E.ParamType.str
local ddIdx, ddVal, iptStr, iptNum, idChar, idContact, idRes = E.ParamInputType.ddIdx, E.ParamInputType.ddVal, E.ParamInputType.iptStr, E.ParamInputType.iptNum, E.ParamInputType.idChar, E.ParamInputType.idContact, E.ParamInputType.idRes
local AvgCmdDefine = {
  SetBg = {
    allow = {ST, CG},
    category = stage,
    color = gray,
    name = "切换背景",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Stages,
        nil
      },
      {
        str,
        "",
        idRes,
        "BgCgFgResName",
        "新图名字"
      },
      {
        str,
        "",
        idRes,
        "BgEffectResName",
        "旧图淡出效果图"
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        str,
        "",
        ddVal,
        "TransKeys",
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.BgFg,
        nil
      }
    }
  },
  CtrlBg = {
    allow = {ST, CG},
    category = stage,
    color = gray,
    name = "控制背景",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Stages,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "中心点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "中心点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "灰态"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "透明"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "明暗"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "模糊"
      },
      {
        str,
        "",
        ddVal,
        "BgShakeTypeKeys",
        nil
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.BgFg,
        nil
      }
    }
  },
  SetStage = {
    allow = {ST, CG},
    category = stage,
    color = blue,
    name = "设置舞台",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.SubStages,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.SubStageInOutAnim,
        nil
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  CtrlStage = {
    allow = {ST, CG},
    category = stage,
    color = blue,
    name = "控制舞台",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Stages,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "中心点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "中心点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "灰态"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "明暗"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "模糊"
      },
      {
        str,
        "",
        ddVal,
        "BgShakeTypeKeys",
        nil
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        num,
        0,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetFx = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = stage,
    color = gray,
    name = "舞台特效",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Stages,
        nil
      },
      {
        str,
        "",
        idRes,
        "FxNames",
        "特效资源名"
      },
      {
        num,
        0,
        ddIdx,
        P.NewDel,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.FxPos,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        bol,
        true,
        ddIdx,
        P.OnOffPP_,
        nil
      }
    }
  },
  SetFrontObj = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = stage,
    color = gray,
    name = "前景物件",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.NewDel,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.Mask_,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "图片名字"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetFilm = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = stage,
    color = gray,
    name = "电影模式",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.InOut,
        nil
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetTrans = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = stage,
    color = gray,
    name = "转场",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Trans,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.TransStyle,
        nil
      },
      {
        str,
        "",
        idRes,
        "BgEffectResName",
        "转场效果图"
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        bol,
        false,
        ddIdx,
        P.ClrChar,
        nil
      },
      {
        bol,
        false,
        ddIdx,
        P.ClrTalk,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        str,
        "",
        ddVal,
        "TransKeys",
        nil
      }
    }
  },
  SetHeartBeat = {
    allow = {ST, CG},
    category = stage,
    color = gray,
    name = "反色心跳",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Stages,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "中心点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "中心点Y"
      },
      {
        num,
        0.75,
        nil,
        nil,
        nil
      }
    }
  },
  SetPP = {
    allow = {ST, CG},
    category = stage,
    color = gray,
    name = "分镜后期",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.SubStages,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.OnOffPP,
        nil
      }
    }
  },
  SetPPGlobal = {
    allow = {ST, CG},
    category = stage,
    color = gray,
    name = "全局应用后期",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.PPApplyAll,
        nil
      }
    }
  },
  SetChar = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "设置角色",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.InOut,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.Stages,
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharEnterExitKeys",
        nil
      },
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "站位顺序"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "灰态"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "明暗"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "透明"
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "模糊"
      }
    }
  },
  CtrlChar = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "控制角色",
    preview = true,
    param = {
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "站位顺序"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "灰态"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "明暗"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "透明"
      },
      {
        str,
        "",
        ddVal,
        "CharShakeTypeKeys",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharFadeEft",
        nil
      },
      {
        str,
        "",
        ddVal,
        P.Eases,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.CharRot,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "Z轴转角"
      },
      {
        bol,
        false,
        ddIdx,
        P.ExitWileDone,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "模糊"
      }
    }
  },
  PlayCharAnim = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "角色动画",
    preview = true,
    param = {
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "动画名"
      },
      {
        bol,
        false,
        ddIdx,
        P.ExitWileDone,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetCharHead = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "设置头像框",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.InOut,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.CharHeadFramePos,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.CharHeadFrameBg,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "灰态"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "明暗"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "透明"
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "模糊"
      }
    }
  },
  CtrlCharHead = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "控制头像框",
    preview = true,
    param = {
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.CharHeadFrameBg,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetL2D = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "设置L2D",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.NewDel,
        nil
      },
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  CtrlL2D = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = character,
    color = purpel,
    name = "控制L2D",
    preview = false,
    param = {
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "动画名"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "角色语音"
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetTalk = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = talk,
    color = green,
    name = "对话",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.TalkType,
        nil
      },
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      },
      {
        num,
        1,
        ddIdx,
        P.ClrPageType,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "角色语音"
      },
      {
        bol,
        false,
        ddIdx,
        P.WaitAudioDone,
        nil
      }
    }
  },
  SetTalkShake = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = talk,
    color = green,
    name = "抖动对话框",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.TalkFrameType,
        nil
      },
      {
        str,
        "",
        ddVal,
        "BgShakeTypeKeys",
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetGoOn = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = talk,
    color = green,
    name = "续播对话",
    preview = false,
    param = {}
  },
  SetMainRoleTalk = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = talk,
    color = green,
    name = "主角说想-控制头像",
    preview = true,
    param = {
      {
        num,
        0,
        ddIdx,
        P.MainRoleHead,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.Mask,
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_1",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharShakeTypeKeys",
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        true,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetPhone = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = phone,
    color = cyan,
    name = "手机动画",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.PhoneAnim,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.ClrHistoryMsg,
        nil
      },
      {
        str,
        "",
        idContact,
        "AvgContacts",
        nil
      }
    }
  },
  SetPhoneMsg = {
    allow = {
      ST,
      BT,
      CG,
      PM,
      GD
    },
    category = phone,
    color = cyan,
    name = "手机消息",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.MsgType,
        nil
      },
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      },
      {
        str,
        "",
        ddIdx,
        P.PicEmoji,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "角色语音"
      },
      {
        bol,
        false,
        ddIdx,
        P.WaitAudioDone,
        nil
      }
    }
  },
  SetPhoneThinking = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = phone,
    color = cyan,
    name = "手机思考",
    preview = false,
    param = {
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      }
    }
  },
  SetPhoneMsgChoiceBegin = {
    allow = {
      ST,
      BT,
      CG,
      PM,
      GD
    },
    category = phone,
    color = cyan,
    name = "手机选项开始",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "选项 A 的内容..."
      },
      {
        str,
        "",
        iptStr,
        nil,
        "选项 B 的内容..."
      },
      {
        str,
        "",
        iptStr,
        nil,
        "选项 C 的内容..."
      }
    }
  },
  SetPhoneMsgChoiceEnd = {
    allow = {
      ST,
      BT,
      CG,
      PM,
      GD
    },
    category = phone,
    color = cyan,
    name = "手机选项结束",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      }
    }
  },
  SetPhoneMsgChoiceJumpTo = {
    allow = {
      ST,
      BT,
      CG,
      PM,
      GD
    },
    category = phone,
    color = cyan,
    name = "手机选项跳转",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "选项索引"
      }
    }
  },
  SetBubbleUIType = {
    allow = {BB},
    category = bubble,
    color = green,
    name = "气泡样式",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.BubbleType,
        nil
      }
    }
  },
  SetBubble = {
    allow = {BB},
    category = bubble,
    color = green,
    name = "气泡对话",
    preview = false,
    param = {
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      },
      {
        num,
        0,
        ddIdx,
        P.LR,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "角色语音名"
      }
    }
  },
  SetChoiceBegin = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "选项开始",
    preview = true,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      },
      {
        num,
        0,
        ddIdx,
        P.Mask_,
        nil
      },
      {
        {
          num,
          0,
          ddIdx,
          P.ChoiceVisible,
          nil
        },
        {
          num,
          0,
          ddIdx,
          P.ChoiceVisible,
          nil
        },
        {
          num,
          0,
          ddIdx,
          P.ChoiceVisible,
          nil
        },
        {
          num,
          0,
          ddIdx,
          P.ChoiceVisible,
          nil
        }
      },
      {
        {
          str,
          "",
          iptStr,
          nil,
          "选项 A 的内容..."
        },
        {
          str,
          "",
          iptStr,
          nil,
          "选项 B 的内容..."
        },
        {
          str,
          "",
          iptStr,
          nil,
          "选项 C 的内容..."
        },
        {
          str,
          "",
          iptStr,
          nil,
          "选项 D 的内容..."
        }
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceSide,
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceRole,
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      }
    }
  },
  SetChoiceJumpTo = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "选项跳转",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "选项索引"
      }
    }
  },
  SetChoiceRollback = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "选项返回",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceRet,
        nil
      }
    }
  },
  SetChoiceRollover = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "选项跳出",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      }
    }
  },
  SetChoiceEnd = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "选项结束",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      }
    }
  },
  SetMajorChoice = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "路线选项",
    preview = true,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "选项A图标"
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceBG,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "A标题"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "A描述"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "解锁条件Id"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "证据Id"
      },
      {
        num,
        0,
        ddIdx,
        P.ForceMajorDisable,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "选项B图标"
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceBG,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "B标题"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "B描述"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "解锁条件Id"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "证据Id"
      },
      {
        num,
        0,
        ddIdx,
        P.ForceMajorDisable,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "选项C图标"
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceBG,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "C标题"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "C描述"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "解锁条件Id"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "证据Id"
      },
      {
        num,
        0,
        ddIdx,
        P.ForceMajorDisable,
        nil
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "语音资源"
      }
    }
  },
  SetMajorChoiceJumpTo = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "路线选项跳转",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "选项索引"
      }
    }
  },
  SetMajorChoiceRollover = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "路线选项跳出",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      }
    }
  },
  SetMajorChoiceEnd = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "路线选项结束",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      }
    }
  },
  SetPersonalityChoice = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "性格选项",
    preview = true,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "倍率系数"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "直觉选项的行为文字"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "分析选项的行为文字"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "混沌选项的行为文字"
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        str,
        "",
        ddVal,
        "CharEmoji",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "说话内容"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "语音资源"
      }
    }
  },
  SetPersonalityChoiceJumpTo = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "性格选项跳转",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "选项索引"
      }
    }
  },
  SetPersonalityChoiceRollover = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "性格选项跳出",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      }
    }
  },
  SetPersonalityChoiceEnd = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "性格选项结束",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "组Id"
      }
    }
  },
  IfTrue = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "如果",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "'如果'指令的组Id"
      },
      {
        num,
        0,
        ddIdx,
        P.ChoiceMP,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "演出配置AvgId"
      },
      {
        num,
        0,
        iptNum,
        nil,
        "选项的组Id"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "最近一次选择"
      }
    }
  },
  EndIf = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = choice,
    color = yellow,
    name = "结束如果",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "'如果'指令的组Id"
      }
    }
  },
  SetAudio = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = audio,
    color = pink,
    name = "音效",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.Audio,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "音效名"
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        false,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetBGM = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = audio,
    color = pink,
    name = "BGM",
    preview = false,
    param = {
      {
        num,
        0,
        ddIdx,
        P.BGM_Play,
        nil
      },
      {
        str,
        "",
        ddVal,
        "BgmVol",
        nil
      },
      {
        num,
        0,
        ddIdx,
        P.BGM_Track,
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "BGM"
      },
      {
        str,
        "",
        ddVal,
        P.BgmFadeTime,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        false,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetSceneHeading = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = etc,
    color = gray,
    name = "时间地点",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "时间"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "月份"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "日期"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "主要地点"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "次要地点"
      }
    }
  },
  Wait = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = etc,
    color = gray,
    name = "等待",
    preview = false,
    param = {
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      }
    }
  },
  Jump = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = etc,
    color = gray,
    name = "跳转",
    preview = false,
    param = {
      {
        num,
        0,
        iptNum,
        nil,
        "跳转至id"
      }
    }
  },
  Clear = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = etc,
    color = gray,
    name = "清场",
    preview = false,
    param = {
      {
        bol,
        false,
        ddIdx,
        P.ClrChar,
        nil
      },
      {
        num,
        1,
        iptNum,
        nil,
        "耗时"
      },
      {
        bol,
        false,
        ddIdx,
        P.ClrTalk,
        nil
      },
      {
        bol,
        false,
        ddIdx,
        P.Wait,
        nil
      }
    }
  },
  SetGroupId = {
    allow = {
      BB,
      PM,
      DP
    },
    category = bubble,
    color = green,
    name = "气泡组",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "组Id"
      }
    }
  },
  SetIntro = {
    allow = {
      ST,
      BT,
      CG
    },
    category = etc,
    color = gray,
    name = "设置梗概",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "图标资源名"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "标题：第一话"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "名字：邂逅"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "梗概内容"
      }
    }
  },
  JUMP_AVG_ID = {
    allow = {
      ST,
      BT,
      CG
    },
    category = etc,
    color = gray,
    name = "AVG ID跳转",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "跳转至 AVG Id"
      },
      {
        num,
        1,
        iptNum,
        nil,
        "跳转至指令 Id"
      }
    }
  },
  NewCharIntro = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = etc,
    color = gray,
    name = "新角登场",
    preview = false,
    param = {
      {
        str,
        "",
        idChar,
        "AvgCharacter",
        nil
      },
      {
        str,
        "",
        iptStr,
        nil,
        "名字"
      },
      {
        str,
        "",
        iptStr,
        nil,
        "称号"
      },
      {
        str,
        "",
        ddVal,
        "CharPose_0",
        nil
      },
      {
        str,
        "002",
        iptStr,
        nil,
        "脸"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点X"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "坐标点Y"
      },
      {
        num,
        nil,
        iptNum,
        nil,
        "缩放"
      },
      {
        num,
        0,
        ddIdx,
        P.NewCharAnim,
        nil
      }
    }
  },
  Comment = {
    allow = {
      ST,
      BT,
      CG,
      GD
    },
    category = etc,
    color = gray,
    name = "备注",
    preview = false,
    param = {
      {
        str,
        "",
        iptStr,
        nil,
        "备注内容"
      }
    }
  },
  End = {
    allow = {
      ST,
      BB,
      BT,
      CG,
      PM,
      GD
    },
    category = etc,
    color = gray,
    name = "<color=red>结束</color>",
    preview = false
  }
}
local bLog = false
local num_Params, num_ddIdx, num_ddVal, num_iptStr, num_iptNum, num_idChar, num_idContact, num_idRes, sCmdName = 0, 0, 0, 0, 0, 0, 0, 0
for k, v in pairs(AvgCmdDefine) do
  local tbParam = v.param
  if tbParam ~= nil then
    local n = #tbParam
    if num_Params < n then
      sCmdName = k
      num_Params = n
    end
    local n_ddIdx, n_ddVal, n_iptStr, n_iptNum, n_idChar, n_idContact, n_idRes = 0, 0, 0, 0, 0, 0, 0
    for ii, vv in ipairs(tbParam) do
      if vv[3] == ddIdx then
        n_ddIdx = n_ddIdx + 1
        if num_ddIdx < n_ddIdx then
          num_ddIdx = n_ddIdx
        end
      elseif vv[3] == ddVal then
        n_ddVal = n_ddVal + 1
        if num_ddVal < n_ddVal then
          num_ddVal = n_ddVal
        end
      elseif vv[3] == iptStr then
        n_iptStr = n_iptStr + 1
        if num_iptStr < n_iptStr then
          num_iptStr = n_iptStr
        end
      elseif vv[3] == iptNum then
        n_iptNum = n_iptNum + 1
        if num_iptNum < n_iptNum then
          num_iptNum = n_iptNum
        end
      elseif vv[3] == idChar then
        n_idChar = n_idChar + 1
        if num_idChar < n_idChar then
          num_idChar = n_idChar
        end
      elseif vv[3] == idContact then
        n_idContact = n_idContact + 1
        if num_idContact < n_idContact then
          num_idContact = n_idContact
        end
      elseif vv[3] == idRes then
        n_idRes = n_idRes + 1
        if num_idRes < n_idRes then
          num_idRes = n_idRes
        end
      end
      if #vv > 5 and bLog == true then
        print("指令参数的描述超过4项 " .. k .. " " .. ii)
      end
    end
  end
end
if bLog == true then
  print(string.format("所有指令中，参数最多的指令是：%s，参数有：%s个", sCmdName, num_Params))
  print("ddIdx 类参数在一个指令中最多出现个数：" .. tostring(num_ddIdx))
  print("ddVal 类参数在一个指令中最多出现个数：" .. tostring(num_ddVal))
  print("iptStr 类参数在一个指令中最多出现个数：" .. tostring(num_iptStr))
  print("iptNum 类参数在一个指令中最多出现个数：" .. tostring(num_iptNum))
  print("idChar 类参数在一个指令中最多出现个数：" .. tostring(num_idChar))
  print("idRes 类参数在一个指令中最多出现个数：" .. tostring(num_idRes))
end
return AvgCmdDefine, {
  num_ddIdx,
  num_ddVal,
  num_iptStr,
  num_iptNum,
  num_idChar,
  num_idContact,
  num_idRes
}
