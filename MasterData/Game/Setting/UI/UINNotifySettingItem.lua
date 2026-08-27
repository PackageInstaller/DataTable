local UINNotifySettingItem = class("UINNotifySettingItem", UIBaseNode)
local UISingleSwitchTogItem = require("Game.Setting.UI.UISingleSwitchTogItem")
local base = UIBaseNode

function UINNotifySettingItem:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.singleSwitchTogItem = UISingleSwitchTogItem.New()
  self.singleSwitchTogItem:Init(self.ui.mailItemTogItem)
  self.isInited = false
end

function UINNotifySettingItem:InitNotifyItem(homesideInfoCfg, isOFF)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(homesideInfoCfg.switch_name)
  self.singleSwitchTogItem:InitSingleSwitchTogItem(not isOFF, {
    ConfigData:GetTipContent(8002),
    ConfigData:GetTipContent(8001)
  }, self.OnNoticeTogValueChange, self)
  self.noticeId = homesideInfoCfg.id
  self.isInited = true
end

function UINNotifySettingItem:OnNoticeTogValueChange(value)
  if self.isInited then
    self.ctrl:SetNoticeSwitchOff(self.noticeId, not value)
    if not value then
      NoticeManager:DeleteNoticeByType(self.noticeId)
    elseif self.noticeId == NoticeManager.eNoticeType.HasOasisBuildingOperate then
      ControllerManager:GetController(ControllerTypeId.HomeController).isOasisHasCOB = false
    end
  end
end

function UINNotifySettingItem:OnDelete()
  base.OnDelete(self)
end

return UINNotifySettingItem
