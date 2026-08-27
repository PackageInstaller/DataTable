local UINTaskUnlockItem = class("UINTaskUnlockItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINTaskUnlockItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.taskUnlockItem, self, self.OnClickItem)
end

function UINTaskUnlockItem:InitTaskUnlockItem(type, clickDes)
  self._clickDes = clickDes
  local cfg = ConfigData.task_unlock_type[type]
  self.ui.text.text = LanguageUtil.GetLocaleText(cfg.type)
  self.ui.image.sprite = CRH:GetSprite(cfg.icon)
end

function UINTaskUnlockItem:SetIsTaskUnlockPicked(isPicked)
  self.ui.obj_isPicked:SetActive(isPicked)
end

function UINTaskUnlockItem:OnClickItem()
  cs_MessageCommon.ShowMessageTips(LanguageUtil.GetLocaleText(self._clickDes))
end

return UINTaskUnlockItem
