local this = class("moduleScanning", G_UIModuleBase)

function this.bind()
  return {
    active_content = false,
    active_cdMask = false,
    toggle_disableScanning = false,
    fill_cdMask = 0,
    moduleScanPetTip = {
      moduleName = "pages/pet/new/moduleScanPetTip"
    }
  }
end

function this.methods()
  return {
    onClick_startScan = function(self)
      if L_DeviceTpl:getIsMobile() then
        L_AudioUtil.playSound("Play_SFX_System_UI_FunctionPanel_Click_Mobile")
      end
      self:startScan()
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  self.modules.moduleScanPetTip:hideTip()
  self:initSystem()
  self.scanningCd = L_GameTpl:getGameConstTpl():getData("SCAN_CD", L_Const.GameTplType.int) / 10000
  L_ShortCutManager:addListener(L_ShortCutConst.event.StartScanning, self.startScan, self)
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.scanning, L_Const.AnchorType.Bottom, self.bindComponents.rTransRider, L_Vector3.new(-0.6, 21.9))
end

function this:close(...)
  this.super.close(self, ...)
  self:disposeScanCdTimer()
  self.modules.moduleScanPetTip:SetActive(false)
  self.disableScanning = false
  L_ShortCutManager:removeListener(L_ShortCutConst.event.StartScanning, self.startScan, self)
  L_ShortCutManager:clearShortKeyFlag(self)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  self.systemUnlockHandleId = nil
end

function this:hide()
  self:hideModules()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
  L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
end

function this:initSystem()
  self.systemId = L_SystemConst.enum.scanning
  if self.systemUnlockHandleId then
    C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  end
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.refreshSystem, self)
  self:refreshSystem(self.systemId)
end

function this:refreshSystem(systemId, isUnlock)
  if systemId ~= self.systemId then
    return
  end
  local isUnlock = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.scanning)
  self.bind.active_content = isUnlock
  self.isUnlock = isUnlock
  L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
end

function this:startScan()
  if not self.isUnlock then
    return
  end
  if self.cd and self.cd > 0 then
    return
  end
  if self.disableScanning then
    self:disposeScanCdTimer()
    self.modules.moduleScanPetTip:SetActive(false)
    return
  end
  AzurWorld.ScanMgr:StartScan()
  self:disposeScanCdTimer()
  self.bind.active_cdMask = true
  if self.scanningCd == nil then
    self.scanningCd = L_GameTpl:getGameConstTpl():getData("SCAN_CD", L_Const.GameTplType.int) / 10000
  end
  self.cd = self.scanningCd
  
  local function getter()
    return self.cd
  end
  
  local function setter(v)
    self.cd = v
    if self.bind and self.bind.fill_cdMask then
      self.bind.fill_cdMask = self.cd / self.scanningCd
    end
  end
  
  if self.scanCdTween ~= nil then
    self.scanCdTween:Kill()
    self.scanCdTween = nil
  end
  self.scanCdTween = DOTween.To(getter, setter, 0, self.scanningCd):SetEase(Tweening.Ease.Linear):OnComplete(function()
    self:disposeScanCdTimer()
    self.modules.moduleScanPetTip:SetActive(false)
  end)
end

function this:disposeScanCdTimer()
  if self.scanCdTween then
    self.scanCdTween:Kill()
    self.scanCdTween = nil
  end
  self:resetScanCdTimerInfo()
end

function this:resetScanCdTimerInfo()
  self.cd = 0
  self.bind.active_cdMask = false
end

return this
