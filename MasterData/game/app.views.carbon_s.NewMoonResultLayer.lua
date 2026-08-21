local ChapterBattleCsv = require("csvdata.moon_chapter_battle")
local TalkCsv = require("csvdata.talk")
local ItemCsv = require("csvdata.item")
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
  TopBar:show(TopBarType.hide)
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
end

function NewCarbonResultLayer:initBaseInfo()
  display.newSprite(CarbonRes .. "guanka.png"):pos(141, 35):addTo(self.titleBg)
  local data = ChapterBattleCsv[self.carbonId]
  display.newTTFLabel({
    text = string.format("%s%s", "净化：", data.name),
    size = 26,
    color = UIHelper.hex2rgb("#FFF7BC")
  }):anch(0, 0.5):pos(120, 415):addTo(self.panel)
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
  display.newSprite(CarbonRes .. "tip5.png"):pos(64, 20):addTo(image2)
  UIHelper.MoveToLeft({
    node = image2,
    delay = delay,
    time = time,
    pos = {500, 0}
  })
  delay = delay + dtime
  local kills = {}
  for day, data in pairs(self.result.kill) do
    for id, num in pairs(data) do
      kills[tonumber(id)] = (kills[tonumber(id)] or 0) + num
    end
  end
  local xPos, yPos = 240, 190
  for index = 1, 6 do
    local icon = display.newSprite(CarbonRes .. string.format("monster%d.png", index)):pos(xPos, yPos):addTo(self.panel)
    local label = display.newTTFLabel({
      text = "x 0",
      size = 18,
      color = UIHelper.hex2rgb("#f5d090")
    }):pos(50, 10):addTo(icon)
    UIHelper.MoveToLeft({
      node = icon,
      delay = delay,
      time = time,
      pos = {380, 0}
    })
    self.actions[index] = {
      node = label,
      endNum = kills[index] or 0
    }
    xPos = xPos + 85
    if index == 3 then
      xPos = 240
      yPos = yPos - 30
    end
  end
  delay = delay + dtime
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
  if next(self.heros) then
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
  if goCarbon then
    if not game.role:carbonActivityIsOpen() then
      SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
      return
    end
    if game.role:isMaxHero() then
      UIHelper.showExtraTip({type = 1, parent = self})
      return
    end
    local chapterData = ChapterBattleCsv[self.carbonId]
    if chapterData.bill > 0 and (game.role.items[30001] or 0) < chapterData.bill then
      SysError(SYS_ERR_GENERALCARBON_NOBILL)
      return
    end
    if game.role.midBattleCount:getv(chapterData.id, 0) == 0 and chapterData.story1 ~= 0 then
      game:createView("talk.PlotTalkLayer", {
        talkId = chapterData.story1,
        csvNo = chapterData.readcsv or 0,
        onComplete = function()
          game:enterScene("MoonScene", {
            carbonId = chapterData.id
          })
        end
      })
      return
    end
    game:enterScene("MoonScene", {
      carbonId = chapterData.id
    })
  else
    BackManager:pop()
  end
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
  UIHelper.numVaryEffect({
    node = params.node,
    repeatTimes = 5,
    stringFormat = "x %d",
    endNum = params.endNum,
    effectTime = Time or 1
  })
end

return NewCarbonResultLayer
