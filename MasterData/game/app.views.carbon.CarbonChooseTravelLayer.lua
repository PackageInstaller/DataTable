local InfoCsv = require("csvdata.tour_info")
local DateCsv = require("csvdata.tour_date")
local TravelRes = "ui/carbon/chooseTravel/"
local uiData = {
  csbFile = "ui/carbon/CarbonChooseTravelLayer.csb",
  widgets = {
    mainBg = "mainBg",
    title = "mainBg/title",
    desc = "mainBg/desc",
    rule = "mainBg/rule",
    battle = "mainBg/battle",
    diff = "mainBg/diff",
    node = "mainBg/node",
    buyBtn = "mainBg/buyBtn",
    startBtn = "mainBg/startBtn",
    timesBg = "mainBg/timesBg",
    title1 = "mainBg/title1",
    desc1 = "mainBg/desc1",
    bar = "mainBg/barBg/bar",
    money = "mainBg/barBg/money",
    root = "node",
    cards = "cards",
    gifts = "gifts"
  }
}
local localPos = {
  [1] = {120, 310},
  [2] = {300, 310},
  [3] = {490, 310}
}
local names = {
  "吃货",
  "助手",
  "小厨",
  "中厨",
  "大厨",
  "厨神"
}
local CarbonChooseTravelLayer = class("CarbonChooseTravelLayer", UIBase)

function CarbonChooseTravelLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonChooseTravelLayer:init(params)
  TopBar:show(TopBarType.full, "游历")
  self.buyBtn:setTouchScale()
  self.startBtn:setTouchScale()
  self.startBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#641f08"), 2)
  display.newTTFLabel({text = "领取", size = 18}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):pos(45, 19):addTo(self.buyBtn)
  UIHelper.MoveToLeft({
    node = self.mainBg
  })
  self.giftNum = 0
  local cloud = display.newSprite("ui/carbon/main/cloud2.png"):anch(1, 0):pos(0, 0):addTo(self.root)
  cloud:runAction(cc.RepeatForever:create(transition.sequence({
    cc.MoveBy:create(30, cc.p(255, 0)),
    cc.MoveBy:create(30, cc.p(-255, 0))
  })))
  local str = "每日 "
  self.limitT = globalCsv.tourOpentime:toTableArray()
  for _, time in ipairs(self.limitT) do
    local hour1, min1 = math.modf(time[1] / 100)
    local hour2, min2 = math.modf(time[2] / 100)
    str = str .. string.format("%d:%02d~%d:%02d ", hour1, min1 * 100, hour2, min2 * 100)
  end
  str = str .. "开放"
  local timeBg = display.newSprite(TravelRes .. "time_bg.png"):pos(295, 135):addTo(self)
  display.newTTFLabel({
    text = str,
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):center(timeBg):addTo(timeBg)
  self.difficult = #InfoCsv
  for level, info in ipairs(InfoCsv) do
    if game.role.level <= info.playerLevel then
      self.difficult = level
      break
    end
  end
  local jump = false
  self.buyBtn:setCallback(function()
    if jump then
      return
    end
    if game.role.dailyExploreScore:getv(self.difficult, 0) < globalCsv.tourRewardCost then
      SysError(SYS_TOUR_BUY_POINT_NOT_ENOUGH)
      return
    end
    local old = game.role.dailyExploreGift
    game:sendData(actionCodes.Explore_buyBoxRpc, MsgPack.pack({
      difficult = self.difficult
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Explore_buyBoxRpc, function(event)
      UIHelper.removeWaiting()
      MedalRewardLayer.new({
        items = MsgPack.unpack(event.data),
        callback = function()
          self:showDetail()
          local new = game.role.dailyExploreGift
          if old == new then
            return
          end
          jump = true
          local flash = UIHelper.createSpineNodeByRes("ui/carbon/chooseTravel/fd"):pos(540, 330):addTo(self.gifts)
          game:playMusic(1907)
          flash:setAnimation(0, "in", false)
          flash:runAction(transition.sequence({
            cc.DelayTime:create(0.6),
            cc.CallFunc:create(function()
              flash:setAnimation(0, "cycle", true)
            end),
            cc.DelayTime:create(0.5),
            cc.MoveTo:create(0.5, cc.p(self.giftNum * 95, 0)),
            cc.DelayTime:create(0.3),
            cc.CallFunc:create(function()
              self:showGift()
              jump = false
            end)
          }))
        end
      })
    end)
  end)
end

function CarbonChooseTravelLayer:showData(params)
  self:showDiffLevel()
  self:showCards()
  self:showDetail()
  self:showGift()
  self.startBtn:setCallback(function()
    if not self:getBattleNum() then
      SysError(SYS_ERR_CARBON_NO_TEAM_AVAILABLE)
      return
    end
    local data = InfoCsv[self.difficult]
    local now = os.date("*t", game:nowTime())
    local nowTime = now.hour * 100 + now.min
    local fit = false
    for _, time in ipairs(self.limitT) do
      if nowTime > tonumber(time[1]) and nowTime < tonumber(time[2]) then
        fit = true
        break
      end
    end
    if not fit then
      SysError(SYS_TOUR_NOT_OPEN_TIME)
      return
    end
    local InfoData = json.decode(game.role.exploreStatus)
    local cur = game.role.dailyExploreScore:getv(self.difficult, 0)
    if cur >= globalCsv.tourRewardCost then
      SysError(SYS_TOUR_SCORE_ENOUGH)
      return
    end
    
    local function enterGame(index)
      game:sendData(actionCodes.Explore_enterRpc, MsgPack.pack({
        difficult = self.difficult,
        teamIndex = index
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Explore_enterRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.result == SERVER_EXPLORE_ENTER_SUCCESS then
          game:enterScene("TravelScene", msg)
        else
          SysError(msg.result)
        end
      end)
    end
    
    if InfoData.teamIndex then
      if self.difficult ~= InfoData.difficult then
        MFlashMsg:show({
          text = string.format("主厨，您正在进行难度为%s的游历哦", names[InfoData.difficult])
        })
        return
      end
      enterGame(InfoData.teamIndex)
    else
      local layer = game:createView("hero.TravelListLayer", {
        requireValue = data.minBattleValue,
        callback = function(choose)
          local format = game.role.formation[tostring(choose)]
          local battle = 0
          if not format then
            return
          end
          if format.list then
            for slot, id in pairs(format.list) do
              local hero = game.role.heros[id]
              if hero.hpPercent == 0 then
                SysError(SYS_ERR_FIGHT_SET_NO_HP)
                return
              end
              battle = battle + hero:getAllValue()
            end
          end
          if battle < data.minBattleValue then
            SysError(SYS_ERR_HERO_BATTLR_NOT_ENOUGH)
            return
          end
          local state = game.role:getFormationState(choose)
          if state[1] then
            SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
            return
          end
          enterGame(choose)
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end
  end)
end

function CarbonChooseTravelLayer:showDiffLevel()
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:enableOutline(UIHelper.hex2rgb("#b4580f"), 1)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:enableOutline(UIHelper.hex2rgb("#007779"), 1)
    end
  })
  local xPos = 89
  for index, name in ipairs(names) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(TravelRes, {
      "btn_diff_a.png",
      "btn_diff_b.png"
    })
    btn:pos(xPos + (index - 1) * 82, 510):addTo(self)
    display.newTTFLabel({text = name, size = 20}):pos(40, 16):addTo(btn):name("name")
    btn:setCallback(function()
      self.difficult = index
      self:showDetail()
    end)
    btn:setName(string.format("btn%d", index))
    btn:setGroup(group)
  end
  group:chooseByName("btn" .. self.difficult)
end

function CarbonChooseTravelLayer:showCards()
  for i = 1, 3 do
    local card = display.newSprite(TravelRes .. string.format("image_%d.png", i)):pos(localPos[i][1], localPos[i][2]):addTo(self.cards, 10)
    local size = card:getContentSize()
    if i ~= 2 then
      card:scale(0.75)
      card:setColor(cc.c3b(140, 140, 140))
      card:setLocalZOrder(1)
    else
      local textBg = display.newSprite(TravelRes .. "mode_text_bg.png"):pos(size.width / 2, 34):addTo(card)
      local text = display.newSprite(TravelRes .. "type_1.png"):pos(size.width / 2, 32):addTo(card)
    end
  end
end

function CarbonChooseTravelLayer:showDetail()
  local data = InfoCsv[self.difficult]
  self.node:removeAllChildren()
  self.title:setString(data.name)
  self.desc:setString(data.desc)
  self.rule:setString(data.rule)
  self.battle:setString(data.minBattleValue)
  self.diff:setString(names[self.difficult])
  self.timesBg:removeAllChildren()
  local cur = game.role.dailyExploreScore:getv(self.difficult, 0)
  self.money:setString(string.format("%d/%d", cur, globalCsv.tourRewardCost))
  self.bar:setPercent(cur / globalCsv.tourRewardCost * 100)
  self.title1:setString(data.reward)
  self.desc1:setString(data.rewardContext)
  UIHelper.newImageView("ui/carbon/travel/" .. string.format("icon_%d.png", self.difficult)):scale(0.8):pos(75, 3):addTo(self.node)
  local gift = UIHelper.newImageView(TravelRes .. string.format("box_%d.png", self.difficult)):addTo(self.node)
  if game.role.dailyExploreBox >= globalCsv.tourRewardTimes then
    display.newSprite(TravelRes .. "got.png"):pos(0, -20):addTo(self.node)
    self.buyBtn:hide()
  else
    self.buyBtn:show()
    gift:setCallback(function()
      UIHelper.showRewardView({
        sender = gift,
        itemStr = data.showContent,
        scale = 0.8
      })
    end)
  end
  MRichText.new({
    text = string.format("今日可领取<div color=#adeb20>%d</div>次游历套餐", globalCsv.tourRewardTimes - game.role.dailyExploreBox),
    size = 18,
    color = UIHelper.hex2rgb("#51a6d0")
  }):anch(0.5, 0.5):pos(193, 15):addTo(self.timesBg)
end

function CarbonChooseTravelLayer:showGift()
  self.gifts:removeAllChildren()
  self.giftNum = 0
  local gifts = game.role.dailyExploreGift:toNumMap()
  for index, giftId in pairs(gifts) do
    if giftId ~= 0 then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(TravelRes, {"pack_a.png", "pack_a.png"})
      btn:pos(self.giftNum * 95, 0):addTo(self.gifts)
      btn:setTouchScale()
      btn:setCallback(function()
        local layer = game:createView("carbon.TravelGiftPackLayer", {id = giftId, index = index})
        BackManager:push(function()
          self:showGift()
          layer:close()
        end)
      end)
      self.giftNum = self.giftNum + 1
    end
  end
end

function CarbonChooseTravelLayer:getBattleNum()
  local newNum = 0
  for index, data in pairs(game.role.formation) do
    if data.list["1"] then
      local states = game.role:getFormationState(tonumber(index))
      if not states[1] and not states[2] and not states[3] then
        newNum = newNum + 1
      end
    end
  end
  return 0 < newNum
end

return CarbonChooseTravelLayer
