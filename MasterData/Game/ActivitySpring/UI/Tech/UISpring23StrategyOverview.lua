local base = require("Game.ActivityChristmas.UI.Tech.UIChristmas22StrategyOverview")
local UISpring23StrategyOverview = class("UISpring23StrategyOverview", base)

function UISpring23StrategyOverview:OnInit()
  base.OnInit(self)
  self.ui.list.onValueChanged:AddListener(BindCallback(self, self.OnValueChange))
end

function UISpring23StrategyOverview:__SetNodeClass()
  self._techItemClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechItem")
  self._techTitleClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechTitle")
  self._specialListClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechSpecialList")
  self._specialSideClass = require("Game.ActivitySpring.UI.Tech.UINSpring23TechSpeicalSide")
  self._techLvClass = require("Game.ActivitySpring.UI.Tech.UINSpring23TechLv")
  self._desType = eLogicDesType.Spring
  self._lvNodeOffset = 20
  self._itemNoEnoughTip = 9109
  self._resetNoEnoughTip = 9110
end

function UISpring23StrategyOverview:OnClickLvCallback(techItem, techData)
  base.OnClickLvCallback(self, techItem, techData)
  self.ui.obj_OnSelelct:SetActive(true)
  self.ui.obj_OnSelelct.transform:SetParent(techItem.transform)
  self.ui.obj_OnSelelct.transform.anchoredPosition = Vector2.zero
end

function UISpring23StrategyOverview:OnClickBg()
  base.OnClickBg(self)
  self.ui.obj_OnSelelct:SetActive(false)
end

function UISpring23StrategyOverview:OnValueChange(vecPos)
  local vecPointY = vecPos.y
  if self._lastPointY ~= nil and math.abs(vecPointY - self._lastPointY) < 0.001 then
    self._lastPointY = vecPointY
    return
  end
  self._lastPointY = vecPointY
  if self._lvNode ~= nil and self._lvNode.active then
    self:OnClickBg()
  end
end

return UISpring23StrategyOverview
