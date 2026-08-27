local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local UINBaseItemWithLock = class("UINBaseItemWithLock", UIBaseNode)
local base = UIBaseNode

function UINBaseItemWithLock:OnInit()
  local baseItemObj = self.transform:Find("UINBaseItemWithReceived")
  self.baseItem = UINBaseItemWithReceived.New()
  self.baseItem:Init(baseItemObj)
  self.obj_lock = self.transform:Find("Obj_lock").gameObject
end

function UINBaseItemWithLock:InitItemWithLock(itemCfg, count, clickEvent, isPicked, islock)
  self:SetLockUIActive(islock)
  self.baseItem:InitItemWithCount(itemCfg, count, clickEvent, isPicked)
end

function UINBaseItemWithLock:SetLockUIActive(islock)
  self.obj_lock:SetActive(islock)
end

function UINBaseItemWithLock:SetPickedUIActive(isPicked)
  self.baseItem:SetPickedUIActive(isPicked)
end

function UINBaseItemWithLock:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINBaseItemWithLock
