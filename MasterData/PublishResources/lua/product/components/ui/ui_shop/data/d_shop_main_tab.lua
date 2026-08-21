_class("DShopMainTab", Object)
DShopMainTab = DShopMainTab
local StringGet = StringTable.Get

function DShopMainTab:Constructor(cfg, uniqueid, componentID)
  if not cfg then
    return
  end
  self.cfg = cfg
  self._uniqueid = uniqueid
  self._componentID = componentID
end

function DShopMainTab:GetId()
  return self.cfg.ID
end

function DShopMainTab:GetMainTab()
  return self.cfg.MainTab
end

function DShopMainTab:GetName()
  return StringTable.Get(self.cfg.TabName)
end

function DShopMainTab:GetEnName()
  return self.cfg.EnName
end

function DShopMainTab:GetIcon()
  return self.cfg.TabIcon
end

function DShopMainTab:GetSelectIcon()
  return self.cfg.TabIconSelect
end

function DShopMainTab:IsOpen()
  local mainTabType = self:GetMainTab()
  return UIShopController.CheckIsOpen(mainTabType)
end

function DShopMainTab:GetSortIndex()
  return self.cfg.SortIndex
end

function DShopMainTab:GetUniqueID()
  return self._uniqueid
end

function DShopMainTab:GetComponentID()
  return self._componentID
end

function DShopMainTab:SetUniqueid(uniqueid)
  self._uniqueid = uniqueid
end
