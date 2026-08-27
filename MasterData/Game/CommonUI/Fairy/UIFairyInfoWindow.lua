local UIFairyInfoWindow = class("UIFairyInfoWindow", UIBaseWindow)
local base = UIBaseWindow
local UINFairyInfo = require("Game.CommonUI.Fairy.UINFairyInfo")

function UIFairyInfoWindow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickClose)
  self.infoNode = UINFairyInfo.New()
  self.infoNode:Init(self.ui.go_uINFairyInfoWindow)
end

function UIFairyInfoWindow:InitCommonFairyInfoWin(fairyData, parentGo)
  self.infoNode:InitCommonFairyInfo(fairyData)
  if parentGo ~= nil then
    local parentTrans = parentGo.transform
    local vector3 = parentTrans:TransformPoint(Vector3.zero)
    self.infoNode.transform.position = vector3
    self.infoNode:SetCloseCardInfoSize(self.ui.btn_bg.transform)
  end
end

function UIFairyInfoWindow:GetFairyInfoNode()
  return self.infoNode
end

function UIFairyInfoWindow:OnClickClose()
  base.Delete(self)
end

function UIFairyInfoWindow:OnDelete()
  self.infoNode:Delete()
  base.OnDelete(self)
end

return UIFairyInfoWindow
