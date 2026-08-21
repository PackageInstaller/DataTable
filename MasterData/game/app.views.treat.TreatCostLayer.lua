local unitCsv = require("csvdata.unit")
local evolutionCsv = require("csvdata.evolution")
local profCsv = require("csvdata.profession")
local treatRes = "ui/treat/"
local uiData = {
  csbFile = "ui/treat/TreatCostLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    time = "time",
    btnOk = "ok",
    desc = "desc",
    cancel = "cancel",
    blockBg = "blockBg",
    content = "content"
  }
}
local TreatCostLayer = class("TreatCostLayer", UIBase)

function TreatCostLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TreatCostLayer:init(params)
  self.choose = false
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.btnOk:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:setTouchScale()
  self.btnOk:setTouchScale()
  self.costCounts = {}
  for i = 1, 5 do
    self.costCounts[i] = 0
  end
  local ids = params.heroIds
  local maxTime = 0
  for id, _ in pairs(ids) do
    local hero = game.role.heros[id]
    local lost = 1 - hero.hpPercent / 1000
    local time = 0
    local num3, num4 = 0, 0
    if 0.7 <= lost then
      num3 = math.ceil(18 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
      num4 = math.ceil(6 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
      time = hero:getCureTime()
      self.costCounts[5] = self.costCounts[5] + 1
    else
      num3 = math.ceil(12 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
      num4 = math.ceil(4 * hero.unit.material2 * evolutionCsv[hero.quality].materialCarry * lost / 7)
    end
    if maxTime < time then
      maxTime = time
    end
    self.costCounts[3] = (self.costCounts[3] or 0) + num3
    self.costCounts[4] = (self.costCounts[4] or 0) + num4
  end
  local interval = 125
  for index = 1, 4 do
    local count = self.costCounts[index]
    HuoBiIcon.new({count = count, base = index}):pos((index - 1) * interval, 0):addTo(self.content)
  end
  self.time:setString(UIHelper.getTimeStr(maxTime))
  if self.costCounts[5] == 0 then
    self.desc:hide()
    self.blockBg:hide()
  else
    local str = string.format("开启快速治疗，消耗 <img src='ui/global/icon_quick2.png' scale=0.5 />x%d", self.costCounts[5])
    MRichText.new({
      text = str,
      color = UIHelper.hex2rgb("#387205"),
      size = 24
    }):anch(0, 0.5):addTo(self.desc)
  end
  self.cancel:setCallback(function()
    self:removeFromParent()
  end)
  self.btnOk:setCallback(function()
    if params.callback then
      if self.choose and (game.role.items[globalCsv.quickRepair] or 0) < self.costCounts[5] then
        UIHelper.showCookTip({type = 5, parent = self})
        return
      end
      if self:checkCostEnough() then
        params.callback(self.choose)
        self:close()
      else
        SysError(SYS_ERR_TREAT_MATERIAL_NOT_ENOUGH)
      end
    end
  end)
  self.blockBg:setCallback(function(sender)
    if not self.choose then
      UIHelper.newImageView(treatRes .. "yes.png"):center(self.blockBg):addTo(self.blockBg)
      self.choose = true
    else
      self.blockBg:removeAllChildren()
      self.choose = false
    end
  end)
end

function TreatCostLayer:showData(params)
end

function TreatCostLayer:checkCostEnough()
  for index, count in ipairs(self.costCounts) do
    if index < 5 and count > game.role["material" .. tostring(index)] then
      return false
    end
  end
  return true
end

return TreatCostLayer
