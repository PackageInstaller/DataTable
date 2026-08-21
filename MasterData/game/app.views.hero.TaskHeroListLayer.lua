local unitCsv = require("csvdata.unit")
local heroRes = "ui/hero/"
local uiData = {
  csbFile = "ui/hero/HeroListLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    btnList = "btnList",
    content = "content",
    btnBattle = "btnBattle",
    btnsBg = "btnsBg",
    angle = "angle",
    up = "up",
    bottom_1 = "bottom_1"
  }
}
local limitTable = {
  [1] = "主食数量: ",
  [2] = "主菜数量: ",
  [3] = "副菜数量: ",
  [4] = "甜点数量: ",
  [5] = "头盘数量: ",
  [6] = "汤饮数量: ",
  [7] = "人数要求: ",
  [8] = "最低等级: ",
  [9] = "队长等级: ",
  [10] = "一阶觉醒: ",
  [11] = "二阶觉醒: ",
  [12] = "三阶觉醒: "
}
local HeroListLayer = class("HeroListLayer", UIBase)

function HeroListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HeroListLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.angle:setPositionX(self.angle:getPositionX() + UIHelper.getMoveXForX())
    self.btnBattle:setPositionX(self.btnBattle:getPositionX() + UIHelper.getMoveXForX())
    self.bottom_1:setPositionX(self.bottom_1:getPositionX() - UIHelper.getMoveXForX())
    self.btnList:setPositionX(self.btnList:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX() + 50)
  end
  TopBar:show(TopBarType.full, "委托")
  self.taskData = params.task or {}
  self.callback = params.callback
  self.result = true
  self.selected = false
  self.btnBattle:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite(heroRes .. "taocan_1.png"):getContentSize()
  local delay = 0.4
  for index = 1, game.role.teamMaxNum do
    local needShow = true
    if not game.role.formation[tostring(index)] or not game.role.formation[tostring(index)].list["1"] then
      needShow = false
    end
    local status = game.role:getFormationState(index)
    if status[2] or status[3] then
      needShow = false
    end
    if needShow then
      if not self.selected then
        self.selected = index
      end
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.btnList):setName(string.format("%d", index))
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(heroRes, {
        "taocan_1.png",
        "taocan_2.png"
      })
      btn:center(viewNode):addTo(viewNode)
      btn:setString({
        text = string.format("套餐%d", index),
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:setCallback(function()
        self:showFormation(index)
      end)
      btn:setName(string.format("list%d", index))
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
      btn:setGroup(self.group)
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.2
      })
      delay = delay + 0.1
    end
  end
  self.btnBattle:setTitleText("确定")
  self.btnBattle:setCallback(function()
    local state = game.role:getFormationState(self.selected)
    if state[1] then
      SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
      return
    end
    if not self.result then
      SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
    elseif self.result == 1 then
      SysError(SYS_ERR_FIGHT_SET_NO_HP)
    elseif self:checkFormationCaptain() and self.callback(self.selected) then
      BackManager:pop()
    end
  end)
end

function HeroListLayer:showData(params)
  local selected = self.selected or 1
  self.group:chooseByName(string.format("list%d", selected))
  self:showFormation(selected)
end

function HeroListLayer:showFormation(index)
  self.selected = index
  self.content:removeAllChildren()
  local xPos = -45
  local interval = 172
  self.card = {}
  local formationData = game.role.formation[tostring(index)] or {
    list = {},
    pos = {}
  }
  for slot = 1, 5 do
    local card
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      local hero = game.role.heros[heroId]
      card = TeamHeroCard.new({
        heroId = heroId,
        captain = slot == 1,
        detail = function()
          local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
          self:hide()
          BackManager:push(function()
            self:show()
            layer:close()
            card:reflashCard()
            TopBar:show(TopBarType.full, "委托")
            local totalValue = game.role:getTotalBattleValue(self.selected)
            self.battleValue:setString(totalValue)
          end)
        end,
        refresh = function()
          self:effect(2)
          local totalValue = game.role:getTotalBattleValue(self.selected)
          self.battleValue:setString(totalValue)
        end
      }):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
      table.insert(self.card, card)
    else
      card = UIHelper.newImageView(heroRes .. "add_bg.png"):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
      display.newSprite(heroRes .. "show.png"):pos(78, 275):addTo(card)
    end
    self:cardAnimation(card, slot, xPos + (slot - 1) * interval)
  end
  self.result = self:checkTaskRequire()
  self:InfoPanel(index, formation)
end

function HeroListLayer:InfoPanel(index, formation)
  local bg = UIHelper.newImageView(heroRes .. "info_bar.png"):pos(800, 0):name("info"):addTo(self.content)
  display.newTTFLabel({
    text = "美味度",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 324):addTo(bg)
  if UIHelper.isiPhoneX() then
    bg:setPositionX(bg:getPositionX() + UIHelper.getMoveXForX())
  end
  local totalValue = game.role:getTotalBattleValue(index)
  self.battleValue = display.newTTFLabel({
    text = totalValue,
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 299):addTo(bg)
  local succeed = self.taskData.perfectSet
  succeed = succeed + self:findAddNum()
  succeed = succeed + game.role:getTalentValue(11, self.taskData.chapter)
  if not self.fistShow then
    bg:setOpacity(0)
    bg:setCascadeOpacityEnabled(true)
    UIHelper.MoveToLeft({
      node = bg,
      delay = 0.4,
      time = 0.18
    })
    UIHelper.MoveToLeft({
      node = self.btnBattle,
      delay = 0.4,
      time = 0.18
    })
    UIHelper.MoveToLeft({
      node = self.angle,
      delay = 0.4,
      time = 0.18
    })
    self.fistShow = 0
  end
  local white = UIHelper.newImageView(heroRes .. "entrust_bg.png"):pos(bg:getContentSize().width / 2, 190):addTo(bg)
  display.newTTFLabel({
    text = "委托需求",
    size = 20,
    color = UIHelper.hex2rgb("#a63407")
  }):pos(60, 160):addTo(white)
  display.newTTFLabel({
    text = string.format("大成功率：%d", succeed) .. "%",
    size = 16,
    color = UIHelper.hex2rgb("#d77312")
  }):pos(60, 20):addTo(white)
  local count, yPos, intervalY = 1, 130, -30
  for flag = 1, #limitTable do
    local data = self.info[flag]
    if data then
      local color = data[2] and "#0f7d03" or "#642d05"
      display.newTTFLabel({
        text = string.format(limitTable[flag] .. data[1] .. "+"),
        size = 18,
        color = UIHelper.hex2rgb(color)
      }):anch(0, 0.5):pos(9, yPos + (count - 1) * intervalY):addTo(white)
      count = count + 1
    end
  end
  if not self.result then
    local flash = display.newScale9Sprite("ui/hero/card_mask.png", 0, 0, cc.size(132, 338)):center(bg):addTo(bg)
    flash:setOpacity(0)
    flash:runAction(transition.sequence({
      cc.FadeTo:create(0.2, 200),
      cc.FadeTo:create(0.2, 0),
      cc.DelayTime:create(0.2),
      cc.RemoveSelf:create()
    }))
  end
end

function HeroListLayer:checkTaskRequire()
  self.info = {}
  self.types = {}
  local result, minLevel, firstLevel, temp = true, 1000, 0, {}
  local sum, num = 0, 0
  local limit = self.taskData.require:toNumMap()
  local formationData = game.role.formation[tostring(self.selected)] or {
    list = {},
    lock = {},
    pos = {}
  }
  local awakeNumMap = {
    0,
    0,
    0
  }
  for index, heroId in pairs(formationData.list) do
    local hero = game.role.heros[heroId]
    if hero then
      local level = hero.level
      local profession = hero.unit.profession
      temp[profession] = (temp[profession] or 0) + 1
      if minLevel > level then
        minLevel = level
      end
      if tonumber(index) == 1 then
        firstLevel = level
      end
      sum = sum + level
      self.types[profession] = (self.types[profession] or 0) + 1
      for i = 1, 3 do
        awakeNumMap[i] = i <= hero.awake and awakeNumMap[i] + 1 or awakeNumMap[i]
      end
    end
  end
  self.types[7] = sum / table.nums(formationData.list)
  for i = 1, 3 do
    self.types[7 + i] = awakeNumMap[i]
  end
  for id, count in pairs(limit) do
    if not self.info[id] then
      self.info[id] = {}
    end
    if not temp[id] then
      temp[id] = 0
    end
    self.info[id][1] = count
    if id == 9 then
      self.info[id][2] = firstLevel >= count
      if firstLevel < count then
        result = false
      end
    elseif id == 8 then
      if minLevel == 1000 then
        minLevel = 0
        self.info[id][2] = false
      else
        self.info[id][2] = count <= minLevel
      end
      if count > minLevel then
        result = false
      end
    elseif id == 7 then
      self.info[id][2] = count <= table.nums(formationData.list)
      if count > self.info[id][1] then
        result = false
      end
    elseif id == 10 then
      if count > awakeNumMap[1] then
        SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
        return
      else
        self.info[id][2] = true
      end
    elseif id == 11 then
      if count > awakeNumMap[2] then
        SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
        return
      else
        self.info[id][2] = true
      end
    elseif id == 12 then
      if count > awakeNumMap[3] then
        SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
        return
      else
        self.info[id][2] = true
      end
    else
      self.info[id][2] = count <= temp[id]
      if count > temp[id] then
        result = false
      end
    end
  end
  for _, heroId in pairs(formationData.list) do
    local hero = game.role.heros[heroId]
    if hero.hpPercent == 0 then
      result = 1
      break
    end
  end
  return result
end

function HeroListLayer:checkFormationCaptain()
  local formation = game.role.formation[tostring(self.selected)]
  if formation and formation.list["1"] then
    return true
  end
  return false
end

function HeroListLayer:findAddNum()
  local limit = self.taskData.perfectPlus:toTableArray()
  local sum = 0
  for _, data in pairs(limit) do
    local type, value, add = tonumber(data[1]), tonumber(data[2]), tonumber(data[3])
    if self.types[type] and value <= self.types[type] then
      sum = sum + add
    end
  end
  return sum
end

function HeroListLayer:cardAnimation(card, slot, xPos)
  card:hide()
  local mask = display.newSprite(heroRes .. "card_mask.png"):pos(xPos, 10):addTo(self.content)
  mask:setOpacity(0)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.03 * (slot - 1)),
    cc.MoveBy:create(0, cc.p(-8, -8)),
    cc.Spawn:create(cc.FadeIn:create(0.06), cc.MoveBy:create(0.06, cc.p(8, 8))),
    cc.CallFunc:create(function()
      card:show()
    end),
    cc.FadeOut:create(0.18),
    cc.CallFunc:create(function()
      mask:removeSelf()
    end)
  }))
end

function HeroListLayer:effect(index)
  for _, card in pairs(self.card) do
    card:showInfo(index)
  end
end

return HeroListLayer
