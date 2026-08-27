local UIReportReasonItemGroup = class("UIReportReasonItemGroup", UIBaseNode)
local base = UIBaseNode
local UIReportReasonItem = require("Game.Report.UI.UIReportReasonItem")

function UIReportReasonItemGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemDic = {}
  local toggleGroup = self.ui.obj_holder:FindComponent(eUnityComponentID.ToggleGroup)
  toggleGroup:SetAllTogglesOff(false)
  toggleGroup.allowSwitchOff = true
end

function UIReportReasonItemGroup:InitItemGroup(checkFunc)
  local reportReasonDic = ConfigData.new_chat_report
  self.ui.obj_item:SetActive(false)
  for _, v in pairs(reportReasonDic) do
    local go = self.ui.obj_item:Instantiate(self.ui.obj_holder)
    go:SetActive(true)
    local item = UIReportReasonItem.New()
    item:Init(go)
    item:InitItem(v.id, v.report_reason, checkFunc)
    self.itemDic[go] = item
  end
end

function UIReportReasonItemGroup:GetCurSelectItemIndex()
  for _, v in pairs(self.itemDic) do
    local isOn = v:GetIsOn()
    if isOn then
      return v:GetReasonId()
    end
  end
  return -1
end

function UIReportReasonItemGroup:OnDelete()
  for _, item in pairs(self.itemDic) do
    item:Delete()
  end
  self.itemDic = nil
  base.OnDelete(self)
end

return UIReportReasonItemGroup
