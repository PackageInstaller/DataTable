local JumpConst = {}

--UI
JumpConst["OpenComRoomUI"] = require "JumpCommand.UI.OpenComRoomUI"                                 --打开通讯室（卡笔）
JumpConst["OpenDormitorySelectPopup"] = require "JumpCommand.UI.OpenDormitorySelectPopup"           --打开宿舍(阿乐)
JumpConst["OpenTaskUI"] = require "JumpCommand.UI.OpenTaskUI"                                       --打开任务界面  （卡笔）
JumpConst["OpenDailyGoals"] = require "JumpCommand.UI.OpenDailyGoals"                               --打开七日特派 （梁仔）
JumpConst["OpenUIVoting"] = require "JumpCommand.UI.OpenUIVoting"                                   --打开正式战员选拔活动 （小威）
JumpConst["OpenTeamConfigUI"] = require "JumpCommand.UI.OpenTeamConfigUI"                           --打开编队界面(花)
JumpConst["OpenChapterSelection"] = require "JumpCommand.UI.OpenChapterSelection"                   --打开战役章节选择界面（火哥）
JumpConst["OpenBag"] = require "JumpCommand.UI.OpenBag"                                             --打开仓库 （卡笔）
JumpConst["OpenWishjourneyUI"] = require "JumpCommand.UI.OpenWishjourneyUI"                         --打开远征界面ui（火哥）
JumpConst["OpenPassUI"] = require("JumpCommand.UI.OpenPassUI")                                      --打开通行证（卡笔）
JumpConst["OpenCurrencyExchangeUI"] = require("JumpCommand.UI.OpenCurrencyExchangeUI")              --打开星斯石兑换(卡笔)
JumpConst["OpenPersonalCopy"] = require "JumpCommand.UI.OpenPersonalCopy"                           --打开个人副本ui（火哥）
JumpConst["OpenBridgeCmdSkill"] = require "JumpCommand.UI.OpenBridgeCmdSkill"                       --打开支援技能
JumpConst["OpenEnergyUI"] = require "JumpCommand.UI.OpenComPopupEnergy"                             --打开体力面板（火哥）
JumpConst["OpenOtakuSynthesis"] = require "JumpCommand.UI.OpenOtakuSynthesisUI"                     --打开合成面板（火哥）
JumpConst["OpenOtakuExpedition"] = require "JumpCommand.UI.OpenWishjourneyUI"                       --打开调查面板（火哥）
JumpConst["OpenFirstRecharge"] = require "JumpCommand.UI.OpenFirstRecharge"                         --打开首充界面
JumpConst["OpenAchievement"] = require "JumpCommand.UI.OpenAchievement"                             -- 成就(五六七)
JumpConst["OpenFriend"] = require "JumpCommand.UI.OpenFriend"                                       -- 好友(五六七)
JumpConst["OpenNotice"] = require "JumpCommand.UI.OpenNotice"                                       -- 打开通用公告
JumpConst["OpenNoticePopup"] = require "JumpCommand.UI.OpenNoticePopup"                             -- 打开展示公告
JumpConst["OpenMonthSignPopup"] = require "JumpCommand.UI.OpenMonthSignPopup"                       -- 主动弹出月签到
JumpConst["OpenMonthSignUI"] = require "JumpCommand.UI.OpenMonthSignUI"                             -- 手动打开月签到
JumpConst["OpenLoginReward"] = require "JumpCommand.UI.OpenLoginReward"                             -- 主动弹出七日登陆
JumpConst["OpenMasqueradeUI"] = require "JumpCommand.UI.OpenMasqueradeUI"                           -- 打开假面舞会
JumpConst["OpenBossWarMainUI"] = require "JumpCommand.UI.OpenBossWarMainUI"                         -- 打开Boss战主界面
JumpConst["OpenMailUI"] = require "JumpCommand.UI.OpenMail"                                         -- 打开邮件
JumpConst["OpeKitChen"] = require "JumpCommand.UI.OpeKitChen"                                       -- 打开厨房
JumpConst["OpenRestaurant"] = require "JumpCommand.UI.OpenRestaurant"                               -- 餐厅 （小威）
JumpConst["OpenActivityUI"] = require "JumpCommand.UI.OpenActivityUI"                               -- 打开活动
JumpConst["UseItem"] = {}                                                                           -- 使用道具（占位），不跳转
--Module
JumpConst["OpenMainScene"] = require "JumpCommand.Module.OpenMainScene"                             --打开主界面(卡笔）
JumpConst["OpenOtakuMain"] = require "JumpCommand.Module.OpenOtakuMain"                             --舰桥主界面(阿乐)
JumpConst["OpenStage"] = require "JumpCommand.Module.OpenStage"                                     --关卡(火哥)
JumpConst["OpenOtakuBridge"] = require "JumpCommand.Module.OpenOtakuBridge"                         --舰桥(阿乐)
JumpConst["OpenOtakuManufacturingCabin"] = require "JumpCommand.Module.OpenOtakuManufacturingCabin" --制造仓(阿乐)
JumpConst["OpenLottery"] = require "JumpCommand.Module.OpenLottery"                                 --抽卡(花)
JumpConst["OpenLuckDraw"] = require "JumpCommand.Module.OpenLuckDraw"                               --礼物抽卡(花)
JumpConst["OpenTrainingHero"] = require "JumpCommand.Module.OpenTrainingHero"                       --战员列表界面(花)
JumpConst["OpenShopUI"] = require "JumpCommand.UI.OpenShopUI" 
JumpConst["OpenMainFirstRecharge"] = require "JumpCommand.UI.OpenMainFirstRecharge"
JumpConst["OpenPlotReviewList"] = require "JumpCommand.UI.OpenPlotReviewList"                       --打开图鉴中剧情详情列表界面
JumpConst["OpenLimiteChallgeStage"] = require "JumpCommand.UI.OpenLimiteChallgeStage"                       

return JumpConst
