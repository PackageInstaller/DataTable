local AwakenCsv = require("csvdata.awaken")
local awakeSkillCsv = require("csvdata.skill_awake")
local specialCsv = require("csvdata.skill_special")
local blockCsv = require("csvdata.skill_block")
local detailRes = "ui/hero/detail/"
local awakeRes = "ui/hero/awake/"
local qulaityRes = "ui/kitchen/quality/"
local uiData = {
  csbFile = "ui/sauce/AwakeDetailLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    descBg = "descBg",
    panel1 = "panel1",
    nameNode = "panel1/nameNode",
    leftNode = "panel1/leftNode",
    rightNode = "panel1/rightNode",
    list = "panel2/list",
    addNode = "descBg/addNode"
  }
}
local AwakeDetailLayer = class("AwakeDetailLayer", UIBase)

function AwakeDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function AwakeDetailLayer:init(params)
  self.data = params.data
  self.hero = params.hero
  self.callback = params.callback
  self.conditions = {}
  self.chooseList = {}
  self.addBgs = {}
  self:initCondition()
end

function AwakeDetailLayer:initCondition()
  local conditions = self.data.cost:toTableArray()
  local xPos = 20 - (#conditions - 1) / 2 * 105
  for idx, data in ipairs(conditions) do
    local limits = {
      lType = tonumber(data[1]) == 0 and 0 or self.data.id,
      lStar = tonumber(data[2]),
      lWake = tonumber(data[3]),
      lNum = tonumber(data[4])
    }
    self.conditions[idx] = limits
    self.chooseList[idx] = {}
    self.addBgs[idx] = display.newSprite(awakeRes .. "add_mask.png"):pos(xPos, 80):addTo(self.addNode)
    xPos = xPos + 105
  end
end

function AwakeDetailLayer:showData(params)
  local awakeBtn = UIHelper.newImageView(awakeRes .. "btn.png"):scale(0.8):pos(0, -75):addTo(self.addNode)
  awakeBtn:setCallback(function()
    if self.hero.awake >= self.data.stage then
      SysError(SYS_ERR_HERO_AWAKE_STAGE_SUCCESS)
      return
    end
    if not self:checkAwakeCost() then
      return
    end
    local heros = ""
    for _, list in ipairs(self.chooseList) do
      local temp = {}
      for heroId, _ in pairs(list) do
        table.insert(temp, heroId)
      end
      heros = heros .. " " .. table.concat(temp, "=")
    end
    game:sendData(actionCodes.Hero_awakeUpRpc, MsgPack.pack({
      cost = heros,
      id = self.hero.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_awakeUpRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_HERO_AWAKE_SUCCESS)
      self.callback()
      for idx, _ in pairs(self.conditions) do
        self.chooseList[idx] = {}
      end
      self:initChooseUI()
    end)
  end)
  self:initChooseUI()
  self:showAttrs()
end

function AwakeDetailLayer:initChooseUI()
  for idx, limits in ipairs(self.conditions) do
    local bg = self.addBgs[idx]
    bg:removeAllChildren()
    local card, descText
    if limits.lType == self.data.id then
      card = HeroHead.new({
        heroId = self.hero.id,
        level = 0,
        quality = 0
      }):addTo(bg)
      descText = "同名卡"
    else
      card = UIHelper.newImageView(string.format("%s%d.png", awakeRes, self.hero.unit.profession)):addTo(bg)
      descText = "同职业"
      if 0 < limits.lStar then
        descText = descText .. string.format("%d星", limits.lStar)
        local xBegin = card:getContentSize().width / 2 - (limits.lStar - 1) * 14 / 2
        for index = 1, limits.lStar do
          UIHelper.newImageView("ui/global/small_star.png"):pos(xBegin + (index - 1) * 14, 11):addTo(card)
        end
      end
    end
    if 0 < limits.lWake then
      display.newSprite(string.format("%sawake%d.png", awakeRes, self:getAwakeLogoIndex(limits.lWake, limits.lStar))):pos(-25, 25):addTo(bg)
      if self.hero.awake == 2 and 2 <= limits.lWake and idx == 3 then
        descText = descText .. "2/3觉"
      else
        descText = descText .. string.format("%d觉", limits.lWake)
      end
    end
    local slot = idx
    card:setCallback(function()
      if self.hero.awake >= self.data.stage then
        SysError(SYS_ERR_HERO_AWAKE_STAGE_SUCCESS)
        return
      end
      
      local function rule(_hero)
        if self.hero.id == _hero.id or _hero.lock == 1 then
          return true
        end
        for i, list in pairs(self.chooseList) do
          if i ~= slot and self.chooseList[i][_hero.id] then
            return true
          end
        end
        if limits.lWake == 0 and _hero.unit.type == 97 then
          return false
        end
        if limits.lType ~= 0 and _hero.unit.type ~= limits.lType then
          return true
        end
        if _hero.unit.profession ~= self.hero.unit.profession then
          return true
        end
        if limits.lWake < 2 then
          if limits.lWake ~= _hero.awake then
            return true
          end
        elseif limits.lWake > _hero.awake then
          return true
        end
        if limits.lStar ~= 0 and _hero.unit.star ~= limits.lStar then
          return true
        end
      end
      
      local layer = game:createView("hero.ChooseAwakeHeroNewLayer", {
        num = limits.lNum,
        rule = rule,
        list = self.chooseList[slot],
        callback = function(choose)
          for heroId, _ in pairs(choose) do
            local hero = game.role.heros[heroId]
            if not hero then
              return
            end
            local state = hero:getState()
            if state[1] then
              SysError(SYS_ERR_HERO_LOCKED_CURE_QUAILTY_UP)
              return true
            end
            if state[2] then
              SysError(SYS_ERR_HERO_LOCKED_FIGHT_QUAILTY_UP)
              return true
            end
            if state[3] then
              SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_QUAILTY_UP)
              return true
            end
          end
          self.chooseList[slot] = {}
          for heroId, _ in pairs(choose) do
            self.chooseList[slot][heroId] = slot
          end
          self:initChooseUI()
          return false
        end
      })
      BackManager:push(function()
        layer:close()
        TopBar:show(TopBarType.full, "食灵资料")
      end)
    end)
    descText = descText .. string.format("%d个", limits.lNum)
    local label = display.newTTFLabel({
      text = descText,
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):pos(0, -65):addTo(bg)
    if label:getContentSize().width > 90 then
      label:setScaleX(90 / label:getContentSize().width)
    end
    display.newTTFLabel({
      text = string.format("%d/%d", table.nums(self.chooseList[idx]), limits.lNum),
      size = 22,
      color = UIHelper.hex2rgb("#703902")
    }):pos(0, -85):addTo(bg)
    if table.nums(self.chooseList[idx]) == 0 then
      UIHelper.newImageView(awakeRes .. "btn_add.png"):pos(33, 32):addTo(bg)
    end
  end
end

function AwakeDetailLayer:getAwakeLogoIndex(wakeLv, star)
  local startSet = {
    [3] = {4},
    [4] = {2, 4},
    [5] = {
      2,
      3,
      4
    }
  }
  return startSet[star or self.hero.unit.star][wakeLv or self.hero.awake] or 1
end

function AwakeDetailLayer:checkAwakeCost()
  for idx, limits in pairs(self.conditions) do
    local list = self.chooseList[idx]
    if table.nums(list) < limits.lNum then
      SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
      return
    end
    for heroId, _ in pairs(list) do
      local hero = game.role.heros[heroId]
      if not hero then
        SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
        return
      end
      local bType, bStar, bWake, bPro
      if limits.lWake == 0 and hero.unit.type == 97 then
        bType, bStar, bWake, bPro = true, true, true, true
      else
        bStar = hero.unit.star == limits.lStar
        bWake = hero.awake >= limits.lWake
        bPro = hero.unit.profession == self.hero.unit.profession
        if limits.lType == 1 then
          bType = hero.unit.type == self.hero.unit.type
        else
          bType = true
        end
      end
      if not (bType and bStar and bWake) or not bPro then
        SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
        return
      end
    end
  end
  return true
end

function AwakeDetailLayer:showAttrs()
  self.leftNode:removeAllChildren()
  self.rightNode:removeAllChildren()
  display.newTTFLabel({
    text = "觉醒提升",
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):center(self.nameNode):addTo(self.nameNode)
  display.newSprite(string.format("%sawake%d.png", awakeRes, self:getAwakeLogoIndex(self.data.stage - 1))):pos(-85, -47):addTo(self.nameNode)
  for i = 1, 4 do
    display.newSprite(qulaityRes .. "arrow.png"):pos(-60 + (i - 1) * 6, -47):addTo(self.nameNode)
  end
  display.newSprite(string.format("%sawake%d.png", awakeRes, self:getAwakeLogoIndex(self.data.stage))):pos(-10, -47):addTo(self.nameNode)
  local totalAttr = self.hero:getTotalAttrValues({
    awakeLv = self.data.stage
  })
  local baseAttr = self.hero:getTotalAttrValues({
    awakeLv = self.data.stage - 1
  })
  for index = 1, 5 do
    local name = AttsEnumEx[index]
    local attrBg = display.newNode():anch(0, 0.5):pos(-100, 15 + (index - 1) * -21):addTo(self.leftNode)
    display.newSprite(detailRes .. name .. ".png"):pos(20, 10):addTo(attrBg)
    display.newTTFLabel({
      text = AttrDesc[index] .. ":",
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(30, 10):addTo(attrBg)
    local value = ROUND[index] and math.ceil(baseAttr[name]) or math.floor(baseAttr[name])
    display.newTTFLabel({
      text = value,
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(90, 10):addTo(attrBg)
    local add = totalAttr[name] - baseAttr[name]
    if add then
      for index = 1, 4 do
        display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(127 + (index - 1) * 6, 11):addTo(attrBg)
      end
      display.newTTFLabel({
        text = string.format("       %.01f", add + value),
        size = 16,
        color = UIHelper.hex2rgb("#228801")
      }):anch(0, 0.5):pos(130, 11):addTo(attrBg)
    end
  end
  local skillNum = 0
  local levels = self.hero:getTotalAttrFactors({
    awakeLv = self.data.stage - 1
  })
  local specialId = self.hero:getSpecialId()
  local blockId = self.hero:getBlockId()
  local awakeId = self.hero:getAwakeIdShow(self.data.stage)
  local awakeAttr = self.hero:getStageActive(self.data.stage)
  for k, skillAdd in pairs(awakeAttr) do
    if k == 6 and specialId ~= 0 or k == 7 and blockId ~= 0 or k == 8 then
      skillNum = skillNum + 1
    end
  end
  if specialId ~= 0 and awakeAttr[6] then
    local level = levels.specialLv
    local specialData = specialCsv[specialId][level]
    display.newTTFLabel({
      text = string.format("%dLv       %dLv", level, level + awakeAttr[7]),
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-6, 40):addTo(self.rightNode)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(19 + (index - 1) * 6, 40):addTo(self.rightNode)
    end
    local txt = display.newTTFLabel({
      text = "料理技",
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-55, 0):addTo(self.rightNode)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = specialData.icon
    }):scale(0.47):anch(0, 0.5):pos(24, 50):addTo(txt)
    display.newSprite(detailRes .. "mask.png"):anch(0, 0.5):pos(-4, 50):addTo(txt)
  end
  if blockId ~= 0 and awakeAttr[7] then
    local level = levels.blockLv
    local blockData = blockCsv[blockId][level]
    display.newTTFLabel({
      text = string.format("%dLv       %dLv", level, level + awakeAttr[7]),
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-6, 40 - 80 * (skillNum - 1)):addTo(self.rightNode)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(19 + (index - 1) * 6, 40 - 80 * (skillNum - 1)):addTo(self.rightNode)
    end
    local txt = display.newTTFLabel({
      text = "固有技",
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-55, 0 - 80 * (skillNum - 1)):addTo(self.rightNode)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = blockData.icon
    }):scale(0.47):anch(0, 0.5):pos(24, 50):addTo(txt)
    display.newSprite(detailRes .. "mask.png"):anch(0, 0.5):pos(-4, 50):addTo(txt)
  end
  if awakeAttr[8] then
    local level = 1
    local awakeData = awakeSkillCsv[awakeId][level]
    local txt = display.newTTFLabel({
      text = "觉醒技",
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-40, 0):addTo(self.rightNode)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = awakeData.icon
    }):scale(0.47):anch(0, 0.5):pos(24, 50):addTo(txt)
    display.newSprite(detailRes .. "mask.png"):anch(0, 0.5):pos(-4, 50):addTo(txt)
  end
end

return AwakeDetailLayer
