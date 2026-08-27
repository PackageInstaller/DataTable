local UIEpNightWarnLine = class("UIEpNightWarnLine", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpNightWarnLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.fxList = {}
end

function UIEpNightWarnLine:SetBossWarnLine(bool)
  self.__isShowBoosWarn = bool
  self.ui.noticeLine:SetActive(not bool)
  self.ui.warnLine:SetActive(bool)
end

function UIEpNightWarnLine:AdjustFx(mapData)
  local colNum = 4
  local rowNum = mapData.width * 2
  for col = 1, colNum do
    for row = 0, rowNum do
      local epNightWarnLineObj = self.ui.fX_UI_Night:Instantiate(self.ui.nightFxHolder)
      table.insert(self.fxList, epNightWarnLineObj)
      local x = self.ui.fxLeftPad + (col - 1) * self.ui.fxPad
      local y = (row % 2 == 1 and 1 or -1) * math.ceil(row / 2) * self.ui.fxPad
      epNightWarnLineObj.transform.localPosition = Vector3.New(x, y, 0)
    end
  end
end

return UIEpNightWarnLine
