_class("UIMedalModule", UIModule)
UIMedalModule = UIMedalModule

function UIMedalModule:IsMedalNew()
  local unLock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_MEDAL)
  if not unLock then
    return false
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  return itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Medal)
end

function UIMedalModule:IsMedalBoardNew()
  local unLock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_MEDAL)
  if not unLock then
    return false
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  return itemModule:HasNewSubTypeItem(ItemSubType.ItemSubType_Medal_Board)
end
