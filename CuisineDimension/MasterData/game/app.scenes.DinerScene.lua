local UnitCsv = require("csvdata.unit")
local DressCsv = require("csvdata.hero_skin")
local DinerScene = class("DinerScene", function()
  return display.newScene("DinerScene")
end)

function DinerScene:ctor(params)
  self.params = params or {}
  BackManager:clear()
end

function DinerScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  TopBar = game:createView("global.TopBar")
  TopBar:hide()
  
  local function getDressType(type, dress)
    local dressId = type * 10 + dress
    local dressSet = DressCsv[dressId]
    if not dressSet then
      return type
    else
      return dressSet.hero
    end
  end
  
  local cacheRes = {}
  if self.params.layerType == "look" then
    for slot = 1, globalCsv.dinerBoxNumMax do
      local box = self.params.boxData.boxes[slot] or {}
      for _, heroId in ipairs(box.heros or {}) do
        local heroInfo = self.params.boxData.heroInfo[heroId]
        if heroInfo then
          local unit = UnitCsv[getDressType(heroInfo.type, heroInfo.dress)]
          table.insert(cacheRes, unit.boneRes)
        end
      end
    end
  else
    for slot = 1, globalCsv.dinerBoxNumMax do
      local box = json.decode(game.role.diner["box" .. slot]) or {}
      for _, heroId in ipairs(box.heros or {}) do
        local hero = game.role.heros[heroId]
        if hero then
          local unit = UnitCsv[hero:getDressType()]
          table.insert(cacheRes, unit.boneRes)
        end
      end
    end
  end
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
  if 1 < #cacheRes then
    ResourceMgr:clear()
    ResourceMgr:addSpineRes(cacheRes)
    local loadingLayer = DinerLoadingLayer.new({
      callback = handler(self, self.showBox)
    })
    loadingLayer:setResourceMgr(ResourceMgr)
    loadingLayer:addTo(self)
    if UIHelper.isiPhoneX() then
      loadingLayer:setPositionX(loadingLayer:getPositionX() + UIHelper.getMoveXForX())
    end
  else
    self:showBox()
  end
end

function DinerScene:showBox()
  if self.params.layerType == "look" then
    game:createView("diner.DinerBoxLookLayer", self.params.boxData)
  else
    game:createView("diner.DinerBoxMainLayer", self.params)
  end
end

function DinerScene:onCleanup()
  if TopBar and TopBar.close then
    TopBar:close()
  end
  ResourceMgr:clear()
  display.removeUnusedSpriteFrames()
  collectgarbage("collect")
end

return DinerScene
