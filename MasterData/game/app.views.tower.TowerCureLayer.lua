local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local profCsv = require("csvdata.profession")
local treatRes = "ui/treat/"
local GlobalRes = "ui/global/"
local TaskRes = "ui/carbon/task/"
local cookRes = "ui/kitchen/cook/"
local uiData = {
  csbFile = "ui/tower/TowerCureLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    hero = "hero",
    btnOk = "ok",
    resCost = "resCost",
    cancel = "cancel"
  }
}
local TowerCureLayer = class("TowerCureLayer", UIBase)

function TowerCureLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TowerCureLayer:init(params)
  local formatInfo = json.decode(game.role.towerData.formatInfo) or {}
  self.heroList = {}
  self.chooseHero = {}
  for slot = 1, 5 do
    local heroId = formatInfo.list[tostring(slot)]
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
  self.btnOk:setCallback(function()
    if params.callback then
      if (game.role.items[globalCsv.quickRepair] or 0) < #self.chooseHero then
        UIHelper.showCookTip({type = 5, parent = self})
        return
      end
      local heroIds = {}
      for i = 1, #self.chooseHero do
        heroIds[self.chooseHero[i].id] = true
      end
      params.callback(heroIds)
      self:close()
    end
  end)
end

function TowerCureLayer:initHeroInfo()
  local x, y, interval = 0, 0, 126
  self.hero:removeAllChildren()
  local herosInfo = json.decode(game.role.towerData.herosInfo) or {}
  for slot = 1, 5 do
    local heroNode = UIHelper.extend(display.newNode()):pos(x + (slot - 1) * interval, y):addTo(self.hero)
    UIHelper.newImageView(treatRes .. "kuang_1.png"):addTo(heroNode)
    if self.heroList[slot] then
      local hero = self.heroList[slot]
      local type = hero:getDressType()
      local attrValues = hero:getTotalAttrValues()
      local percent = herosInfo[tostring(hero.id)]
      local hp = attrValues.hp * percent / 1000
      hp = 500 < percent and math.floor(hp) or math.ceil(hp)
      local big = percent <= 300
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
      hpBar:setPercentage(percent / 10)
      local hpLab = display.newTTFLabel({
        text = string.format("%d/%d", hp, attrValues.hp),
        size = 13,
        color = UIHelper.hex2rgb("#703803")
      }):center(hpBarBg):addTo(hpBarBg):name("hpText")
      hpLab:setPositionY(hpLab:getPositionY() - 10)
      if percent < 1000 then
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

function TowerCureLayer:initCost()
  self.resCost:removeAllChildren()
  local bg = UIHelper.newImageView(treatRes .. "kuang_2.png"):anch(0.5, 0.5):pos(30, 0):addTo(self.resCost)
  UIHelper.newImageView(GlobalRes .. "icon_quick2.png"):center(bg):addTo(bg):scale(0.7)
  local size = bg:getContentSize()
  local lab = display.newTTFLabel({
    text = #self.chooseHero,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(size.width - 5, 6.1):addTo(bg)
  if (game.role.items[globalCsv.quickRepair] or 0) < #self.chooseHero then
    lab:setTextColor(UIHelper.hex2rgb("#f90900"))
  end
end

function TowerCureLayer:getCureCost(num)
  local cureCount = game.role.towerData.cureCount
  
  local function getCost(_num)
    local cost = globalCsv.tower_cure_diamond_init + (cureCount + _num - 1) * globalCsv.tower_cure_diamond_growth
    return cost > globalCsv.tower_cure_diamond_limit and globalCsv.tower_cure_diamond_limit or cost
  end
  
  local allCost = 0
  for i = 1, num do
    allCost = allCost + getCost(i)
  end
  return allCost
end

function TowerCureLayer:showData()
  self:initCost()
end

return TowerCureLayer
