local UINLevelAvgSub = class("UINLevelAvgSub", UIBaseNode)
local base = UIBaseNode

function UINLevelAvgSub:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
end

function UINLevelAvgSub:InitLAvgSub(localPos, avgCfg, clickEvent)
  self.avgCfg = avgCfg
  self.clickEvent = clickEvent
  self.transform.localPosition = localPos
  self.ui.tex_Name:SetIndex(0, tostring(avgCfg.number))
  self.ui.Img_PlotBg:SetIndex(0)
  self:RefreshLAvgSubPlayed()
end

function UINLevelAvgSub:__OnClickRoot()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINLevelAvgSub:RefreshLAvgSubPlayed()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local played = avgPlayCtrl:IsAvgPlayed(self.avgCfg.id)
  self.ui.Img_PlotBg:SetIndex(played and 1 or 0)
end

function UINLevelAvgSub:GetLAvgSubCfg()
  return self.avgCfg
end

function UINLevelAvgSub:OnDelete()
  base.OnDelete(self)
end

return UINLevelAvgSub
