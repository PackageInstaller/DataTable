local UINDunHexaTowerSelectNodeLockItem = class("UINDunHexaTowerSelectNodeLockItem", UIBaseNode)
local base = UIBaseNode

function UINDunHexaTowerSelectNodeLockItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDunHexaTowerSelectNodeLockItem:InitHexaLockedItem(towerCfg)
  local unlockStr = CheckCondition.GetUnlockInfoLua(towerCfg.pre_condition, towerCfg.pre_para1, towerCfg.pre_para2)
  self.ui.Tex_CNLock.text = unlockStr
end

return UINDunHexaTowerSelectNodeLockItem
