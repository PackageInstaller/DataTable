local UINNotifySettingItemGroup = class("UINNotifySettingItemGroup", UIBaseNode)
local base = UIBaseNode
local UINNotifySettingItem = require("Game.Setting.UI.UINNotifySettingItem")

function UINNotifySettingItemGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.noticeTypePool = UIItemPool.New(UINNotifySettingItem, self.ui.obj_notice_Item)
  self.ui.obj_notice_Item:SetActive(false)
end

function UINNotifySettingItemGroup:InitNotifySettingGroup(homesideSwitchCfg, noticeSwitchOffDic, notifyList)
  self.ui.tex_title.text = LanguageUtil.GetLocaleText(homesideSwitchCfg.type_name)
  self.noticeTypePool:HideAll()
  for _, homesideInfoCfg in ipairs(notifyList) do
    if homesideInfoCfg.id ~= 100 or FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Friend) then
      local item = self.noticeTypePool:GetOne()
      item:InitNotifyItem(homesideInfoCfg, noticeSwitchOffDic[homesideInfoCfg.id])
    end
  end
end

function UINNotifySettingItemGroup:OnDelete()
  base.OnDelete(self)
end

return UINNotifySettingItemGroup
