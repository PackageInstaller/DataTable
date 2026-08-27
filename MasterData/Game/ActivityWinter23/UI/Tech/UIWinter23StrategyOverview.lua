local base = require("Game.ActivitySpring.UI.Tech.UISpring23StrategyOverview")
local UIWinter23StrategyOverview = class("UIWinter23StrategyOverview", base)
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIWinter23StrategyOverview:OnInit()
  base.OnInit(self)
  self._sideNode:SetSpItemClick(BindCallback(self, self.OnClickSpItemDetail))
  self._sideNode:SetTechInfoHideFunc(BindCallback(self, self.OnClickBg))
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.uI_CommonActivityBG)
end

function UIWinter23StrategyOverview:__SetNodeClass()
  self._techItemClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechItem")
  self._techTitleClass = require("Game.ActivityChristmas.UI.Tech.UINChristmas22TechTitle")
  self._specialSideClass = require("Game.ActivityWinter23.UI.Tech.UINWinter23TechSpecialSide")
  self._techLvClass = require("Game.ActivitySpring.UI.Tech.UINSpring23TechLv")
  self._lvNodeOffset = 20
  self._desType = eLogicDesType.Winter23
  self._itemNoEnoughTip = 9204
  self._resetNoEnoughTip = 9205
end

function UIWinter23StrategyOverview:InitChristmas22StrategyOverview(actTechTree, specialBranchId, callback)
  base.InitChristmas22StrategyOverview(self, actTechTree, specialBranchId, callback)
  self._actBgNode:InitActivityBG(actTechTree:GetTechActFrameId(), self.resloader)
  self:ResetActivityBaseTechInfo(actTechTree)
end

function UIWinter23StrategyOverview:ResetActivityBaseTechInfo(actTechTree)
  local treeId = actTechTree:GetTreeId()
  local infoCfg = ConfigData.activity_tech_type[treeId]
  self._itemNoEnoughTip = infoCfg.itemNoEnoughTip ~= 0 and infoCfg.itemNoEnoughTip or self._itemNoEnoughTip
  self._resetNoEnoughTip = infoCfg.resetNoEnoughTip ~= 0 and infoCfg.resetNoEnoughTip or self._resetNoEnoughTip
  self._desType = infoCfg.common_des ~= 0 and infoCfg.common_des or self._desType
end

function UIWinter23StrategyOverview:OnClickSpItemDetail(techItem, techData)
  if self._lvNode == nil then
    self.ui.techInfoNode:SetActive(true)
    self._lvNode = self._techLvClass.New()
    self._lvNode:Init(self.ui.techInfoNode)
    self._lvNode:SetChristmas22LogicDesType(self._desType)
  else
    self._lvNode:Show()
  end
  self._lvNode:InitChristmas22TechLv(techData)
  self._lvNode:HideChristmas22TechBtnState()
  self._lvNode:FloatTo(techItem.transform, HAType.left, VAType.downAuto)
  self.ui.obj_OnSelelct:SetActive(false)
end

return UIWinter23StrategyOverview
