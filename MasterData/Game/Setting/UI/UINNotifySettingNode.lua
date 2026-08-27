local UINNotifySettingNode = class("UINNotifySettingNode", UIBaseNode)
local base = UIBaseNode
local UINNotifySettingItemGroup = require("Game.Setting.UI.UINNotifySettingItemGroup")

function UINNotifySettingNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.noticeTypePool = UIItemPool.New(UINNotifySettingItemGroup, self.ui.obj_Notice_Type)
  self.ui.obj_Notice_Type:SetActive(false)
end

function UINNotifySettingNode:InitNotifySettingNode(noticeSwitchOffDic)
  self.noticeTypePool:HideAll()
  local notifyTypeList = {}
  for noticeId, homesideSwitchCfg in pairs(ConfigData.homeside_switch) do
    table.insert(notifyTypeList, homesideSwitchCfg)
  end
  table.sort(notifyTypeList, function(a, b)
    return a.id < b.id
  end)
  for _, homesideSwitchCfg in ipairs(notifyTypeList) do
    local notifyList = {}
    for _, homesideInfoCfg in pairs(ConfigData.homeside_info) do
      if homesideInfoCfg.switch_type == homesideSwitchCfg.id and homesideInfoCfg.info_type ~= 0 and (homesideInfoCfg.unlock_for_setting == 0 or FunctionUnlockMgr:ValidateUnlock(homesideInfoCfg.unlock_for_setting)) then
        table.insert(notifyList, homesideInfoCfg)
      end
    end
    if 0 < #notifyList then
      table.sort(notifyList, function(a, b)
        return a.id < b.id
      end)
      local item = self.noticeTypePool:GetOne()
      item:InitNotifySettingGroup(homesideSwitchCfg, noticeSwitchOffDic, notifyList)
    end
  end
end

function UINNotifySettingNode:OnDelete()
  base.OnDelete(self)
end

return UINNotifySettingNode
