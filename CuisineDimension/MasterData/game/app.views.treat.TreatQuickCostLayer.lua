local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local profCsv = require("csvdata.profession")
local treatRes = "ui/treat/"
local GlobalRes = "ui/global/"
local TaskRes = "ui/carbon/task/"
local cookRes = "ui/kitchen/cook/"
local uiData = {
  csbFile = "ui/treat/TreatQuickCostLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    hero = "hero",
    btnOk = "ok",
    resCost = "resCost",
    cancel = "cancel"
  }
}
local TreatQuickCostLayer = class("TreatQuickCostLayer", UIBase)

function TreatQuickCostLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TreatQuickCostLayer:init(params)
  self.index = params.index
  local formationData = game.role.formation[tostring(self.index)] or {
    list = {},
    pos = {}
  }
  self.heroList = {}
  self.chooseHero = {}
  for slot = 1, 5 do
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      self.heroList[#self.heroList + 1] = game.role.heros[heroId]
    end
  end
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.btnOk:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:setTouchScale()
  self.btnOk:setTouchScale()
  self:initHeroInfo()
  self.cancel:setCallback(function()
    self:close()
  end)
  
  local function makeCure()
    if params.callback then
      if (game.role.items[globalCsv.quickRepair] or 0) < self.costCounts[5] then
        SysError(SYS_ERR_TREAT_DRAWING_NOT_ENOUGH)
        return
      end
      if self:checkCostEnough() then
        local heroIds = {}
        for i = 1, #self.chooseHero do
          heroIds[self.chooseHero[i].id] = true
        end
        params.callback(heroIds)
        self:close()
      else
        SysError(SYS_ERR_TREAT_MATERIAL_NOT_ENOUGH)
      end
    end
  end
  
  self.btnOk:setCallback(function()
    makeCure()
  end)
  local autoBattle = params.autoBattle or false
  if UserData.autoBattleLoop == 1 and UserData.autoBattleLoopCure == 1 and autoBattle and params.battleType == BattleType.PvE then
    local time = 5
    self.btnOk:setTitleText(string.format("确定(%d)", time))
    
    local function timeTick()
      self.btnOk:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          if 0 < time then
            self.btnOk:setTitleText(string.format("确定(%d)", time))
            time = time - 1
            timeTick()
          else
            makeCure()
          end
        end)
      }))
    end
    
    timeTick()
  end
end

function TreatQuickCostLayer:initHeroInfo()
  local x, y, interval = 0, -3, 126
  self.hero:removeAllChildren()
  for slot = 1, 5 do
    local heroNode = UIHelper.extend(display.newNode()):pos(x + (slot - 1) * interval, y):addTo(self.hero)
    UIHelper.newImageView(treatRes .. "kuang_1.png"):addTo(heroNode)
    if self.heroList[slot] then
      local hero = self.heroList[slot]
      local type = hero:getDressType()
      local attrValues = hero:getTotalAttrValues()
      local hp = attrValues.hp * hero.hpPercent / 1000
      hp = hero.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
      local big = hero.hpPercent <= 300
      local iconRes = UIHelper.getCardRes("book", type, big, hero.quality)
      UIHelper.newImageView(GlobalRes .. "item_bg.png"):anch(0.5, 0.5):pos(0, 20):addTo(heroNode)
      UIHelper.getClipNode({
        steRes = GlobalRes .. "mask_1.png",
        clipRes = iconRes
      }):center(heroNode):pos(0, 20):addTo(heroNode):scale(0.7)
      UIHelper.newImageView(GlobalRes .. "item_frame.png"):anch(0.5, 0.5):pos(0, 20):addTo(heroNode)
      local hpBarBg = display.newSprite(treatRes .. "bar_1.png"):pos(0, -35):addTo(heroNode):name("hpBarBg")
      local hpBar
      if big then
        hpBar = display.newProgressTimer(treatRes .. "bar_3.png", 1):center(hpBarBg):addTo(hpBarBg)
      else
        hpBar = display.newProgressTimer(treatRes .. "bar_2.png", 1):center(hpBarBg):addTo(hpBarBg)
      end
      hpBar:setMidpoint(cc.p(0, 0.5))
      hpBar:setBarChangeRate(cc.p(1, 0))
      hpBar:setPercentage(hero.hpPercent / 10)
      local hpLab = display.newTTFLabel({
        text = string.format("%d/%d", hp, attrValues.hp),
        size = 13,
        color = UIHelper.hex2rgb("#703803")
      }):center(hpBarBg):addTo(hpBarBg):name("hpText")
      hpLab:setPositionY(hpLab:getPositionY() - 10)
      if hero.hpPercent < 1000 then
        local blockBg = UIHelper.newImageView(treatRes .. "block_bg.png"):anch(0.5, 0.5):pos(40, 47):addTo(heroNode)
        blockBg:setTouchEnabled(true)
        blockBg:setCallback(function()
          local had = false
          for i = #self.chooseHero, 1, -1 do
            if self.chooseHero[i].id == hero.id then
              blockBg:removeAllChildren()
              table.remove(self.chooseHero, i)
              had = true
              break
            end
          end
          if not had then
            UIHelper.newImageView(treatRes .. "yes.png"):center(blockBg):addTo(blockBg)
            self.chooseHero[#self.chooseHero + 1] = hero
          end
          self:initCost()
        end)
        UIHelper.newImageView(treatRes .. "yes.png"):center(blockBg):addTo(blockBg)
        self.chooseHero[#self.chooseHero + 1] = hero
      end
    end
  end
end

function TreatQuickCostLayer:initCost()
  self.resCost:removeAllChildren()
  local x, y, interval = 0, 0, 75
  self.costCounts = {}
  for i = 1, 5 do
    self.costCounts[i] = 0
  end
  for i = 1, #self.chooseHero do
    local hero = self.chooseHero[i]
    local lost = 1 - hero.hpPercent / 1000
    local num3, num4 = 0, 0
    if 0.7 <= lost then
      if not hero:getState()[1] then
        num3 = math.ceil(18 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
        num4 = math.ceil(6 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
      end
      self.costCounts[5] = self.costCounts[5] + 1
    else
      num3 = math.ceil(12 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
      num4 = math.ceil(4 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
    end
    self.costCounts[3] = (self.costCounts[3] or 0) + num3
    self.costCounts[4] = (self.costCounts[4] or 0) + num4
  end
  local start = 3
  for index = start, 5 do
    local count = self.costCounts[index]
    if index == 5 then
      local bg = UIHelper.newImageView(treatRes .. "kuang_2.png"):anch(0.5, 0.5):pos((index - start) * interval, 0):addTo(self.resCost)
      UIHelper.newImageView(GlobalRes .. "icon_quick2.png"):center(bg):addTo(bg):scale(0.7)
      local size = bg:getContentSize()
      local lab = display.newTTFLabel({
        text = count,
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(size.width - 5, 6.1):addTo(bg)
      if count > (game.role.items[globalCsv.quickRepair] or 0) then
        lab:setTextColor(UIHelper.hex2rgb("#f90900"))
      end
    else
      local content = UIHelper.extend(display.newNode()):pos((index - start) * interval, 0):addTo(self.resCost)
      local bg = UIHelper.newImageView(TaskRes .. "huobi_bg.png"):scale(0.7):addTo(content)
      display.newSprite(string.format(cookRes .. "material%d.png", index)):setScale(0.46):center(bg):addTo(bg)
      local size = bg:getContentSize()
      local lab = display.newTTFLabel({
        text = count,
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(size.width / 2 * bg:getScaleX() - 5, -size.height / 2 * bg:getScaleY() + 3):addTo(content)
      if count > game.role["material" .. tostring(index)] then
        lab:setTextColor(UIHelper.hex2rgb("#f90900"))
      end
    end
  end
end

function TreatQuickCostLayer:showData()
  self:initCost()
end

function TreatQuickCostLayer:checkCostEnough()
  for index, count in ipairs(self.costCounts) do
    if index < 5 and count > game.role["material" .. tostring(index)] then
      return false
    end
  end
  return true
end

return TreatQuickCostLayer
