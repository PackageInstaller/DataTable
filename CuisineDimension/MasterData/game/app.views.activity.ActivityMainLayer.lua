local CtrlCsv = require("csvdata.activity_ctrl")
local ItemCsv = require("csvdata.item")
local UnitCsv = require("csvdata.unit")
local SkinCsv = require("csvdata.hero_skin")
local LevelCsv = require("csvdata.activity_levelgift")
local RechargeCsv = require("csvdata.activity_rechargegift")
local LoginCsv = require("csvdata.activity_logingift")
local DrawCsv = require("csvdata.activity_drawgift")
local SpeicalMCsv = require("csvdata.activity_scoregift")
local HeroMCsv = require("csvdata.activity_puzzlegift")
local MagicTaskCsv = require("csvdata.activity_traditionaltask")
local InviteCsv = require("csvdata.friend_invite")
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local ActivityLogingiftCsv = require("csvdata.loop_activity.loop_logingift")
local NewRechargeCsv = require("csvdata.loop_activity.loop_rechargegift")
local MarryCsv = require("csvdata.once_activity.marry")
local Marry86Csv = require("csvdata.once_activity.marry86")
local YearLoginCsv = require("csvdata.loop_activity.logingift_year")
local YearLogin103Csv = require("csvdata.loop_activity.logingift_year103")
local SauceLoginCsv = require("csvdata.once_activity.logingift1")
local ShakeGiftCsv = require("csvdata.activity_shakegift")
local ShakeLimitCsv = require("csvdata.once_activity.shake")
local CarbonDrawCsv = require("csvdata.loop_activity.loop_drawgift")
local FormationCsv = require("csvdata.activity_formation")
local OpenBoxCsv = require("csvdata.box_shake")
local CollectHeroCsv = require("csvdata.activity_herocollection")
local CarbonRes = "ui/general/carbon/"
local RankRes = "ui/tower/rank/"
local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local DressCsv = require("csvdata.hero_skin")
local PTRankCsv = require("csvdata.pt_rankgift1")
local AwakeCsv = require("csvdata.awaken_draw")
local InviteReturnCsv = require("csvdata.invitation_reward")
local InviteTaskCsv = require("csvdata.regression_task")
local ActivityCookDrawRewardCsv = require("csvdata.activity_71_draw_support")
local YearTotalRechargeRewardCsv = require("csvdata.loop_activity.loop_totalrechargegift")
local TimeLimitGiftCsv = require("csvdata.time_limit_gift")
local CollectExtraStarCsv = require("csvdata.collect_extrastar_task")
local ActivitySummerCookDrawRewardCsv = require("csvdata.activity_75_draw_support")
local NewShakeUnlimitCsv = require("csvdata.activity_unlimitgift")
local MagicCapHeroCsv = require("csvdata.activity_77_hero")
local MonthLoginGiftCsv = require("csvdata.activity_month_logingift")
local CostDiamondCsv = require("csvdata.activity_costdiamond_reward")
local Activity105TaskCsv = require("csvdata.activity_105_task")
local ChapterPassTaskLayer = require("app.views.mission.ChapterPassTaskLayer")
local ChapterPassPreLayer = require("app.views.mission.ChapterPassPreLayer")
local Activity83Layer = require("app.views.activity.Activity83Layer")
local Activity88Layer = require("app.views.activity.Activity88Layer")
local Activity92Layer = require("app.views.activity.Activity92Layer")
local Activity95Layer = require("app.views.activity.Activity95Layer")
local Activity106Layer = require("app.views.activity.Activity106Layer")
local ActivityManager = require("app.models.ActivityManager")
local GlobalRes = "ui/global/"
local MainRes = "ui/activity/main/"
local BtnsRes = "ui/activity/btns/"
local DressRes = "ui/activity/dress/"
local LoginRes = "ui/activity/login/"
local LevelRes = "ui/activity/level/"
local ChargeRes = "ui/activity/charge/"
local RechargeRes = "ui/activity/recharge/"
local UpRes1 = "ui/activity/up1/"
local UpRes2 = "ui/activity/up2/"
local UpRes3 = "ui/activity/up3/"
local DrawItemRes = "ui/activity/drawItem/"
local DrawHeroRes = "ui/activity/drawHero/"
local SpeicalMRes = "ui/activity/specialMission/"
local HeroMRes = "ui/activity/heroMission/"
local InheritRes = "ui/activity/inherit/"
local HomeHeroSkinRes = "ui/activity/homeHeroSkin/"
local ActivityCarbonRes = "ui/activity/activityCarbon/"
local EquipUpRes = "ui/activity/equipUp/"
local ScoreRes = "ui/autumn/score/"
local ActivityLoginRes = "ui/activity/4/"
local Activity11Res = "ui/activity/11/"
local CarbonExpRes = "ui/activity/20/"
local NewHeroRes = "ui/activity/22/"
local MagicRes = "ui/activity/23/"
local BossRes = "ui/activity/24/"
local OnlyShowRes = "ui/activity/25/"
local AfricanRes = "ui/activity/26/"
local BackRes = "ui/activity/27/"
local LtyRes = "ui/activity/29/"
local OrderBuyRes = "ui/activity/30/"
local ChristmasRes = "ui/activity/31/"
local DoubleOneRes = "ui/activity/32/"
local FriendRes = "ui/activity/33/"
local HeroAndDressRes = "ui/activity/34/"
local TapTapRes = "ui/activity/36/"
local NewYearRes = "ui/activity/38/"
local DressGiftDrawRes = "ui/activity/39/"
local CookGiftRes = "ui/activity/40/"
local PalaceRes = "ui/activity/42/"
local NewRechargeRes = "ui/activity/43/"
local OnlyShowRes2 = "ui/activity/44/"
local MarryRes = "ui/activity/45/"
local YearLoginRes = "ui/activity/47/"
local YearScoreRes = "ui/activity/48/"
local SauceUpRes = "ui/activity/52/"
local HalloweenRes = "ui/activity/halloween/"
local CarbonDropUpRes = "ui/activity/53/"
local ShakeHappyRes = "ui/activity/55/"
local ShakeHappy2Res = "ui/activity/56/"
local CarbonDrawRes = "ui/activity/59/"
local GeneralScoreRes = "ui/activity/60/"
local FormationRes = "ui/activity/62/"
local OpenBoxRes = "ui/activity/64/"
local CollectHeroRes = "ui/activity/65/"
local PTRankRes = "ui/activity/67/"
local CarbonDraw2Res = "ui/activity/68/"
local InviteReturnRes = "ui/activity/70/"
local CookDrawRes = "ui/activity/71/"
local EquipRewardRes = "ui/common/reward/"
local TotalRechargeRes = "ui/activity/72/"
local TimeLimitGiftRes = "ui/activity/time_limit_gift/"
local CollectExtraStarRes = "ui/activity/74/"
local SummerCookDrawRes = "ui/activity/75/"
local NewShakeUnlimitRes = "ui/activity/76/"
local MagicCapRes = "ui/activity/77/"
local MonthSignRes = "ui/activity/81/"
local CostDiamondRes = "ui/activity/82/"
local Marry86Res = "ui/activity/86/"
local Show87Res = "ui/activity/87/"
local Activity105Res = "ui/activity/105/"
local uiData = {
  csbFile = "ui/activity/ActivityMainLayer.csb",
  widgets = {
    bg = "bg",
    btnsBg = "btnsBg",
    up = "up",
    list = "btnsBg/list",
    content = "mainBg/content"
  }
}
local btnsData = {
  [1] = {
    red = "1",
    name = "萌新主厨福利",
    func = function(self)
      self:showLevelGift()
    end
  },
  [2] = {
    red = "2",
    name = "首充反馈",
    func = function(self)
      self:showChargeGift()
    end
  },
  [3] = {
    red = "3",
    name = "白米饭养成计划",
    func = function(self)
      self:showRechargeGift()
    end
  },
  [4] = {
    red = "4",
    name = "7日登陆奖励",
    func = function(self)
      self:showLoginLayer1()
    end
  },
  [5] = {
    red = "5",
    name = "限时任务",
    func = function(self)
    end
  },
  [6] = {
    red = "6",
    name = "每日礼包",
    func = function(self)
    end
  },
  [7] = {
    red = "7",
    name = "限时烹饪",
    func = function(self)
      self:showCookLayer1(7)
    end
  },
  [8] = {
    red = "8",
    name = "粽子限时烹饪",
    func = function(self)
      self:showCookLayer2(8)
    end
  },
  [9] = {
    red = "9",
    name = "康沃尔馅饼限时UP",
    func = function(self)
      self:showCookLayer3(9)
    end
  },
  [10] = {
    red = "10",
    name = "次元衣橱",
    func = function(self)
      self:showDrawItemLayer()
    end
  },
  [11] = {
    red = "11",
    name = "小屋场景上新",
    func = function(self)
      self:showDressLayer()
    end
  },
  [12] = {
    red = "12",
    name = "保温盒继承",
    func = function(self)
      self:showDrawHeroLayer()
    end
  },
  [13] = {
    red = "13",
    name = "春禊觅青",
    func = function(self)
      self:showSpecialMissionLayer(13)
    end
  },
  [14] = {
    red = "14",
    name = "新手主厨之路",
    func = function(self)
      self:showHeroMissionLayer(14)
    end
  },
  [16] = {
    red = "16",
    name = "中秋活动复刻",
    func = function(self)
      self:showActivityCarbonLayer(16)
    end
  },
  [17] = {
    red = "17",
    name = "热闹夜市限时返场",
    func = function(self)
      self:showHomeAndHeroSkinLayer(17)
    end
  },
  [18] = {
    red = "18",
    name = "装备采购会",
    func = function(self)
      self:showEquipUpLayer(18)
    end
  },
  [20] = {
    red = "20",
    name = "爱意渗透",
    func = function(self)
      self:showCarnonExpLayer(20)
    end
  },
  [22] = {
    red = "22",
    name = "蛋饼限时烹饪",
    func = function(self)
      self:showNewHeroLayer(22)
    end
  },
  [23] = {
    red = "23",
    name = "魔法炉能量收集",
    func = function(self)
      self:showCollectMagicLayer1(23)
    end
  },
  [24] = {
    red = "24",
    name = "异变boss",
    func = function(self)
      self:showBossLayer()
    end
  },
  [25] = {
    red = "25",
    name = "关注有礼",
    func = function(self)
      self:showOnlyShowLayer()
    end,
    isClose = function()
      return CHANNEL_KEY == "quick"
    end
  },
  [26] = {
    red = "26",
    name = "烤鸭限时烹饪",
    func = function(self)
      self:showAfricanLayer(26)
    end
  },
  [27] = {
    red = "27",
    name = "主厨回归计划",
    func = function(self)
      self:showBackGift(27)
    end
  },
  [28] = {
    red = "28",
    name = "累计登陆奖励",
    func = function(self)
      self:showLoginLayer2()
    end
  },
  [30] = {
    red = "30",
    name = Activity30Title,
    func = function(self)
      self:showOrderBuyLayer(30)
    end
  },
  [31] = {
    red = "31",
    name = "圣诞活动",
    func = function(self)
      self:showChristmasLayer(31)
    end
  },
  [32] = {
    red = "32",
    name = "挑战区域解禁",
    func = function(self)
      self:showDoubleOneLayer(32)
    end
  },
  [33] = {
    red = "33",
    name = "好友邀请",
    func = function(self)
      self:showInviteFriendLayer(33)
    end
  },
  [34] = {
    red = "34",
    name = "换装限时返场",
    func = function(self)
      self:showHeroAndHeroDressLayer(34)
    end
  },
  [35] = {
    red = "35",
    name = "魔法炉能量收集",
    func = function(self)
      self:showCollectMagicLayer2(35)
    end
  },
  [36] = {
    red = "36",
    name = "像素游园季",
    func = function(self)
      self:showTapTapLayer(36)
    end
  },
  [38] = {
    red = "38",
    name = "新春活动",
    func = function(self)
      self:showNewYearLayer(38)
    end
  },
  [39] = {
    red = "39",
    name = "圣器兑换",
    func = function(self)
      self:showDressGiftDrawLayer(39)
    end
  },
  [40] = {
    red = "40",
    name = Activity40Title,
    func = function(self)
      self:showCookGiftLayer(40)
    end
  },
  [42] = {
    red = "42",
    name = Activity42Title,
    func = function(self)
      self:showPalaceLayer(42)
    end
  },
  [43] = {
    red = "43",
    name = "主厨进阶计划",
    func = function(self)
      self:showNewRechargeLayer(43)
    end
  },
  [44] = {
    red = "44",
    name = "法式鹅肝升华开启",
    func = function(self)
      self:showOnlyShowLayer2(44)
    end
  },
  [45] = {
    red = "45",
    name = "誓约有礼",
    func = function(self)
      self:showMarryGiftLayer(45)
    end
  },
  [46] = {
    red = "46",
    name = "食灵换装",
    func = function(self)
      self:showNewDressLayer(46)
    end
  },
  [47] = {
    red = "47",
    name = Activity47Title,
    func = function(self)
      self:showLoginLayer3(47)
    end
  },
  [48] = {
    red = "48",
    name = "周年积分活动",
    func = function(self)
      self:showYearScoreLayer(48)
    end
  },
  [51] = {
    red = "51",
    name = "梦境七日签到",
    func = function(self)
      self:showLoginLayer4(51)
    end
  },
  [52] = {
    red = "52",
    name = "酱料限时UP",
    func = function(self)
      self:showSauceUpLayer(52)
    end
  },
  [53] = {
    red = "53",
    name = "祥灵献瑞",
    func = function(self)
      self:showCarbonDropUpLayer(53)
    end
  },
  [55] = {
    red = "55",
    name = "乐转迎春",
    func = function(self)
      self:showShakeHappyLayer(55)
    end
  },
  [56] = {
    red = "56",
    name = "转转乐",
    func = function(self)
      self:showShakeLimitLayer(56)
    end
  },
  [59] = {
    red = "59",
    name = "薇琪的秘密",
    func = function(self)
      self:showCommonCarbonDrawLayer(59)
    end
  },
  [62] = {
    red = "62",
    name = "装盘训练营",
    func = function(self)
      self:showFormationMissionLayer(62)
    end,
    isClose = function()
      return ActivityManager:IsFinishFormationPractice()
    end
  },
  [64] = {
    red = "64",
    name = "圣诞树之礼",
    func = function(self)
      self:showOpenBoxLayer(64)
    end
  },
  [65] = {
    red = "65",
    name = "金秋Collection",
    func = function(self)
      self:showCollectHeroLayer(65)
    end
  },
  [67] = {
    red = "67",
    name = "赤兔心之旅挑战赛",
    func = function(self)
      self:showPTRankLayer(67)
    end
  },
  [68] = {
    red = "68",
    name = "觉醒精选计划",
    func = function(self)
      self:showCommonCarbonDraw2Layer(68)
    end
  },
  [70] = {
    red = "70",
    name = "萌新邀请活动",
    func = function(self)
      self:showInviteReturnLayer(70)
    end
  },
  [71] = {
    red = "71",
    name = "神秘魔女釜",
    func = function(self)
      self:showCookDrawLayer(71)
    end
  },
  [72] = {
    red = "72",
    name = "主厨充值回馈",
    func = function(self)
      self:showAllRechargeLayer(72)
    end
  },
  [74] = {
    red = "74",
    name = "松鼠鱼的礼物",
    func = function(self)
      self:collectExtraStar(74)
    end
  },
  [75] = {
    red = "75",
    name = Activity75Title,
    func = function(self)
      self:showSummerCookDrawLayer(75)
    end
  },
  [76] = {
    red = "76",
    name = "彩券摇摇乐",
    func = function(self)
      self:showNewShakeUnlimitLayer(76)
    end
  },
  [77] = {
    red = "77",
    name = "躲猫猫作战",
    func = function(self)
      self:showMagicCapLayer(77)
    end
  },
  [79] = {
    red = "79",
    name = "华夏功名箓",
    func = function(self)
      ChapterPassTaskLayer:init(self.content)
    end
  },
  [80] = {
    red = "80",
    name = "遨游凤栖",
    func = function(self)
      self:showActivity80Layer()
    end
  },
  [81] = {
    red = "81",
    name = "梦境遨游30日签到",
    func = function(self)
      self:showLoginLayer5(81)
    end
  },
  [82] = {
    red = "82",
    name = "新春消费计划",
    func = function(self)
      self:showCostDiamondLayer(82)
    end
  },
  [83] = {
    red = "83",
    name = "魔力回馈",
    func = function(self)
      Activity83Layer:init(self)
    end,
    isClose = function()
      return false
    end
  },
  [86] = {
    red = "86",
    name = "永恒之誓",
    func = function(self)
      self:showMarryGiftLayer2(86)
    end
  },
  [87] = {
    red = "87",
    name = "商城礼包上新",
    func = function(self)
      self:show87Layer(87)
    end
  },
  [88] = {
    red = "88",
    name = "情人节签到",
    func = function(self)
      Activity88Layer:init(self)
    end
  },
  [92] = {
    red = "92",
    name = "华旦霓裳",
    func = function(self)
      Activity92Layer:init(self)
    end
  },
  [95] = {
    red = "95",
    name = "世界树之底",
    func = function(self)
      Activity95Layer:init(self.content)
    end
  },
  [103] = {
    red = "103",
    name = Activity103Title,
    func = function(self)
      self:showLoginLayer6(103)
    end
  },
  [104] = {
    red = "104",
    name = "梦境呼唤",
    func = function(self)
      self:showDreamCookGiftLayer(104)
    end
  },
  [105] = {
    red = "105",
    name = "感恩陪伴！",
    func = function(self)
      self:showActivity105Layer(105)
    end
  },
  [106] = {
    red = "106",
    name = "海滨冒险",
    func = function(self)
      Activity106Layer:init(self)
    end
  },
  [1001] = {
    red = "1001",
    name = "限时礼包",
    func = function(self)
      self:showLimitTimeGift1001(1001)
    end
  }
}
local ActivityMainLayer = class("ActivityMainLayer", UIBase)

function ActivityMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ActivityMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.bg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
  end
  TopBar:show(TopBarType.full, "活动")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.handlersUpdate = {}
end

function ActivityMainLayer:showData(params)
  params = params or {}
  self.content:removeAllChildren()
  self.list:removeAllChildren()
  self:clearHander()
  self.handlers = {}
  self.types = {}
  self.btns = {}
  local temp = json.decode(game.role.activityBackStatus)
  local activityStatus = game.role.activityStatus
  if not config.showShare then
    temp["33"] = nil
  end
  game.role.activityBackStatus = json.encode(temp)
  game.role:setRedDirty("activity")
  for type, data in pairs(activityStatus) do
    if tonumber(type) >= 1000 and (data.open == 0 or data.startTime ~= 0 and game:nowTime() > data.startTime + TimeLimitGiftCsv[tonumber(type)].time) then
      temp[tostring(type)] = nil
    end
  end
  local sortTypes = {}
  for type, value in pairs(temp) do
    self.types[tonumber(type)] = value
    if tonumber(type) == params.selected then
      self.selected = params.selected
    end
  end
  for _, data in pairs(CtrlCsv[0]) do
    if self.types[data.activity] and (data.activity ~= 27 or data.activity == 27 and activityStatus["27"] == 1) then
      table.insert(sortTypes, clone(data))
    end
  end
  table.sort(sortTypes, function(a, b)
    return a.order < b.order
  end)
  
  local function chooseOne(select)
    if temp[tostring(select)] and temp[tostring(select)].red then
      game:sendData(actionCodes.Activity_clearRed, MsgPack.pack({type = select}))
      temp[tostring(select)].red = nil
      game.role.activityBackStatus = json.encode(temp)
      game.role:setRedDirty("activity")
    end
    btnsData[select].func(self)
  end
  
  local group = MRadioGroup:create()
  local delay = 0.2
  local btnSize = display.newSprite(MainRes .. "btn_a.png"):getContentSize()
  btnSize.height = btnSize.height + 4
  for index, data in ipairs(sortTypes) do
    local funcData = btnsData[data.activity]
    if funcData and (not funcData.isClose or not funcData.isClose()) then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.list)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(MainRes, {"btn_b.png", "btn_a.png"})
      btn:center(viewNode):addTo(viewNode):name("btn" .. data.activity)
      btn:setGroup(group)
      local name = display.newTTFLabel({
        text = funcData.name,
        size = 22
      }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(btn):addTo(btn)
      UIHelper.setMaxWidth(name, 136)
      if 0 < DEBUG then
        display.newTTFLabel({
          text = data.activity,
          size = 30,
          color = UIHelper.hex2rgb("#00ff00")
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(130, 25):addTo(btn)
      end
      if not self.selected then
        self.selected = data.activity
      end
      btn:setCallback(function()
        if self.selected == data.activity then
          return
        end
        self.selected = data.activity
        self.content:removeAllChildren()
        chooseOne(self.selected)
      end)
      if funcData.red then
        self.btns[funcData.red] = btn
        local bShow = checkbool(game.role.redPoints.activity[funcData.red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      end
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.2
      })
      delay = delay + 0.1
    end
  end
  if params.disappear and params.disappear == self.selected then
    group:chooseByName("btn" .. sortTypes[1].activity)
    self.selected = sortTypes[1].activity
  else
    group:chooseByName("btn" .. self.selected)
  end
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "activity" then
      for index, btnData in pairs(btnsData) do
        if btnData.red then
          local bShow = checkbool(game.role.redPoints.activity[btnData.red])
          UIHelper.showRedPoint(self.btns[btnData.red], bShow, cc.p(12, 6), 0.8)
        end
      end
    end
  end))
  if not next(self.handlersUpdate) then
    table.insert(self.handlersUpdate, game.role:addEventListener("set_activityBackStatus", function(event)
      for _, tag in pairs(self.handlers) do
        game.role:removeEventListener(tag)
      end
      self:showData()
    end))
  end
  chooseOne(self.selected)
  self.list:requestDoLayout()
end

function ActivityMainLayer:showDressLayer()
  local mainBg = display.newSprite(Activity11Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnDress = UIHelper.extend(ccui.Button:create())
  btnDress:setImages(Activity11Res, {"btn_go.png", "btn_go.png"})
  btnDress:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btnDress:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 2})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showCollectHeroLayer(Type)
  local mainBg = display.newSprite(CollectHeroRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local xPos, yPos = 576, 395
  local detalY = {
    141,
    153,
    0
  }
  local status = game.role.activityStatus["65"] or ""
  for index, data in ipairs(CollectHeroCsv) do
    local box = UIHelper.newImageView(CollectHeroRes .. "box.png"):pos(xPos, yPos):addTo(mainBg)
    local curNum = status:getv(data.id, 0)
    if curNum == -1 then
      display.newSprite(MainRes .. "image_red.png"):center(box):addTo(box)
      box:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true
        })
      end)
    elseif curNum >= data.condition then
      display.newTTFLabel({
        text = string.format("%d/%d", curNum == -1 and data.condition or curNum, data.condition),
        size = 16,
        color = UIHelper.hex2rgb("#99272a")
      }):pos(40, -10):addTo(box)
      local image = display.newSprite(MainRes .. "image_green.png"):center(box):addTo(box)
      box:setCallback(function()
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 65,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          image:setTexture(MainRes .. "image_red.png")
          box:setCallback(function()
            ItemRewardLayer.new({
              items = data.gift:toTableArray(),
              preView = true
            })
          end)
        end)
      end)
    else
      display.newTTFLabel({
        text = string.format("%d/%d", curNum == -1 and data.condition or curNum, data.condition),
        size = 16,
        color = UIHelper.hex2rgb("#99272a")
      }):pos(40, -10):addTo(box)
      box:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true
        })
      end)
    end
    xPos = xPos + 91
    if index % 4 == 0 then
      xPos = 578
      yPos = yPos - detalY[index / 4]
    end
  end
end

function ActivityMainLayer:showOpenBoxLayer(Type)
  local mainBg = display.newSprite(OpenBoxRes .. "main_bg2.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local costIds = "49=1"
  local numLabs = {}
  
  local function updateLabs()
    for boxId, lab in pairs(numLabs) do
      local num = game.role.items[boxId]
      num = num or 0
      lab:setString("X" .. num)
    end
  end
  
  local function send(idx, num)
    local data = globalCsv.openList[idx]
    if num > (game.role.items[data.boxId] or 0) then
      SysError(SYS_ERR_ACTIVITY_NOT_ENOUGH_OPENBOX)
      return
    end
    game:sendData(actionCodes.Activity_openBoxRpc, MsgPack.pack({id = idx, type = num}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_openBoxRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.reward = msg.reward
      self.closeCount = 0
      self.needCloseCount = #self.reward
      for i = 1, #self.reward do
        if self.reward[i].changeId then
          self.needCloseCount = self.needCloseCount + 1
        end
      end
      self.heros = {}
      for _, data in pairs(self.reward) do
        if ItemCsv[data.id].type == ItemType.Hero then
          self.heros[data.id] = (self.heros[data.id] or 0) + data.count
        end
      end
      updateLabs()
      self:showAnimation()
    end)
  end
  
  local xPos = 150
  local YBasePos = 250
  for idx, data in ipairs(globalCsv.openList or {}) do
    if costIds:getv(data.costId, 0) == 0 then
      costIds = costIds:setv(data.costId, 1)
    end
    display.newSprite(OpenBoxRes .. "jt.png"):anch(0.5, 0.5):pos(xPos, YBasePos + 10):scale(1):addTo(mainBg)
    local box = UIHelper.newImageView(OpenBoxRes .. string.format("box%d.png", idx)):anch(0.5, 0.5):pos(xPos, YBasePos):scale(1):addTo(mainBg)
    local boxNum = display.newTTFLabel({
      text = "x" .. (game.role.items[idx] or 0),
      size = 18,
      color = UIHelper.hex2rgb("#000000")
    }):anch(0.5, 0.5):pos(xPos, 152):addTo(mainBg)
    display.newSprite(OpenBoxRes .. string.format("box%d.png", idx)):anch(0.5, 0.5):pos(xPos - 48, 150):scale(0.3):addTo(mainBg)
    numLabs[data.boxId] = boxNum
    box:setCallback(function()
      local mask, image = UIHelper.showOnleImgTip(CarbonDrawRes .. "draw_info_bg.png")
      local node1 = display.newNode():pos(76, 395):addTo(image)
      local lineCount = 9
      local group1, group2 = {}, {}
      for _, data in ipairs(OpenBoxCsv) do
        if data.group == idx then
          if data.prize == 1 then
            table.insert(group1, data)
          else
            table.insert(group2, data)
          end
        end
      end
      local node1 = display.newNode():pos(45, 395):addTo(image)
      local xPos = 6
      for index, data in ipairs(group1) do
        if lineCount < index then
          break
        end
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.8):pos(xPos, 10):addTo(node1)
        xPos = xPos + 76
      end
      local list = ccui.ListView:create()
      list:size(cc.size(690, 306))
      list:setInnerContainerSize(cc.size(690, 306))
      list:setClippingEnabled(true)
      list:setBounceEnabled(true)
      list:anch(0, 0):pos(10, 10):addTo(image)
      for row = 1, math.ceil(#group2 / lineCount) do
        xPos = 6
        local viewNode = ccui.Widget:create()
        viewNode:setContentSize(cc.size(690, 86)):addTo(list)
        for i = 1, lineCount do
          local data = group2[(row - 1) * lineCount + i]
          if not data then
            break
          end
          local item = data.gift:toArray("=", true)
          ItemIcon.new({
            type = item[1],
            count = item[2],
            showTip = true
          }):scale(0.8):anch(0, 0.5):pos(xPos, 43):addTo(viewNode)
          xPos = xPos + 76
        end
      end
      list:requestDoLayout()
    end)
    local posy = -102
    local chooseTxt = {
      [1] = "兑换一次",
      [2] = "兑换十次"
    }
    for i = 1, 2 do
      local btn = UIHelper.extend(ccui.Button:create())
      local path, inPox = "btn1.png", 90
      if i == 2 then
        path = "btn2.png"
        inPox = 82
      end
      btn:setImages(OpenBoxRes, {path, path})
      btn:anch(0.5, 0.5):pos(48, posy):scale(1):addTo(box):setTouchScale()
      btn:setCallback(function()
        if i == 1 then
          send(idx, 1)
        else
          MDialog:double({
            text = "主厨确定要花费10倍道具兑换10次吗",
            size = 24,
            color = UIHelper.hex2rgb("#430602"),
            cancelCallback = function()
              return true
            end,
            okCallback = function()
              send(idx, 10)
              return true
            end
          })
        end
      end)
      posy = posy - 50
    end
    xPos = xPos + 205
  end
  updateLabs()
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "openbox"})
  end)
end

function ActivityMainLayer:showNewDressLayer()
  local mainBg = display.newSprite(DressRes .. "dress_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnDress = UIHelper.extend(ccui.Button:create())
  btnDress:setImages(DressRes, {
    "btn_dress.png",
    "btn_dress.png"
  })
  btnDress:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btnDress:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showLoginLayer1()
  local mainBg = UIHelper.newImageView(ActivityLoginRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local xPos, yPos, delta = 180, 100, 90
  for _, data in ipairs(ActivityLogingiftCsv) do
    local state = game.role.activityStatus["4"]:getv(data.day, 0)
    local cellBg = display.newSprite(LevelRes .. "cell_bg.png"):pos(xPos, yPos):addTo(mainBg)
    local label = display.newTTFLabel({
      text = string.format("第%d天", data.day),
      size = 18
    }):pos(43, 110):addTo(cellBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    UIHelper.makeFontClear(label)
    local items = data.gift:toArray("=", true)
    local giftImage = ItemIcon.new({
      type = items[1],
      count = items[2]
    }):scale(0.75):pos(43, 64):addTo(cellBg)
    local done = state == -1
    local btnImage = done and "had.png" or state >= data.day and "get.png" or "cant.png"
    local bTouch = not done and state >= data.day
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(43, 17):addTo(cellBg):setTouchScale()
    btn:setTouchEnabled(bTouch)
    
    local function getReward()
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
        type = 4,
        id = data.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:setTouchEnabled(false)
        bTouch = false
        btn:setImages(LevelRes, {"had.png", "had.png"})
        MedalRewardLayer.new({
          items = data.gift:toNumMap()
        })
      end)
    end
    
    giftImage:setCallback(function()
      if bTouch then
        getReward()
      else
        MTip:show({
          type = MTipType.item,
          node = giftImage,
          itemType = items[1],
          itemData = ItemCsv[items[1]]
        })
      end
    end)
    btn:setCallback(function()
      getReward()
    end)
    xPos = xPos + delta
  end
end

function ActivityMainLayer:showLoginLayer2()
  local list = ccui.ListView:create()
  list:size(cc.size(916, 516))
  list:setInnerContainerSize(cc.size(916, 516))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 0.5):pos(5, 0):addTo(self.content)
  local selected
  local cellSize = display.newSprite(LoginRes .. "cell_bg.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  for _, data in ipairs(LoginCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(LoginRes .. "cell_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = string.format("累计登陆%d天", data.day),
      size = 20
    }):pos(741, 97):addTo(cell)
    local xPos = 110
    for index, item in pairs(data.gift:toTableArray()) do
      local itemId = tonumber(item[1])
      local isTip = 4 < itemId and true or false
      ItemIcon.new({
        type = itemId,
        count = tonumber(item[2]),
        showTip = isTip
      }):scale(0.76):pos(xPos, 58):addTo(cell)
      xPos = xPos + 75
    end
    local state = game.role.activityStatus["28"]:getv(data.day, 0)
    local done = state == -1
    local text = done and "已领取" or state >= data.day and "领取" or "未达成"
    local btnImage = done and "btn_2.png" or state >= data.day and "btn_1.png" or "btn_3.png"
    local bTouch = not done and state >= data.day
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LoginRes, {btnImage, btnImage})
    btn:pos(825, 40):addTo(cell):setTouchScale()
    btn:setString({
      text = text,
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      local items = data.gift:toNumMap()
      local boxId
      
      local function send(itemId)
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 28,
          id = data.id,
          chooseId = itemId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          btn:setString({
            text = "已领取",
            size = 22,
            color = UIHelper.hex2rgb("#ffffff")
          })
          btn:setImages(LoginRes, {"btn_2.png", "btn_2.png"})
          btn:setTouchEnabled(false)
          if itemId then
            items[itemId] = 1
            items[boxId] = nil
          end
          MedalRewardLayer.new({items = items})
        end)
      end
      
      for itemId, num in pairs(items) do
        if ItemCsv[itemId].type == ItemType.ChooseBox then
          boxId = itemId
          break
        end
      end
      if boxId then
        local item = ItemCsv[boxId]
        local layer = game:createView("shop.ChooseItemLayer", {
          items = item.content,
          callback = function(itemId)
            if itemId ~= 0 then
              send(itemId)
            end
          end
        })
      else
        send()
      end
    end)
    btn:setTouchEnabled(bTouch)
    if not selected and bTouch then
      selected = data.day
    end
  end
  list:doLayout()
  if selected then
    list:scrollToItem(selected - 1, cc.p(0, 0.53), cc.p(0, -1))
  end
end

function ActivityMainLayer:showLoginLayer3(Type)
  local mainBg = display.newSprite(YearLoginRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local xPos, yPos = 180, 120
  for idx, data in ipairs(YearLoginCsv) do
    local state = game.role.activityStatus["47"]:getv(data.day, 0)
    local cellBg = display.newSprite(LevelRes .. "cell_bg.png"):pos(xPos, yPos):addTo(mainBg)
    local label = display.newTTFLabel({
      text = string.format("第%d天", data.day),
      size = 18
    }):pos(41, 110):addTo(cellBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    UIHelper.makeFontClear(label)
    local giftImage = UIHelper.newImageView(string.format("ui/carbon/chooseTravel/box_%d.png", math.min(6, idx))):pos(43, 64):addTo(cellBg)
    local done = state == -1
    local btnImage = done and "had.png" or state >= data.day and "get.png" or "cant.png"
    local bTouch = not done and state >= data.day
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(43, 17):addTo(cellBg):setTouchScale()
    btn:setTouchEnabled(bTouch)
    
    local function getReward()
      local items = data.gift:toNumMap()
      local boxId
      
      local function send(itemId)
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 47,
          id = data.id,
          chooseId = itemId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          btn:setImages(LevelRes, {"had.png", "had.png"})
          btn:setTouchEnabled(false)
          bTouch = false
          if itemId then
            items[itemId] = 1
            items[boxId] = nil
          end
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      end
      
      for itemId, num in pairs(items) do
        if ItemCsv[itemId].type == ItemType.ChooseBox then
          boxId = itemId
          break
        end
      end
      if boxId then
        local item = ItemCsv[boxId]
        local layer = game:createView("shop.ChooseItemLayer", {
          title = "五星招待券",
          items = item.content,
          callback = function(itemId)
            if itemId ~= 0 then
              send(itemId)
            end
          end
        })
      else
        send()
      end
    end
    
    giftImage:setCallback(function()
      if bTouch then
        getReward()
      else
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end
    end)
    btn:setCallback(function()
      getReward()
    end)
    xPos = xPos + 90
  end
end

function ActivityMainLayer:showLoginLayer6(Type)
  local mainBg = display.newSprite(YearLoginRes .. "main_bg_103.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local xPos, yPos = 180, 120
  for idx, data in ipairs(YearLogin103Csv) do
    local state = game.role.activityStatus["103"]:getv(data.day, 0)
    local cellBg = display.newSprite(LevelRes .. "cell_bg.png"):pos(xPos, yPos):addTo(mainBg)
    local label = display.newTTFLabel({
      text = string.format("第%d天", data.day),
      size = 18
    }):pos(41, 110):addTo(cellBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    UIHelper.makeFontClear(label)
    local giftImage = UIHelper.newImageView(string.format("ui/carbon/chooseTravel/box_%d.png", math.min(6, idx))):pos(43, 64):addTo(cellBg)
    local done = state == -1
    local btnImage = done and "had.png" or state >= data.day and "get.png" or "cant.png"
    local bTouch = not done and state >= data.day
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(43, 17):addTo(cellBg):setTouchScale()
    btn:setTouchEnabled(bTouch)
    
    local function getReward()
      local items = data.gift:toNumMap()
      local boxId
      
      local function send(itemId)
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 103,
          id = data.id,
          chooseId = itemId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          btn:setImages(LevelRes, {"had.png", "had.png"})
          btn:setTouchEnabled(false)
          bTouch = false
          if itemId then
            items[itemId] = 1
            items[boxId] = nil
          end
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      end
      
      for itemId, num in pairs(items) do
        if ItemCsv[itemId].type == ItemType.ChooseBox then
          boxId = itemId
          break
        end
      end
      if boxId then
        local item = ItemCsv[boxId]
        local layer = game:createView("shop.ChooseItemLayer", {
          title = "五星招待券",
          items = item.content,
          callback = function(itemId)
            if itemId ~= 0 then
              send(itemId)
            end
          end
        })
      else
        send()
      end
    end
    
    giftImage:setCallback(function()
      if bTouch then
        getReward()
      else
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end
    end)
    btn:setCallback(function()
      getReward()
    end)
    xPos = xPos + 90
  end
end

function ActivityMainLayer:showLoginLayer4()
  local list = ccui.ListView:create()
  list:size(cc.size(916, 516))
  list:setInnerContainerSize(cc.size(916, 516))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 0.5):pos(5, 0):addTo(self.content)
  local selected
  local cellSize = display.newSprite(LoginRes .. "cell_bg.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  for _, data in ipairs(SauceLoginCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(LoginRes .. "cell_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = string.format("累计登陆%d天", data.day),
      size = 20
    }):pos(741, 97):addTo(cell)
    local xPos = 110
    for index, item in pairs(data.gift:toTableArray()) do
      local itemId = tonumber(item[1])
      local isTip = 4 < itemId and true or false
      ItemIcon.new({
        type = itemId,
        count = tonumber(item[2]),
        showTip = isTip
      }):scale(0.76):pos(xPos, 58):addTo(cell)
      xPos = xPos + 75
    end
    local state = game.role.activityStatus["51"]:getv(data.day, 0)
    local done = state == -1
    local text = done and "已领取" or state >= data.day and "领取" or "未达成"
    local btnImage = done and "btn_2.png" or state >= data.day and "btn_1.png" or "btn_3.png"
    local bTouch = not done and state >= data.day
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LoginRes, {btnImage, btnImage})
    btn:pos(825, 40):addTo(cell):setTouchScale()
    btn:setString({
      text = text,
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      local items = data.gift:toNumMap()
      local boxId
      
      local function send(itemId)
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 51,
          id = data.id,
          chooseId = itemId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          btn:setString({
            text = "已领取",
            size = 22,
            color = UIHelper.hex2rgb("#ffffff")
          })
          btn:setImages(LoginRes, {"btn_2.png", "btn_2.png"})
          btn:setTouchEnabled(false)
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      end
      
      for itemId, num in pairs(items) do
        if ItemCsv[itemId].type == ItemType.ChooseBox then
          boxId = itemId
          break
        end
      end
      if boxId then
        local item = ItemCsv[boxId]
        local layer = game:createView("shop.ChooseItemLayer", {
          items = item.content,
          callback = function(itemId)
            if itemId ~= 0 then
              send(itemId)
            end
          end
        })
      else
        send()
      end
    end)
    btn:setTouchEnabled(bTouch)
    if not selected and bTouch then
      selected = data.day
    end
  end
  list:doLayout()
  if selected then
    list:scrollToItem(selected - 1, cc.p(0, 0.53), cc.p(0, -1))
  end
end

function ActivityMainLayer:showLevelGift()
  local mainBg = display.newSprite(LevelRes .. "level_bg.png"):pos(0, 0):addTo(self.content)
  local xPos, yPos, delta = 97, 100, 90
  for index, levelData in ipairs(LevelCsv) do
    local cellBg = display.newSprite(LevelRes .. "cell_bg.png"):pos(xPos, yPos):addTo(mainBg)
    local state = game.role.activityStatus["1"]:getv(index, 0)
    local level = levelData.level
    display.newTTFLabel({
      text = level .. "级",
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):pos(43, 106):addTo(cellBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    local imageIndex = index % 2 == 0 and index / 2 or index / 2 + 1
    local image = string.format("box_%d.png", imageIndex)
    local giftImage = UIHelper.newImageView("ui/carbon/chooseTravel/" .. image):pos(43, 60):addTo(cellBg)
    local done = state == -1
    local btnImage = done and "had.png" or level <= game.role.level and "get.png" or "cant.png"
    local bTouch = not done and level <= game.role.level
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(43, 17):addTo(cellBg):setTouchScale()
    btn:setTouchEnabled(bTouch)
    
    local function getReward()
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
        type = 1,
        id = levelData.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:setTouchEnabled(false)
        bTouch = false
        btn:setImages(LevelRes, {"had.png", "had.png"})
        MedalRewardLayer.new({
          items = levelData.gift:toNumMap()
        })
      end)
    end
    
    giftImage:setCallback(function()
      if bTouch then
        getReward()
      else
        ItemRewardLayer.new({
          items = levelData.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end
    end)
    btn:setCallback(function()
      getReward()
    end)
    xPos = xPos + delta
  end
end

function ActivityMainLayer:showChargeGift()
  local bg = display.newSprite(ChargeRes .. "charge_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local state = game.role.activityStatus["2"]:getv(1, 0)
  local items = globalCsv.rechargeFirstGift:toTableArray()
  local xPos, yPos = 97, 227
  for index, item in ipairs(items) do
    ItemIcon.new({
      type = tonumber(item[1]),
      count = tonumber(item[2]),
      showTip = true
    }):scale(0.8):pos(xPos, yPos):addTo(bg)
    xPos = xPos + 80
    if index == 4 then
      xPos, yPos = 97, 147
    end
  end
  if state == -1 then
    display.newSprite(MainRes .. "common_had.png"):pos(840, 35):addTo(bg)
  elseif state == 1 then
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {
      "anniu_1.png",
      "anniu_1.png"
    })
    btn:pos(840, 35):addTo(bg):setTouchScale()
    btn:setString({text = "领取", size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 2, id = 1}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:removeSelf()
        display.newSprite(MainRes .. "common_had.png"):pos(840, 35):addTo(bg)
        MedalRewardLayer.new({
          items = globalCsv.rechargeFirstGift:toNumMap()
        })
      end)
    end)
  else
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {
      "common_btn.png",
      "common_btn.png"
    })
    btn:pos(840, 35):addTo(bg):setTouchScale()
    btn:setCallback(function()
      local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
      BackManager:push(function()
        self.content:removeAllChildren()
        self:showChargeGift()
        layer:close()
      end)
    end)
    display.newTTFLabel({text = "去看看", size = 24}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):pos(60, 25):addTo(btn)
  end
end

function ActivityMainLayer:showRechargeGift()
  local mainBg = display.newSprite(RechargeRes .. "recharge_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local curNum = game.role.activityStatus["3"]:getv(1, 0)
  if curNum == -1 then
    display.newSprite(MainRes .. "common_had.png"):pos(840, 35):addTo(mainBg)
    return
  end
  if curNum < RechargeCsv[1].money then
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(RechargeRes, {"btn_a.png", "btn_b.png"})
    btn:pos(829, 40):addTo(mainBg)
    btn:setCallback(function()
      local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
      BackManager:push(function()
        TopBar:show(TopBarType.full, "活动")
        self.content:removeAllChildren()
        self:showRechargeGift()
        layer:close()
      end)
    end)
  else
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {
      "anniu_1.png",
      "anniu_1.png"
    })
    btn:pos(845, 35):addTo(mainBg):setTouchScale()
    btn:setString({text = "领取", size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 3, id = 1}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:removeSelf()
        display.newSprite(MainRes .. "common_had.png"):pos(840, 35):addTo(mainBg)
        local msg = MsgPack.unpack(event.data)
        if msg.change then
          MDialog:single({
            title = "提示",
            text = "获得的重复外观已自动折算为等值物品"
          }, function()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        else
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
      end)
    end)
  end
  display.newTTFLabel({
    text = string.format("累充:%d/%d", curNum, RechargeCsv[1].money),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#ce4f2e"), 1):anch(0, 0.5):pos(785, 80):addTo(mainBg)
end

function ActivityMainLayer:showCookLayer1(Type)
  local mainBg = display.newSprite(UpRes1 .. "up_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer2")
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showCookLayer2(Type)
  local mainBg = display.newSprite(UpRes2 .. "up_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer2")
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showCookLayer3(Type)
  local mainBg = display.newSprite(UpRes3 .. "up_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(UpRes3, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    if not CommonHelper.funcOpen("extraStar") then
      SysError(SYS_ERR_FUNCOPEN_EXTRASTARDRAW)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 8})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showDrawItemLayer()
  local offsetPos = {0, 0}
  local Pos = {
    {230, 412},
    {343, 375},
    {408, 285},
    {408, 175},
    {339, 78},
    {225, 43},
    {120, 80},
    {55, 175},
    {55, 285},
    {120, 375}
  }
  local mainBg = display.newSprite(DrawItemRes .. "draw_bg.png"):anch(0, 0):pos(-454, -255):addTo(self.content)
  local icons = {}
  local costId = globalCsv.drawCostItemId
  local countBg = UIHelper.newImageView(DrawItemRes .. "count_bg_cost.png"):anch(1, 0.5):scale(1.2):pos(890, 490):addTo(mainBg)
  countBg:setCallback(function()
    MTip:show({
      type = MTipType.item,
      node = countBg,
      itemType = costId,
      itemData = ItemCsv[costId]
    })
  end)
  display.newSprite(ItemCsv[costId].icon):scale(0.5):pos(790, 490):addTo(mainBg)
  local countNum = display.newTTFLabel({
    text = game.role.items[costId] or 0,
    size = 26
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(840, 490):addTo(mainBg)
  local itemsBg = display.newSprite(DrawItemRes .. "big_circle_bg.png"):pos(642, 265):addTo(mainBg)
  local btnBg = display.newSprite(DrawItemRes .. "btn_bg.png"):pos(232 + offsetPos[1], 228 + offsetPos[2]):addTo(itemsBg)
  for index, data in ipairs(DrawCsv) do
    local cellBg = display.newSprite(DrawItemRes .. "circle_black_bg.png"):pos(Pos[index][1] + offsetPos[1], Pos[index][2] + offsetPos[2]):addTo(itemsBg)
    display.newSprite(DrawItemRes .. "item_bg.png"):center(cellBg):addTo(cellBg)
    display.newSprite(data.res):scale(data.scale):center(cellBg):addTo(cellBg)
    display.newSprite(DrawItemRes .. "frame.png"):center(cellBg):addTo(cellBg)
    MRichText.new({
      text = string.format("<div outline=1,#2b1405 >%s</div>", data.title),
      size = 16,
      color = UIHelper.hex2rgb("#ffd38f")
    }):anch(0.5, 0.5):pos(35, -5):addTo(cellBg)
    icons[index] = cellBg
  end
  local total = game.role.activityStatus["10"].roundCount == 1 and globalCsv.totalCount1 or globalCsv.totalCount2
  local drawCountText = display.newTTFLabel({
    text = "已抽取" .. game.role.activityStatus["10"].count .. "次，第" .. total .. "次保底",
    size = 22
  }):pos(210, 16):addTo(mainBg)
  local hander = display.newSprite(DrawItemRes .. "hander.png"):anch(0.5, 0):pos(232 + offsetPos[1], 228 + offsetPos[2]):addTo(itemsBg)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(DrawItemRes, {
    "btn_start.png",
    "btn_start.png"
  })
  btn:pos(232 + offsetPos[1], 228 + offsetPos[2]):addTo(itemsBg):setTouchScale()
  local costBg = display.newSprite(DrawItemRes .. "count_bg_cost.png"):pos(232 + offsetPos[1], 160 + offsetPos[2]):addTo(itemsBg)
  local lab = display.newTTFLabel({text = "", size = 22}):pos(47, 16):addTo(costBg)
  local icon = display.newSprite(ItemCsv[costId].icon):scale(0.4):pos(2, 16):addTo(costBg)
  local costType = 1
  
  local function updateIcon()
    if game.role.activityStatus["10"].free > 0 then
      lab:setString("免费")
    else
      costType = 2
      icon:setTexture(ItemCsv[costId].icon)
      lab:setString(globalCsv.drawCost2)
    end
  end
  
  updateIcon()
  
  local function checkLeft()
    for index, data in pairs(DrawCsv) do
      local done = false
      local gift = data.gift:toArray("=", true)
      if ItemCsv[gift[1]].type == 19 or ItemCsv[gift[1]].type == 20 or ItemCsv[gift[1]].type == 21 then
        if game.role.items[gift[1]] then
          done = true
        end
      elseif ItemCsv[gift[1]].type == 24 and game.role.dressBook[tonumber(ItemCsv[gift[1]].content)] then
        done = true
      end
      local times = game.role.activityStatus["10"].status:getv(index, 0)
      if 0 < data.limit and times >= data.limit then
        done = true
      end
      if done and icons[index] then
        display.newSprite(DrawItemRes .. "done.png"):center(icons[index]):addTo(icons[index])
        icons[index] = nil
      end
    end
  end
  
  local function send()
    game:sendData(actionCodes.Activity_lotteryGiftRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_lotteryGiftRpc, function(event)
      UIHelper.removeWaiting()
      local mask = UIHelper.newMask({
        size = cc.size(display.width, display.height),
        opacity = 0
      })
      mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(display.getRunningScene(), 100)
      mask:setTouchEnabled(true)
      mask:setSwallowTouches(true)
      local msg = MsgPack.unpack(event.data)
      local beginRota, endRota = self:getRotation(hander, msg.id)
      btn:setTouchEnabled(false)
      hander:runAction(transition.sequence({
        cc.RotateBy:create(beginRota / 900, beginRota),
        cc.RotateBy:create(0.16, 360),
        cc.RotateBy:create(0.03 * endRota / 60, endRota),
        cc.EaseSineOut:create(cc.RotateBy:create(0.5, 360)),
        cc.CallFunc:create(function()
          btn:setTouchEnabled(true)
          mask:removeSelf()
          checkLeft()
          if msg.change then
            MDialog:single({
              text = string.format("主厨您已经获得<div color=#e36f36>%s</div>，已为您转换为<div color=#e36f36>%s</div><img src='%s' scale=0.5 />!", ItemCsv[msg.change[1].fromId].name, msg.change[1].toCount, ItemCsv[msg.change[1].toId].icon)
            }, function()
            end)
          else
            MedalRewardLayer.new({
              items = msg.reward
            })
          end
          updateIcon()
          total = game.role.activityStatus["10"].roundCount == 1 and globalCsv.totalCount1 or globalCsv.totalCount2
          drawCountText:setString("已抽取" .. game.role.activityStatus["10"].count .. "次，第" .. total .. "次保底")
          countNum:setString(game.role.items[costId] or 0)
        end)
      }))
    end)
  end
  
  checkLeft()
  btn:setCallback(function()
    local Data = game.role.activityStatus["10"]
    if Data.free > 0 then
      send()
    elseif costType == 2 then
      if (game.role.items[costId] or 0) < globalCsv.drawCost2 then
        MFlashMsg:show({
          text = string.format("%s数量不足，抽奖失败", ItemCsv[costId].name)
        })
        return
      end
      send()
    elseif tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.dialogSkipTime or 0) then
      MDialog:double({
        showSkip = true,
        title = "钻石购买",
        text = string.format("是否要消耗 <img src='ui/global/5.png' scale=0.5 />X%d 继续？", globalCsv.drawCost2),
        okCallback = function()
          if game.role.diamond < globalCsv.drawCost2 then
            UIHelper.showDiamondTip()
          else
            send()
          end
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    elseif game.role.diamond < globalCsv.drawCost2 then
      UIHelper.showDiamondTip()
    else
      send()
    end
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "luckyRound"})
  end)
end

function ActivityMainLayer:showDrawHeroLayer()
  local mainBg = display.newSprite(DrawHeroRes .. "draw_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local xPos, yPos = 190, 230
  for index = 1, 3 do
    local bg = display.newSprite(DrawHeroRes .. "common_bg.png"):pos(xPos, yPos):addTo(mainBg)
    local itemId = game.role.openBox:getv(index, 0)
    local posY = itemId ~= 0 and 120 or 30
    if itemId ~= 0 then
      local spineNode = UIHelper.createSpineNode(itemId - ItemStartId.hero):pos(80, -45):addTo(bg)
      spineNode:setAnimation(0, "idle", true)
      display.newSprite(DrawHeroRes .. "image_got.png"):pos(190, -15):addTo(bg)
    end
    local mask = UIHelper.newImageView(DrawHeroRes .. (index < 3 and "green_mask.png" or "yellow_mask.png")):anch(0.5, 1):pos(78, 31):addTo(bg)
    local gai = UIHelper.newImageView(DrawHeroRes .. (index < 3 and "green_up.png" or "yellow_up.png")):pos(80, posY):addTo(bg)
    
    local function showTip()
      gai:stopAllActions()
      gai:setRotation(0)
      gai:runAction(transition.sequence({
        cc.RotateBy:create(0.05, 10),
        cc.RotateBy:create(0.05, -20),
        cc.RotateBy:create(0.05, 10),
        cc.CallFunc:create(function()
          local textBg = display.newSprite(DrawHeroRes .. "tip_bg.png"):pos(80, posY + 30):addTo(bg)
          local str = itemId ~= 0 and "该食灵将继承到公测中" or index == 1 and "累计登录获得该保温盒" or "海之家商店兑换该保温盒"
          local text = display.newTTFLabel({text = str, size = 16}):pos(100, 23):addTo(textBg)
          textBg:setOpacity(0)
          textBg:runAction(transition.sequence({
            cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 30))),
            cc.DelayTime:create(1),
            cc.Spawn:create(cc.FadeOut:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 20))),
            cc.RemoveSelf:create()
          }))
        end)
      }))
    end
    
    mask:setCallback(function()
      showTip()
    end)
    gai:setCallback(function()
      showTip()
    end)
    xPos = xPos + 270
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "common_btn.png",
    "common_btn.png"
  })
  btn:pos(840, 35):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 4})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      self.content:removeAllChildren()
      self:showDrawHeroLayer()
      layer:close()
    end)
  end)
  display.newTTFLabel({text = "去看看", size = 24}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):pos(60, 25):addTo(btn)
end

function ActivityMainLayer:showSpecialMissionLayer(Type)
  self.content:removeAllChildren()
  local itemId = 20128
  local mainBg = display.newSprite(SpeicalMRes .. "mission_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local countBg = UIHelper.newImageView(SpeicalMRes .. "cout_bg.png"):pos(95, 75):addTo(mainBg)
  countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = countBg,
      itemType = itemId,
      itemData = ItemCsv[itemId]
    })
  end)
  local num = display.newTTFLabel({
    text = game.role.items[itemId] or 0,
    size = 28
  }):pos(90, 18):addTo(countBg)
  local tLabel = display.newTTFLabel({
    text = "00:00:00后刷新",
    size = 20,
    color = UIHelper.hex2rgb("#065855")
  }):anch(0, 0.5):pos(740, 333):addTo(mainBg)
  local times = self.types[Type]
  if next(times) then
    local sT = CommonHelper.date(times.start)
    local cT = CommonHelper.date(times.close)
    display.newTTFLabel({
      text = string.format("%02d月%02d日维护后-%02d月%02d日4时", sT.month, sT.day, cT.month, cT.day),
      size = 28
    }):enableOutline(UIHelper.hex2rgb("#1661a7"), 2):pos(710, 480):addTo(mainBg)
  end
  local list = ccui.ListView:create()
  list:size(cc.size(690, 306))
  list:setInnerContainerSize(cc.size(690, 306))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(200, 12):addTo(mainBg)
  local tT = CommonHelper.date(game:nowTime() + 86400)
  local endTime = CommonHelper.time({
    year = tT.year,
    month = tT.month,
    day = tT.day,
    hour = 4
  })
  
  local function refreshTime()
    local left = (endTime - game:nowTime()) % 86400
    if 0 < left then
      tLabel:setString(UIHelper.getTimeStr(left) .. "后刷新")
      tLabel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          refreshTime()
        end)
      }))
    else
      self:showSpecialMissionLayer(Type)
    end
  end
  
  refreshTime()
  local Csv1 = SpeicalMCsv[1]
  local Csv2 = SpeicalMCsv[2]
  local status1 = game.role.activityStatus[tostring(Type)]["1"]
  local barBg = display.newSprite(SpeicalMRes .. "bar_bg.png"):anch(0, 0.5):pos(200, 394):addTo(mainBg)
  local bar = display.newProgressTimer(SpeicalMRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  local all, longth = Csv1[#Csv1].condition1, bar:getContentSize().width
  local progress = status1:getv(#Csv1, 0)
  if progress == -1 then
    progress = all
  end
  bar:setPercentage(progress / all * 100)
  for index, data in ipairs(Csv1) do
    local xPos = data.condition1 / all * longth
    local btn
    if data.gift2see ~= "" then
      btn = UIHelper.newImageView(data.gift2see)
      btn:scale(0.6)
    else
      btn = UIHelper.newImageView(SpeicalMRes .. "bar_icon.png")
    end
    btn:pos(xPos, 6):addTo(bar)
    local items = data.gift:toArray("=", true)
    display.newTTFLabel({
      text = "x" .. items[2],
      size = 14,
      color = UIHelper.hex2rgb("#f6ff00")
    }):enableOutline(UIHelper.hex2rgb("#1661a7"), 1):pos(xPos + 3, -2):addTo(bar)
    display.newTTFLabel({
      text = data.condition1 .. "次",
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#1661a7"), 1):pos(xPos, -20):addTo(bar)
    local curNum = status1:getv(data.id, 0)
    if curNum == -1 then
      display.newSprite(SpeicalMRes .. "image_got.png"):pos(xPos, 6):addTo(bar)
    elseif curNum >= data.condition1 then
      local red = display.newSprite("ui/global/msg_new.png"):anch(0, 0):pos(xPos, 7):addTo(bar)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = Type,
          id = data.id,
          part = data.part
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          display.newSprite(SpeicalMRes .. "image_got.png"):pos(xPos, 6):addTo(bar)
          red:removeSelf()
          btn:setTouchEnabled(false)
          num:setString(game.role.items[itemId] or 0)
          MedalRewardLayer.new({
            items = data.gift:toNumMap()
          })
        end)
      end)
    else
      btn:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end)
    end
  end
  local status2 = game.role.activityStatus[tostring(Type)]["2"]
  local size = display.newSprite(SpeicalMRes .. "cell_bg.png"):getContentSize()
  local lastTask = {}
  for i = 1, #Csv2 do
    if status2:getv(Csv2[i].id, 0) == -1 and Csv2[i].after == 0 or status2:getv(Csv2[i].id, 0) ~= -1 and (status2:getv(Csv2[i].pre, 0) == -1 or Csv2[i].pre == 0) then
      table.insert(lastTask, Csv2[i])
    end
  end
  table.sort(lastTask, function(a, b)
    local curA = status2:getv(a.id, 0)
    local factorA = curA == -1 and 100000 or curA >= a.condition1 and 0 or 1000
    local curB = status2:getv(b.id, 0)
    local factorB = curB == -1 and 100000 or curB >= b.condition1 and 0 or 1000
    return factorA + a.id < factorB + b.id
  end)
  local rows = math.ceil(#lastTask / 2)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:size(690, size.height):addTo(list)
    for col = 1, 2 do
      local data = lastTask[(row - 1) * 2 + col]
      if data then
        local xPos = 178 + (col - 1) * 340
        local cell = display.newSprite(SpeicalMRes .. "cell_bg.png"):pos(xPos, 50):addTo(viewNode)
        display.newTTFLabel({
          text = data.desc,
          size = 24
        }):enableOutline(UIHelper.hex2rgb("#31709d"), 1):anch(0, 0.5):pos(20, 76):addTo(cell)
        local gift = data.gift:toArray("=", true)
        display.newTTFLabel({
          text = "x" .. gift[2],
          size = 24
        }):enableOutline(UIHelper.hex2rgb("#31709d"), 1):anch(0, 0.5):pos(53, 25):addTo(cell)
        local curNum = status2:getv(data.id, 0)
        if curNum == -1 then
          display.newSprite(SpeicalMRes .. "image_done.png"):anch(1, 0.5):pos(320, 23):addTo(cell)
        else
          display.newTTFLabel({
            text = string.format("%d/%d", curNum, data.condition1),
            size = 24,
            color = UIHelper.hex2rgb("#146496")
          }):pos(275, 55):addTo(cell)
          local done = curNum >= data.condition1
          local image = done and "btn_2.png" or "btn_1.png"
          local str = done and "领取" or "前往"
          local color = done and "#517100" or "#4c3605"
          local btn = UIHelper.extend(ccui.Button:create())
          btn:setImages(SpeicalMRes, {image, image})
          btn:setString({
            text = str,
            size = 20,
            color = UIHelper.hex2rgb("ffffff")
          })
          btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb(color), 1)
          btn:pos(275, 25):addTo(cell):setTouchScale()
          btn:setCallback(function()
            if done then
              game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
                type = Type,
                id = data.id,
                part = data.part
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
                UIHelper.removeWaiting()
                self:showSpecialMissionLayer(Type)
                MedalRewardLayer.new({
                  items = data.gift:toNumMap()
                })
              end)
            else
              CommonHelper.jumpLayer(data.link == 0 and data.type or data.link, function()
                self:hide()
              end, function()
                TopBar:show(TopBarType.full, "活动")
                CommonHelper.playHomeBGM()
                self:show()
                self:showSpecialMissionLayer(Type)
              end, data.condition2)
            end
          end)
        end
      end
    end
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(SpeicalMRes, {"btn_go.png", "btn_go.png"})
  btn:pos(95, 30):addTo(mainBg)
  btn:setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      self:showSpecialMissionLayer(Type)
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = "前往兑换",
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):pos(60, 25):addTo(btn)
end

function ActivityMainLayer:showHeroMissionLayer(Type)
  local mainBg = display.newSprite(HeroMRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local hero = display.newSprite(HeroMRes .. "image_hero.png"):pos(620, 260):addTo(mainBg)
  display.newSprite(HeroMRes .. "image_desc.png"):pos(181, 256):addTo(mainBg)
  display.newSprite(HeroMRes .. "image_image.png"):pos(181, 120):addTo(mainBg)
  local status = game.role.activityStatus["14"]
  if status:getv(0, 0) == -1 then
    display.newSprite(MainRes .. "common_had.png"):pos(830, 35):addTo(mainBg)
    return
  end
  local xPos, yPos, finishNum = 282, 571, 0
  for row = 1, 3 do
    yPos = yPos - 157
    xPos = 282
    for col = 1, 3 do
      xPos = xPos + 176
      local index = (row - 1) * 3 + col
      local data = HeroMCsv[index]
      if not data then
        break
      end
      local curNum = status:getv(data.id, -10)
      if curNum == -1 then
        finishNum = finishNum + 1
      else
        local cell = UIHelper.newImageView(HeroMRes .. "cell_bg.png"):pos(xPos, yPos):addTo(mainBg)
        if 0 <= curNum then
          curNum = data.type == 0 and status:getv(0, 0) or curNum
          local label = display.newTTFLabel({
            text = data.desc,
            size = 18,
            color = UIHelper.hex2rgb("#6b2d1a")
          }):pos(85, 135):addTo(cell)
          UIHelper.makeFontClear(label)
          local items = data.gift:toTableArray()
          local x, y = 90 - (#items - 1) / 2 * 66, 81
          for _, item in ipairs(items) do
            ItemIcon.new({
              type = tonumber(item[1]),
              count = tonumber(item[2]),
              showTip = true
            }):scale(0.6):pos(x, y):addTo(cell)
            x = x + 66
          end
          local text = curNum >= data.condition1 and "点击领取" or string.format("进度:%d/%d", curNum, data.condition1)
          local numLabel = display.newTTFLabel({
            text = text,
            size = 18,
            color = UIHelper.hex2rgb("#2e8c00")
          }):pos(85, 30):addTo(cell)
          UIHelper.makeFontClear(numLabel)
          cell:setCallback(function()
            if curNum < data.condition1 then
              return
            end
            game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
              type = 14,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
              UIHelper.removeWaiting()
              MedalRewardLayer.new({
                items = data.gift:toNumMap(),
                callback = function()
                  cell:runAction(transition.sequence({
                    cc.OrbitCamera:create(0.3, 1, 0, 0, 100, 0, 0),
                    cc.RemoveSelf:create(),
                    cc.CallFunc:create(function()
                      self.content:removeAllChildren()
                      self:showHeroMissionLayer(Type)
                    end)
                  }))
                end
              })
            end)
          end)
        else
          display.newSprite(HeroMRes .. "image_lock.png"):center(cell):addTo(cell)
        end
      end
    end
  end
  if finishNum == #HeroMCsv then
    local flash = display.newSprite(HeroMRes .. "image_guang.png"):center(hero):addTo(hero)
    flash:runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeIn:create(1),
      cc.FadeOut:create(1)
    })))
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/carbon/boss/", {
      "anniu_1.png",
      "anniu_1.png"
    })
    btn:pos(830, 35):addTo(mainBg):setTouchScale()
    btn:setString({text = "领取", size = 24})
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      game:sendData(actionCodes.Activity_puzzleRewardRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_puzzleRewardRpc, function(event)
        UIHelper.removeWaiting()
        self.content:removeAllChildren()
        self:showHeroMissionLayer(Type)
        MedalRewardLayer.new({
          items = globalCsv.puzzleFinalGift:toNumMap()
        })
      end)
    end)
  end
end

function ActivityMainLayer:showInheritLayer(Type)
  local Data = game.role.activityStatus["15"]
  local mainBg = display.newSprite(InheritRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local itemsStatus = Data.status:getv(4, -10)
  if -10 < itemsStatus then
    local itemsBg = display.newSprite(InheritRes .. "diamond_bg.png"):pos(175, 330):addTo(mainBg)
    local index, xPos, yPos = 0, 47, 140
    for itemId, value in pairs(Data.items:toNumMap()) do
      if 0 < value then
        ItemIcon.new({
          type = itemId,
          count = value,
          showTip = true
        }):scale(0.8):pos(xPos, yPos):addTo(itemsBg)
        index = index + 1
        xPos = xPos + 87
        if index == 3 then
          xPos, yPos = 47, 52
        end
      end
    end
    if 0 < itemsStatus then
      local itemsBtn = UIHelper.extend(ccui.Button:create())
      itemsBtn:setImages(InheritRes, {
        "diamond_btn.png",
        "diamond_btn.png"
      })
      itemsBtn:pos(205, 40):addTo(itemsBg):setTouchScale()
      itemsBtn:setCallback(function()
        game:sendData(actionCodes.Activity_inheritRewardRpc, MsgPack.pack({type = 4}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_inheritRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          itemsBtn:removeSelf()
          display.newSprite(MainRes .. "common_had.png"):pos(200, 40):addTo(itemsBg)
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      end)
    else
      display.newSprite(MainRes .. "common_had.png"):pos(200, 40):addTo(itemsBg)
    end
  end
  local dressStatus = Data.status:getv(5, -10)
  local dresss = Data.skin:toNumMap()
  local posSet = {
    [12051] = {
      530,
      270,
      1
    },
    [11121] = {
      660,
      270,
      2
    },
    [16091] = {
      810,
      243,
      3
    },
    [12031] = {
      525,
      179,
      4
    },
    [15031] = {
      800,
      175,
      5
    },
    [10991] = {
      660,
      170,
      6
    }
  }
  for itemId, Pos in pairs(posSet) do
    local image = display.newSprite(InheritRes .. string.format("%d.png", itemId)):pos(Pos[1], Pos[2]):addTo(mainBg):setLocalZOrder(Pos[3])
    if not dresss[itemId] then
      image:setColor(cc.c3b(48, 48, 48))
    end
  end
  if 0 < dressStatus then
    local dressBtn = UIHelper.extend(ccui.Button:create())
    dressBtn:setImages(InheritRes, {
      "dress_btn.png",
      "dress_btn.png"
    })
    dressBtn:pos(670, 40):addTo(mainBg):setTouchScale()
    dressBtn:setLocalZOrder(10)
    dressBtn:setCallback(function()
      game:sendData(actionCodes.Activity_inheritRewardRpc, MsgPack.pack({type = 5}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_inheritRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        dressBtn:removeSelf()
        display.newSprite(MainRes .. "common_had.png"):pos(670, 40):addTo(mainBg):setLocalZOrder(10)
        local change = false
        for id, _ in pairs(msg.reward) do
          if ItemCsv[id].type == ItemType.HeroSkin then
            change = true
            break
          end
        end
        if change then
          MDialog:single({
            title = "提示",
            text = "获得的重复外观已自动折算为等值物品"
          }, function()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        else
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
      end)
    end)
  else
    if -10 < dressStatus then
      display.newSprite(MainRes .. "common_had.png"):pos(670, 40):addTo(mainBg):setLocalZOrder(10)
    else
    end
  end
  local posSet = {
    {187, 85},
    {75, 135},
    {300, 135}
  }
  for index = 1, 3 do
    local status = Data.status:getv(index, -10)
    local bg = UIHelper.newImageView(InheritRes .. "box_bg.png"):pos(posSet[index][1], posSet[index][2]):addTo(mainBg)
    local box = display.newSprite(InheritRes .. string.format("box_%d.png", index == 1 and 5 or 4)):center(bg):addTo(bg)
    if status == -10 then
      box:setColor(cc.c3b(80, 80, 80))
    elseif status == -1 then
      display.newSprite(InheritRes .. "box_got.png"):pos(60, 15):addTo(bg)
    else
      local tip = display.newSprite(InheritRes .. "box_tip.png"):pos(60, 15):addTo(bg)
      bg:setCallback(function()
        local boxId = index == 1 and 25 or 26
        game:createView("shop.ChooseItemLayer", {
          items = ItemCsv[boxId].content,
          callback = function(itemId)
            MDialog:double({
              title = "提示",
              text = "因食灵装盘与食灵投放调整，请您慎重地重新选择需要继承的食灵！确定要继承该食灵吗？",
              cancelText = "再想想"
            }, function()
              game:sendData(actionCodes.Activity_inheritRewardRpc, MsgPack.pack({type = index, chooseId = itemId}))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_inheritRewardRpc, function(event)
                UIHelper.removeWaiting()
                bg:setTouchEnabled(false)
                local msg = MsgPack.unpack(event.data)
                tip:removeSelf()
                display.newSprite(InheritRes .. "box_got.png"):pos(60, 15):addTo(bg)
                MedalRewardLayer.new({
                  items = msg.reward
                })
              end)
            end)
          end
        })
      end)
    end
  end
end

function ActivityMainLayer:showActivityCarbonLayer(Type)
  local mainBg = display.newSprite(ActivityCarbonRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  display.newTTFLabel({
    text = game.role.items[17] or 0,
    size = 22
  }):anch(0, 0.5):pos(675, 25):addTo(mainBg)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(ActivityCarbonRes, {"btn_a.png", "btn_b.png"})
  btnGo:anch(1, 0.5):pos(912, 35):addTo(mainBg):setTouchScale()
  btnGo:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "moon"})
  end)
end

function ActivityMainLayer:showHomeAndHeroSkinLayer(Type)
  local mainBg = display.newSprite(HomeHeroSkinRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGift = UIHelper.extend(ccui.Button:create())
  btnGift:setImages(HomeHeroSkinRes, {
    "btn_1_a.png",
    "btn_1_b.png"
  })
  btnGift:anch(1, 0.5):scale(1.3):pos(912, 39):addTo(mainBg):setTouchScale()
  btnGift:setCallback(function()
    local layer = game:createView("pass.PassMainLayer", {select = 1})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showEquipUpLayer(Type)
  local mainBg = display.newSprite(EquipUpRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(EquipUpRes, {"btn_a.png", "btn_a.png"})
  btnGo:anch(1, 0.5):pos(912, 39):addTo(mainBg):setTouchScale()
  btnGo:setCallback(function()
    if not CommonHelper.funcOpen("equip") then
      SysError(SYS_ERR_FUNCOPEN_EQUIP)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 4})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      self.content:removeAllChildren()
      self:showEquipUpLayer(Type)
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showCarnonExpLayer(Type)
  local mainBg = display.newSprite(CarbonExpRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(CarbonExpRes, {"btn_go.png", "btn_go.png"})
  btnGo:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btnGo:setCallback(function()
    game:createView("wasteland.WastelandLayer")
  end)
end

function ActivityMainLayer:showNewHeroLayer(Type)
  local mainBg = display.newSprite(NewHeroRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 34):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer2")
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showHalloweenLayer(Type)
  local mainBg = display.newSprite(HalloweenRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnEquip = UIHelper.extend(ccui.Button:create())
  btnEquip:setImages(HalloweenRes, {"btn_go.png", "btn_go.png"})
  btnEquip:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btnEquip:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "hallowmas"})
  end)
end

function ActivityMainLayer:showCollectMagicLayer1(Type)
  local Data = game.role.activityStatus[tostring(Type)]
  local mainBg = display.newSprite(MagicRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local taskNode = display.newNode():pos(7, 8):addTo(mainBg)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = MagicRes .. "rule.png"
    })
  end)
  local guo = UIHelper.createSpineNodeByRes("spine/ui/activity/guo")
  guo:setAnimation(0, "special", true)
  guo:pos(690, 288):addTo(mainBg)
  display.newSprite(MagicRes .. "image_2.png"):anch(0.5, 0):pos(690, 0):addTo(mainBg)
  display.newSprite(MagicRes .. "image_3.png"):anch(0.5, 1):pos(605, 513):addTo(mainBg)
  local spine = UIHelper.createSpineNode(globalCsv.traditional_heroshow):pos(875, 0):addTo(mainBg)
  spine:setAnimation(0, "idle", true)
  spine:scale(spine:getScale() * 1.4)
  spine:setScaleX(spine:getScale() * -1)
  local countBg = display.newSprite("ui/kitchen/cook/paper_bg.png"):pos(763, 487):addTo(mainBg)
  display.newSprite(MagicRes .. "bottle_empty.png"):pos(130, 21):addTo(countBg)
  display.newTTFLabel({
    text = "剩余魔法瓶:",
    size = 18,
    color = UIHelper.hex2rgb("#e6c5a5")
  }):pos(62, 20):addTo(countBg)
  local count = display.newTTFLabel({
    text = "x" .. Data.empty,
    size = 24,
    color = UIHelper.hex2rgb("#3ff914")
  }):anch(0, 0.5):pos(147, 20):addTo(countBg)
  local btnCircle = UIHelper.newImageView(MagicRes .. "circle.png"):pos(690, 278):addTo(mainBg)
  local num = display.newTTFLabel({
    text = string.format("%d/100", Data.energy),
    size = 18
  }):pos(30, 92):addTo(btnCircle)
  local barBg = display.newSprite(MagicRes .. "bar_bg.png"):pos(30, 70):addTo(btnCircle)
  local bar = display.newProgressTimer(MagicRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(Data.energy)
  display.newSprite(MagicRes .. "bottle_big.png"):pos(29, 33):addTo(btnCircle)
  if Data.energy >= 100 then
    local pingzi = UIHelper.createSpineNodeByRes("spine/ui/activity/pingzi")
    pingzi:setAnimation(0, "special", true)
    pingzi:center(btnCircle):addTo(btnCircle):name("pingzi")
  end
  btnCircle:setCallback(function()
    if Data.empty < 1 then
      SysError(SYS_ERR_ACTIVITY_BOTTLE_USE_OUT)
      return
    end
    if Data.energy < 100 then
      SysError(SYS_ERR_ACTIVITY_MAGIC_NOT_FULL)
      return
    end
    game:sendData(actionCodes.Activity_traditionalRewardRpc, MsgPack.pack({type = 2}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_traditionalRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      Data = game.role.activityStatus[tostring(Type)]
      count:setString("x" .. Data.empty)
      num:setString(string.format("%d/100", Data.energy))
      bar:setPercentage(Data.energy)
      MedalRewardLayer.new({
        items = msg.reward
      })
      local pingzi = btnCircle:getChildByName("pingzi")
      if Data.energy < 100 and pingzi then
        pingzi:removeSelf()
      end
    end)
  end)
  
  local function showAnimation(value)
    local tipBg = display.newSprite(MagicRes .. "text_bg.png"):pos(723, 95):addTo(mainBg)
    display.newTTFLabel({
      text = "呵呵，能量正在上升喔",
      size = 18,
      color = UIHelper.hex2rgb("#992e11")
    }):pos(100, 33):addTo(tipBg)
    tipBg:setOpacity(0)
    tipBg:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.DelayTime:create(0.5),
      cc.Spawn:create(cc.FadeOut:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.RemoveSelf:create()
    }))
    local text = display.newTTFLabel({
      text = "+" .. Data.energy - value,
      size = 18,
      color = UIHelper.hex2rgb("#3ff914")
    }):pos(691, 347):addTo(mainBg)
    text:setOpacity(0)
    text:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.5), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.DelayTime:create(0.5),
      cc.Spawn:create(cc.FadeOut:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.RemoveSelf:create()
    }))
    num:setString(string.format("%d/100", Data.energy))
    bar:runAction(cc.ProgressTo:create(0.4, Data.energy))
  end
  
  local function showTask()
    taskNode:removeAllChildren()
    display.newTTFLabel({text = "任务", size = 20}):pos(73, 108):addTo(taskNode)
    if Data.task == "no" then
      display.newTTFLabel({
        text = "所有奖励领取完毕，魔法炉已彻底激活，恭喜主厨！",
        size = 18,
        color = UIHelper.hex2rgb("#763636")
      }):pos(225, 55):addTo(taskNode)
    elseif Data.task == "empty" then
      display.newTTFLabel({
        text = "主厨今日可开魔法瓶数目已经用完了\n请明天再来开启新的魔法瓶",
        size = 18,
        color = UIHelper.hex2rgb("#763636")
      }):pos(225, 55):addTo(taskNode)
    else
      local data = Data.task:toArray("=", true)
      local taskData = MagicTaskCsv[data[1]]
      display.newTTFLabel({
        text = taskData.desc,
        size = 20,
        color = UIHelper.hex2rgb("#763636")
      }):anch(0, 0.5):pos(15, 65):addTo(taskNode)
      display.newTTFLabel({
        text = string.format("%d/%d", data[2], taskData.condition2),
        size = 20,
        color = UIHelper.hex2rgb("#763636")
      }):anch(0, 0.5):pos(15, 41):addTo(taskNode)
      display.newTTFLabel({
        text = "能量+" .. taskData.gift,
        size = 18,
        color = UIHelper.hex2rgb("#763636")
      }):pos(380, 75):addTo(taskNode)
      local done = data[2] >= taskData.condition2
      local image = done and "btn_2.png" or "btn_1.png"
      local text = done and "领取" or "前往"
      local outColor = done and "#106e10" or "#d0622c"
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(MagicRes, {image, image})
      btn:anch(0, 0.5):pos(335, 36):addTo(taskNode):setTouchScale()
      btn:setCallback(function()
        if done then
          if Data.energy >= 100 then
            SysError(SYS_ERR_ACTIVITY_MAGIC_FULL_AND_DRAW)
            return
          end
          game:sendData(actionCodes.Activity_traditionalRewardRpc, MsgPack.pack({type = 1}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_traditionalRewardRpc, function(event)
            UIHelper.removeWaiting()
            btn:setTouchEnabled(false)
            local temp = Data.energy
            Data = game.role.activityStatus[tostring(Type)]
            showAnimation(temp)
            showTask()
            if Data.energy >= 100 then
              local pingzi = UIHelper.createSpineNodeByRes("spine/ui/activity/pingzi")
              pingzi:setAnimation(0, "special", true)
              pingzi:center(btnCircle):addTo(btnCircle):name("pingzi")
            end
          end)
        else
          local layer = game:createView("carbon.CarbonDetailLayer", {
            mapId = math.floor(taskData.condition1 / 100),
            carbonId = taskData.condition1
          })
          BackManager:push(function()
            layer:close()
            TopBar:show(TopBarType.full, "活动")
            CommonHelper.playHomeBGM()
          end)
        end
      end)
      display.newTTFLabel({text = text, size = 20}):enableOutline(UIHelper.hex2rgb(outColor), 1):pos(47, 21):addTo(btn)
    end
  end
  
  showTask()
end

function ActivityMainLayer:showBossLayer(Type)
  local mainBg = display.newSprite(BossRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(BossRes, {"btn_go.png", "btn_go.png"})
  btnGo:anch(1, 0.5):pos(912, 35):addTo(mainBg):setTouchScale()
  btnGo:setCallback(function()
    local layer = game:createView("carbon.CarbonMainLayer")
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "活动")
      CommonHelper.playHomeBGM()
    end)
  end)
end

function ActivityMainLayer:showOnlyShowLayer()
  local mainBg = display.newSprite(OnlyShowRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
end

function ActivityMainLayer:showOnlyShowLayer2()
  local mainBg = display.newSprite(OnlyShowRes2 .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGift = UIHelper.extend(ccui.Button:create())
  btnGift:setImages(OnlyShowRes2, {"btn_go.png", "btn_go.png"})
  btnGift:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btnGift:setCallback(function()
    if not CommonHelper.funcOpen("tree") then
      SysError(SYS_ERR_FUNCOPEN_TREE)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showAfricanLayer(type)
  local mainBg = display.newSprite(AfricanRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    UIHelper.showOnleImgTip(AfricanRes .. "rule.png")
  end)
  local smallDi = display.newSprite(AfricanRes .. "small_di.png"):addTo(mainBg):anch(0, 0):pos(593, 180)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer2")
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
      self.content:removeAllChildren()
      self:showAfricanLayer(26)
    end)
  end)
  local count = game.role.activityStatus[tostring(type)]
  local heroMinimum = globalCsv.heroMinimum:toArray("=", true)
  local lab = display.newTTFLabel({
    text = "祈愿:" .. count .. "/" .. heroMinimum[2],
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):center(smallDi):addTo(smallDi)
  lab:enableOutline(UIHelper.hex2rgb("#000000"), 1)
  if count >= heroMinimum[2] then
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MagicRes, {"btn_1.png", "btn_1.png"})
    btn:anch(1, 0.5):pos(860, 205):addTo(mainBg):setTouchScale()
    btn:setCallback(function()
      game:sendData(actionCodes.Activity_africanRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_africanRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward
        })
        lab:setString("祈愿完成")
        btn:hide()
      end)
    end)
    display.newTTFLabel({text = "领取", size = 20}):enableOutline(UIHelper.hex2rgb("#d0622c"), 1):pos(47, 21):addTo(btn)
  elseif count == -1 then
    lab:setString("祈愿完成")
  else
    if count == -2 then
      lab:setString("已烹饪获得")
    else
    end
  end
end

function ActivityMainLayer:showBackGift(Type)
  local mainBg = display.newSprite(BackRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local state = game.role.activityStatus["27"]
  if state ~= 1 then
    return
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MagicRes, {"btn_1.png", "btn_1.png"})
  btn:pos(845, 50):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    game:sendData(actionCodes.Activity_oldBackRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_oldBackRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      btn:removeSelf()
      local bg = display.newSprite(MagicRes .. "btn_1.png"):pos(845, 50):addTo(mainBg)
      display.newTTFLabel({text = "已获得", size = 20}):enableOutline(UIHelper.hex2rgb("#259f92"), 1):pos(48, 21):addTo(bg)
      MedalRewardLayer.new({
        items = msg.reward
      })
    end)
  end)
  display.newTTFLabel({text = "领取", size = 20}):enableOutline(UIHelper.hex2rgb("#d0622c"), 1):pos(48, 21):addTo(btn)
end

function ActivityMainLayer:showLtyLayer(type)
  local mainBg = display.newSprite(LtyRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(LtyRes, {"btn_go.png", "btn_go.png"})
  btn:anch(1, 0.5):pos(912, 45):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    game:enterScene("LtyScene")
  end)
end

function ActivityMainLayer:showOrderBuyLayer(type)
  local mainBg = display.newSprite(OrderBuyRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(LtyRes, {
    "btn_draw.png",
    "btn_draw.png"
  })
  btn:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    if not CommonHelper.funcOpen("box") then
      SysError(SYS_ERR_FUNCOPEN_DINER_DRAW)
      return
    end
    game.role:requestDinerInfo(function()
      local layer = game:createView("diner.DinerDrawLayer")
      self:hide()
      BackManager:push(function()
        TopBar:show(TopBarType.full, "活动")
        self:show()
        layer:close()
        self.content:removeAllChildren()
        self:showOrderBuyLayer(30)
      end)
    end)
  end)
end

function ActivityMainLayer:show87Layer(type)
  local mainBg = display.newSprite(Show87Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnDress = UIHelper.extend(ccui.Button:create())
  btnDress:setImages(Show87Res, {"btn_go.png", "btn_go.png"})
  btnDress:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btnDress:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showChristmasLayer(type)
  local mainBg = display.newSprite(ChristmasRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  display.newTTFLabel({
    text = "12月20日维护后-1月10日维护前",
    size = 26,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(180, 499):addTo(mainBg)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(ChristmasRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = ChristmasRes .. "info_bg.png"
    })
  end)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(LtyRes, {"btn_go.png", "btn_go.png"})
  btn:anch(1, 0.5):pos(912, 45):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "christmas"})
  end)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(LtyRes, {
    "btn_shop.png",
    "btn_shop.png"
  })
  btn:anch(1, 0.5):pos(912, 110):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showDoubleOneLayer(type)
  local mainBg = display.newSprite(DoubleOneRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(LtyRes, {"btn_go.png", "btn_go.png"})
  btn:anch(1, 0.5):pos(912, 70):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "christmas"})
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(DoubleOneRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(495, 190):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    local mask = UIHelper.showOnleImgTip(DoubleOneRes .. "info_bg.png")
    local cx, cy = mask:getContentSize().width / 2, mask:getContentSize().height / 2
    display.newTTFLabel({
      text = "享受战斗力加成的食灵",
      size = 20,
      color = UIHelper.hex2rgb("#ffcc00")
    }):pos(cx + 3, cy + 151):addTo(mask)
    local index = 1
    for heroType, _ in pairs(globalCsv.ActivityPoweredHero:toNumMap()) do
      if heroType < 30000 then
        local lie = math.ceil(index / 2)
        local hang = index % 2
        local x = cx + 3 + (lie - 3) * 90
        local y = cy - 30
        if hang == 1 then
          y = y + 75
        else
          y = y - 30
        end
        if lie % 2 == 1 then
          y = y - 30
        else
          y = y + 25
        end
        local head = FormatHead.new({type = heroType}):pos(x, y):addTo(mask)
        head:setCallback(function()
          MTip:show({
            type = MTipType.item,
            node = head,
            itemType = ItemCsv[ItemStartId.hero + heroType].type,
            itemData = ItemCsv[ItemStartId.hero + heroType],
            count = 0
          })
        end)
        index = index + 1
      end
    end
  end)
end

function ActivityMainLayer:showInviteFriendLayer(Type)
  local mainBg = display.newSprite(FriendRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local yPos = 455
  for i = 1, 4 do
    local y = yPos
    local data = InviteCsv[i]
    local state = game.role.activityStatus["33"]:getv(i, 0)
    if state == -1 then
      display.newSprite(FriendRes .. "image_done.png"):pos(840, y):addTo(mainBg)
    elseif game.role.inviteCount < data.condition then
      local label = display.newTTFLabel({
        text = string.format("%d/%d", game.role.inviteCount, data.condition),
        size = 28
      }):enableOutline(UIHelper.hex2rgb("#ae4f14"), 1):pos(750, y):addTo(mainBg)
      display.newSprite(FriendRes .. "image_lock.png"):pos(840, y):addTo(mainBg)
    else
      local label = display.newTTFLabel({
        text = string.format("%d/%d", game.role.inviteCount, data.condition),
        size = 28
      }):enableOutline(UIHelper.hex2rgb("#ae4f14"), 1):pos(750, y):addTo(mainBg)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(FriendRes, {
        "btn_get.png",
        "btn_get.png"
      })
      btn:pos(840, y):addTo(mainBg):setTouchScale()
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 33,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          label:removeSelf()
          btn:removeSelf()
          display.newSprite(FriendRes .. "image_done.png"):pos(840, y):addTo(mainBg)
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
      end)
    end
    yPos = yPos - 120
  end
  local times = self.types[Type]
  local str = "活动时间：%d/%02d/%02d维护后 —— %d/%02d/%02d维护前\n \n活动期间点击【邀请好友】按钮进行好友邀请，好友成功注册并达成特定等级后，主厨大人将获得相应的礼物。邀请人数越多，获得的礼物也越多哦，赶快邀请好友一起来拯救料理次元吧！"
  if next(times) then
    local sT = CommonHelper.date(times.start)
    local cT = CommonHelper.date(times.close)
    str = string.format(str, sT.year, sT.month, sT.day, cT.year, cT.month, cT.day)
  end
  display.newTTFLabel({
    text = str,
    size = 18,
    color = UIHelper.hex2rgb("#875e26"),
    dimensions = cc.size(464, 320)
  }):anch(0, 1):pos(25, 400):addTo(mainBg)
  if not APP_VERSION_TAG or APP_VERSION_TAG ~= "1" then
    display.newTTFLabel({
      text = "您的客户端并非最新安装包，分享到微信朋友圈、QQ空间将无法参与本活动，请您重新下载最新安装包",
      size = 18,
      color = UIHelper.hex2rgb("#875e26"),
      dimensions = cc.size(464, 320)
    }):anch(0, 1):pos(25, 170):addTo(mainBg)
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(FriendRes, {
    "btn_send.png",
    "btn_send.png"
  })
  btn:pos(260, 75):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    if config.showShare then
      local path = string.gsub(device.writablePath, "[\\\\/]+$", "") .. device.directorySeparator .. "res/ui/activity/33/share.jpg"
      local url = "http://cook.coco.cn/share/" .. string.sub(string.format("%#x", game.role.id), 3, -1)
      if APP_VERSION_TAG and APP_VERSION_TAG == "1" then
        local thumbUrl
        if device.platform == "ios" then
          thumbUrl = "https://upload.cc/i/VM8nZO.png"
        else
          thumbUrl = "http://res.llcy.punchbox.info/icon/logo_64.png"
        end
        umeng.shareContent({
          url = url,
          title = "【料理次元】邀请新主厨啦",
          desc = "玩小游戏，送食灵小姐姐",
          thumbUrl = thumbUrl
        })
      else
        umeng.shareContent({
          content = "#料理次元# 邀请新主厨啦！点击下面的链接，玩小游戏即送食灵小姐姐哦~ " .. url,
          image = path
        })
      end
    end
  end)
end

function ActivityMainLayer:showHeroAndHeroDressLayer(Type)
  local mainBg = display.newSprite(HeroAndDressRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
end

function ActivityMainLayer:showCollectMagicLayer2(Type)
  local Data = game.role.activityStatus[tostring(Type)]
  local mainBg = display.newSprite(MagicRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local taskNode = display.newSprite(MagicRes .. "task_bg.png"):anch(0, 0):pos(7, 5):addTo(mainBg)
  local times = self.types[Type]
  if next(times) then
    local sT = CommonHelper.date(times.start)
    local cT = CommonHelper.date(times.close)
    display.newTTFLabel({
      text = string.format("%d/%02d/%02d 维护后-%d/%02d/%02d 4时", sT.year, sT.month, sT.day, cT.year, cT.month, cT.day),
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(14, 146):addTo(mainBg)
  end
  local showOne = true
  if showOne then
  else
    local location = {
      {138, 280},
      {305, 278},
      {425, 205}
    }
    for index, set in ipairs(location) do
      display.newSprite(MagicRes .. "circle_big.png"):pos(set[1], set[2]):addTo(mainBg)
      display.newSprite(MagicRes .. string.format("icon_%d.png", index)):pos(set[1], set[2]):addTo(mainBg)
    end
  end
  local guo = UIHelper.createSpineNodeByRes("spine/ui/activity/guo")
  guo:setAnimation(0, "special", true)
  guo:pos(690, 288):addTo(mainBg)
  display.newSprite(MagicRes .. "image_2.png"):anch(0.5, 0):pos(690, 0):addTo(mainBg)
  display.newSprite(MagicRes .. "image_3.png"):anch(0.5, 1):pos(600, 513):addTo(mainBg)
  display.newSprite(MagicRes .. "image_title.png"):anch(0, 0.5):pos(8, 210):addTo(mainBg)
  display.newSprite(MagicRes .. "image_task.png"):anch(0, 0.5):pos(15, 115):addTo(mainBg)
  local spine = UIHelper.createSpineNode(globalCsv.traditional_heroshow):pos(875, 0):addTo(mainBg)
  spine:setAnimation(0, "idle", true)
  spine:scale(0.9)
  spine:setScaleX(spine:getScale() * -1)
  local countBg = display.newSprite("ui/kitchen/cook/paper_bg.png"):pos(763, 487):addTo(mainBg)
  display.newSprite(MagicRes .. "bottle_empty.png"):pos(130, 21):addTo(countBg)
  display.newTTFLabel({
    text = "剩余魔法瓶:",
    size = 18,
    color = UIHelper.hex2rgb("#e6c5a5")
  }):pos(62, 20):addTo(countBg)
  local lastNum = display.newTTFLabel({
    text = "x0",
    size = 24,
    color = UIHelper.hex2rgb("#3ff914")
  }):anch(0, 0.5):pos(147, 20):addTo(countBg)
  
  local function update()
    local last = 0
    for _, itemData in pairs(globalCsv.traditional_draw_gift:toArray()) do
      local temp = itemData:toArray("=", true)
      last = last + temp[3] - Data.limit:getv(temp[1], 0)
    end
    lastNum:setString(last)
  end
  
  update()
  local tipBg = display.newSprite(MagicRes .. "image_bg.png"):pos(705, 15):addTo(mainBg)
  display.newTTFLabel({
    text = "今日可开魔法瓶      个",
    size = 18,
    color = UIHelper.hex2rgb("#e6c5a5")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(130, 14):addTo(tipBg)
  local label = display.newTTFLabel({
    text = string.format("%d/%d", Data.empty, 3),
    size = 18,
    color = UIHelper.hex2rgb("#3ff914")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(185, 14):addTo(tipBg)
  local btnCircle = UIHelper.newImageView(MagicRes .. "circle.png"):pos(690, 278):addTo(mainBg)
  local num = display.newTTFLabel({
    text = string.format("%d/100", Data.energy),
    size = 18
  }):pos(30, 92):addTo(btnCircle)
  local barBg = display.newSprite(MagicRes .. "bar_bg.png"):pos(30, 70):addTo(btnCircle)
  local bar = display.newProgressTimer(MagicRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(Data.energy)
  display.newSprite(MagicRes .. "bottle_big.png"):pos(29, 33):addTo(btnCircle)
  if Data.energy >= 100 then
    local pingzi = UIHelper.createSpineNodeByRes("spine/ui/activity/pingzi")
    pingzi:setAnimation(0, "special", true)
    pingzi:center(btnCircle):addTo(btnCircle):name("pingzi")
  end
  btnCircle:setCallback(function()
    if Data.empty < 1 then
      SysError(SYS_ERR_ACTIVITY_BOTTLE_USE_OUT)
      return
    end
    if Data.energy < 100 then
      SysError(SYS_ERR_ACTIVITY_MAGIC_NOT_FULL)
      return
    end
    game:sendData(actionCodes.Activity_traditionalRewardRpc, MsgPack.pack({type = 2}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_traditionalRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      Data = game.role.activityStatus[tostring(Type)]
      label:setString(string.format("%d/%d", Data.empty, 3))
      update()
      num:setString(string.format("%d/100", Data.energy))
      bar:setPercentage(Data.energy)
      MedalRewardLayer.new({
        items = msg.reward
      })
      local pingzi = btnCircle:getChildByName("pingzi")
      if Data.energy < 100 and pingzi then
        pingzi:removeSelf()
      end
    end)
  end)
  
  local function showAnimation(value)
    local tipBg = display.newSprite(MagicRes .. "text_bg.png"):pos(723, 95):addTo(mainBg)
    display.newTTFLabel({
      text = "呵呵，能量正在上升喔",
      size = 18,
      color = UIHelper.hex2rgb("#992e11")
    }):pos(100, 33):addTo(tipBg)
    tipBg:setOpacity(0)
    tipBg:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.DelayTime:create(0.5),
      cc.Spawn:create(cc.FadeOut:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.RemoveSelf:create()
    }))
    local text = display.newTTFLabel({
      text = "+" .. Data.energy - value,
      size = 18,
      color = UIHelper.hex2rgb("#3ff914")
    }):pos(691, 347):addTo(mainBg)
    text:setOpacity(0)
    text:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.5), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.DelayTime:create(0.5),
      cc.Spawn:create(cc.FadeOut:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 15))),
      cc.RemoveSelf:create()
    }))
    num:setString(string.format("%d/100", Data.energy))
    bar:runAction(cc.ProgressTo:create(0.4, Data.energy))
  end
  
  local needRefresh = true
  
  local function showTask()
    Data = game.role.activityStatus[tostring(Type)]
    taskNode:removeAllChildren()
    if Data.task == "no" then
      needRefresh = false
      display.newTTFLabel({
        text = "所有奖励领取完毕，魔法炉已彻底激活，恭喜主厨！",
        size = 18,
        color = UIHelper.hex2rgb("#763636")
      }):pos(225, 55):addTo(taskNode)
    elseif Data.task == "empty" then
      needRefresh = false
      display.newTTFLabel({
        text = "主厨今日可开魔法瓶数目已经用完了\n请明天再来开启新的魔法瓶",
        size = 18,
        color = UIHelper.hex2rgb("#763636")
      }):pos(225, 55):addTo(taskNode)
    else
      local data = Data.task:toArray("=", true)
      local taskData = MagicTaskCsv[data[1]]
      display.newTTFLabel({
        text = taskData.desc,
        size = 20,
        color = UIHelper.hex2rgb("#763636")
      }):anch(0, 0.5):pos(15, 65):addTo(taskNode)
      display.newTTFLabel({
        text = string.format("%d/%d", data[2], taskData.condition1),
        size = 20,
        color = UIHelper.hex2rgb("#763636")
      }):anch(0, 0.5):pos(15, 41):addTo(taskNode)
      display.newTTFLabel({
        text = "能量+" .. taskData.gift,
        size = 18,
        color = UIHelper.hex2rgb("#763636")
      }):pos(380, 81):addTo(taskNode)
      local done = data[2] >= taskData.condition1
      local image = done and "btn_2.png" or "btn_1.png"
      local text = done and "领取" or "前往"
      local outColor = done and "#106e10" or "#d0622c"
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(MagicRes, {image, image})
      btn:anch(0, 0.5):pos(335, 41):addTo(taskNode):setTouchScale()
      btn:setCallback(function()
        if done then
          if Data.energy >= 100 then
            SysError(SYS_ERR_ACTIVITY_MAGIC_FULL_AND_DRAW)
            return
          end
          game:sendData(actionCodes.Activity_traditionalRewardRpc, MsgPack.pack({type = 1}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_traditionalRewardRpc, function(event)
            UIHelper.removeWaiting()
            btn:setTouchEnabled(false)
            local temp = Data.energy
            Data = game.role.activityStatus[tostring(Type)]
            showAnimation(temp)
            showTask()
            if Data.energy >= 100 then
              local pingzi = UIHelper.createSpineNodeByRes("spine/ui/activity/pingzi")
              pingzi:setAnimation(0, "special", true)
              pingzi:center(btnCircle):addTo(btnCircle):name("pingzi")
            end
          end)
        else
          CommonHelper.jumpLayer(taskData.type, function()
            self:hide()
          end, function()
            TopBar:show(TopBarType.full, "活动")
            CommonHelper.playHomeBGM()
            self:show()
            showTask()
          end, taskData.condition2)
        end
      end)
      display.newTTFLabel({text = text, size = 20}):enableOutline(UIHelper.hex2rgb(outColor), 1):pos(47, 21):addTo(btn)
    end
  end
  
  showTask()
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_35"
    })
  end)
  local bFlash = false
  local btnRefresh = UIHelper.extend(ccui.Button:create())
  btnRefresh:setImages(MagicRes, {
    "btn_refresh.png",
    "btn_refresh.png"
  })
  btnRefresh:pos(450, 110):addTo(mainBg):setTouchScale()
  btnRefresh:setCallback(function()
    if not needRefresh or bFlash then
      return
    end
    bFlash = true
    mainBg:runAction(transition.sequence({
      cc.DelayTime:create(1.2),
      cc.CallFunc:create(function()
        bFlash = false
      end)
    }))
    game:sendData(actionCodes.Activity_traditionalRewardRpc, MsgPack.pack({type = 3}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_traditionalRewardRpc, function(event)
      UIHelper.removeWaiting()
      taskNode:runAction(cc.CallFunc:create(function()
        local flash = display.newSprite(MagicRes .. "flash.png"):center(taskNode):addTo(taskNode)
        flash:setOpacity(0)
        flash:runAction(transition.sequence({
          cc.FadeIn:create(0.2),
          cc.DelayTime:create(0.1),
          cc.CallFunc:create(function()
            showTask()
          end),
          cc.FadeOut:create(0.1),
          cc.RemoveSelf:create()
        }))
      end))
    end)
  end)
end

function ActivityMainLayer:showTapTapLayer(Type)
  local mainBg = display.newSprite(TapTapRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local num = display.newTTFLabel({
    text = game.role.items[globalCsv.Activity36ItemId] or 0,
    size = 24
  }):pos(799, 480):addTo(mainBg)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(LtyRes, {"btn_go.png", "btn_go.png"})
  btn:anch(1, 0.5):pos(912, 125):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "taptap"})
  end)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(TapTapRes, {
    "btn_shop.png",
    "btn_shop.png"
  })
  btn:anch(1, 0.5):pos(912, 55):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 6})
    BackManager:push(function()
      num:setString(game.role.items[20] or 0)
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showNewYearLayer(Type)
  local mainBg = display.newSprite(NewYearRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(LtyRes, {"btn_go.png", "btn_go.png"})
  btnGo:anch(1, 0.5):pos(912, 35):addTo(mainBg):setTouchScale()
  btnGo:setCallback(function()
    game.role:requestDinerInfo(function()
      game:enterScene("MidAutumnScene", {sceneType = "newyear"})
    end)
  end)
end

function ActivityMainLayer:showDressGiftDrawLayer(Type)
  local mainBg = display.newSprite(DressGiftDrawRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGift = UIHelper.extend(ccui.Button:create())
  btnGift:setImages(DressGiftDrawRes, {
    "btn_go1.png",
    "btn_go1.png"
  })
  btnGift:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btnGift:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showCookGiftLayer(Type)
  local mainBg = display.newSprite(CookGiftRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local set = globalCsv.ActivitySpecialCook:toArray("=", true)
  local status = game.role.activityStatus["40"] or ""
  local cookNum = status:getv(0, 0)
  local gotCount = status:getv(1, 0)
  local tempCount = 0
  local needMore = 0
  if cookNum >= set[2] then
    cookNum = cookNum - set[2]
    tempCount = 1
    tempCount = tempCount + math.floor(cookNum / set[3])
    needMore = set[3] - cookNum % set[3]
  else
    needMore = set[2] - cookNum
  end
  local left = tempCount - gotCount
  display.newSprite(CookGiftRes .. "icon.png"):pos(610, 175):addTo(mainBg)
  display.newTTFLabel({
    text = "x" .. math.max(1, left),
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(665, 175):addTo(mainBg)
  local str = string.format("再烹饪%d次可以领取%s", 0 < left and 0 or needMore, ItemCsv[set[1]].name)
  if 0 < left then
    str = string.format("已达成目标，可领取%s~", ItemCsv[set[1]].name)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MagicRes, {"btn_1.png", "btn_1.png"})
    btn:pos(770, 170):addTo(mainBg):setTouchScale()
    btn:setString({
      text = "领取",
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#d0622c"), 2)
    btn:setCallback(function()
      game:sendData(actionCodes.Activity_cookHeroRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_cookHeroRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward,
          bShow = true
        })
        self.content:removeAllChildren()
        self:showCookGiftLayer(Type)
      end)
    end)
  end
  local label = display.newTTFLabel({
    text = str,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(620, 115):addTo(mainBg)
  UIHelper.makeFontClear(label)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    UIHelper.showOnleImgTip(CookGiftRes .. "image_rule.png")
  end)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer2")
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showDreamCookGiftLayer(Type)
  local mainBg = display.newSprite(CookGiftRes .. "dream_main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local set = globalCsv.ActivitySpecialCookDream:toArray("=", true)
  local status = game.role.activityStatus["104"] or ""
  local cookNum = status:getv(0, 0)
  local gotCount = status:getv(1, 0)
  local tempCount = 0
  local needMore = 0
  if cookNum >= set[2] then
    cookNum = cookNum - set[2]
    tempCount = 1
    tempCount = tempCount + math.floor(cookNum / set[3])
    needMore = set[3] - cookNum % set[3]
  else
    needMore = set[2] - cookNum
  end
  local left = tempCount - gotCount
  display.newSprite(CookGiftRes .. "dream_icon.png"):pos(560, 175):addTo(mainBg)
  display.newTTFLabel({
    text = "x" .. math.max(1, left),
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(615, 175):addTo(mainBg)
  local str = string.format("再烹饪%d次可以领取%s", 0 < left and 0 or needMore, ItemCsv[set[1]].name)
  if 0 < left then
    str = string.format("已达成目标，可领取%s~", ItemCsv[set[1]].name)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MagicRes, {"btn_1.png", "btn_1.png"})
    btn:pos(700, 170):addTo(mainBg):setTouchScale()
    btn:setString({
      text = "领取",
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#d0622c"), 2)
    btn:setCallback(function()
      game:sendData(actionCodes.Activity_cookDreamHeroRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_cookDreamHeroRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.reward,
          bShow = true
        })
        self.content:removeAllChildren()
        self:showDreamCookGiftLayer(Type)
      end)
    end)
  end
  local label = display.newTTFLabel({
    text = str,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(570, 115):addTo(mainBg)
  UIHelper.makeFontClear(label)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_104"
    })
  end)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 8})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showPalaceLayer(Type)
  local mainBg = display.newSprite(PalaceRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGO = UIHelper.extend(ccui.Button:create())
  btnGO:setImages(PalaceRes, {"btn_go.png", "btn_go.png"})
  btnGO:anch(1, 0.5):pos(912, 100):addTo(mainBg):setTouchScale()
  btnGO:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 2})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
  local btnShop = UIHelper.extend(ccui.Button:create())
  btnShop:setImages(PalaceRes, {
    "btn_exchange.png",
    "btn_exchange.png"
  })
  btnShop:anch(1, 0.5):pos(912, 35):addTo(mainBg):setTouchScale()
  btnShop:setCallback(function()
    if not CommonHelper.funcOpen("box") then
      SysError(SYS_ERR_FUNCOPEN_DINER_SHOP)
      return
    end
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showOptionalBox(itemId, btn)
  print("test")
  local itemData = ItemCsv[itemId]
  if not itemData or not itemData.content then
    return
  end
  MDialog:optional({
    title = "自选礼盒",
    items = itemData.content,
    cancelCallback = function()
      return true
    end,
    okCallback = function(selectId)
      selectId = selectId or 0
      print("selectItemId:" .. selectId)
      local selectData = ItemCsv[tonumber(selectId)]
      if not selectData then
        MFlashMsg:show({
          text = "主厨，您还未选择想要的食灵哦~"
        })
        return
      end
      game:sendData(actionCodes.Role_selectOptionItemRpc, MsgPack.pack({itemId = itemId, selectId = selectId}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Role_selectOptionItemRpc, function(event)
        UIHelper.removeWaiting()
        local reward = {}
        reward[selectId] = itemData.content:getv(selectId, 0)
        MedalRewardLayer.new({items = reward})
        if btn then
          local label = btn:getChildByName("countLabel")
          label:setString("" .. (game.role.items[tonumber(itemId)] or 0))
        end
      end)
      return true
    end
  })
end

function ActivityMainLayer:showNewRechargeLayer(Type)
  local mainBg = display.newSprite(NewRechargeRes .. "recharge_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local itemData = ItemCsv[globalCsv.optionalItemId]
  if itemData then
    local itemCount = game.role.items[tonumber(itemData.itemId)] or 0
    local optionalBtn = UIHelper.extend(ccui.Button:create())
    optionalBtn:setImages(GlobalRes, {
      "gift_optional.png",
      "gift_optional.png"
    })
    optionalBtn:pos(50, 470):addTo(mainBg):setTouchScale()
    optionalBtn:setCallback(function()
      local count = game.role.items[tonumber(globalCsv.optionalItemId)] or 0
      if count <= 0 then
        MFlashMsg:show({
          text = "主厨，您还未获得" .. itemData.name
        })
        return
      end
      self:showOptionalBox(globalCsv.optionalItemId, optionalBtn)
    end)
    local label = display.newTTFLabel({
      text = "" .. itemCount,
      size = 26,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):name("countLabel"):pos(74, 15):addTo(optionalBtn)
    local stars = UIHelper.createSpineNodeByRes("spine/ui/activity/stars")
    stars:setAnimation(0, "special", true)
    stars:pos(49, 49):scale(0.8):addTo(optionalBtn):name("stars")
  end
  local curNum = game.role.activityStatus["43"]:getv(#NewRechargeCsv, 0)
  if curNum == -1 then
    curNum = NewRechargeCsv[#NewRechargeCsv].money
  end
  local percent = 0
  local barBg = display.newSprite(NewRechargeRes .. "bar_bg.png"):anch(0, 0):pos(62, 45):addTo(mainBg)
  local barContent = display.newSprite(NewRechargeRes .. "bar_content.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(64, 47):addTo(mainBg)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(1, 0))
  local progressNum = display.newTTFLabel({
    text = string.format("%s/%s", curNum, NewRechargeCsv[#NewRechargeCsv].money),
    size = 18,
    color = UIHelper.hex2rgb("#faff00")
  }):enableOutline(UIHelper.hex2rgb("#872f0c"), 1):center(progressBar):addTo(progressBar)
  UIHelper.makeFontClear(progressNum)
  local color = {
    [-1] = UIHelper.hex2rgb("#ffffff"),
    [0] = UIHelper.hex2rgb("#faff00"),
    [1] = UIHelper.hex2rgb("#ff2b35")
  }
  
  local function createTag(params)
    local id = params.data.id
    local count = params.count
    local money = params.data.money
    local state = params.state
    local tagBg = UIHelper.newImageView(NewRechargeRes .. string.format("tag_%d.png", state + 2))
    tagBg:anch(0.5, 0):pos(math.ceil(id / count * 900 - 50), 68):addTo(mainBg)
    local item = params.data.gift:toArray("=", true)
    display.newSprite(string.format("ui/carbon/chooseTravel/box_%d.png", id)):pos(56, 110):addTo(tagBg)
    local numLabel = display.newTTFLabel({
      text = money,
      size = 22,
      color = color[state]
    }):anch(0, 0.5):pos(82, 10):rotation(-40):addTo(tagBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    local newPercent = 0
    if money <= curNum then
      newPercent = id / count
    else
      local oriMoney = id == 1 and 0 or NewRechargeCsv[id - 1].money
      if oriMoney < curNum then
        newPercent = (id - (money - curNum) / (money - oriMoney)) / count
      end
    end
    if newPercent > percent then
      percent = newPercent
    end
    if state == -1 then
      display.newSprite(LevelRes .. "had.png"):pos(56, 58):addTo(tagBg)
      return
    end
    local btn = UIHelper.extend(ccui.Button:create())
    local btnImage = state == 1 and "cant.png" or "get.png"
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(56, 58):addTo(tagBg):setTouchScale()
    
    local function callback()
      if state == 1 then
        ItemRewardLayer.new({
          items = params.data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
        return
      end
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 43, id = id}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:removeSelf()
        tagBg:setImage(NewRechargeRes .. "tag_1.png")
        tagBg:setTouchEnabled(false)
        numLabel:setTextColor(color[-1])
        display.newSprite(LevelRes .. "had.png"):pos(56, 58):addTo(tagBg)
        local msg = MsgPack.unpack(event.data)
        if msg.change then
          MDialog:single({
            title = "温馨提示",
            text = "获得的重复外观已自动折算为等值物品"
          }, function()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        else
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
      end)
    end
    
    btn:setCallback(callback)
    tagBg:setCallback(callback)
  end
  
  for index, data in pairs(NewRechargeCsv) do
    local state = game.role.activityStatus["43"]:getv(index, 0)
    if state ~= -1 then
      state = state >= data.money and 0 or 1
    end
    createTag({
      data = data,
      count = #NewRechargeCsv,
      state = state
    })
  end
  progressBar:setPercentage(percent * 100)
  local numStr = ""
  for i = 1, #NewRechargeCsv do
    numStr = numStr .. NewRechargeCsv[i].money .. "/"
  end
  numStr = string.format("活动期间累积充值达到%s，就可以领取", string.sub(numStr, 1, -2))
  local tipLabel = MRichText.new({
    text = numStr,
    size = 22,
    color = UIHelper.hex2rgb("#530d17")
  }):anch(0.5, 0.5):pos(455, 27):addTo(mainBg)
  UIHelper.makeFontClear(tipLabel)
end

function ActivityMainLayer:showMarryGiftLayer(Type)
  local mainBg = display.newSprite(MarryRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local cur = game.role.achievementTypeStatus:getv(47, 0)
  display.newSprite(MarryRes .. "title_image.png"):anch(0, 0.5):pos(380, 375):addTo(mainBg)
  display.newSprite(MarryRes .. "title_image.png"):anch(0, 0.5):pos(15, 375):setFlippedX(true):addTo(mainBg)
  display.newTTFLabel({
    text = string.format("已誓约%d名食灵", cur),
    size = 26
  }):enableOutline(UIHelper.hex2rgb("#98263b"), 1):pos(250, 375):addTo(mainBg)
  local Pos = {
    {75, 175},
    {210, 260},
    {380, 295},
    {530, 210},
    {380, 110}
  }
  for index, data in ipairs(MarryCsv) do
    local bg = UIHelper.newImageView(MarryRes .. "circle_bg.png")
    local items = data.gift:toArray("=", true)
    bg:pos(Pos[index][1], Pos[index][2]):addTo(mainBg)
    bg:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = bg,
        itemType = items[1],
        itemData = ItemCsv[items[1]]
      })
    end)
    display.newSprite(ItemCsv[items[1]].icon):scale(ItemType.HeadFarme == ItemCsv[items[1]].type and 0.7 or 1):center(bg):addTo(bg)
    local label = display.newTTFLabel({
      text = string.format("誓约%d名", data.count),
      size = 20,
      color = UIHelper.hex2rgb("#f62135")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(64, 122):addTo(bg)
    UIHelper.makeFontClear(label)
    display.newTTFLabel({
      text = "x" .. items[2],
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#781818"), 1):anch(1, 0.5):pos(95, 24):addTo(bg)
    local status = game.role.activityStatus[tostring(Type)]:getv(data.id, 0)
    if status == -1 then
      display.newSprite(MarryRes .. "done.png"):center(bg):addTo(bg)
    elseif cur >= data.count then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(MagicRes, {"btn_1.png", "btn_1.png"})
      btn:setString({
        text = "领取",
        size = 21,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#f62135"), 1)
      btn:pos(66, -12):addTo(bg)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_marryRewardRpc, MsgPack.pack({
          type = 45,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_marryRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          btn:removeSelf()
          display.newSprite(MarryRes .. "done.png"):center(bg):addTo(bg)
        end)
      end)
    end
  end
end

function ActivityMainLayer:showMarryGiftLayer2(Type)
  local mainBg = display.newSprite(Marry86Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local cur = game.role.activityStatus[tostring(Type)].num or 0
  display.newSprite(Marry86Res .. "title_image.png"):anch(0, 0.5):pos(800, 480):addTo(mainBg)
  display.newSprite(Marry86Res .. "title_image.png"):anch(0, 0.5):pos(514, 480):setFlippedX(true):addTo(mainBg)
  display.newTTFLabel({
    text = string.format("已誓约%d名食灵", cur),
    size = 26
  }):enableOutline(UIHelper.hex2rgb("#98263b"), 1):pos(710, 480):addTo(mainBg)
  local Pos = {
    {150, 65},
    {300, 65},
    {450, 65},
    {530, 210},
    {380, 110}
  }
  for index, data in ipairs(Marry86Csv) do
    local bg = UIHelper.newImageView(Marry86Res .. "circle_bg.png")
    local items = data.gift:toArray("=", true)
    bg:pos(Pos[index][1], Pos[index][2]):addTo(mainBg)
    bg:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = bg,
        itemType = items[1],
        itemData = ItemCsv[items[1]]
      })
    end)
    display.newSprite(ItemCsv[items[1]].icon):scale(ItemType.HeadFarme == ItemCsv[items[1]].type and 0.7 or 1):center(bg):addTo(bg)
    local label = display.newTTFLabel({
      text = string.format("誓约%d名", data.count),
      size = 20,
      color = UIHelper.hex2rgb("#f62135")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(64, 122):addTo(bg)
    UIHelper.makeFontClear(label)
    display.newTTFLabel({
      text = "x" .. items[2],
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#781818"), 1):anch(1, 0.5):pos(95, 24):addTo(bg)
    local status = game.role.activityStatus[tostring(Type)].status and game.role.activityStatus[tostring(Type)].status:getv(data.id, 0) or 0
    if status == -1 then
      display.newSprite(Marry86Res .. "done.png"):center(bg):addTo(bg)
    elseif cur >= data.count then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(Marry86Res, {"btn_1.png", "btn_1.png"})
      btn:setString({
        text = "领取",
        size = 21,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#f62135"), 1)
      btn:pos(66, -12):addTo(bg)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_marryRewar86dRpc, MsgPack.pack({
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_marryRewar86dRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          btn:removeSelf()
          display.newSprite(Marry86Res .. "done.png"):center(bg):addTo(bg)
        end)
      end)
    end
  end
end

function ActivityMainLayer:showYearScoreLayer(Type)
  local mainBg = display.newSprite(YearScoreRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGO = UIHelper.extend(ccui.Button:create())
  btnGO:setImages(LtyRes, {"btn_go.png", "btn_go.png"})
  btnGO:anch(1, 0.5):pos(912, 35):addTo(mainBg):setTouchScale()
  btnGO:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "oneyear"})
  end)
end

function ActivityMainLayer:showShakeHappyLayer(type)
  local isTurning = false
  local selectId = 1
  local mainBg = display.newSprite(ShakeHappyRes .. "main_bg.png"):pos(0, 2):addTo(self.content)
  local coin = globalCsv.shakeCost1:toArray("=", true)
  local countBg = display.newSprite("ui/kitchen/cook/paper_bg.png"):anch(1, 0.5):pos(865, 490):addTo(mainBg)
  display.newSprite(ItemCsv[coin[1]].icon):scale(0.6):pos(23, 19):addTo(countBg)
  local countLabel = display.newTTFLabel({
    text = game.role.items[coin[1]] or 0,
    size = 20
  }):pos(106, 17):addTo(countBg)
  UIHelper.makeFontClear(countLabel)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 492):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_55"
    })
  end)
  local btnInfo2 = UIHelper.extend(ccui.Button:create())
  btnInfo2:setImages(ShakeHappyRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo2:pos(367, 381):addTo(mainBg):setTouchScale()
  btnInfo2:setCallback(function()
    local status = game.role.activityStatus[tostring(type)] or {}
    local drawItems = status[tostring(selectId)] or ""
    status.limit = status.limit or ""
    local rewarditems = {
      itemGot = {},
      itemLeft = {}
    }
    for _, gift in ipairs(ShakeGiftCsv[selectId]) do
      local drawCount = drawItems:getv(gift.giftId, 0)
      local leftCount = gift.count - drawCount
      local giftItem = gift.gift:toArray("=", true)
      if gift.count == 0 then
        drawCount, leftCount = 0, 1
      end
      if gift.limit == 1 and status.limit:getv(giftItem[1], 0) ~= 0 then
        drawCount, leftCount = gift.count, 0
      end
      if 0 < drawCount then
        for i = 1, drawCount do
          table.insert(rewarditems.itemGot, gift.gift)
        end
      end
      if 0 < leftCount then
        for i = 1, leftCount do
          table.insert(rewarditems.itemLeft, gift.gift)
        end
      end
    end
    UIHelper.showRewardItem(rewarditems)
  end)
  local spine = UIHelper.createSpineNodeByRes("spine/ui/activity/bjcjx")
  spine:setAnimation(0, "zhuanquandaiji", true)
  spine:setSkin("zhuanpan" .. selectId)
  spine:anch(0, 0):pos(235, 105):addTo(mainBg):name("spine")
  local costType = {
    [1] = "1次消耗:",
    [2] = "10次消耗:"
  }
  local costNum = selectId == 9 and globalCsv.shakeCost2:toNumMap() or globalCsv.shakeCost1:toNumMap()
  for type, text in ipairs(costType) do
    local round = type == 2 and 10 or 1
    display.newTTFLabel({text = text, size = 20}):anch(0, 0):pos(10 + type * 260, 112):addTo(mainBg):enableOutline(UIHelper.hex2rgb("#541c06"), 2)
    display.newSprite(ItemCsv[coin[1]].icon):scale(0.5):anch(0, 0):pos(110 + type * 260, 106):addTo(mainBg)
    display.newTTFLabel({
      text = "x " .. costNum[coin[1]] * round,
      size = 20
    }):anch(0, 0):pos(165 + type * 260, 112):addTo(mainBg):enableOutline(UIHelper.hex2rgb("#541c06"), 2):name("costLabel" .. type)
  end
  local buttonType = {
    [1] = {
      name = "轻轻摇",
      anima = {1, 2}
    },
    [2] = {
      name = "普通摇",
      anima = {3, 4}
    },
    [3] = {
      name = "用力摇",
      anima = {5, 7}
    },
    [4] = {
      name = "闭眼摇",
      anima = {
        1,
        2,
        3,
        4,
        5,
        7
      }
    },
    [5] = {
      name = "十连摇",
      anima = {
        1,
        2,
        3,
        4,
        5,
        7
      }
    }
  }
  local animaType = {
    [1] = {name = "hongqiu"},
    [2] = {name = "ziqiu"},
    [3] = {name = "lanqiu"},
    [4] = {name = "baiqiu"},
    [5] = {name = "huangqiu"},
    [6] = {name = "10lianqiu"}
  }
  local turnBtns = {}
  local btnBg = display.newSprite(ShakeHappyRes .. "btn_bg.png"):anch(0, 1):pos(760, 412):addTo(mainBg)
  local interval = 52
  for i = 1, 5 do
    local btnName = i == 5 and "btn_2.png" or "btn_1.png"
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(ShakeHappyRes, {btnName, btnName})
    btn:pos(74, 297 - i * interval):addTo(btnBg):setTouchScale()
    btn:setCallback(function()
      if isTurning then
        return
      end
      isTurning = true
      game:sendData(actionCodes.Activity_shakeRewardRpc, MsgPack.pack({
        type = 55,
        id = selectId,
        shakeType = i
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_shakeRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        local state = msg.state
        if state == -1 then
          SysError(SYS_ERR_SHAKE_POOL_EMPTY)
          isTurning = false
          return
        end
        if state == -2 then
          SysError(SYS_ERR_SHAKE_COST_NOT_ENOUGH)
          isTurning = false
          return
        end
        countLabel:setString(game.role.items[coin[1]] or 0)
        UIHelper.makeFontClear(countLabel)
        local rewardColor = i == 5 and 6 or msg.color
        local animaIndex = math.randomInt(1, #buttonType[i].anima)
        spine:setAnimation(0, "zhuanquan" .. buttonType[i].anima[animaIndex], false)
        spine:registerSpineEventHandler(function(event)
          if event.type ~= "end" then
            return
          end
          local ball = UIHelper.createSpineNodeByRes("spine/ui/activity/bjcjx_qiu")
          ball:setAnimation(0, animaType[rewardColor].name, false)
          ball:anch(0, 0):pos(200, 105):addTo(mainBg)
          ball:registerSpineEventHandler(function(event)
            if event.type ~= "end" then
              return
            end
            MedalRewardLayer.new({
              items = msg.reward,
              rewardStr = msg.rewardStr
            })
            refreshBtn()
            isTurning = false
            scheduler.performWithDelayGlobal(function()
              ball:removeSelf()
            end, 0.016666666666666666)
          end, sp.EventType.ANIMATION_END)
          spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
        end, sp.EventType.ANIMATION_END)
      end)
    end)
    local labelColor = i == 5 and "#bf7d12" or "#cba58d"
    local btnLabel = display.newTTFLabel({
      text = buttonType[i].name,
      size = 24
    }):center(btn):addTo(btn):enableOutline(UIHelper.hex2rgb(labelColor), 2)
    UIHelper.makeFontClear(btnLabel)
  end
  
  function refreshBtn()
    for _, btn in ipairs(turnBtns) do
      btn:removeSelf()
    end
    turnBtns = {}
    local status = game.role.activityStatus[tostring(type)] or {}
    status.open = status.open or "1=1"
    local keyMapping = globalCsv.keyMapping:toNumMap()
    for poolId, keyId in pairs(keyMapping) do
      local keyCount = game.role.items[keyId] or 0
      if 0 < keyCount and status.open:getv(poolId, 0) ~= 1 then
        status.open = status.open:setv(poolId, 1)
      end
    end
    local offSetX = 90
    for i = 1, 9 do
      local btnName = string.format("turn_%s.png", i)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(ShakeHappyRes, {btnName, btnName})
      btn:pos(5 + i * offSetX, 48):addTo(mainBg):setTouchScale()
      turnBtns[i] = btn
      if selectId ~= i then
        display.newSprite(ShakeHappyRes .. "mask.png"):center(btn):addTo(btn, _, -1):name("mask")
      end
      if status.open:getv(i, 0) ~= 0 then
        btn:setCallback(function()
          if isTurning then
            return
          end
          display.newSprite(ShakeHappyRes .. "mask.png"):center(turnBtns[selectId]):addTo(turnBtns[selectId], _, -1):name("mask")
          btn:removeChildByName("mask")
          selectId = i
          spine:setSkin("zhuanpan" .. selectId)
          local costNum = selectId == 9 and globalCsv.shakeCost2:toNumMap() or globalCsv.shakeCost1:toNumMap()
          for type, _ in ipairs(costType) do
            local round = type == 2 and 10 or 1
            local costLabel = mainBg:getChildByName("costLabel" .. type)
            costLabel:setString("x " .. costNum[coin[1]] * round)
          end
        end)
      else
        display.newSprite(ShakeHappyRes .. "lock.png"):center(btn):addTo(btn):name("lock")
      end
    end
  end
  
  refreshBtn()
end

function ActivityMainLayer:showShakeLimitLayer(Type)
  local mainBg = display.newSprite(ShakeHappy2Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 492):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    UIHelper.showOnleImgTip(ShakeHappy2Res .. "info.png")
  end)
  local btnInfo2 = UIHelper.extend(ccui.Button:create())
  btnInfo2:setImages(ShakeHappy2Res, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo2:pos(367, 351):addTo(mainBg):setTouchScale()
  btnInfo2:setCallback(function()
    local drawItems = game.role.activityStatus[tostring(Type)]
    local rewarditems = {
      itemGot = {},
      itemLeft = {}
    }
    for _, gift in ipairs(ShakeLimitCsv) do
      local drawCount = drawItems:getv(gift.id, 0)
      if 0 < drawCount then
        table.insert(rewarditems.itemGot, gift.gift)
      else
        table.insert(rewarditems.itemLeft, gift.gift)
      end
    end
    UIHelper.showRewardItem(rewarditems)
  end)
  local spine = UIHelper.createSpineNodeByRes("spine/ui/activity/bjcjx")
  spine:setAnimation(0, "zhuanquandaiji", true)
  spine:setSkin("zhuanpan9")
  spine:anch(0, 0):pos(235, 75):addTo(mainBg):name("spine")
  display.newTTFLabel({
    text = "本次消耗:",
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#541c06"), 2):anch(0, 0):pos(275, 82):addTo(mainBg)
  display.newSprite(ItemCsv[5].icon):scale(0.5):anch(0, 0):pos(370, 76):addTo(mainBg)
  local lab = display.newTTFLabel({text = "x 0", size = 20}):enableOutline(UIHelper.hex2rgb("#541c06"), 2):anch(0, 0):pos(425, 84):addTo(mainBg)
  local animaType = {
    [1] = {name = "hongqiu"},
    [2] = {name = "ziqiu"},
    [3] = {name = "lanqiu"},
    [4] = {name = "baiqiu"},
    [5] = {name = "huangqiu"},
    [6] = {name = "10lianqiu"}
  }
  local costs = globalCsv.shakeCostSpecial:toArray("=", true)
  local got
  
  local function checkTimes()
    got = 0
    local status = game.role.activityStatus[tostring(Type)]
    for _, data in ipairs(ShakeLimitCsv) do
      if status:getv(data.id, 0) == 1 then
        got = got + 1
      end
    end
    lab:setString(string.format("x %d", got == #ShakeLimitCsv and 0 or costs[got + 1]))
  end
  
  checkTimes()
  local wait = false
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(ShakeHappy2Res, {"btn_2.png", "btn_2.png"})
  btn:pos(823, 180):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    if wait then
      return
    end
    if got >= #ShakeLimitCsv then
      SysError(SYS_ERR_SHAKE_POOL_EMPTY)
      return
    end
    if game.role.diamond < costs[got + 1] then
      UIHelper.showDiamondTip()
      return
    end
    game:sendData(actionCodes.Activity_shakeLimitRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_shakeLimitRpc, function(event)
      UIHelper.removeWaiting()
      wait = true
      checkTimes()
      local msg = MsgPack.unpack(event.data)
      spine:setAnimation(0, "zhuanquan" .. math.random(1, 2), false)
      spine:registerSpineEventHandler(function(event)
        if event.type ~= "end" then
          return
        end
        local ball = UIHelper.createSpineNodeByRes("spine/ui/activity/bjcjx_qiu")
        ball:setAnimation(0, animaType[msg.color].name, false)
        ball:anch(0, 0):pos(200, 75):addTo(mainBg)
        ball:registerSpineEventHandler(function(event)
          if event.type ~= "end" then
            return
          end
          MedalRewardLayer.new({
            items = msg.reward
          })
          wait = false
          scheduler.performWithDelayGlobal(function()
            ball:removeSelf()
          end, 0.016666666666666666)
        end, sp.EventType.ANIMATION_END)
        spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
      end, sp.EventType.ANIMATION_END)
    end)
  end)
  display.newTTFLabel({text = "转 动", size = 24}):enableOutline(UIHelper.hex2rgb("#FF4423"), 1):center(btn):addTo(btn)
end

function ActivityMainLayer:showSauceUpLayer(Type)
  local mainBg = display.newSprite(SauceUpRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MainRes, {
    "btn_cook_up_a.png",
    "btn_cook_up_b.png"
  })
  btn:anch(1, 0.5):pos(913, 39):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    if not CommonHelper.funcOpen("sauce") then
      SysError(SYS_ERR_FUNCOPEN_SAUCE)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 6})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "活动")
      layer:close()
    end)
  end)
end

function ActivityMainLayer:showGeneralScoreLayer(Type)
  local mainBg = display.newSprite(GeneralScoreRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local btnGo = UIHelper.extend(ccui.Button:create())
  btnGo:setImages(GeneralScoreRes, {"btn_go.png", "btn_go.png"})
  btnGo:anch(1, 0.5):pos(912, 35):addTo(mainBg):setTouchScale()
  btnGo:setCallback(function()
    game:enterScene("MidAutumnScene", {sceneType = "general2"})
  end)
end

function ActivityMainLayer:showCarbonDropUpLayer(Type)
  local mainBg = display.newSprite(CarbonDropUpRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local curCount = game.role.activityStatus[tostring(Type)] == "" and 0 or game.role.activityStatus[tostring(Type)]
  local num = display.newTTFLabel({
    text = string.format("当前掉落:%d/%d", curCount, globalCsv.ActivityCarbonDropCount),
    size = 30,
    color = UIHelper.hex2rgb("#fff9e9")
  }):anch(0, 0.5):pos(100, 19):addTo(mainBg)
  num:enableOutline(UIHelper.hex2rgb("#5e2807"), 1)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(CarbonDropUpRes, {"btn_go.png", "btn_go.png"})
  btn:anch(1, 0.5):pos(912, 110):addTo(mainBg):setTouchScale()
  btn:setCallback(function()
    local layer = game:createView("carbon.CarbonMainLayer")
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "活动")
      CommonHelper.playHomeBGM()
    end)
  end)
  local btn1 = UIHelper.extend(ccui.Button:create())
  btn1:setImages(CarbonDropUpRes, {
    "btn_go1.png",
    "btn_go1.png"
  })
  btn1:anch(1, 0.5):pos(912, 40):addTo(mainBg):setTouchScale()
  btn1:setCallback(function()
    self:showData({selected = 55})
    TopBar:show(TopBarType.full, "活动")
  end)
end

function ActivityMainLayer:showCommonCarbonDrawLayer(Type)
  local mainBg = display.newSprite(CarbonDrawRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local countBg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):anch(1, 0.5):pos(910, 490):addTo(mainBg)
  local countLab = display.newTTFLabel({text = 0, size = 22}):pos(104, 19):addTo(countBg)
  local frame = display.newSprite(CarbonDrawRes .. "draw_frame.png"):pos(605, 288):addTo(mainBg)
  display.newSprite(CarbonDrawRes .. "btns_bg.png"):anch(0.5, 1):pos(297, 2):addTo(frame)
  local drawCountKey = 9999999
  local costId = 0
  local curGroup = 1
  self.drawCount = game.role.activityStatus[tostring(Type)]:getv(drawCountKey, 0)
  local leftBg = UIHelper.newImageView(CarbonDrawRes .. "draw_left_bg.png"):pos(486, 63):addTo(frame)
  leftBg:setCallback(function()
    local mask, image = UIHelper.showOnleImgTip(CarbonDrawRes .. "draw_info_bg.png")
    if globalCsv.ActivityDrawType == 1 then
      local node1 = display.newNode():pos(76, 395):addTo(image)
      local node2 = display.newNode():pos(76, 261):addTo(image)
      local now, all, group = {}, {}, {
        {},
        {}
      }
      for _, data in pairs(CarbonDrawCsv) do
        if data.group == curGroup then
          local itemId, count = data.gift:match("(%d+)=(%d+)")
          if not all[tonumber(itemId)] then
            if data.prize == 1 then
              table.insert(group[1], tonumber(itemId))
            else
              table.insert(group[2], tonumber(itemId))
            end
          end
          now[tonumber(itemId)] = (now[tonumber(itemId)] or 0) + game.role.activityStatus[tostring(Type)]:getv(data.id, 0)
          all[tonumber(itemId)] = (all[tonumber(itemId)] or 0) + data.limit
        end
      end
      local xPos, yPos = 6, 0
      for i, itemId in ipairs(group[1]) do
        if 6 < i then
          break
        end
        ItemIcon.new({type = itemId, showTip = true}):scale(0.8):pos(xPos, 10):addTo(node1)
        local tempLimit = all[itemId] - now[itemId]
        display.newTTFLabel({
          text = 999 <= tempLimit and "∞" or string.format("剩余%d", tempLimit),
          size = 18,
          color = UIHelper.hex2rgb("#630c07")
        }):pos(xPos, -35):addTo(node1)
        xPos = xPos + 110
      end
      xPos, yPos = 6, -5
      for i, itemId in ipairs(group[2]) do
        if 18 < i then
          break
        end
        ItemIcon.new({type = itemId, showTip = true}):scale(0.8):pos(xPos, 10 + yPos):addTo(node2)
        local tempLimit = all[itemId] - now[itemId]
        display.newTTFLabel({
          text = 999 <= tempLimit and "∞" or string.format("剩余%d", tempLimit),
          size = 18,
          color = UIHelper.hex2rgb("#630c07")
        }):pos(xPos, -35 + yPos):addTo(node2)
        xPos = xPos + 110
        if i % 6 == 0 then
          xPos = 6
          yPos = yPos - 100
        end
      end
    else
      local lineCount = 9
      local group1, group2 = {}, {}
      for _, data in ipairs(CarbonDrawCsv) do
        if data.prize == 1 then
          table.insert(group1, data)
        else
          table.insert(group2, data)
        end
      end
      local node1 = display.newNode():pos(45, 395):addTo(image)
      local xPos = 6
      for idx, data in ipairs(group1) do
        if lineCount < idx then
          break
        end
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.8):pos(xPos, 10):addTo(node1)
        xPos = xPos + 76
      end
      local list = ccui.ListView:create()
      list:size(cc.size(690, 306))
      list:setInnerContainerSize(cc.size(690, 306))
      list:setClippingEnabled(true)
      list:setBounceEnabled(true)
      list:anch(0, 0):pos(10, 10):addTo(image)
      for row = 1, math.ceil(#group2 / lineCount) do
        xPos = 6
        local viewNode = ccui.Widget:create()
        viewNode:setContentSize(cc.size(690, 86)):addTo(list)
        for i = 1, lineCount do
          local data = group2[(row - 1) * lineCount + i]
          if not data then
            break
          end
          local item = data.gift:toArray("=", true)
          ItemIcon.new({
            type = item[1],
            count = item[2],
            showTip = true
          }):scale(0.8):anch(0, 0.5):pos(xPos, 43):addTo(viewNode)
          xPos = xPos + 76
        end
      end
      list:requestDoLayout()
    end
  end)
  local leftTip = display.newTTFLabel({text = "", size = 20}):enableOutline(UIHelper.hex2rgb("#C85F26"), 1):anch(0, 0.5):setRotation(-20):pos(-32, 42):addTo(leftBg)
  local leftNum = display.newTTFLabel({
    text = "点击查看奖励",
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#C85F26"), 1):anch(0, 0.5):setRotation(-20):pos(19, 20):addTo(leftBg)
  local sprite = display.newSprite(CarbonDrawRes .. "draw_image_1.png"):pos(297, 172):addTo(frame)
  sprite:setLocalZOrder(-1)
  
  local function getDrawNum()
    local now, level, group = 0, 0, {}
    local temp = 0
    for _, data in ipairs(CarbonDrawCsv) do
      temp = temp + data.limit
      now = now + game.role.activityStatus[tostring(Type)]:getv(data.id, 0)
      group[data.group] = temp
    end
    for i, value in ipairs(group) do
      if value > now then
        level = i
        break
      end
    end
    if level == 0 then
      level = #group
    end
    return now, level, group
  end
  
  local function updateDrawNum(...)
    local now, level, group = getDrawNum()
    curGroup = level
    leftTip:setString(string.format("当前%d/%d阶段", level, #group))
    local tempLeftNum = group[level] - now
    leftNum:setString(999 <= tempLeftNum and "奖励剩余: ∞" or string.format("奖励剩余: %d", tempLeftNum))
    sprite:setTexture(CarbonDrawRes .. string.format("draw_image_%d.png", level))
  end
  
  if globalCsv.ActivityDrawType == 1 then
    updateDrawNum()
  end
  
  local function itemNotEnoughDialogOpen()
    MDialog:double({
      text = "活动道具不足，无法抽奖，是否跳转商城购买？",
      size = 24,
      color = UIHelper.hex2rgb("#430602"),
      cancelCallback = function()
        return true
      end,
      okCallback = function()
        local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 3})
        BackManager:push(function()
          TopBar:show(TopBarType.full, "活动")
          layer:close()
        end)
        return true
      end
    })
  end
  
  local function draw(num)
    local now, level, group = getDrawNum()
    if now >= group[level] then
      SysError(SYS_ERR_CARBON_ACTIVITY_DRAW_OUT)
      return
    elseif num == 10 and level == #group and group[level] - now < 10 then
      itemNotEnoughDialogOpen()
      return
    end
    local str = num == 1 and globalCsv.ActivityDrawCost_1 or globalCsv.ActivityDrawCost_10
    local cost = str:toArray("=", true)
    if (game.role.items[cost[1]] or 0) < cost[2] then
      itemNotEnoughDialogOpen()
      return
    end
    game:sendData(actionCodes.Activity_newYearDrawRewardRpc, MsgPack.pack({
      type = num == 1 and 1 or 2,
      reward2 = true
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_newYearDrawRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.reward = msg.reward
      self.drawCount = game.role.activityStatus[tostring(Type)]:getv(drawCountKey, 0)
      self.drawCountLabel:setString("抽取次数：" .. self.drawCount)
      self.closeCount = 0
      self.needCloseCount = #self.reward
      for i = 1, #self.reward do
        if self.reward[i].changeId then
          self.needCloseCount = self.needCloseCount + 1
        end
      end
      self.heros = {}
      for _, data in pairs(self.reward) do
        if ItemCsv[data.id].type == ItemType.Hero then
          self.heros[data.id] = (self.heros[data.id] or 0) + data.count
        end
      end
      countLab:setString(game.role.items[costId] or 0)
      if globalCsv.ActivityDrawType == 1 then
        updateDrawNum()
      end
      self:showAnimation(function()
        if msg.reward2 and next(msg.reward2) then
          MedalRewardLayer.new({
            items = msg.reward2,
            bShow = true
          })
        end
      end)
    end)
  end
  
  local btnOne = UIHelper.extend(ccui.Button:create())
  btnOne:setImages(CarbonDrawRes, {
    "btn_draw_1.png",
    "btn_draw_1.png"
  })
  btnOne:pos(178, -34):addTo(frame):setTouchScale()
  btnOne:setCallback(function()
    draw(1)
  end)
  local btnTen = UIHelper.extend(ccui.Button:create())
  btnTen:setImages(CarbonDrawRes, {
    "btn_draw_10.png",
    "btn_draw_10.png"
  })
  btnTen:pos(417, -34):addTo(frame):setTouchScale()
  btnTen:setCallback(function()
    draw(10)
  end)
  self.drawCountLabel = display.newTTFLabel({
    text = "抽取次数：" .. self.drawCount,
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(300, -88):addTo(frame)
  local id, count = globalCsv.ActivityDrawCost_1:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count, size = 24}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(40, 34):addTo(btnOne)
  id, count = globalCsv.ActivityDrawCost_10:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count, size = 24}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(40, 34):addTo(btnTen)
  costId = tonumber(id)
  display.newSprite(ItemCsv[costId].icon):scale(0.5):pos(71, 34):addTo(btnOne)
  display.newSprite(ItemCsv[costId].icon):scale(0.5):pos(76, 34):addTo(btnTen)
  display.newSprite(ItemCsv[costId].icon):scale(0.7):pos(17, 18):addTo(countBg)
  countLab:setString(game.role.items[costId] or 0)
  countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = countBg,
      itemType = costId,
      itemData = ItemCsv[costId]
    })
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "secretVickie"
    })
  end)
end

function ActivityMainLayer:showAnimation(_callBack)
  if _callBack then
    self.callBack59 = _callBack
  end
  self.mask = UIHelper.extend(ccui.Layout:create())
  local isIphonex = false
  if UIHelper.isiPhoneX() then
    isIphonex = true
    self.mask:size(display.width + UIHelper.getMoveXForX() * 2, display.height)
  else
    self.mask:size(display.width, display.height)
  end
  self.mask:setBackGroundColorType(1)
  self.mask:setBackGroundColor(cc.c3b(0, 0, 0))
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:setBackGroundColorOpacity(0)
  self.mask:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  local spine = UIHelper.createSpineNodeByRes("ui/diner/draw/feichuan")
  spine:setAnimation(0, "bg", false)
  spine:pos(self.mask:getContentSize().width / 2, display.cy + 4):addTo(self.mask)
  if isIphonex then
    UIHelper.fitForiPhoneX(spine)
  end
  spine:runAction(transition.sequence({
    cc.DelayTime:create(10),
    cc.CallFunc:create(function()
      self.mask:setBackGroundColorOpacity(191)
      self:showItems()
    end),
    cc.RemoveSelf:create()
  }))
  self.mask:setCallback(function()
    if not tolua.isnull(spine) then
      spine:stopAllActions()
      self.mask:removeAllChildren()
      self.mask:setBackGroundColorOpacity(191)
      self:showItems()
    end
  end)
end

function ActivityMainLayer:showItems()
  self.Pos = {}
  if #self.reward == 1 then
    self.Pos[1] = {
      display.cx,
      display.cy - 10
    }
    if UIHelper.isiPhoneX() then
      self.Pos[1][1] = self.Pos[1][1] + UIHelper.getMoveXForX()
    end
  else
    local xPos, yPos = 270, 390
    if UIHelper.isiPhoneX() then
      xPos = xPos + UIHelper.getMoveXForX()
    end
    for index = 1, 10 do
      self.Pos[index] = {xPos, yPos}
      xPos = xPos + 150
      if index == 5 then
        xPos = 270
        if UIHelper.isiPhoneX() then
          xPos = xPos + UIHelper.getMoveXForX()
        end
        yPos = 210
      end
    end
  end
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  local di = display.newSprite(CarbonDrawRes .. "draw_result_bg.png"):pos(cx, display.cy):addTo(self.mask)
  di:setScaleY(0)
  di:runAction(transition.sequence({
    cc.ScaleTo:create(0.1, 1, 1),
    cc.CallFunc:create(function()
      self:open(1)
    end)
  }))
end

function ActivityMainLayer:open(index)
  if index > #self.Pos then
    return
  end
  local itemType = ItemCsv[self.reward[index].id].type
  local bg
  if self.reward[index].prize == 1 then
    bg = display.newSprite("ui/diner/draw/card_bg2.png")
    local flash = UIHelper.loadAnimation("ui/diner/draw/", "draw", 10, 10)
    flash.sprite:center(bg):addTo(bg)
    flash.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
    flash.sprite:playAnimationForever(flash.animation)
  else
    bg = display.newSprite(CarbonDrawRes .. "draw_card_bg.png")
  end
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  bg:pos(cx, display.cy):addTo(self.mask, nil, index):setScale(0)
  local name = display.newTTFLabel({
    text = ItemCsv[self.reward[index].id].name,
    size = 20,
    color = UIHelper.hex2rgb("#763636")
  }):pos(70, 22):addTo(bg)
  local countLab = display.newTTFLabel({
    text = "x" .. self.reward[index].count,
    size = 18,
    color = UIHelper.hex2rgb("#763636")
  }):anch(1, 0.5):pos(132, 50):addTo(bg):hide()
  local icon
  if itemType == ItemType.DinerCar or itemType == ItemType.DinerBox or itemType == ItemType.Fitment then
    icon = UIHelper.newImageView(ItemCsv[self.reward[index].id].icon):pos(70, 105):addTo(bg)
    icon:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = icon,
        itemType = itemType,
        itemData = ItemCsv[self.reward[index].id],
        count = 0
      })
    end)
    if 1 < self.reward[index].count then
      countLab:show()
    end
  else
    icon = ItemIcon.new({
      type = self.reward[index].id,
      count = self.reward[index].count,
      showTip = true
    }):pos(70, 105):addTo(bg)
  end
  local action = {
    transition.sequence({
      cc.EaseExponentialOut:create(cc.ScaleTo:create(0.05, 1)),
      cc.DelayTime:create(0.1),
      cc.MoveTo:create(0.1, cc.p(self.Pos[index][1], self.Pos[index][2])),
      cc.CallFunc:create(function()
        self:checkCanClose()
      end)
    }),
    transition.sequence({
      cc.DelayTime:create(0.15),
      cc.CallFunc:create(function()
        self:open(index + 1)
      end)
    })
  }
  if self.reward[index].changeId then
    action[#action + 1] = transition.sequence({
      cc.DelayTime:create(0.15 * (#self.reward - index) + 0.5),
      cc.ScaleTo:create(0.1, 0, 1),
      cc.CallFunc:create(function()
        icon:removeSelf()
        ItemIcon.new({
          type = self.reward[index].changeId,
          count = self.reward[index].changeCount,
          showTip = true
        }):pos(70, 105):addTo(bg)
        name:setString(ItemCsv[self.reward[index].changeId].name)
        countLab:hide()
      end),
      cc.ScaleTo:create(0.05, 1, 1),
      cc.CallFunc:create(function()
        self:checkCanClose()
      end)
    })
  end
  bg:runAction(cc.Spawn:create(action))
end

function ActivityMainLayer:checkCanClose()
  self.closeCount = self.closeCount + 1
  if self.closeCount >= self.needCloseCount then
    self.mask:setCallback(function()
      self.mask:removeSelf()
      if self.callBack59 then
        self.callBack59()
      end
    end)
  end
end

function ActivityMainLayer:showFormationMissionLayer(Type, diffType)
  local mainBg = display.newSprite(FormationRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local listBg = display.newSprite(FormationRes .. "list_bg.png"):pos(580, 250):addTo(mainBg)
  local list1 = ccui.ListView:create()
  list1:size(cc.size(618, 108))
  list1:setInnerContainerSize(cc.size(618, 108))
  list1:setClippingEnabled(true)
  list1:anch(0, 0.5):pos(10, 347):addTo(listBg)
  local list2 = ccui.ListView:create()
  list2:size(cc.size(618, 284))
  list2:setInnerContainerSize(cc.size(618, 284))
  list2:setClippingEnabled(true)
  list2:setBounceEnabled(true)
  list2:anch(0, 0.5):pos(10, 152):addTo(listBg)
  local diffType = diffType or 1
  local status = ""
  
  local function refreshList1()
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(618, 108)):addTo(list1)
    local data = FormationCsv[diffType][0]
    local cellBg = display.newSprite(FormationRes .. "cell_big.png"):center(viewNode):addTo(viewNode)
    local xPos = 40
    for _, item in ipairs(data.gift:toTableArray()) do
      ItemIcon.new({
        type = tonumber(item[1]),
        count = tonumber(item[2]),
        showTip = true
      }):scale(0.67):pos(xPos, 40):addTo(cellBg)
      xPos = xPos + 68
    end
    local cur = status:getv(data.group * 100, 0)
    if cur == -1 then
      display.newSprite(FormationRes .. "image_done.png"):anch(1, 0.5):pos(585, 50):addTo(cellBg)
      cur = #FormationCsv[diffType]
    elseif cur >= #FormationCsv[diffType] then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(FormationRes, {
        "btn_get.png",
        "btn_get.png"
      })
      btn:pos(528, 50):addTo(cellBg)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_formatPracticeRpc, MsgPack.pack({
          group = data.group,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_formatPracticeRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          self.content:removeAllChildren()
          self:showFormationMissionLayer(Type, diffType)
        end)
      end)
      display.newTTFLabel({text = "领取", size = 20}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):anch(0.5, 0.5):pos(60, 22):addTo(btn)
    end
    display.newTTFLabel({
      text = string.format(diffType == 1 and "新手训练营进度：%d/%d" or "进阶训练营进度：%d/%d", cur, #FormationCsv[diffType]),
      size = 23,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(8, 88):addTo(cellBg)
  end
  
  local function refreshList2()
    local sortData = {}
    for _, data in ipairs(FormationCsv[diffType]) do
      local temp = clone(data)
      temp.cur = status:getv(data.group * 100 + data.id, 0)
      table.insert(sortData, temp)
    end
    table.sort(sortData, function(a, b)
      return (a.cur > 0 and a.id or a.id * (a.cur == -1 and -10 or -1)) > (b.cur > 0 and b.id or b.id * (b.cur == -1 and -10 or -1))
    end)
    for _, data in ipairs(sortData) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(618, 108)):addTo(list2)
      local cellBg = display.newSprite(FormationRes .. "cell_small.png"):center(viewNode):addTo(viewNode)
      local xPos = 40
      for _, item in ipairs(data.gift:toTableArray()) do
        ItemIcon.new({
          type = tonumber(item[1]),
          count = tonumber(item[2]),
          showTip = true
        }):scale(0.67):pos(xPos, 40):addTo(cellBg)
        xPos = xPos + 68
      end
      local cur = status:getv(data.group * 100 + data.id, 0)
      if cur == -1 then
        display.newSprite(FormationRes .. "image_done.png"):anch(1, 0.5):pos(570, 50):addTo(cellBg)
        cur = #FormationCsv
      else
        local btn = UIHelper.extend(ccui.Button:create())
        btn:pos(528, 50):addTo(cellBg)
        if 0 < cur then
          btn:setImages(FormationRes, {
            "btn_get.png",
            "btn_get.png"
          })
          btn:setCallback(function()
            game:sendData(actionCodes.Activity_formatPracticeRpc, MsgPack.pack({
              group = data.group,
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_formatPracticeRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              MedalRewardLayer.new({
                items = msg.reward
              })
              self.content:removeAllChildren()
              self:showFormationMissionLayer(Type, diffType)
            end)
          end)
          display.newTTFLabel({text = "领取", size = 20}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):anch(0.5, 0.5):pos(60, 22):addTo(btn)
        else
          btn:setImages(FormationRes, {"btn_go.png", "btn_go.png"})
          btn:setCallback(function()
            local layer = game:createView("hero.FormationPracticeLayer", {
              types = data.heros,
              goal = data.goal,
              group = data.group,
              id = data.id
            })
            self:hide()
            BackManager:push(function()
              TopBar:show(TopBarType.full, "活动")
              self:show()
              self.content:removeAllChildren()
              self:showFormationMissionLayer(Type, diffType)
              layer:close()
            end)
          end)
          display.newTTFLabel({text = "前往", size = 20}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):anch(0.5, 0.5):pos(60, 22):addTo(btn)
        end
      end
      display.newTTFLabel({
        text = data.desc,
        size = 22,
        color = UIHelper.hex2rgb("#703802")
      }):anch(0, 0.5):pos(8, 85):addTo(cellBg)
    end
    list2:requestDoLayout()
    list2:jumpToTop()
  end
  
  local function showList()
    list1:removeAllChildren()
    list2:removeAllChildren()
    status = game.role.activityStatus[tostring(Type)] or ""
    refreshList1()
    refreshList2()
  end
  
  local names = {
    "新手训练营",
    "进阶训练营"
  }
  local group = MRadioGroup:create()
  local xPos = 295
  for idx = 1, #FormationCsv do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(FormationRes, {"btn_a.png", "btn_b.png"})
    btn:name("btn" .. idx)
    btn:setGroup(group)
    btn:anch(0.5, 0):pos(xPos, 402):addTo(listBg)
    btn:setCallback(function()
      diffType = idx
      showList()
    end)
    display.newTTFLabel({
      text = names[idx],
      size = 23
    }):enableOutline(UIHelper.hex2rgb("#3a200a"), 1):pos(103, 16):addTo(btn)
    xPos = xPos + 210
  end
  group:chooseByName("btn" .. diffType)
  showList()
end

function ActivityMainLayer:showPTRankLayer(Type)
  local rankList = {}
  game:sendData(actionCodes.Role_getPTRankRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Role_getPTRankRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    rankList = msg.list
    local mainBg = display.newSprite(PTRankRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
    local bufferCouponSmallBg = UIHelper.newImageView(CarbonRes .. "btn_add2_bg.png"):anch(0.5, 0.5):pos(730, 475):addTo(mainBg)
    display.newSprite(ItemCsv[30100].icon):scale(0.4):pos(5, 21):addTo(bufferCouponSmallBg)
    bufferCouponSmallBg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = bufferCouponSmallBg,
        itemType = 30100,
        itemData = ItemCsv[30100]
      })
    end)
    local couponLabel = display.newTTFLabel({
      text = game.role.items[30100] or 0,
      size = 24,
      color = UIHelper.hex2rgb("#38f315")
    }):pos(77, 19):addTo(bufferCouponSmallBg)
    local panel = UIHelper.newImageView("ui/tower/rank/phb.png"):anch(0, 0):pos(124, 30):scale(0.8):addTo(mainBg)
    local node1 = display.newNode():pos(430, 513):addTo(panel)
    local node2 = display.newNode():pos(430, 16):addTo(panel)
    local list = ccui.ListView:create()
    list:size(cc.size(830, 465))
    list:setInnerContainerSize(cc.size(830, 475))
    list:setClippingEnabled(true)
    list:setBounceEnabled(true)
    list:anch(0, 0):pos(35, -40):addTo(panel)
    
    local function showIcon(type)
      list:removeAllChildren()
      node1:removeAllChildren()
      node2:removeAllChildren()
      if type == 1 then
        bufferCouponSmallBg:show()
        panel:setImage("ui/tower/rank/phb.png")
        panel:pos(124, 65)
        list:pos(35, 27)
        list:size(cc.size(830, 395))
        local title = display.newTTFLabel({
          text = "PT数量排行榜",
          size = 22,
          color = UIHelper.hex2rgb("#ba471a")
        }):pos(-13, -68):addTo(node1)
        local myRank = display.newTTFLabel({
          text = "我的排行",
          size = 16
        }):pos(-20, -2):addTo(node2)
        if not next(rankList) then
          display.newTTFLabel({
            text = "还没有人上榜",
            size = 24,
            color = UIHelper.hex2rgb("#b26b3f")
          }):pos(375, 250):addTo(list)
          myRank:setString("我的排名：未上榜")
        end
        local isHave = false
        for idx, _data in ipairs(rankList) do
          local data = _data
          if data.roleId == game.role.id then
            isHave = true
            myRank:setString("我的排名：" .. idx)
          end
          self:createOnePTRank(idx, data):addTo(list)
        end
        if not isHave then
          myRank:setString("我的排名：未上榜")
        end
      else
        panel:setImage("ui/shop/main/shop_bg_1.png")
        panel:pos(124, 30)
        list:pos(115, 35)
        list:size(cc.size(830, 465))
        local itemCount = type == 2 and (game.role.items[30100] or 0) or msg.ptItem
        if type == 3 then
          bufferCouponSmallBg:hide()
        else
          bufferCouponSmallBg:show()
          couponLabel:setString(itemCount)
        end
        local cellSize = display.newSprite(ScoreRes .. "cell_a.png"):getContentSize()
        cellSize.height = cellSize.height + 4
        local giftCsv = type == 2 and PTRankCsv[1] or PTRankCsv[2]
        local line = 1
        for i = 1, math.ceil(table.nums(giftCsv) / 4) do
          local viewNode = ccui.Widget:create()
          viewNode:setContentSize(cellSize):addTo(list)
          local cell = display.newSprite(ScoreRes .. "cell_a.png"):center(viewNode):addTo(viewNode)
          local xPos, delta = 90, 170
          local index = (line - 1) * 4 == 0 and 1 or (line - 1) * 4 + 1
          for j = index, math.min(line * 4, table.nums(giftCsv)) do
            local curStatus = game.role.activityStatus["67"]
            local data = giftCsv[j]
            local done = curStatus and curStatus:getv(data.phase * 1000 + data.id, 0) or 0
            local item = data.gift:toArray("=", true)
            local bg = display.newSprite(ScoreRes .. "item_bg_open1.png"):pos(xPos, 57):addTo(cell)
            display.newSprite(ItemCsv[30100].icon):scale(0.2):pos(26, 14):addTo(bg)
            ItemIcon.new({
              type = item[1],
              count = item[2],
              showTip = true
            }):scale(0.85):pos(56, 65):addTo(bg)
            display.newTTFLabel({
              text = data.condition,
              size = 18
            }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0, 0.5):pos(42, 14):addTo(bg)
            if done == -1 then
              display.newSprite(ScoreRes .. "done.png"):pos(57, 40):addTo(bg)
            elseif itemCount >= data.condition then
              local red = display.newSprite(ScoreRes .. "red.png"):pos(57, 40):addTo(bg)
              local touch = UIHelper.extend(ccui.Layout:create())
              touch:setContentSize(cc.size(82, 78)):anch(0.5, 0.5):pos(56, 65):addTo(bg)
              touch:setSwallowTouches(true)
              touch:setCallback(function()
                game:sendData(actionCodes.Activity_ptRewardRpc, MsgPack.pack({
                  type = type,
                  id = data.phase * 1000 + data.id
                }))
                UIHelper.showWaiting()
                game:addResponseHandler(actionCodes.Activity_ptRewardRpc, function(event)
                  UIHelper.removeWaiting()
                  local msg = MsgPack.unpack(event.data)
                  red:setTexture(ScoreRes .. "done.png")
                  MedalRewardLayer.new({
                    items = msg.reward
                  })
                  touch:removeSelf()
                end)
              end)
            end
            xPos = 600 <= xPos and 90 or xPos + delta
          end
          line = line + 1
        end
        list:requestDoLayout()
      end
    end
    
    local names = {
      [1] = "排\n行\n榜",
      [2] = "个\n人\n奖",
      [3] = "全\n服\n奖"
    }
    local group = MRadioGroup:create({
      chooseCb = function(sender)
        sender:setPositionX(sender:getPositionX() - 1)
      end,
      unchooseCb = function(sender)
        sender:setPositionX(sender:getPositionX() + 1)
      end
    })
    local posY = 365
    for index, name in ipairs(names) do
      local btn = UIHelper.extend(ccui.Button:create())
      btn:name("btn" .. index)
      btn:setImages("ui/home/roleDetail", {"btn_a.png", "btn_b.png"})
      btn:pos(-20, posY):scale(1.2):addTo(panel):setTouchScale()
      display.newTTFLabel({
        text = name,
        size = 20,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#3a200a"), 1):pos(25, 40):addTo(btn)
      btn:setLocalZOrder(-1)
      btn:setGroup(group)
      btn:setCallback(function()
        group:chooseByName("btn" .. index)
        showIcon(index)
      end)
      group:chooseByName(btn1)
      showIcon(1)
      posY = posY - 100
    end
    local btnInfo = UIHelper.extend(ccui.Button:create())
    btnInfo:setImages(MagicRes, {
      "btn_info.png",
      "btn_info.png"
    })
    btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
    btnInfo:setCallback(function()
      game:createView("global.RuleLayer", {typeStr = "ptRankRule"})
    end)
  end)
end

function ActivityMainLayer:showCommonCarbonDraw2Layer(Type)
  local mainBg = display.newSprite(CarbonDraw2Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local countBg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):anch(1, 0.5):pos(910, 490):addTo(mainBg)
  local countLab = display.newTTFLabel({text = 0, size = 22}):pos(104, 19):addTo(countBg)
  local frame = display.newSprite(CarbonDraw2Res .. "draw_frame.png"):pos(605, 288):addTo(mainBg)
  display.newSprite(CarbonDraw2Res .. "btns_bg.png"):anch(0.5, 1):pos(297, 2):addTo(frame)
  local costId = 0
  local curGroup = 1
  local leftBg = UIHelper.newImageView(CarbonDraw2Res .. "draw_left_bg.png"):pos(486, 63):addTo(frame)
  leftBg:setCallback(function()
    local mask, image = UIHelper.showOnleImgTip(CarbonDraw2Res .. "draw_info_bg.png")
    local lineCount = 9
    local group1, group2 = {}, {}
    for _, data in ipairs(AwakeCsv) do
      if data.prize == 1 then
        table.insert(group1, data)
      else
        table.insert(group2, data)
      end
    end
    local node1 = display.newNode():pos(45, 395):addTo(image)
    local xPos = 6
    for idx, data in ipairs(group1) do
      if lineCount < idx then
        break
      end
      local item = data.gift:toArray("=", true)
      ItemIcon.new({
        type = item[1],
        count = item[2],
        showTip = true
      }):scale(0.8):pos(xPos, 10):addTo(node1)
      xPos = xPos + 76
    end
    local list = ccui.ListView:create()
    list:size(cc.size(690, 306))
    list:setInnerContainerSize(cc.size(690, 306))
    list:setClippingEnabled(true)
    list:setBounceEnabled(true)
    list:anch(0, 0):pos(10, 10):addTo(image)
    for row = 1, math.ceil(#group2 / lineCount) do
      xPos = 6
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(690, 86)):addTo(list)
      for i = 1, lineCount do
        local data = group2[(row - 1) * lineCount + i]
        if not data then
          break
        end
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.8):anch(0, 0.5):pos(xPos, 43):addTo(viewNode)
        xPos = xPos + 76
      end
    end
    list:requestDoLayout()
  end)
  local securityNum = game.role.activityStatus[tostring(Type)]:getv(0, 0)
  local leftTxt = securityNum >= globalCsv.awakeBaseNum and "已完成" or string.format("保底: %d/%s", securityNum, globalCsv.awakeBaseNum)
  local leftNum = display.newTTFLabel({text = leftTxt, size = 20}):enableOutline(UIHelper.hex2rgb("#C85F26"), 1):anch(0, 0.5):setRotation(-20):pos(19, 20):addTo(leftBg)
  
  local function getBtnFun()
    securityNum = game.role.activityStatus[tostring(Type)]:getv(0, 0)
    if securityNum >= globalCsv.awakeBaseNum and game.role.activityStatus[tostring(Type)]:getv(-1, 0) == 1 then
      local lastBtn = leftBg:getChildByName("rewardBtn")
      if lastBtn then
        lastBtn:removeSelf()
      end
      local btn = UIHelper.extend(ccui.Button:create()):name("rewardBtn")
      btn:setImages(MagicRes, {"btn_1.png", "btn_1.png"})
      btn:pos(-70, 24):addTo(leftBg):setTouchScale()
      btn:setString({
        text = "领取",
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#d0622c"), 2)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_awakeRewardSendRpc, MsgPack.pack({form = 2}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_awakeRewardSendRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward,
            bShow = true
          })
          btn:hide()
        end)
      end)
    end
  end
  
  getBtnFun()
  local sprite = display.newSprite(CarbonDraw2Res .. "draw_image_1.png"):pos(297, 172):addTo(frame)
  sprite:setLocalZOrder(-1)
  
  local function getDrawNum()
    local now, level, group = 0, 0, {}
    local temp = 0
    for _, data in ipairs(AwakeCsv) do
      temp = temp + data.limit
      now = now + game.role.activityStatus[tostring(Type)]:getv(data.id, 0)
      group[data.group] = temp
    end
    for i, value in ipairs(group) do
      if value > now then
        level = i
        break
      end
    end
    if level == 0 then
      level = #group
    end
    return now, level, group
  end
  
  local function updateDrawNum(...)
    local securityNum = game.role.activityStatus[tostring(Type)]:getv(0, 0)
    local leftTxt = securityNum >= globalCsv.awakeBaseNum and "已完成" or string.format("保底: %d/%s", securityNum, globalCsv.awakeBaseNum)
    leftNum:setString(leftTxt)
  end
  
  local function draw(num)
    local now, level, group = getDrawNum()
    if now >= group[level] then
      SysError(SYS_ERR_CARBON_ACTIVITY_DRAW_OUT)
      return
    elseif num == 10 and level == #group and group[level] - now < 10 then
      SysError(SYS_ERR_CARBON_ACTIVITY_NOT_ENOUGH_DRAW_TEN)
      return
    end
    local str = num == 1 and globalCsv.ActivityAwakeCost_1 or globalCsv.ActivityAwakeCost_10
    local cost = str:toArray("=", true)
    if (game.role.items[cost[1]] or 0) < cost[2] then
      local surplusNum = math.ceil(cost[2] - (game.role.items[cost[1]] or 0))
      local str = string.format("精选券不足，是否花费 <img src='ui/global/5.png' scale=0.4 />x%d 购买 <img src='ui/global/awakebuild.png' scale=0.4 />x%d？", surplusNum * 120, surplusNum * 1)
      MDialog:double({
        title = "提示",
        text = str,
        okCallback = function()
          if (game.role.diamond or 0) < surplusNum * 120 then
            UIHelper.showDiamondTip({parent = self})
          else
            if surplusNum < 1 then
              return
            end
            game:sendData(actionCodes.Store_diamondBuyRpc, MsgPack.pack({index = 1014, num = surplusNum}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Store_diamondBuyRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              MedalRewardLayer.new({
                items = msg.items
              })
              countLab:setString(game.role.items[costId] or 0)
            end)
          end
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
      return
    end
    game:sendData(actionCodes.Activity_awakeRewardRpc, MsgPack.pack({
      type = num == 1 and 1 or 2
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_awakeRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.reward = msg.reward
      self.closeCount = 0
      self.needCloseCount = #self.reward
      for i = 1, #self.reward do
        if self.reward[i].changeId then
          self.needCloseCount = self.needCloseCount + 1
        end
      end
      self.heros = {}
      for _, data in pairs(self.reward) do
        if ItemCsv[data.id].type == ItemType.Hero then
          self.heros[data.id] = (self.heros[data.id] or 0) + data.count
        end
      end
      countLab:setString(game.role.items[costId] or 0)
      updateDrawNum()
      getBtnFun()
      self:showAnimation()
    end)
  end
  
  local btnOne = UIHelper.extend(ccui.Button:create())
  btnOne:setImages(CarbonDraw2Res, {
    "btn_draw_1.png",
    "btn_draw_1.png"
  })
  btnOne:pos(178, -34):addTo(frame):setTouchScale()
  btnOne:setCallback(function()
    draw(1)
  end)
  local btnTen = UIHelper.extend(ccui.Button:create())
  btnTen:setImages(CarbonDraw2Res, {
    "btn_draw_10.png",
    "btn_draw_10.png"
  })
  btnTen:pos(417, -34):addTo(frame):setTouchScale()
  btnTen:setCallback(function()
    draw(10)
  end)
  local id, count = globalCsv.ActivityAwakeCost_1:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count, size = 24}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(40, 34):addTo(btnOne)
  id, count = globalCsv.ActivityAwakeCost_10:match("(%d+)=(%d+)")
  display.newTTFLabel({text = count, size = 24}):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(40, 34):addTo(btnTen)
  costId = tonumber(id)
  display.newSprite(ItemCsv[costId].icon):scale(0.5):pos(81, 34):addTo(btnOne)
  display.newSprite(ItemCsv[costId].icon):scale(0.5):pos(81, 34):addTo(btnTen)
  display.newSprite(ItemCsv[costId].icon):scale(0.7):pos(17, 18):addTo(countBg)
  countLab:setString(game.role.items[costId] or 0)
  countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = countBg,
      itemType = costId,
      itemData = ItemCsv[costId]
    })
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "awaken"})
  end)
end

function ActivityMainLayer:showInviteReturnLayer(Type)
  local data = game.role.activityStatus["70"]
  local mainBg = display.newSprite(InviteReturnRes .. "bg_main.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local shadow1 = display.newSprite(InviteReturnRes .. "main_bg1.png")
  shadow1:pos(205, 382.5):addTo(mainBg)
  local confirmBtn = UIHelper.extend(ccui.Button:create())
  confirmBtn:setImages(InviteReturnRes, {
    "btn_confirm1.png",
    "btn_confirm1.png",
    "btn_confirm2.png"
  })
  confirmBtn:pos(188, 30):addTo(shadow1):setTouchScale()
  confirmBtn:setCallback(function()
    if not data.oldPlayer then
      SysError(SYS_ERR_NOT_REGRESSION)
      return
    end
    if self.inviteID == "" then
      SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
      return
    end
    local temp = tonumber(self.inviteID)
    if not temp then
      MFlashMsg:show({
        text = "邀请人ID输入错误"
      })
      return
    end
    if temp == game.role.id then
      SysError(SYS_ERR_NOT_SELF_ID)
      return
    end
    game:sendData(actionCodes.Activity_getInviterRewardRpc, MsgPack.pack({msgType = 0, id = temp}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_getInviterRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.code and msg.code ~= 0 then
        return
      end
      MFlashMsg:show({
        text = "邀请人已填写成功"
      })
      self:showInviteReturnLayer(70)
    end)
  end)
  if data.inviter ~= 0 then
    local Text1 = display.newTTFLabel({
      text = data.inviter,
      size = 20,
      color = UIHelper.hex2rgb("#5c2408")
    }):anch(0, 0.5):pos(130, 202):addTo(shadow1)
    confirmBtn:setEnabled(false)
  else
    local codeBg = UIHelper.newImageView(InviteReturnRes .. "input.png")
    codeBg:pos(230, 200):addTo(shadow1)
    local text = display.newTTFLabel({
      text = "",
      size = 20,
      color = UIHelper.hex2rgb("#b9957a")
    }):center(codeBg):addTo(codeBg)
    self.inviteID = ""
    codeBg:setCallback(function()
      local layer = game:createView("common.InputLayer", {
        longth = 20,
        content = "请输入对方ID",
        callback = function(str)
          text:setString(str)
          self.inviteID = str
          BackManager:pop()
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end)
  end
  local shadow2 = display.newSprite(InviteReturnRes .. "main_bg3.png")
  shadow2:pos(626, 257.5):addTo(mainBg)
  if data.inviter == 0 then
    local lock = UIHelper.newImageView(InviteReturnRes .. "lock.png")
    lock:center(shadow2):addTo(shadow2)
  else
    local list = ccui.ListView:create()
    list:size(cc.size(410, 410))
    list:setInnerContainerSize(cc.size(410, 410))
    list:setClippingEnabled(true)
    list:anch(0, 0.5):pos(10, 215):addTo(shadow2)
    local taskDataList = data.taskStr:toNumMap()
    local showTaskList = {}
    local showTaskDataList = {}
    local tempTask
    for i, taskdata in ipairs(InviteTaskCsv) do
      table.insert(showTaskList, taskdata)
      table.insert(showTaskDataList, taskDataList[i] or 0)
      if i ~= 1 then
        if tempTask.type == taskdata.type and taskDataList[i - 1] ~= -1 then
          table.remove(showTaskList)
          table.remove(showTaskDataList)
        end
        if tempTask.type == taskdata.type and taskDataList[i - 1] == -1 then
          table.remove(showTaskList, #showTaskList - 1)
          table.remove(showTaskDataList, #showTaskDataList - 1)
        end
      end
      tempTask = taskdata
    end
    for i, taskData in ipairs(showTaskList) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(410, 93)):addTo(list)
      local cell = UIHelper.newImageView(InviteReturnRes .. "cell_1.png"):center(viewNode):addTo(viewNode)
      display.newTTFLabel({
        text = taskData.desc,
        size = 16,
        color = UIHelper.hex2rgb("#e2570b")
      }):anch(0, 0.5):pos(13, 72):addTo(cell)
      local dataMap = taskData.gift
      local posX = 41
      for idx, count in pairs(dataMap:toNumMap()) do
        if idx ~= nil then
          ItemIcon.new({
            type = idx,
            count = count,
            showTip = true
          }):scale(0.52):pos(posX, 33):addTo(cell)
        end
        posX = posX + 54
      end
      local cur = showTaskDataList[i] or 0
      if cur == -1 then
        display.newSprite(CarbonRes .. "image_done.png"):pos(340, 40):addTo(cell)
      elseif cur < taskData.condition1 then
        if taskData.condition1 ~= 0 then
          display.newTTFLabel({
            text = string.format("%d/%d", cur, taskData.condition1),
            size = 16,
            color = UIHelper.hex2rgb("#984914")
          }):pos(340, 65):addTo(cell)
        end
        local btn = UIHelper.extend(ccui.Button:create())
        btn:setImages(InviteReturnRes, {"btn_go.png", "btn_go.png"})
        btn:pos(338, 30):addTo(cell)
        btn:setCallback(function()
          CommonHelper.jumpLayer(taskData.type, function()
            self:hide()
          end, function()
            TopBar:show(TopBarType.full, "活动")
            self:show()
          end, taskData.condition2)
        end)
      else
        if taskData.condition1 ~= 0 then
          display.newTTFLabel({
            text = string.format("%d/%d", cur, taskData.condition1),
            size = 16,
            color = UIHelper.hex2rgb("#984914")
          }):pos(340, 65):addTo(cell)
        end
        local btn = UIHelper.extend(ccui.Button:create())
        btn:setImages(InviteReturnRes, {
          "btn_got.png",
          "btn_got.png"
        })
        btn:pos(338, 30):addTo(cell)
        btn:setCallback(function()
          game:sendData(actionCodes.Activity_getInviterRewardRpc, MsgPack.pack({
            msgType = 2,
            id = taskData.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_getInviterRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.reward
            })
            self:showInviteReturnLayer(70)
          end)
        end)
      end
    end
  end
  local rewardList = data.rewardStr:toNumMap()
  local shadow3 = display.newSprite(InviteReturnRes .. "main_bg2.png")
  shadow3:pos(205, 132.5):addTo(mainBg)
  local rewardTypeImgList = {
    "had.png",
    "get.png",
    "cant.png"
  }
  local percent = 0
  percent = game.role.inviterCount * 0.36 - 0.22
  if percent < 0 then
    percent = 0
  end
  for i = 1, 3 do
    if i <= game.role.inviterCount and rewardList[i] then
      rewardList[i] = 1
    elseif i <= game.role.inviterCount and not rewardList[i] then
      rewardList[i] = 2
    else
      rewardList[i] = 3
    end
    local rewardBg = UIHelper.newImageView(string.format(InviteReturnRes .. "tag_%d.png", rewardList[i]))
    rewardBg:pos(122 * i - 56, 140):addTo(shadow3)
    local rewardBox = UIHelper.newImageView(string.format(InviteReturnRes .. "box_%d.png", i + 2))
    rewardBox:pos(56, 100):addTo(rewardBg)
    local rewardTypeImg = UIHelper.newImageView(LevelRes .. rewardTypeImgList[rewardList[i]])
    rewardTypeImg:pos(56, 55):addTo(rewardBg)
    rewardBg:setCallback(function()
      if rewardList[i] == 2 then
        game:sendData(actionCodes.Activity_getInviterRewardRpc, MsgPack.pack({msgType = 1, id = i}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getInviterRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          self:showInviteReturnLayer(70)
        end)
      else
        ItemRewardLayer.new({
          items = InviteReturnCsv[i].gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end
    end)
  end
  local progressRate = display.newSprite(InviteReturnRes .. "bar_bg.png")
  progressRate:pos(188, 45):addTo(shadow3)
  local barContent = display.newSprite(InviteReturnRes .. "bar_content.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0.5, 0.5):pos(188, 45):addTo(shadow3)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(1, 0))
  progressBar:setPercentage(percent * 100)
  display.newTTFLabel({
    text = "成功邀请1名       成功邀请2名       成功邀请3名",
    size = 15,
    color = UIHelper.hex2rgb("#815f3d")
  }):pos(188, 25):addTo(shadow3)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(880, 480):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_70"
    })
  end)
end

function ActivityMainLayer:showCookDrawLayer(Type)
  local data = game.role.activityStatus["71"]
  local mainBg = display.newSprite(CookDrawRes .. "bg_main.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  HeroBigCard.new({
    type = globalCsv.Activity71ShowHero,
    showPic = true
  }):scale(0.75):pos(200, 220):addTo(mainBg)
  local rewardInfoBtn = UIHelper.newImageView(ShakeHappy2Res .. "btn_info.png"):pos(300, 480):addTo(mainBg)
  rewardInfoBtn:setCallback(function()
    local mask, image = UIHelper.showOnleImgTip(CarbonDraw2Res .. "draw_info_bg.png")
    local lineCount = 9
    local group1, group2 = {}, {}
    for _, data in ipairs(ActivityCookDrawRewardCsv) do
      if data.prize == 1 then
        table.insert(group1, data)
      else
        table.insert(group2, data)
      end
    end
    local node1 = display.newNode():pos(45, 395):addTo(image)
    local xPos = 6
    for idx, data in ipairs(group1) do
      if lineCount < idx then
        break
      end
      local item = data.gift:toArray("=", true)
      ItemIcon.new({
        type = item[1],
        count = item[2],
        showTip = true
      }):scale(0.8):pos(xPos, 10):addTo(node1)
      xPos = xPos + 76
    end
    local list = ccui.ListView:create()
    list:size(cc.size(690, 306))
    list:setInnerContainerSize(cc.size(690, 306))
    list:setClippingEnabled(true)
    list:setBounceEnabled(true)
    list:anch(0, 0):pos(10, 10):addTo(image)
    for row = 1, math.ceil(#group2 / lineCount) do
      xPos = 6
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(690, 86)):addTo(list)
      for i = 1, lineCount do
        local data = group2[(row - 1) * lineCount + i]
        if not data then
          break
        end
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.8):anch(0, 0.5):pos(xPos, 43):addTo(viewNode)
        xPos = xPos + 76
      end
    end
    list:requestDoLayout()
  end)
  local wenduboard = display.newSprite(CookDrawRes .. "wendu_board.png"):anch(0, 0):pos(348, 69):addTo(mainBg)
  local word = display.newSprite(CookDrawRes .. "word.png"):anch(0, 0):pos(0, 50):addTo(mainBg)
  local wenduji_1 = display.newSprite(CookDrawRes .. "wendu_1.png"):anch(0, 0):pos(410, 43):addTo(mainBg)
  local barContent = display.newSprite(CookDrawRes .. "wendu_2.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(410, 43):addTo(mainBg)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(0, 1))
  local percent = data.drawCount % 100 or 0
  progressBar:setPercentage(21 + (percent - 10) * 79 / 90)
  local wenduji_3 = display.newSprite(CookDrawRes .. "wendu_3.png"):anch(0, 0):pos(406, 39):addTo(mainBg)
  local btnNode = ccui.Widget:create()
  btnNode:addTo(mainBg)
  local isfalling = {
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  }
  local itemCount = 0
  local itemList = globalCsv.Activity71ItemPool:toTableArray(" ")
  
  local function refreshItemBtn()
    btnNode:removeAllChildren()
    itemCount = 0
    for i = 1, 8 do
      isfalling[i] = false
    end
    local randomList = {}
    for i = 1, 8 do
      randomList[i] = math.random(1, #itemList)
    end
    for i = 1, 8 do
      local xPos = 550 + 90 * ((i - 1) % 4)
      local yPos = 330 + math.floor((i - 1) / 4) * 110
      local itemNameBg = display.newSprite(CookDrawRes .. "bg_itemname.png"):pos(xPos, yPos - 50):addTo(btnNode)
      local itemName = display.newTTFLabel({
        text = itemList[randomList[i]][2],
        size = 16,
        color = UIHelper.hex2rgb("#ffffff")
      }):anch(0.5, 0.5):pos(36, 13):addTo(itemNameBg)
    end
    for i = 1, 8 do
      local btn = UIHelper.extend(ccui.Button:create())
      local imageFileName = itemList[randomList[i]][1] .. ".png"
      btn:setImages("icon/gift/", {
        imageFileName,
        imageFileName,
        imageFileName
      })
      local xPos = 550 + 90 * ((i - 1) % 4)
      local yPos = 330 + math.floor((i - 1) / 4) * 110
      btn:pos(xPos, yPos):addTo(btnNode):setTouchScale()
      btn:setCallback(function()
        btn:setEnabled(false)
        isfalling[i] = true
        local action = {}
        action[#action + 1] = cc.Spawn:create(cc.FadeOut:create(1), cc.MoveTo:create(1, cc.p(700, 150)))
        action[#action + 1] = cc.CallFunc:create(function()
          isfalling[i] = false
          itemCount = itemCount + 1
        end)
        btn:runAction(transition.sequence(action))
      end)
    end
  end
  
  refreshItemBtn()
  local refreshBtn = UIHelper.extend(ccui.Button:create())
  refreshBtn:setImages(MagicRes, {
    "btn_refresh.png",
    "btn_refresh.png"
  })
  refreshBtn:pos(850, 230):addTo(mainBg):setTouchScale()
  refreshBtn:setCallback(function()
    refreshItemBtn()
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(880, 480):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_71"
    })
  end)
  
  local function drawFlash(reward)
    local width = display.width
    local height = display.height
    local posx = display.width / 2
    if UIHelper.isiPhoneX() then
      width = display.width + UIHelper.getMoveXForX(true) * 2
      posx = posx + 50
    end
    local maskLayer = UIHelper.newMask({
      size = cc.size(width, height)
    })
    maskLayer:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER + 1)
    maskLayer:setTouchEnabled(true)
    maskLayer:setSwallowTouches(true)
    local spine = UIHelper.createSpineNodeByRes(CookDrawRes .. "zbhd2")
    spine:scale(1.3):pos(width / 4 * 3, height / 4 + 60):addTo(maskLayer)
    spine:setAnimation(0, "special", false)
    spine:registerSpineEventHandler(function(event)
      if event.type ~= "end" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        maskLayer:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    maskLayer:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        refreshItemBtn()
        local star = 0
        for i, data in pairs(reward) do
          if star < data.star then
            star = data.star
          end
          if star == 5 then
            break
          end
        end
        CookDrawRewardLayer.new({star = star, items = reward})
      end)
    }))
  end
  
  local draw1Btn = UIHelper.extend(ccui.Button:create())
  draw1Btn:setImages(CookDrawRes, {"btn_1.png", "btn_1.png"})
  draw1Btn:pos(600, 50):addTo(mainBg):setTouchScale()
  local diamond1bg = display.newSprite(CookDrawRes .. "bg_diamond.png"):pos(600, 100):addTo(mainBg)
  local diamond1Text = display.newTTFLabel({
    text = "60",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(60, 14):addTo(diamond1bg)
  draw1Btn:setCallback(function()
    if itemCount == 0 then
      SysError(SYS_ERR_MATERIAL_EMPTY)
      return
    end
    if game.role.diamond < 60 then
      UIHelper.showDiamondTip()
      return
    end
    for i, data in ipairs(isfalling) do
      if data == true then
        return
      end
    end
    if tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.dialogSkipTime or 0) then
      MDialog:double({
        showSkip = true,
        title = "钻石购买",
        text = string.format("是否要消耗 <img src='ui/global/5.png' scale=0.5 />X60 继续？"),
        okCallback = function()
          game:sendData(actionCodes.Activity_cookDrawRewardRpc, MsgPack.pack({msgType = 1, count = itemCount}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_cookDrawRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            drawFlash(msg.reward)
            local percent = game.role.activityStatus["71"].drawCount % 100 or 0
            progressBar:setPercentage(21 + (percent - 10) * 79 / 90)
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      game:sendData(actionCodes.Activity_cookDrawRewardRpc, MsgPack.pack({msgType = 1, count = itemCount}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_cookDrawRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        drawFlash(msg.reward)
        local percent = game.role.activityStatus["71"].drawCount % 100 or 0
        progressBar:setPercentage(21 + (percent - 10) * 79 / 90)
      end)
    end
  end)
  local buyNode = ccui.Widget:create()
  buyNode:addTo(mainBg)
  local draw10Count = game.role.activityStatus["71"].draw10Count or 0
  
  local function refreshBtn10()
    buyNode:removeAllChildren()
    local draw10Btn = UIHelper.extend(ccui.Button:create())
    draw10Btn:setImages(CookDrawRes, {"btn_10.png", "btn_10.png"})
    draw10Btn:pos(800, 50):addTo(buyNode):setTouchScale()
    local diamond10bg = display.newSprite(CookDrawRes .. "bg_diamond.png"):pos(800, 100):addTo(buyNode)
    local diamond10Text = display.newTTFLabel({
      text = draw10Count == 0 and "300" or "540",
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):pos(60, 14):addTo(diamond10bg)
    local shopOffImg = display.newSprite("ui/shop/main/off_1.png"):pos(100, 12):scale(0.6):addTo(diamond10bg)
    local shopOffText = display.newTTFLabel({
      text = draw10Count == 0 and "50%" or "10%",
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):pos(39, 46):addTo(shopOffImg)
    draw10Btn:setCallback(function()
      if itemCount == 0 then
        SysError(SYS_ERR_MATERIAL_EMPTY)
        return
      end
      if game.role.diamond < (draw10Count == 0 and 300 or 540) then
        UIHelper.showDiamondTip()
        return
      end
      for i, data in ipairs(isfalling) do
        if data == true then
          return
        end
      end
      if tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.dialogSkipTime or 0) then
        MDialog:double({
          showSkip = true,
          title = "钻石购买",
          text = string.format("是否要消耗 <img src='ui/global/5.png' scale=0.5 />X%d 继续？", draw10Count == 0 and 300 or 540),
          okCallback = function()
            game:sendData(actionCodes.Activity_cookDrawRewardRpc, MsgPack.pack({msgType = 10, count = itemCount}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_cookDrawRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              drawFlash(msg.reward)
              draw10Count = game.role.activityStatus["71"].draw10Count
              refreshBtn10()
              local percent = game.role.activityStatus["71"].drawCount % 100 or 0
              progressBar:setPercentage(21 + (percent - 10) * 79 / 90)
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      else
        game:sendData(actionCodes.Activity_cookDrawRewardRpc, MsgPack.pack({msgType = 10, count = itemCount}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_cookDrawRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          drawFlash(msg.reward)
          draw10Count = game.role.activityStatus["71"].draw10Count
          refreshBtn10()
          local percent = game.role.activityStatus["71"].drawCount % 100 or 0
          progressBar:setPercentage(21 + (percent - 10) * 79 / 90)
        end)
      end
    end)
  end
  
  refreshBtn10()
end

function ActivityMainLayer:showAllRechargeLayer(Type)
  local data = game.role.activityStatus["72"]
  local mainBg = display.newSprite(TotalRechargeRes .. "recharge_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local curNum = game.role.cumulCharge
  local percent = 0
  local barBg = display.newSprite(TotalRechargeRes .. "bar_bg.png"):anch(0, 0):pos(62, 45):addTo(mainBg)
  local barContent = display.newSprite(TotalRechargeRes .. "bar_content.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(64, 47):addTo(mainBg)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(1, 0))
  local progressNum = display.newTTFLabel({
    text = string.format("%s/%s", curNum, YearTotalRechargeRewardCsv[#YearTotalRechargeRewardCsv].money),
    size = 18,
    color = UIHelper.hex2rgb("#faff00")
  }):enableOutline(UIHelper.hex2rgb("#872f0c"), 1):center(progressBar):addTo(progressBar)
  UIHelper.makeFontClear(progressNum)
  local color = {
    [-1] = UIHelper.hex2rgb("#ffffff"),
    [0] = UIHelper.hex2rgb("#faff00"),
    [1] = UIHelper.hex2rgb("#ff2b35")
  }
  
  local function createTag(params)
    local id = params.data.id
    local count = params.count
    local money = params.data.money
    local state = params.state
    local tagBg = UIHelper.newImageView(TotalRechargeRes .. string.format("tag_%d.png", state + 2))
    tagBg:anch(0.5, 0):pos(math.ceil(id / count * 782 + 58), 68):addTo(mainBg)
    local item = params.data.gift:toArray("=", true)
    display.newSprite(string.format("ui/carbon/chooseTravel/box_%d.png", id)):pos(56, 110):addTo(tagBg)
    local numLabel = display.newTTFLabel({
      text = money,
      size = 22,
      color = color[state]
    }):anch(0, 0.5):pos(82, 10):rotation(-40):addTo(tagBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    local newPercent = 0
    if money <= curNum then
      newPercent = id / count
    else
      local oriMoney = id == 1 and 0 or YearTotalRechargeRewardCsv[id - 1].money
      if oriMoney < curNum then
        newPercent = (id - (money - curNum) / (money - oriMoney)) / count
      end
    end
    if newPercent > percent then
      percent = newPercent
    end
    if state == -1 then
      display.newSprite(LevelRes .. "had.png"):pos(56, 58):addTo(tagBg)
      return
    end
    local btn = UIHelper.extend(ccui.Button:create())
    local btnImage = state == 1 and "cant.png" or "get.png"
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(56, 58):addTo(tagBg):setTouchScale()
    
    local function callback()
      if state == 1 then
        ItemRewardLayer.new({
          items = params.data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
        return
      end
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 72, id = id}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:removeSelf()
        tagBg:setImage(TotalRechargeRes .. "tag_1.png")
        tagBg:setTouchEnabled(false)
        numLabel:setTextColor(color[-1])
        display.newSprite(LevelRes .. "had.png"):pos(56, 58):addTo(tagBg)
        local msg = MsgPack.unpack(event.data)
        if msg.change then
          MDialog:single({
            title = "温馨提示",
            text = "获得的重复外观已自动折算为等值物品"
          }, function()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        else
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
      end)
    end
    
    btn:setCallback(callback)
    tagBg:setCallback(callback)
  end
  
  for index, data in pairs(YearTotalRechargeRewardCsv) do
    local state = game.role.activityStatus["72"]:getv(index, 0)
    if state ~= -1 then
      state = game.role.cumulCharge >= data.money and 0 or 1
    end
    createTag({
      data = data,
      count = #YearTotalRechargeRewardCsv,
      state = state
    })
  end
  progressBar:setPercentage(percent * 100)
  local numStr = ""
  for i = 1, #YearTotalRechargeRewardCsv do
    numStr = numStr .. YearTotalRechargeRewardCsv[i].money .. "/"
  end
  numStr = string.format("账号累积充值达到%s即可以领取", string.sub(numStr, 1, -2))
  local tipLabel = MRichText.new({
    text = numStr,
    size = 22,
    color = UIHelper.hex2rgb("#530d17")
  }):anch(0.5, 0.5):pos(455, 27):addTo(mainBg)
  UIHelper.makeFontClear(tipLabel)
end

function ActivityMainLayer:collectExtraStar(Type)
  local data = game.role.activityStatus["74"]
  local rewardStr = data.rewardStr
  local dayGain = data.dayGain
  local tempStr = ""
  local mainBg = display.newSprite(CollectExtraStarRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local dailyRewardData = CollectExtraStarCsv[100 + data.dayCount - data.dayGain]
  local dailyRewardGift = dailyRewardData.gift:toTableArray()
  local dailyItem = ItemCsv[tonumber(dailyRewardGift[1][1])]
  local dailyItemBg = UIHelper.newImageView(CollectExtraStarRes .. "item_bg.png"):anch(0, 0):pos(115, 60):addTo(mainBg)
  local image = ItemIcon.new({
    type = dailyItem.itemId,
    count = tonumber(dailyRewardGift[1][2])
  }):scale(0.9)
  image:pos(47, 60):addTo(dailyItemBg)
  display.newTTFLabel({
    text = dailyItem.name,
    size = 16
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(47, 9):addTo(dailyItemBg)
  if rewardStr:getv(100 + data.dayCount - data.dayGain, 0) == -1 or tempStr:getv(100 + data.dayCount - data.dayGain, 0) == -1 then
    local Img = display.newSprite(InviteReturnRes .. "had.png"):anch(0.5, 0.5):pos(47, 60):addTo(dailyItemBg)
  else
    local Img = display.newSprite(InviteReturnRes .. "get.png"):anch(0.5, 0.5):pos(47, 60):addTo(dailyItemBg)
    dailyItemBg:setCallback(function()
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
        type = 74,
        id = 100 + data.dayCount
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.change then
          MDialog:single({
            title = "温馨提示",
            text = "获得的重复外观已自动折算为等值物品"
          }, function()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        else
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
        Img:removeSelf()
        local Img = display.newSprite(InviteReturnRes .. "had.png"):anch(0.5, 0.5):pos(47, 60):addTo(dailyItemBg)
        dailyItemBg:setEnabled(false)
        tempStr = tempStr:setv(100 + data.dayCount, -1)
      end)
    end)
  end
  local taskNum = 0
  for i, _ in ipairs(CollectExtraStarCsv) do
    taskNum = taskNum + 1
  end
  local jindutiao1 = display.newSprite(CollectExtraStarRes .. "jindutiao1.png"):anch(0, 0):pos(839, 188):addTo(mainBg)
  local barContent = display.newSprite(CollectExtraStarRes .. "jindutiao2.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(839, 188):addTo(mainBg)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(0, 1))
  local gainCount = data.gainCount
  local rewardStr = data.rewardStr
  local percent = gainCount
  progressBar:setPercentage(percent * 100 / taskNum)
  local rewardNode = ccui.Widget:create():anch(0.5, 0.5):pos(843, 93):addTo(mainBg)
  
  local function showReward(rewardNum)
    rewardNode:removeAllChildren()
    local taskItemBg = UIHelper.newImageView(CollectExtraStarRes .. "item_bg.png"):anch(0.5, 0.5):pos(0, 0):addTo(rewardNode)
    local taskRewardData = CollectExtraStarCsv[rewardNum]
    local taskRewardGift = taskRewardData.gift:toTableArray()
    local taskItem = ItemCsv[tonumber(taskRewardGift[1][1])]
    local image = ItemIcon.new({
      type = taskItem.itemId,
      count = tonumber(taskRewardGift[1][2])
    }):scale(0.9)
    image:pos(47, 60):addTo(taskItemBg)
    display.newTTFLabel({
      text = taskItem.name,
      size = 16
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(47, 9):addTo(taskItemBg)
    statusStr = ""
    if rewardStr:getv(rewardNum, 0) == -1 or tempStr:getv(rewardNum, 0) == -1 then
      statusStr = "had.png"
    elseif rewardNum <= gainCount then
      statusStr = "get.png"
    else
      statusStr = "cant.png"
    end
    local statusImg = display.newSprite(InviteReturnRes .. statusStr):anch(0.5, 0.5):pos(0, -70):addTo(rewardNode)
    if statusStr == "get.png" then
      taskItemBg:setCallback(function()
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 74, id = rewardNum}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          if msg.change then
            MDialog:single({
              title = "温馨提示",
              text = "获得的重复外观已自动折算为等值物品"
            }, function()
              MedalRewardLayer.new({
                items = msg.reward
              })
            end)
          else
            MedalRewardLayer.new({
              items = msg.reward
            })
          end
          local statusImg = display.newSprite(InviteReturnRes .. "had.png"):anch(0.5, 0.5):pos(0, -70):addTo(rewardNode)
          taskItemBg:setEnabled(false)
          tempStr = tempStr:setv(rewardNum, -1)
        end)
      end)
    end
  end
  
  for i = 1, taskNum do
    local gotReward = false
    if rewardStr:getv(i, 0) == -1 then
      gotReward = true
    end
    local jindu = UIHelper.newImageView(CollectExtraStarRes .. (gotReward and "jindu2.png" or "jindu1.png")):anch(0.5, 0.5):pos(4, 297 / taskNum * i):addTo(progressBar)
    jindu:setCallback(function()
      showReward(i)
    end)
  end
  local cishukuang = display.newSprite(CollectExtraStarRes .. "cishukuang.png"):anch(0.5, 0.5):pos(843, 163):addTo(mainBg)
  local cishu = display.newTTFLabel({
    text = gainCount .. "/" .. taskNum,
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(35, 12):addTo(cishukuang)
  showReward(1)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(750, 480):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_74"
    })
  end)
end

function ActivityMainLayer:addOptionalBox(parentNode, optionalItemId)
  local itemData = ItemCsv[optionalItemId]
  if itemData then
    local itemCount = game.role.items[tonumber(itemData.itemId)] or 0
    local optionalBtn = UIHelper.extend(ccui.Button:create())
    optionalBtn:setImages(GlobalRes, {
      "activitiy_75_option.png",
      "activitiy_75_option.png"
    })
    optionalBtn:pos(840, 50):addTo(parentNode):setTouchScale()
    optionalBtn:setCallback(function()
      local count = game.role.items[tonumber(optionalItemId)] or 0
      if count <= 0 then
        MFlashMsg:show({
          text = "主厨，您还未获得" .. itemData.name
        })
        return
      end
      self:showOptionalBox(optionalItemId, optionalBtn)
    end)
    self.act97OptionItemCountLabel = display.newTTFLabel({
      text = "" .. itemCount,
      size = 26,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):name("countLabel"):pos(74, 15):addTo(optionalBtn)
    local stars = UIHelper.createSpineNodeByRes("spine/ui/activity/stars")
    stars:setAnimation(0, "special", true)
    stars:pos(49, 49):scale(0.8):addTo(optionalBtn):name("stars")
  end
end

function ActivityMainLayer:showSummerCookDrawLayer(Type)
  local data = game.role.activityStatus["75"]
  local mainBg = display.newSprite(SummerCookDrawRes .. "bg_main.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  self:addOptionalBox(mainBg, globalCsv.Activity75OptionalItemId)
  HeroBigCard.new({
    type = globalCsv.activity75Hero,
    showPic = true
  }):scale(0.75):pos(160, 240):addTo(mainBg)
  local rewardInfoBtn = UIHelper.newImageView(ShakeHappy2Res .. "btn_info.png"):pos(300, 480):addTo(mainBg)
  rewardInfoBtn:setCallback(function()
    local mask, image = UIHelper.showOnleImgTip(CarbonDraw2Res .. "draw_info_bg.png")
    local lineCount = 9
    local group1, group2 = {}, {}
    for _, data in ipairs(ActivitySummerCookDrawRewardCsv) do
      if data.prize == 1 then
        table.insert(group1, data)
      else
        table.insert(group2, data)
      end
    end
    local node1 = display.newNode():pos(45, 395):addTo(image)
    local xPos = 6
    for idx, data in ipairs(group1) do
      if lineCount < idx then
        break
      end
      local item = data.gift:toArray("=", true)
      ItemIcon.new({
        type = item[1],
        count = item[2],
        showTip = true
      }):scale(0.8):pos(xPos, 10):addTo(node1)
      xPos = xPos + 76
    end
    local list = ccui.ListView:create()
    list:size(cc.size(690, 306))
    list:setInnerContainerSize(cc.size(690, 306))
    list:setClippingEnabled(true)
    list:setBounceEnabled(true)
    list:anch(0, 0):pos(10, 10):addTo(image)
    for row = 1, math.ceil(#group2 / lineCount) do
      xPos = 6
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(690, 86)):addTo(list)
      for i = 1, lineCount do
        local data = group2[(row - 1) * lineCount + i]
        if not data then
          break
        end
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.8):anch(0, 0.5):pos(xPos, 43):addTo(viewNode)
        xPos = xPos + 76
      end
    end
    list:requestDoLayout()
  end)
  local wenduboard = display.newSprite(SummerCookDrawRes .. "wendu_board.png"):anch(0, 0):pos(775, 78):addTo(mainBg)
  local word = display.newSprite(SummerCookDrawRes .. "word.png"):anch(0, 0):pos(0, 50):addTo(mainBg)
  local wenduji_1 = display.newSprite(SummerCookDrawRes .. "wendu_1.png"):anch(0, 0):pos(840, 70):addTo(mainBg)
  local barContent = display.newSprite(SummerCookDrawRes .. "wendu_2.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(840, 70):addTo(mainBg)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(0, 1))
  local percent = data.drawCount % 100 or 0
  progressBar:setPercentage(13 + (percent - 10) * 87 / 90)
  local wenduji_3 = display.newSprite(SummerCookDrawRes .. "wendu_3.png"):anch(0, 0):pos(840, 70):addTo(mainBg)
  local guizi = display.newSprite(SummerCookDrawRes .. "guizi.png"):anch(0, 0):pos(340, 0):addTo(mainBg)
  local guizi2 = display.newSprite(SummerCookDrawRes .. "guizi2.png"):anch(0, 0):pos(345, 0):addTo(mainBg)
  local btnNode = ccui.Widget:create()
  btnNode:addTo(mainBg)
  local isfalling = {
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  }
  local itemCount = 0
  local itemList = globalCsv.Activity75ItemPool:toTableArray(" ")
  
  local function refreshItemBtn()
    btnNode:removeAllChildren()
    itemCount = 0
    for i = 1, 8 do
      isfalling[i] = false
    end
    local randomList = {}
    for i = 1, 8 do
      randomList[i] = math.random(1, #itemList)
    end
    for i = 1, 8 do
      local xPos = 422 + 90 * ((i - 1) % 4)
      local yPos = 335 + math.floor((i - 1) / 4) * 110
      local itemNameBg = display.newSprite(SummerCookDrawRes .. "bg_itemname.png"):pos(xPos, yPos - 50):addTo(btnNode)
      local itemName = display.newTTFLabel({
        text = itemList[randomList[i]][2],
        size = 16,
        color = UIHelper.hex2rgb("#ffffff")
      }):anch(0.5, 0.5):pos(36, 13):addTo(itemNameBg)
    end
    for i = 1, 8 do
      local btn = UIHelper.extend(ccui.Button:create())
      local imageFileName = itemList[randomList[i]][1] .. ".png"
      btn:setImages("icon/gift/", {
        imageFileName,
        imageFileName,
        imageFileName
      })
      local xPos = 422 + 90 * ((i - 1) % 4)
      local yPos = 335 + math.floor((i - 1) / 4) * 110
      btn:pos(xPos, yPos):addTo(btnNode):setTouchScale()
      btn:setCallback(function()
        btn:setEnabled(false)
        isfalling[i] = true
        local action = {}
        action[#action + 1] = cc.Spawn:create(cc.FadeOut:create(1), cc.MoveTo:create(1, cc.p(550, 150)))
        action[#action + 1] = cc.CallFunc:create(function()
          isfalling[i] = false
          itemCount = itemCount + 1
        end)
        btn:runAction(transition.sequence(action))
      end)
    end
  end
  
  refreshItemBtn()
  local refreshBtn = UIHelper.extend(ccui.Button:create())
  refreshBtn:setImages(MagicRes, {
    "btn_refresh.png",
    "btn_refresh.png"
  })
  refreshBtn:pos(740, 480):addTo(mainBg):setTouchScale()
  refreshBtn:setCallback(function()
    refreshItemBtn()
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(35, 480):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_75"
    })
  end)
  
  local function drawFlash(reward)
    local width = display.width
    local height = display.height
    local posx = display.width / 2
    if UIHelper.isiPhoneX() then
      width = display.width + UIHelper.getMoveXForX(true) * 2
      posx = posx + 50
    end
    local maskLayer = UIHelper.newMask({
      size = cc.size(width, height)
    })
    maskLayer:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER + 1)
    maskLayer:setTouchEnabled(true)
    maskLayer:setSwallowTouches(true)
    local spine = UIHelper.createSpineNodeByRes(SummerCookDrawRes .. "zbhd2")
    print(display.width, display.height)
    spine:scale(1.3):pos(650, 150):addTo(maskLayer)
    spine:setAnimation(0, "special", false)
    spine:registerSpineEventHandler(function(event)
      if event.type ~= "end" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        maskLayer:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    if self.act97OptionItemCountLabel then
      local itemId = globalCsv.Activity75OptionalItemId
      self.act97OptionItemCountLabel:setString("" .. (game.role.items[tonumber(itemId)] or 0))
    end
    maskLayer:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        refreshItemBtn()
        local star = 0
        for i, data in pairs(reward) do
          if star < data.star then
            star = data.star
          end
          if star == 5 then
            break
          end
        end
        CookDrawRewardLayer.new({star = star, items = reward})
      end)
    }))
  end
  
  local draw1Btn = UIHelper.extend(ccui.Button:create())
  draw1Btn:setImages(SummerCookDrawRes, {"btn_1.png", "btn_1.png"})
  draw1Btn:pos(450, 190):addTo(mainBg):setTouchScale()
  local diamond1bg = display.newSprite(SummerCookDrawRes .. "bg_diamond.png"):pos(450, 240):addTo(mainBg)
  local diamond1Text = display.newTTFLabel({
    text = "60",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(60, 14):addTo(diamond1bg)
  draw1Btn:setCallback(function()
    if itemCount == 0 then
      SysError(SYS_ERR_MATERIAL_EMPTY)
      return
    end
    if game.role.diamond < 60 then
      UIHelper.showDiamondTip()
      return
    end
    for i, data in ipairs(isfalling) do
      if data == true then
        return
      end
    end
    if tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.dialogSkipTime or 0) then
      MDialog:double({
        showSkip = true,
        title = "钻石购买",
        text = string.format("是否要消耗 <img src='ui/global/5.png' scale=0.5 />X60 继续？"),
        okCallback = function()
          game:sendData(actionCodes.Activity_summerCookDrawRewardRpc, MsgPack.pack({msgType = 1, count = itemCount}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_summerCookDrawRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            drawFlash(msg.reward)
            local percent = game.role.activityStatus["75"].drawCount % 100 or 0
            progressBar:setPercentage(13 + (percent - 10) * 87 / 90)
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      game:sendData(actionCodes.Activity_summerCookDrawRewardRpc, MsgPack.pack({msgType = 1, count = itemCount}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_summerCookDrawRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        drawFlash(msg.reward)
        local percent = game.role.activityStatus["75"].drawCount % 100 or 0
        progressBar:setPercentage(13 + (percent - 10) * 87 / 90)
      end)
    end
  end)
  local buyNode = ccui.Widget:create()
  buyNode:addTo(mainBg)
  local draw10Count = game.role.activityStatus["75"].draw10Count or 0
  
  local function refreshBtn10()
    buyNode:removeAllChildren()
    local draw10Btn = UIHelper.extend(ccui.Button:create())
    draw10Btn:setImages(SummerCookDrawRes, {"btn_10.png", "btn_10.png"})
    draw10Btn:pos(650, 190):addTo(buyNode):setTouchScale()
    local diamond10bg = display.newSprite(SummerCookDrawRes .. "bg_diamond.png"):pos(650, 240):addTo(buyNode)
    local diamond10Text = display.newTTFLabel({
      text = draw10Count == 0 and "300" or "540",
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):pos(60, 14):addTo(diamond10bg)
    local shopOffImg = display.newSprite("ui/shop/main/off_1.png"):pos(100, 12):scale(0.6):addTo(diamond10bg)
    local shopOffText = display.newTTFLabel({
      text = draw10Count == 0 and "50%" or "10%",
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):pos(39, 46):addTo(shopOffImg)
    draw10Btn:setCallback(function()
      if itemCount == 0 then
        SysError(SYS_ERR_MATERIAL_EMPTY)
        return
      end
      if game.role.diamond < (draw10Count == 0 and 300 or 540) then
        UIHelper.showDiamondTip()
        return
      end
      for i, data in ipairs(isfalling) do
        if data == true then
          return
        end
      end
      if tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.dialogSkipTime or 0) then
        MDialog:double({
          showSkip = true,
          title = "钻石购买",
          text = string.format("是否要消耗 <img src='ui/global/5.png' scale=0.5 />X%d 继续？", draw10Count == 0 and 300 or 540),
          okCallback = function()
            game:sendData(actionCodes.Activity_summerCookDrawRewardRpc, MsgPack.pack({msgType = 10, count = itemCount}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_summerCookDrawRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              drawFlash(msg.reward)
              draw10Count = game.role.activityStatus["75"].draw10Count
              refreshBtn10()
              local percent = game.role.activityStatus["75"].drawCount % 100 or 0
              progressBar:setPercentage(13 + (percent - 10) * 87 / 90)
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      else
        game:sendData(actionCodes.Activity_summerCookDrawRewardRpc, MsgPack.pack({msgType = 10, count = itemCount}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_summerCookDrawRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          drawFlash(msg.reward)
          draw10Count = game.role.activityStatus["75"].draw10Count
          refreshBtn10()
          local percent = game.role.activityStatus["75"].drawCount % 100 or 0
          progressBar:setPercentage(13 + (percent - 10) * 87 / 90)
        end)
      end
    end)
  end
  
  refreshBtn10()
end

function ActivityMainLayer:showNewShakeUnlimitLayer(type)
  local isTurning = false
  local selectId = 1
  local mainBg = display.newSprite(NewShakeUnlimitRes .. "main_bg.png"):pos(0, 2):addTo(self.content)
  local coin = globalCsv.NewShakeCost:toArray("=", true)
  local countBg = display.newSprite("ui/kitchen/cook/paper_bg.png"):anch(1, 0.5):pos(865, 490):addTo(mainBg)
  display.newSprite(ItemCsv[coin[1]].icon):scale(0.6):pos(23, 19):addTo(countBg)
  local countLabel = display.newTTFLabel({
    text = game.role.items[coin[1]] or 0,
    size = 20
  }):pos(106, 17):addTo(countBg)
  UIHelper.makeFontClear(countLabel)
  local useMaterial = game.role.activityStatus[tostring(type)].useMaterial
  local dailyGain100 = game.role.activityStatus[tostring(type)].dailyGain100
  local gainTextBg = display.newSprite(NewShakeUnlimitRes .. "gainText.png"):anch(0.5, 0.5):pos(113, 486):addTo(mainBg)
  local materialText = display.newTTFLabel({
    text = useMaterial or 0,
    size = 22
  }):pos(165, 41):addTo(gainTextBg)
  local gainText = display.newTTFLabel({
    text = dailyGain100 .. "/5" or 0,
    size = 22
  }):pos(152, 16):addTo(gainTextBg)
  local get100Btn = UIHelper.extend(ccui.Button:create())
  get100Btn:setImages(NewShakeUnlimitRes, {
    "gain100Btn.png",
    "gain100Btn.png"
  })
  get100Btn:pos(300, 486):addTo(mainBg):setTouchScale()
  get100Btn:setCallback(function()
    if dailyGain100 >= math.min(math.floor(useMaterial / globalCsv.Activity76RewardGain), 5) then
      SysError(SYS_ERR_PASS_NOTCANGET)
      return
    end
    game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 76, id = 1}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      countLabel:setString(game.role.items[coin[1]] or 0)
      dailyGain100 = game.role.activityStatus[tostring(type)].dailyGain100
      gainText:setString(dailyGain100 .. "/5")
    end)
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 492):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_76"
    })
  end)
  local btnInfo2 = UIHelper.extend(ccui.Button:create())
  btnInfo2:setImages(ShakeHappyRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo2:pos(367, 381):addTo(mainBg):setTouchScale()
  btnInfo2:setCallback(function()
    local status = game.role.activityStatus[tostring(type)] or {}
    local drawItems = status[tostring(selectId)] or ""
    status.limit = status.limit or ""
    local rewarditems = {
      itemGot = {},
      itemLeft = {}
    }
    for _, gift in ipairs(NewShakeUnlimitCsv[selectId]) do
      local drawCount = drawItems:getv(gift.giftId, 0)
      local leftCount = gift.count - drawCount
      local giftItem = gift.gift:toArray("=", true)
      if gift.count == 0 then
        drawCount, leftCount = 0, 1
      end
      if gift.limit == 1 and status.limit:getv(giftItem[1], 0) ~= 0 then
        drawCount, leftCount = gift.count, 0
      end
      if 0 < drawCount then
        for i = 1, drawCount do
          table.insert(rewarditems.itemGot, gift.gift)
        end
      end
      if 0 < leftCount then
        for i = 1, leftCount do
          table.insert(rewarditems.itemLeft, gift.gift)
        end
      end
    end
    UIHelper.showRewardItem(rewarditems)
  end)
  local spine = UIHelper.createSpineNodeByRes("spine/ui/activity/bjcjx")
  spine:setAnimation(0, "zhuanquandaiji", true)
  spine:setSkin("zhuanpan" .. 7)
  spine:anch(0, 0):pos(235, 105):addTo(mainBg):name("spine")
  local costType = {
    [1] = "1次消耗:",
    [2] = "10次消耗:"
  }
  local costNum = globalCsv.NewShakeCost:toNumMap()
  for type, text in ipairs(costType) do
    local round = type == 2 and 10 or 1
    display.newTTFLabel({text = text, size = 20}):anch(0, 0):pos(10 + type * 260, 112):addTo(mainBg):enableOutline(UIHelper.hex2rgb("#541c06"), 2)
    display.newSprite(ItemCsv[coin[1]].icon):scale(0.5):anch(0, 0):pos(110 + type * 260, 106):addTo(mainBg)
    display.newTTFLabel({
      text = "x " .. costNum[coin[1]] * round,
      size = 20
    }):anch(0, 0):pos(165 + type * 260, 112):addTo(mainBg):enableOutline(UIHelper.hex2rgb("#541c06"), 2):name("costLabel" .. type)
  end
  local buttonType = {
    [1] = {
      name = "轻轻摇",
      anima = {1, 2}
    },
    [2] = {
      name = "普通摇",
      anima = {3, 4}
    },
    [3] = {
      name = "用力摇",
      anima = {5, 7}
    },
    [4] = {
      name = "闭眼摇",
      anima = {
        1,
        2,
        3,
        4,
        5,
        7
      }
    },
    [5] = {
      name = "十连摇",
      anima = {
        1,
        2,
        3,
        4,
        5,
        7
      }
    }
  }
  local animaType = {
    [1] = {name = "hongqiu"},
    [2] = {name = "ziqiu"},
    [3] = {name = "lanqiu"},
    [4] = {name = "baiqiu"},
    [5] = {name = "huangqiu"},
    [6] = {name = "10lianqiu"}
  }
  local turnBtns = {}
  local btnBg = display.newSprite(ShakeHappyRes .. "btn_bg.png"):anch(0, 1):pos(760, 412):addTo(mainBg)
  local interval = 52
  for i = 1, 5 do
    local btnName = i == 5 and "btn_2.png" or "btn_1.png"
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(ShakeHappyRes, {btnName, btnName})
    btn:pos(74, 297 - i * interval):addTo(btnBg):setTouchScale()
    btn:setCallback(function()
      if isTurning then
        return
      end
      isTurning = true
      game:sendData(actionCodes.Activity_newShakeUnlimitRewardRpc, MsgPack.pack({
        type = 76,
        id = selectId,
        shakeType = i
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_newShakeUnlimitRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        local state = msg.state
        if state == -1 then
          SysError(SYS_ERR_SHAKE_POOL_EMPTY)
          isTurning = false
          return
        end
        if state == -2 then
          SysError(SYS_ERR_SHAKE_COST_NOT_ENOUGH)
          isTurning = false
          return
        end
        countLabel:setString(game.role.items[coin[1]] or 0)
        UIHelper.makeFontClear(countLabel)
        local rewardColor = i == 5 and 6 or msg.color
        local animaIndex = math.randomInt(1, #buttonType[i].anima)
        spine:setAnimation(0, "zhuanquan" .. buttonType[i].anima[animaIndex], false)
        spine:registerSpineEventHandler(function(event)
          if event.type ~= "end" then
            return
          end
          local ball = UIHelper.createSpineNodeByRes("spine/ui/activity/bjcjx_qiu")
          ball:setAnimation(0, animaType[rewardColor].name, false)
          ball:anch(0, 0):pos(200, 105):addTo(mainBg)
          ball:registerSpineEventHandler(function(event)
            if event.type ~= "end" then
              return
            end
            MedalRewardLayer.new({
              items = msg.reward,
              rewardStr = msg.rewardStr
            })
            refreshBtn()
            isTurning = false
            scheduler.performWithDelayGlobal(function()
              ball:removeSelf()
            end, 0.016666666666666666)
          end, sp.EventType.ANIMATION_END)
          spine:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
        end, sp.EventType.ANIMATION_END)
      end)
    end)
    local labelColor = i == 5 and "#bf7d12" or "#cba58d"
    local btnLabel = display.newTTFLabel({
      text = buttonType[i].name,
      size = 24
    }):center(btn):addTo(btn):enableOutline(UIHelper.hex2rgb(labelColor), 2)
    UIHelper.makeFontClear(btnLabel)
  end
  
  function refreshBtn()
    for _, btn in ipairs(turnBtns) do
      btn:removeSelf()
    end
    turnBtns = {}
    local status = game.role.activityStatus[tostring(type)] or {}
    status.open = status.open or "1=1 2=1 3=1 4=1 5=1 6=1"
    local offSetX = 128
    for i = 1, 6 do
      local btnName = string.format("turn_%s.png", i)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(NewShakeUnlimitRes, {btnName, btnName})
      btn:pos(5 + i * offSetX, 48):addTo(mainBg):setTouchScale()
      turnBtns[i] = btn
      if selectId ~= i then
        display.newSprite(ShakeHappyRes .. "mask.png"):center(btn):addTo(btn, _, -1):name("mask")
      end
      if status.open:getv(i, 0) ~= 0 then
        btn:setCallback(function()
          if isTurning then
            return
          end
          display.newSprite(ShakeHappyRes .. "mask.png"):center(turnBtns[selectId]):addTo(turnBtns[selectId], _, -1):name("mask")
          btn:removeChildByName("mask")
          selectId = i
          spine:setSkin("zhuanpan" .. 7)
          local costNum = globalCsv.NewShakeCost:toNumMap()
          for type, _ in ipairs(costType) do
            local round = type == 2 and 10 or 1
            local costLabel = mainBg:getChildByName("costLabel" .. type)
            costLabel:setString("x " .. costNum[coin[1]] * round)
          end
        end)
      else
        display.newSprite(ShakeHappyRes .. "lock.png"):center(btn):addTo(btn):name("lock")
      end
    end
  end
  
  refreshBtn()
end

function ActivityMainLayer:showMagicCapLayer(Type)
  local data = game.role.activityStatus["77"]
  local mainBg = display.newSprite(MagicCapRes .. "bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local titleImage = display.newSprite(MagicCapRes .. "title.png"):anch(0.5, 0.5):pos(170, 439):addTo(mainBg)
  local gameRoundImage = display.newSprite(MagicCapRes .. "gameRoundImage.png"):anch(0.5, 0.5):pos(757, 493):addTo(mainBg)
  local gameRoundText = display.newTTFLabel({
    text = "今日奖励次数 " .. math.min(data.dailyGameCount, 10) .. "/10",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(20, 21):addTo(gameRoundImage)
  local selectTips = display.newSprite(MagicCapRes .. "selectTips.png"):anch(0.5, 0.5):pos(456, 407):addTo(mainBg)
  local selectTipsText = display.newTTFLabel({
    text = "请选择一款食物",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(100, 20):addTo(selectTips)
  selectTips:setVisible(false)
  local curSelectImage = display.newSprite(MagicCapRes .. "gameRoundImage.png"):anch(0.5, 0.5):pos(757, 443):addTo(mainBg)
  local curSelectText = display.newTTFLabel({
    text = "当前选择的食物:无",
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(20, 21):addTo(curSelectImage)
  local allCountImage = display.newSprite(MagicCapRes .. "allCount.png"):anch(0.5, 0.5):pos(840, 405):addTo(mainBg)
  local allCountText = display.newTTFLabel({
    text = "总胜利次数:" .. data.allCount,
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(66, 14):addTo(allCountImage)
  local winImage = UIHelper.newImageView(MagicCapRes .. "win.png"):anch(0.5, 0.5):pos(456, 407):addTo(mainBg)
  local loseImage = display.newSprite(MagicCapRes .. "lose.png"):anch(0.5, 0.5):pos(456, 407):addTo(mainBg)
  winImage:setVisible(false)
  loseImage:setVisible(false)
  local canClick = true
  local startBtn, startMoveBtn
  local chooseNo = 0
  local chooseNodeList = {}
  local roleList = {}
  local heroNodeList = {}
  local spineList = {}
  local chooseBtnList = {}
  local lidImageList = {}
  local secondChooseBtnList = {}
  local moveType = {
    {
      1,
      2,
      3,
      4
    },
    {
      1,
      2,
      4,
      3
    },
    {
      1,
      3,
      2,
      4
    },
    {
      1,
      3,
      4,
      2
    },
    {
      1,
      4,
      2,
      3
    },
    {
      1,
      4,
      3,
      2
    },
    {
      2,
      1,
      3,
      4
    },
    {
      2,
      1,
      4,
      3
    },
    {
      2,
      3,
      1,
      4
    },
    {
      2,
      3,
      4,
      1
    },
    {
      2,
      4,
      1,
      3
    },
    {
      2,
      4,
      3,
      1
    },
    {
      3,
      1,
      2,
      4
    },
    {
      3,
      1,
      4,
      2
    },
    {
      3,
      2,
      1,
      4
    },
    {
      3,
      2,
      4,
      1
    },
    {
      3,
      4,
      1,
      2
    },
    {
      3,
      4,
      2,
      1
    },
    {
      4,
      1,
      2,
      3
    },
    {
      4,
      1,
      3,
      2
    },
    {
      4,
      2,
      1,
      3
    },
    {
      4,
      2,
      3,
      1
    },
    {
      4,
      3,
      1,
      2
    },
    {
      4,
      3,
      2,
      1
    }
  }
  local deltaTimeList = {
    0.85,
    0.75,
    0.65,
    0.55,
    0.45,
    0.35,
    0.3,
    0.25,
    0.2,
    0.15
  }
  local deltaX = 230
  for i = 1, 4 do
    local chooseNode = ccui.Widget:create()
    chooseNode:pos(110 + (i - 1) * deltaX, 140):addTo(mainBg)
    chooseNodeList[i] = chooseNode
    local panzi = display.newSprite(MagicCapRes .. "pan.png"):pos(0, 15):addTo(chooseNode)
    local heroNode = ccui.Widget:create()
    heroNode:pos(0, 5):scale(0.7):addTo(chooseNode)
    heroNodeList[i] = heroNode
    repeat
      local isLegal = true
      local roleType = MagicCapHeroCsv[math.randomInt(1, 169)].type
      if 0 < #roleList then
        for j = 1, #roleList do
          if roleList[j] == roleType then
            isLegal = false
          end
        end
        if isLegal then
          roleList[i] = roleType
        end
      else
        roleList[i] = roleType
      end
    until isLegal
    local spine = UIHelper.createSpineNode(roleList[i]):anch(0.5, 0):pos(0, 0):addTo(heroNode)
    spine:setAnimation(0, "idle", true)
    spineList[i] = spine
    local chooseBtn = UIHelper.extend(ccui.Layout:create())
    chooseBtn:setContentSize(cc.size(100, 100))
    chooseBtn:anch(0.5, 0):pos(0, 0):addTo(chooseNode)
    chooseBtn:setCallback(function()
      if not canClick then
        return
      end
      curSelectText:setString("当前选择的食物:" .. UnitCsv[roleList[i]].name)
      selectTips:setVisible(false)
      startMoveBtn:setVisible(true)
      chooseNo = i
    end)
    chooseBtnList[i] = chooseBtn
    chooseBtn:setVisible(false)
    heroNode:setVisible(false)
    local lidImage = UIHelper.newImageView(MagicCapRes .. "guo.png"):anch(0.5, 0):pos(0, -5):addTo(chooseNode)
    local secondChooseBtn
    lidImage:setCallback(function()
      if not canClick then
        return
      end
      for i = 1, 4 do
        secondChooseBtnList[i]:setVisible(false)
      end
      secondChooseBtn:setVisible(true)
    end)
    lidImage:setVisible(false)
    lidImageList[i] = lidImage
    secondChooseBtn = UIHelper.extend(ccui.Button:create())
    secondChooseBtn:setImages(MagicCapRes, {
      "secondChooseBtn.png",
      "secondChooseBtn.png"
    })
    secondChooseBtn:anch(0.5, 0.5):pos(0, 40):addTo(chooseNode):setTouchScale()
    secondChooseBtn:setCallback(function()
      if not canClick then
        return
      end
      canClick = false
      local smoke = UIHelper.loadAnimation("ui/treat/", "cure", 24, 30)
      smoke.sprite:pos(0, 70):addTo(chooseNode)
      smoke.sprite:playAnimationOnce(smoke.animation, true)
      spineList[i]:setAnimation(0, chooseNo == i and "cheer" or "failure", true)
      secondChooseBtn:setVisible(false)
      lidImageList[i]:runAction(transition.sequence({
        cc.Spawn:create(cc.FadeOut:create(1), cc.MoveTo:create(1, cc.p(0, 150))),
        cc.DelayTime:create(0.3),
        cc.CallFunc:create(function()
          local isWin = false
          if chooseNo == i then
            isWin = true
            winImage:setImage(MagicCapRes .. math.min(data.seryWin + 1, 11) .. ".png")
            if globalCsv.activity77AllCountReward[data.allCount + 1] == 1 then
              local allCountWin = display.newSprite(MagicCapRes .. data.allCount + 1 .. "_all.png"):anch(0.5, 0.5):pos(113.5, 110.5):addTo(winImage)
            end
            winImage:setVisible(true)
          else
            isWin = false
            loseImage:setVisible(true)
          end
          game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
            type = 77,
            isWin = isWin and 1 or 0,
            id = math.min(data.seryWin + 2, 11)
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            
            local function clean()
              data = game.role.activityStatus["77"]
              selectTips:setVisible(false)
              winImage:removeAllChildren()
              winImage:setVisible(false)
              loseImage:setVisible(false)
              startBtn:setVisible(true)
              canClick = true
              chooseNo = 0
              curSelectText:setString("当前选择的食物:无")
              roleList = {}
              lidImageList[i]:setOpacity(255)
              for a = 1, 4 do
                chooseBtnList[a]:setVisible(false)
                heroNodeList[a]:setVisible(false)
                lidImageList[a]:setVisible(false)
                secondChooseBtnList[a]:setVisible(false)
                heroNodeList[a]:removeAllChildren()
                repeat
                  local isLegal = true
                  local roleType = MagicCapHeroCsv[math.randomInt(1, 169)].type
                  if 0 < #roleList then
                    for j = 1, #roleList do
                      if roleList[j] == roleType then
                        isLegal = false
                      end
                    end
                    if isLegal then
                      roleList[a] = roleType
                    end
                  else
                    roleList[a] = roleType
                  end
                until isLegal
                local spine = UIHelper.createSpineNode(roleList[a]):anch(0.5, 0):pos(0, 0):addTo(heroNodeList[a])
                spine:setAnimation(0, "idle", true)
                spineList[a] = spine
              end
              gameRoundText:setString("今日奖励次数 " .. math.min(data.dailyGameCount, 10) .. "/10")
              allCountText:setString("总胜利次数:" .. data.allCount)
            end
            
            if next(msg.reward) ~= nil then
              MedalRewardLayer.new({
                items = msg.reward,
                callback = function()
                  clean()
                end
              })
            else
              clean()
            end
          end)
        end)
      }))
    end)
    secondChooseBtnList[i] = secondChooseBtn
    secondChooseBtn:setVisible(false)
  end
  startBtn = UIHelper.extend(ccui.Button:create())
  startBtn:setImages(MagicCapRes, {
    "startBtn.png",
    "startBtn.png"
  })
  startBtn:anch(0.5, 0.5):pos(456, 307):addTo(mainBg):setTouchScale()
  startBtn:setCallback(function()
    startBtn:setVisible(false)
    selectTips:setVisible(true)
    for i = 1, 4 do
      chooseBtnList[i]:setVisible(true)
      heroNodeList[i]:setVisible(true)
    end
  end)
  startMoveBtn = UIHelper.extend(ccui.Button:create())
  startMoveBtn:setImages(MagicCapRes, {
    "moveBtn.png",
    "moveBtn.png"
  })
  startMoveBtn:anch(0.5, 0.5):pos(456, 307):addTo(mainBg):setTouchScale()
  startMoveBtn:setCallback(function()
    if not canClick then
      return
    end
    startMoveBtn:setVisible(false)
    local moveCount = math.randomInt(5, 10)
    local moveRoundInfo = {
      {
        1,
        2,
        3,
        4
      }
    }
    for i = 2, moveCount do
      if i == 2 then
        moveRoundInfo[i] = moveType[math.randomInt(2, 24)]
      else
        moveRoundInfo[i] = moveType[math.randomInt(1, 24)]
      end
    end
    local deltaTime = deltaTimeList[math.min(data.seryWin + 1, 10)]
    
    local function move(node, nodeNo, roundNo)
      local target = moveRoundInfo[roundNo][nodeNo]
      node:runAction(transition.sequence({
        cc.DelayTime:create(0.1),
        cc.EaseInOut:create(cc.MoveTo:create(deltaTime, cc.p(230 * target - 120, 140)), 3),
        cc.CallFunc:create(function()
          if roundNo >= #moveRoundInfo then
            lidImageList[nodeNo]:setEnabled(true)
            return
          end
          move(node, nodeNo, roundNo + 1)
        end)
      }))
    end
    
    for i = 1, 4 do
      lidImageList[i]:pos(0, 100)
      lidImageList[i]:setEnabled(false)
      lidImageList[i]:setVisible(true)
      chooseBtnList[i]:setVisible(false)
      lidImageList[i]:runAction(transition.sequence({
        cc.MoveTo:create(1, cc.p(0, -5)),
        cc.DelayTime:create(0.1),
        cc.CallFunc:create(function()
          move(chooseNodeList[i], i, 1)
        end)
      }))
    end
  end)
  startMoveBtn:setVisible(false)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(890, 490):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_77"
    })
  end)
end

function ActivityMainLayer:showLoginLayer5(Type)
  local data = game.role.activityStatus["81"]
  local mainBg = UIHelper.newImageView(MonthSignRes .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local xPos, yPos, xdelta, ydelta = 100, 250, 80, 100
  for _, data in ipairs(MonthLoginGiftCsv) do
    local state = game.role.activityStatus["81"]:getv(data.day, 0)
    local allTime = game.role.activityStatus["81"]:getv(0, 0)
    local items = data.gift:toArray("=", true)
    if data.effect == 1 then
      local spineNode = UIHelper.createSpineNodeByRes("spine/ui/activity/gold"):pos(xPos, yPos):scale(0.75):addTo(mainBg)
      spineNode:setAnimation(0, "special", true)
    elseif data.effect == 2 then
      local spineNode = UIHelper.createSpineNodeByRes("spine/ui/activity/colorful"):pos(xPos, yPos):scale(0.75):addTo(mainBg)
      spineNode:setAnimation(0, "special", true)
    end
    local giftImage = ItemIcon.new({
      type = items[1],
      count = items[2]
    }):scale(0.75):pos(xPos, yPos):addTo(mainBg, nil, data.day)
    local label = display.newTTFLabel({
      text = string.format("第%d天", data.day),
      size = 18
    }):pos(45, 110):addTo(giftImage):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    UIHelper.makeFontClear(label)
    local done = state == -1
    local btnImage = done and "had.png" or state >= data.day and "get.png" or allTime >= data.day and (data.day == state + 1 and "makeup.png" or "wait.png") or "cant.png"
    local bTouch = not done and allTime >= data.day and data.day <= state + 1
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:center(giftImage):addTo(giftImage):setTouchScale()
    btn:setTouchEnabled(bTouch)
    
    local function getReward()
      if state >= data.day then
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 81,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          btn:setTouchEnabled(false)
          bTouch = false
          btn:setImages(LevelRes, {"had.png", "had.png"})
          MedalRewardLayer.new({
            items = data.gift:toNumMap()
          })
        end)
      else
        MDialog:double({
          title = "补签",
          text = string.format("是否要消耗 <img src='ui/global/5.png' scale=0.5 />X%d 继续？", globalCsv.Activity81CostNum),
          okCallback = function()
            if game.role.diamond < globalCsv.Activity81CostNum then
              UIHelper.showDiamondTip()
              return
            end
            game:sendData(actionCodes.Activity_makeUpSignForMonthSignActivityRpc, MsgPack.pack({
              day = data.day
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_makeUpSignForMonthSignActivityRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              state = game.role.activityStatus["81"]:getv(data.day, 0)
              btn:setImages(LevelRes, {"get.png", "get.png"})
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      end
    end
    
    giftImage:setCallback(function()
      if bTouch then
        getReward()
      else
        MTip:show({
          type = MTipType.item,
          node = giftImage,
          itemType = items[1],
          itemData = ItemCsv[items[1]]
        })
      end
    end)
    btn:setCallback(function()
      getReward()
    end)
    xPos = xPos + xdelta
    if data.day % 10 == 0 then
      yPos = yPos - ydelta
      xPos = 100
    end
  end
end

function ActivityMainLayer:showCostDiamondLayer(Type)
  local mainBg = display.newSprite(CostDiamondRes .. "recharge_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local curNum = game.role.activityStatus["82"]:getv(#CostDiamondCsv, 0)
  if curNum == -1 then
    curNum = CostDiamondCsv[#CostDiamondCsv].cost
  end
  local percent = 0
  local barBg = display.newSprite(CostDiamondRes .. "bar_bg.png"):anch(0, 0):pos(62, 45):addTo(mainBg)
  local barContent = display.newSprite(CostDiamondRes .. "bar_content.png")
  local progressBar = cc.ProgressTimer:create(barContent):anch(0, 0):pos(64, 47):addTo(mainBg)
  progressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
  progressBar:setMidpoint(cc.p(0, 0))
  progressBar:setBarChangeRate(cc.p(1, 0))
  local progressNum = display.newTTFLabel({
    text = string.format("%s/%s", curNum, CostDiamondCsv[#CostDiamondCsv].cost),
    size = 18,
    color = UIHelper.hex2rgb("#faff00")
  }):enableOutline(UIHelper.hex2rgb("#872f0c"), 1):center(progressBar):addTo(progressBar)
  UIHelper.makeFontClear(progressNum)
  local color = {
    [-1] = UIHelper.hex2rgb("#ffffff"),
    [0] = UIHelper.hex2rgb("#faff00"),
    [1] = UIHelper.hex2rgb("#ff2b35")
  }
  
  local function createTag(params)
    local id = params.data.id
    local count = params.count
    local cost = params.data.cost
    local state = params.state
    local tagBg = UIHelper.newImageView(CostDiamondRes .. string.format("tag_%d.png", state + 2))
    tagBg:anch(0.5, 0):pos(math.ceil(id / count * 782 + 58), 68):addTo(mainBg)
    local item = params.data.gift:toArray("=", true)
    display.newSprite(string.format("ui/carbon/chooseTravel/box_%d.png", id)):pos(56, 110):addTo(tagBg)
    local numLabel = display.newTTFLabel({
      text = cost,
      size = 22,
      color = color[state]
    }):anch(0, 0.5):pos(82, 10):rotation(-40):addTo(tagBg):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    local newPercent = 0
    if cost <= curNum then
      newPercent = id / count
    else
      local oriCost = id == 1 and 0 or CostDiamondCsv[id - 1].cost
      if oriCost < curNum then
        newPercent = (id - (cost - curNum) / (cost - oriCost)) / count
      end
    end
    if newPercent > percent then
      percent = newPercent
    end
    if state == -1 then
      display.newSprite(LevelRes .. "had.png"):pos(56, 58):addTo(tagBg)
      return
    end
    local btn = UIHelper.extend(ccui.Button:create())
    local btnImage = state == 1 and "cant.png" or "get.png"
    btn:setImages(LevelRes, {btnImage, btnImage})
    btn:pos(56, 58):addTo(tagBg):setTouchScale()
    
    local function callback()
      if state == 1 then
        ItemRewardLayer.new({
          items = params.data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
        return
      end
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 82, id = id}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        btn:removeSelf()
        tagBg:setImage(CostDiamondRes .. "tag_1.png")
        tagBg:setTouchEnabled(false)
        numLabel:setTextColor(color[-1])
        display.newSprite(LevelRes .. "had.png"):pos(56, 58):addTo(tagBg)
        local msg = MsgPack.unpack(event.data)
        if msg.change then
          MDialog:single({
            title = "温馨提示",
            text = "获得的重复外观已自动折算为等值物品"
          }, function()
            MedalRewardLayer.new({
              items = msg.reward
            })
          end)
        else
          MedalRewardLayer.new({
            items = msg.reward
          })
        end
      end)
    end
    
    btn:setCallback(callback)
    tagBg:setCallback(callback)
  end
  
  for index, data in pairs(CostDiamondCsv) do
    local state = game.role.activityStatus["82"]:getv(index, 0)
    if state ~= -1 then
      state = state >= data.cost and 0 or 1
    end
    createTag({
      data = data,
      count = #CostDiamondCsv,
      state = state
    })
  end
  progressBar:setPercentage(percent * 100)
  local numStr = ""
  for i = 1, #CostDiamondCsv do
    numStr = numStr .. CostDiamondCsv[i].cost .. "/"
  end
  numStr = string.format("活动期间累积消耗钻石达到%s，就可以领取", string.sub(numStr, 1, -2))
  local tipLabel = MRichText.new({
    text = numStr,
    size = 22,
    color = UIHelper.hex2rgb("#530d17")
  }):anch(0.5, 0.5):pos(455, 27):addTo(mainBg)
  UIHelper.makeFontClear(tipLabel)
end

function ActivityMainLayer:showActivity80Layer()
  game:sendData(actionCodes.Activity_chapterPassGetFinalCountRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_chapterPassGetFinalCountRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    ChapterPassPreLayer:init(self.content, msg)
  end)
end

function ActivityMainLayer:showActivity105Layer(Type)
  local mainBg = display.newSprite(Activity105Res .. "main_bg.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local activityStatus = game.role.activityStatus["105"] or {}
  local curDay = activityStatus.sign or 0
  local createDay = math.ceil((game:nowTime() - game.role.createTime) / 86400)
  local signTime = activityStatus.sTime or 0
  local signLabel = display.newTTFLabel({
    text = string.format("签到天数：%d天", curDay),
    size = 20,
    color = UIHelper.hex2rgb("#F3DCC8")
  }):anch(0, 0.5):pos(280, 48):addTo(mainBg)
  local createLabel = display.newTTFLabel({
    text = string.format("角色创建天数：%d天", createDay),
    size = 20,
    color = UIHelper.hex2rgb("#F3DCC8")
  }):anch(0, 0.5):pos(280, 77):addTo(mainBg)
  local posX = 550
  local posY = 385
  local maxSignDay = 0
  for index, data in ipairs(Activity105TaskCsv) do
    if maxSignDay < data.condition2 then
      maxSignDay = data.condition2
    end
    local taskBg = UIHelper.newImageView(Activity105Res .. "task_bg.png"):anch(0.5, 0.5):pos(posX, posY):addTo(mainBg)
    local bg = UIHelper.newImageView(Activity105Res .. "circle_bg.png")
    local items = data.gift:toArray("=", true)
    bg:pos(365, 44):addTo(taskBg)
    bg:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = bg,
        itemType = items[1],
        itemData = ItemCsv[items[1]]
      })
    end)
    display.newSprite(ItemCsv[items[1]].icon):scale(ItemType.HeadFarme == ItemCsv[items[1]].type and 0.4 or 0.7):center(bg):addTo(bg)
    display.newTTFLabel({
      text = "x" .. items[2],
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(37, 15):addTo(bg)
    local label1 = display.newTTFLabel({
      text = string.format("角色创建%d天", data.condition1),
      size = 20,
      color = UIHelper.hex2rgb("#763B15")
    }):anch(0, 0.5):pos(35, 62):addTo(taskBg)
    local label2 = display.newTTFLabel({
      text = string.format("签到%d天", data.condition2),
      size = 20,
      color = UIHelper.hex2rgb("#763B15")
    }):anch(0, 0.5):pos(35, 33):addTo(taskBg)
    UIHelper.makeFontClear(label1)
    UIHelper.makeFontClear(label2)
    local status = (activityStatus.status or ""):getv(data.id, 0)
    if status == 1 then
      taskBg:setImage(Activity105Res .. "task_bg2.png")
      display.newSprite(Activity105Res .. "done.png"):pos(485, 44):addTo(taskBg)
    elseif createDay >= data.condition1 and curDay >= data.condition2 then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(Activity105Res, {"btn_1.png", "btn_1.png"})
      btn:pos(485, 44):addTo(taskBg)
      btn:setCallback(function()
        game:sendData(actionCodes.Activity_act105GetRewardRpc, MsgPack.pack({
          type = 105,
          id = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_act105GetRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          btn:removeSelf()
          display.newSprite(Activity105Res .. "done.png"):pos(485, 44):addTo(taskBg)
        end)
      end)
    else
      display.newSprite(Activity105Res .. "btn_2.png"):pos(485, 44):addTo(taskBg)
    end
    posY = posY - 82
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(Activity105Res, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(880, 480):addTo(mainBg):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity105",
      tableHeightMin = 56
    })
  end)
  if curDay < maxSignDay then
    if signTime == UIHelper.getOperationDayStartTime() then
      display.newSprite(Activity105Res .. "sign_done.png"):anch(1, 0.5):pos(840, 60):addTo(mainBg)
      return
    end
    local btnSign = UIHelper.extend(ccui.Button:create())
    btnSign:setImages(Activity105Res, {
      "btn_sign.png",
      "btn_sign.png"
    })
    btnSign:anch(1, 0.5):pos(840, 60):addTo(mainBg):setTouchScale()
    btnSign:setCallback(function()
      if signTime == UIHelper.getOperationDayStartTime() then
        MFlashMsg:show({
          text = "今日已签到"
        })
        return
      end
      game:sendData(actionCodes.Activity_act105SignRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_act105SignRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.status == 0 then
          signLabel:setString(string.format("签到天数：%d天", curDay + 1))
          MFlashMsg:show({
            text = "签到成功"
          })
          self.content:removeAllChildren()
          self:showActivity105Layer()
        end
      end)
    end)
  end
end

function ActivityMainLayer:showLimitTimeGift1001(Type)
  local data = game.role.activityStatus["1001"]
  local mainBg = display.newSprite(TimeLimitGiftRes .. "kitchen_1001.png"):anch(0, 0):pos(-455, -256):addTo(self.content)
  local costType = TimeLimitGiftCsv[1001].costType
  local cost = TimeLimitGiftCsv[1001].cost
  local remainTimeText = display.newTTFLabel({
    text = "",
    size = 22,
    color = UIHelper.hex2rgb("#000000")
  }):pos(277, 297):addTo(mainBg)
  local startTime = data.startTime
  remainTimeText:runAction(cc.RepeatForever:create(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local remainTime = startTime + TimeLimitGiftCsv[1001].time - game:nowTime()
      if 0 <= remainTime then
        local timeTab = os.date("!*t", remainTime)
        remainTimeText:setString(string.format("%d时%d分%d秒", timeTab.hour, timeTab.min, timeTab.sec))
      else
        self:showData({disappear = 1001})
        remainTimeText:stopAllActions()
      end
    end)
  })))
  local buybtn = UIHelper.extend(ccui.Button:create())
  buybtn:setImages(TimeLimitGiftRes, {"buy.png", "buy.png"})
  buybtn:pos(750, 58):addTo(mainBg):setTouchScale()
  buybtn:setCallback(function()
    local costname
    if costType == 60 then
      costname = "礼包券"
    elseif costType == 5 then
      costname = "钻石"
    end
    if (game.role.items[costType] or 0) < cost then
      MDialog:double({
        title = costname .. "不足",
        text = costname .. "不足，是否跳转商城购买？",
        okCallback = function()
          local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
          BackManager:push(function()
            TopBar:show(TopBarType.full, "活动")
            layer:close()
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      MDialog:double({
        title = "礼包购买",
        text = "确认要购买" .. TimeLimitGiftCsv[1001].desc .. "吗？",
        okCallback = function()
          game:sendData(actionCodes.Activity_timeLimitGiftBuyRpc, MsgPack.pack({activityType = 1001}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_timeLimitGiftBuyRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            MedalRewardLayer.new({
              items = msg.reward
            })
            self:showData({disappear = 1001})
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    end
  end)
end

function ActivityMainLayer:createOnePTRank(idx, data)
  local isSelf = data.roleId == game.role.id
  local rankColor = isSelf and "#ffe13c" or "#ffffff"
  local cell = UIHelper.newImageView(RankRes .. (isSelf and "phb3.png" or "phb2.png"))
  if isSelf then
    self.inRank = idx
  end
  local bg = UIHelper.newImageView(PicCsv[data.headIconTag].res):addTo(cell):pos(94, 30):scale(0.38)
  display.newSprite(FramCsv[data.headFrameTag].res):center(bg):addTo(bg)
  display.newTTFLabel({
    text = idx,
    size = 40,
    color = UIHelper.hex2rgb(rankColor)
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(35, 30):addTo(cell)
  display.newTTFLabel({
    text = string.format("拥有PT数量:%d个", data.itemCount or 0),
    size = 24,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(530, 30):addTo(cell)
  local label = display.newTTFLabel({
    text = data.name,
    size = 20,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(130, 28):addTo(cell)
  return cell
end

function ActivityMainLayer:getRotation(node, index)
  local beginRota = node:getRotation() % 360
  node:setRotation(beginRota)
  local endRota = (index - 1) * 36
  return beginRota == 0 and 360 or 360 - beginRota, endRota
end

function ActivityMainLayer:clearHander()
  if self.handlers then
    for _, tag in pairs(self.handlers) do
      game.role:removeEventListener(tag)
    end
  end
  if self.handlersUpdate then
    for _, tag in pairs(self.handlersUpdate) do
      game.role:removeEventListener(tag)
    end
  end
end

function ActivityMainLayer:onExit()
  self:clearHander()
end

return ActivityMainLayer
