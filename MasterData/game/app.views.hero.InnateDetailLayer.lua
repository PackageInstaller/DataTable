local evolutionCsv = require("csvdata.evolution")
local innateCsv = require("csvdata.innate")
local awakeRes = "ui/hero/awake/"
local heroRes = "ui/hero/detail/"
local qulaityRes = "ui/kitchen/quality/"
local uiData = {
  csbFile = "ui/sauce/InnateDetailLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    descBg = "descBg",
    panel1 = "panel1",
    nameNode = "panel1/nameNode",
    upNode = "panel1/upNode",
    downNode = "panel1/downNode",
    list = "panel2/list",
    addNode = "descBg/addNode"
  }
}
local InnateDetailLayer = class("InnateDetailLayer", UIBase)

function InnateDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function InnateDetailLayer:init(params)
  self.data = params.data
  self.hero = params.hero
  self.callback = params.callback
  self.chooseList = {}
end

function InnateDetailLayer:showData(params)
  display.newTTFLabel({
    text = "天赋提升",
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):center(self.nameNode):addTo(self.nameNode)
  self:showUpSkill()
  self:showUseHero()
end

function InnateDetailLayer:showUpSkill()
  self.upNode:removeAllChildren()
  self.downNode:removeAllChildren()
  local innateLevel = self.hero.innate + evolutionCsv[self.hero.quality].innateLevel
  local innateNewLevel = math.min(self.hero.innate + evolutionCsv[self.hero.quality].innateLevel + 1, 20)
  local innateData = innateCsv[self.hero.unit.type][innateLevel]
  local newInnateData = innateCsv[self.hero.unit.type][innateNewLevel]
  local typeString = {
    [1] = {
      text = "技能等级提高",
      typeName = "skillLevel"
    },
    [2] = {
      text = "属性提升解锁",
      typeName = "statusLevel"
    },
    [3] = {
      text = "属性提升",
      typeName = "statusLevel"
    },
    [4] = {
      text = "进阶装盘解锁",
      typeName = "formationUp"
    },
    [5] = {
      text = "梦境祝福解锁",
      typeName = "characteristic"
    },
    [6] = {
      text = "梦境祝福提升",
      typeName = "characteristic"
    },
    [7] = {
      text = "梦特技解锁",
      typeName = "dreamLevel"
    },
    [8] = {
      text = "梦特技提升",
      typeName = "dreamLevel"
    }
  }
  for i = 1, 2 do
    local node = i == 1 and self.upNode or self.downNode
    local text = i == 1 and "天赋" or typeString[newInnateData.type].text
    local typeLevel = innateData[typeString[newInnateData.type].typeName]
    local newTypeLevel = newInnateData[typeString[newInnateData.type].typeName]
    local level = i == 1 and innateLevel or typeLevel
    local newLevel = i == 1 and innateNewLevel or newTypeLevel
    display.newSprite(heroRes .. "skill_bg.png"):pos(20, 0):scale(0.8):addTo(node)
    UIHelper.getClipNode({
      steRes = heroRes .. "skill_mask.png",
      clipRes = i == 1 and innateData.icon or innateData.typeIcon
    }):pos(20, 0):scale(0.47):addTo(node)
    display.newSprite(heroRes .. "mask.png"):pos(20, 0):addTo(node)
    display.newTTFLabel({
      text = text,
      size = 14,
      color = UIHelper.hex2rgb("#703902")
    }):pos(110, -10):addTo(node)
    display.newTTFLabel({
      text = "Lv" .. level,
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):pos(73, 10):addTo(node)
    display.newTTFLabel({
      text = "Lv" .. newLevel,
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):pos(146, 10):addTo(node)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):pos(96 + (index - 1) * 10, 10):addTo(node)
    end
  end
end

function InnateDetailLayer:showUseHero()
  self.addNode:removeAllChildren()
  local bg = display.newSprite(awakeRes .. "add_mask.png"):pos(20, 80):addTo(self.addNode)
  local card = HeroHead.new({
    heroId = self.hero.id,
    level = 0,
    quality = 0
  }):addTo(bg)
  local descText = "同名卡1个"
  local label = display.newTTFLabel({
    text = descText,
    size = 16,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, -65):addTo(bg)
  display.newTTFLabel({
    text = string.format("%d/1", #self.chooseList),
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):pos(0, -85):addTo(bg)
  card:setCallback(function()
    local function rule(_hero)
      if self.hero.id == _hero.id or _hero.lock == 1 then
        return true
      end
      if self.hero.type ~= _hero.type then
        return true
      end
    end
    
    local function newrule(heroId)
      local hero = game.role.heros[heroId]
      local state = hero:getState()
      if state[1] then
        SysError(SYS_ERR_HERO_LOCKED_CURE_RECYCLE)
        return true
      end
      if state[2] then
        SysError(SYS_ERR_HERO_LOCKED_FIGHT_RECYCLE)
        return true
      end
      if state[3] then
        SysError(SYS_ERR_HERO_LOCKED_CONSIGNATION_RECYCLE)
        return true
      end
    end
    
    local layer = game:createView("hero.ChooseHeroLayer", {
      rule = rule,
      type = 12,
      max = 1,
      callback = function(chooseHeroId)
        self.chooseList = {}
        table.insert(self.chooseList, chooseHeroId)
        self:showUseHero()
      end,
      newRule = newrule
    })
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "食灵资料")
    end)
  end)
  local upBtn = UIHelper.extend(ccui.Button:create())
  upBtn:setImages(heroRes, {
    "innate_level_up.png",
    "innate_level_up.png"
  })
  upBtn:pos(0, -130):addTo(bg)
  upBtn:setTouchScale()
  upBtn:setCallback(function()
    if #self.chooseList == 0 then
      SysError(SYS_ERR_MATERIAL_NOT_ENOUGH)
      return
    end
    if self.hero.innate == 14 then
      SysError(SYS_ERR_TALENT_IS_FULL)
      return
    end
    game:sendData(actionCodes.Hero_innateUpRpc, MsgPack.pack({
      mainHeroId = self.hero.id,
      useHeroId = self.chooseList[1]
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_innateUpRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_INNATE_RANK_UP)
      self.chooseList = {}
      self:showUpSkill()
      self:showUseHero()
      self.callback()
    end)
  end)
end

return InnateDetailLayer
