local ChapterBattleCsv = require("csvdata.chapter_battle")
local MonsterCsv = require("csvdata.monster")
local TalkCsv = require("csvdata.talk")
local ItemCsv = require("csvdata.item")
local AutoBattleCsv = require("csvdata.auto_battle")
local CarbonRes = "ui/carbon/carbonresult/"
local BattleRes = "ui/carbon/battleresult/"
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  widgets = {touch = "touch"}
}
local NewCarbonResultLayer = class("NewCarbonResultLayer", UIBase)

function NewCarbonResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewCarbonResultLayer:init(params)
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.actions = {}
  self.result = params.endResult
  self.carbonId = params.carbonId
  self.formatId = params.id
  self.autoBattle = params.autoBattle
  self.battleType = params.carbonType
  self.modeType = params.modeType
  self.skipAnimation = false
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.actionNode = display.newNode():center(self):addTo(self)
  self.heroNode = display.newNode():pos(350, 280):addTo(self)
  self.panel = display.newSprite(CarbonRes .. "panel_bg.png"):anch(1, 0.5):pos(1136 + self.dalteX, 350):addTo(self)
  self.titleBg = display.newSprite(BattleRes .. "title_bg.png"):anch(0, 0.5):pos(-self.dalteX, 570):addTo(self)
  self:initBaseInfo()
  self:initRoleInfo()
end

function NewCarbonResultLayer:showData(params)
  self:hide()
  if not params.isTopBar then
    TopBar:show(TopBarType.hide)
  end
  self.heros = {}
  for itemId, count in pairs(self.result.dropItems) do
    if ItemCsv[itemId].type == ItemType.Hero and CommonHelper.showHeroAnimation(itemId - ItemStartId.hero, count) then
      self.heros[itemId] = count
    end
  end
  self:showItems()
end

function NewCarbonResultLayer:initDelay()
  self:show()
  UIHelper.MoveToRight({
    node = self.titleBg,
    time = 0.2
  })
  UIHelper.MoveToRight({
    node = self.heroNode,
    delay = 0.1,
    time = 0.2,
    pos = {350, 0}
  })
  UIHelper.MoveToLeft({
    node = self.panel,
    delay = 0.3,
    time = 0.3
  })
  self.touch:setCallback(function()
    if not self.skipAnimation then
      self.skipAnimation = true
      self:resetUI()
    end
  end)
  self.actionNode:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self:initPanelInfo()
      for _, data in ipairs(self.actions) do
        self:barRunAnimation(data)
      end
    end),
    cc.DelayTime:create(0.3),
    cc.CallFunc:create(function()
      self.skipAnimation = true
    end)
  }))
  local btn1 = UIHelper.extend(ccui.Button:create())
  btn1:setImages("ui/global/", {
    "dialog_cancel.png",
    "dialog_cancel.png"
  })
  btn1:pos(1039 + self.dalteX, 50):addTo(self)
  btn1:setTouchScale()
  btn1:setCallback(function()
    self:nextCallBack()
  end)
  display.newTTFLabel({text = "确定", size = 24}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(70, 23):addTo(btn1)
  local mapId = math.floor(self.carbonId / 100)
  if 400 < mapId or game.role.majorGuideStep <= MAX_MAJOR_STEP then
    return
  end
  if not self.autoBattle then
    local btn2 = UIHelper.extend(ccui.Button:create())
    btn2:setImages("ui/global/", {
      "dialog_ok.png",
      "dialog_ok.png"
    })
    btn2:pos(835 + self.dalteX, 50):addTo(self)
    btn2:setTouchScale()
    btn2:setCallback(function()
      self:nextCallBack(true)
    end)
    display.newTTFLabel({
      text = "再次净化",
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(70, 23):addTo(btn2)
  elseif UserData.autoBattleLoop == 1 then
    local time = 5
    local label = display.newTTFLabel({
      text = string.format("%d秒后自动关闭", time),
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(835 + self.dalteX, 50):addTo(self)
    
    local function timeTick()
      self.touch:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          if 0 < time then
            label:setString(string.format("%d秒后自动关闭", time))
            time = time - 1
            timeTick()
          else
            self:nextCallBack(true)
            label:removeSelf()
          end
        end)
      }))
    end
    
    timeTick()
  end
end

function NewCarbonResultLayer:initBaseInfo()
  display.newSprite(CarbonRes .. "guanka.png"):pos(141, 35):addTo(self.titleBg)
  local data = ChapterBattleCsv[self.carbonId]
  display.newTTFLabel({
    text = string.format("%s%s %s", "净化：", data.name, self.carbonId < 20000 and "(轻污染)" or self.carbonId > 30000 and "(污染源)" or "(重污染)"),
    size = 26,
    color = UIHelper.hex2rgb("#FFF7BC")
  }):anch(0, 0.5):pos(120, 420):addTo(self.panel)
  if not CommonHelper.funcOpen("ghost") then
    display.newTTFLabel({
      text = "未开启搜索异变食灵功能",
      size = 18,
      color = UIHelper.hex2rgb("#2ee009")
    }):anch(0, 0.5):pos(120, 392):addTo(self.panel)
    return
  end
  if self.result.energy == -1 or self.result.energy == 100 then
    self.result.energy = 0
  end
  local time = game.role.progressTime
  time = time == 0 and game:nowTime() or time
  local progress = game.role.progress + (game:nowTime() - time) / (60 * globalCsv.ghostPowerSpeed)
  progress = math.min(100, progress)
  display.newTTFLabel({
    text = "异变能量",
    size = 18,
    color = UIHelper.hex2rgb("#FFF7BC")
  }):anch(0, 0.5):pos(120, 392):addTo(self.panel)
  local barBg = display.newSprite(CarbonRes .. "bar_bg.png"):pos(310, 392):addTo(self.panel)
  local bar = display.newProgressTimer(CarbonRes .. "bar.png", 1):center(barBg):addTo(barBg)
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setPercentage((progress - self.result.energy) / 100 * 100)
  local label = display.newTTFLabel({
    text = "",
    size = 18,
    color = UIHelper.hex2rgb("#2ee009")
  }):anch(0, 0.5):pos(415, 393):addTo(self.panel)
  table.insert(self.actions, {
    bar = bar,
    add = self.result.energy,
    endProcess = progress,
    label = label
  })
end

function NewCarbonResultLayer:initRoleInfo()
  local heroId = game.role.formation[tostring(self.formatId)].list["1"]
  if game.role.heros[heroId] then
    local image = HeroBigCard.new({
      heroId = heroId,
      quality = game.role.heros[heroId].quality
    }):anch(0.5, 0):pos(0, -570):addTo(self.heroNode)
    image:setOpacity(0)
    image:runAction(cc.FadeIn:create(0.5))
    if self.result.win then
      local say = display.newSprite(CarbonRes .. "say.png"):pos(-10, -220):addTo(self.heroNode)
      local text = display.newTTFLabel({
        text = TalkCsv[game.role.heros[heroId].unit.type].victory,
        size = 18,
        color = UIHelper.hex2rgb("#000000"),
        dimensions = cc.size(380, 56)
      }):pos(210, 36):addTo(say)
      CommonHelper.playCV(game.role.heros[heroId].unit.type, "victory")
      say:setOpacity(0)
      say:runAction(cc.FadeIn:create(0.5))
    end
  end
end

function NewCarbonResultLayer:initPanelInfo()
  local time = self.skipAnimation and 0 or 0.2
  local dtime = self.skipAnimation and 0 or 0.2
  local delay = 0
  local image1 = display.newSprite("ui/carbon/carbonresult/tip2.png"):anch(0, 0.5):pos(80, 360):addTo(self.panel)
  display.newSprite("ui/carbon/carbonresult/tip3.png"):pos(64, 20):addTo(image1)
  UIHelper.MoveToLeft({
    node = image1,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  local chapterData = ChapterBattleCsv[self.carbonId]
  if chapterData.endconditionType == 2 then
    local desc = {
      chapterData.AssessDesc6,
      chapterData.AssessDesc5,
      chapterData.AssessDesc4
    }
    local dayConds = chapterData.assessment:toTableArray()
    local result = {}
    if self.result.win and self.result.boss then
      result[3] = true
    end
    if self.result.win and self.result.costDay <= tonumber(dayConds[2][2]) then
      result[2] = true
      result[1] = true
    end
    if self.result.win and self.result.costDay > tonumber(dayConds[2][2]) then
      result[1] = true
    end
    for idx = 3, 1, -1 do
      local label = display.newTTFLabel({
        text = desc[idx],
        size = 20,
        color = UIHelper.hex2rgb(result[idx] and "#2ee009" or "#ababab")
      }):anch(0, 0.5):pos(225, 260 + (idx - 1) * 30):addTo(self.panel)
      UIHelper.MoveToLeft({
        node = label,
        delay = delay,
        time = time,
        pos = {380, 0}
      })
      delay = delay + dtime
    end
  else
    local desc = {
      chapterData.AssessDesc3,
      chapterData.AssessDesc2,
      chapterData.AssessDesc1
    }
    for idx = 3, 1, -1 do
      local label = display.newTTFLabel({
        text = desc[idx],
        size = 20,
        color = UIHelper.hex2rgb(idx <= self.result.assess and "#2ee009" or "#ababab")
      }):anch(0, 0.5):pos(225, 260 + (idx - 1) * 30):addTo(self.panel)
      UIHelper.MoveToLeft({
        node = label,
        delay = delay,
        time = time,
        pos = {380, 0}
      })
      delay = delay + dtime
    end
  end
  local image2 = display.newSprite(CarbonRes .. "tip2.png"):anch(0, 0.5):pos(85, 220):addTo(self.panel)
  display.newSprite(CarbonRes .. "tip4.png"):pos(64, 20):addTo(image2)
  UIHelper.MoveToLeft({
    node = image2,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  for cond = 1, 3 do
    local label = display.newTTFLabel({
      text = chapterData["con" .. cond .. "Desc"],
      size = 20,
      color = UIHelper.hex2rgb("#F5D090")
    }):anch(0, 0.5):pos(260, 215 - (cond - 1) * 25):addTo(self.panel)
    display.newSprite(CarbonRes .. string.format("aim%d.png", self.result.achievement[cond] and 1 or 0)):pos(-20, 7):addTo(label)
    UIHelper.MoveToLeft({
      node = label,
      delay = delay,
      time = time,
      pos = {380, 0}
    })
    delay = delay + dtime
  end
  local image3 = display.newSprite(CarbonRes .. "tip2.png"):anch(0, 0.5):pos(85, 120):addTo(self.panel)
  display.newSprite(BattleRes .. "jiesuan_7.png"):pos(64, 20):addTo(image3)
  UIHelper.MoveToLeft({
    node = image3,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  local list = ccui.ListView:create()
  list:size(cc.size(480, 84))
  list:setInnerContainerSize(cc.size(480, 84))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:setDirection(2)
  list:anch(0, 0.5):pos(100, 55):addTo(self.panel)
  for itemId, count in pairs(self.result.dropItems) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(86, 84)):addTo(list)
    local icon = ItemIcon.new({
      type = itemId,
      count = count,
      showTip = true
    }):scale(0.8):center(viewNode):addTo(viewNode)
    UIHelper.MoveToLeft({
      node = icon,
      delay = delay,
      time = time,
      pos = {480, 0}
    })
    delay = delay + dtime
  end
  list:doLayout()
  local image4 = display.newSprite(BattleRes .. string.format("point%d.png", self.result.assess)):scale(1.5):pos(60, 325):addTo(self.panel)
  image4:setOpacity(0)
  image4:runAction(transition.sequence({
    cc.DelayTime:create(delay),
    cc.CallFunc:create(function()
      game:playMusic(1700)
      image4:setOpacity(255)
    end),
    cc.Spawn:create(cc.MoveTo:create(time, cc.p(165, 290)), cc.ScaleTo:create(time, 0.9))
  }))
end

function NewCarbonResultLayer:showItems()
  if next(self.heros) and not self.autoBattle then
    MedalRewardLayer.new({
      items = self.heros,
      callback = function()
        self:initDelay()
      end
    })
  else
    self:initDelay()
  end
end

function NewCarbonResultLayer:nextCallBack(goCarbon)
  local function nextStep()
    if goCarbon then
      if game.role:isMaxHero() then
        UIHelper.showExtraTip({type = 1, parent = self})
        
        return
      end
      if game.role:isMaxEquip() then
        UIHelper.showExtraTip({type = 2, parent = self})
        return
      end
      if self.autoBattle then
        BackManager:pop()
      else
        game:enterScene("CarbonScene", {
          carbonId = self.carbonId,
          modeType = self.modeType
        })
      end
    else
      local activeGuide = game.role.activeGuide
      game.role.cancelAutoBattle = true
      BackManager:pop()
    end
  end
  
  if self.result.trade then
    local layer = game:createView("trade.TradeSellLayer", {
      items = game.role.tradeItems,
      autoBattle = self.autoBattle,
      battleType = BattleType.PvE
    })
    BackManager:push(function()
      self.result.trade = false
      layer:close()
      nextStep()
    end)
    return
  end
  nextStep()
end

function NewCarbonResultLayer:resetUI()
  local xPos = {
    0,
    250,
    1136 + self.dalteX
  }
  for idx, name in ipairs({
    "titleBg",
    "heroNode",
    "panel"
  }) do
    self[name]:stopAllActions()
    self[name]:setOpacity(255)
    self[name]:setPositionX(xPos[idx])
  end
end

function NewCarbonResultLayer:barRunAnimation(params)
  local seq, time = {}, self.skipAnimation and 0 or 0.5
  params.bar:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      UIHelper.numVaryEffect({
        node = params.label,
        repeatTimes = 10,
        endNum = params.add,
        stringFormat = "+%d",
        effectTime = time
      })
    end),
    cc.ProgressTo:create(time / 2, params.endProcess)
  }))
end

return NewCarbonResultLayer
