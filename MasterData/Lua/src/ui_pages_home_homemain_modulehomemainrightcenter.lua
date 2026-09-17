local this = class("moduleHomeMainRightCenter", G_UIModuleBase)

function this.bind()
  return {
    active_pc = true,
    active_mobile = false,
    m_TxtFieldNum = "",
    active_switch_mobile = false
  }
end

function this.methods()
  return {
    onClick_farming = function(self)
      self:onPressKeyCodeE()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:addListener(L_ShortCutConst.event.KeyCodeE, self.onPressKeyCodeE, self)
    self.bind.active_pc = true
    self.bind.active_mobile = false
  else
    self.bind.active_pc = false
    self.bind.active_mobile = true
  end
  self.csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  self:refreshFieldNumData()
end

function this:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function this:onRefreshInfo()
end

function this:close(...)
  this.super.close(self, ...)
end

function this:show()
  if L_DeviceTpl:getIsPc() then
    if not AzurWorld.HomeDormMgr.IsInDorm then
      self:showShortCut(7, true)
      self:showShortCut(45, true)
    else
      self:showShortCut(36, true)
    end
  else
    self.bind.active_switch_mobile = self:getIsUnLockHomePlowLand()
  end
  self:refreshFieldNumData()
end

function this:onRefreshFarmModel(isShow)
  if isShow then
    self.allowPlow = self:getIsUnLockHomePlowLand()
  else
    self.allowPlow = false
  end
  if L_DeviceTpl:getIsPc() then
    self.bind.active_switch_mobile = false
    local isOpen = L_UI:checkPageOpen("PageHomeCropEditor")
    if isShow and not AzurWorld.HomeDormMgr.IsInDorm and not isOpen then
      self:showShortCut(5, self.allowPlow)
      self:showShortCut(45, true)
    else
      self:showShortCut(5, false)
    end
  elseif isShow then
    self.bind.active_switch_mobile = self:getIsUnLockHomePlowLand()
  else
    self.bind.active_switch_mobile = false
  end
end

function this:removeShortCut()
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:clearShortKeyFlag(self)
    if not AzurWorld.HomeDormMgr.IsInDorm then
      self:showShortCut(5, false)
      self:showShortCut(7, false)
      self:showShortCut(45, false)
      self.allowPlow = false
    else
      self:showShortCut(36, false)
    end
  end
end

function this:hide()
  self:removeShortCut()
  self:refreshFieldNumData()
end

function this:onPressKeyCodeE()
  if AzurWorld.HomeDormMgr.IsInDorm or not self.allowPlow then
    return
  end
  local currBlockId, currGridId = AzurWorld.HomeMgr.BlockModule:GetInteractBlockIdAndGridIdWithPlayerByOffset()
  if currBlockId == nil or currBlockId <= 0 or AzurWorld.HomeMgr.BlockModule:OnIsUnLockByBlockId(currBlockId) == false then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_home_arrange_tip_7"))
    return
  end
  L_UI:open("PageHomeCropEditor")
end

function this:refreshFieldNumData()
  self.bind.m_TxtFieldNum = L_WordsTpl:getValue("ui_home_plantmode")
end

function this:checkIsUnLockHomePlowLand()
  local result = C_HomeUtil:OnCheckIsUnLockHomePlowLand()
  return result
end

return this
