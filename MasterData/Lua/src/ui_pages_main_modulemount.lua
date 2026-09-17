local this = class("moduleMount", G_UIModuleBase)
local DoTweenName = {
  ImgChangeFill = "ImgChangeFill",
  ImgSatietyFill = "ImgSatietyFill",
  LongPressFill = "LongPressFill",
  SpeedTxtChange = "SpeedTxtChange"
}

function this.bind()
  return {
    go_root = false,
    go_rider = false,
    go_mountDown = false,
    go_mountUp = true,
    slider_mask = 0,
    fillAmount_longPress = 0,
    toggle_disableMount = false,
    go_speedBar = false,
    go_speedBarContent = false,
    fillAmount_satiety = 1,
    fillAmount_change = 1,
    color_satiety = nil,
    txt_speed = nil
  }
end

function this.methods()
  return {}
end

function this:open()
  self.isPc = L_DeviceTpl:getIsPc()
  self._ESyncMountRouletteServerDataHandler = handler(self, self.infoRefresh)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
  L_MountStore:listenCallFunc(L_MountStore.event.mountReq, self.refreshMountCd, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.infoRefresh, self)
  self._onCutWorldComplete = handler(self, self.infoRefresh)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.infoRefresh, self)
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.refreshSystem, self)
  L_ShortCutManager:addListener(L_ShortCutConst.event.LongPressMount, self.onEvent_longPress, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.canMountStatusChange, self.infoRefresh, self)
  L_ReddotManager:registerReddot(self.bindComponents.rect_redotNormal, L_ReddotManager.DotDef.Mount)
  self:configTouch("+")
  self:infoRefresh()
  self:refreshMountCd()
  self._doTweenMap = {}
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.summonPet, L_Const.AnchorType.Bottom, self.bindComponents.rTransRider, L_Vector3.new(0, -10))
end

function this:close()
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.infoRefresh, self)
  L_MountStore:unListenCallFunc(L_MountStore.event.mountReq, self.refreshMountCd, self)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.infoRefresh, self)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.LongPressMount, self.onEvent_longPress, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.canMountStatusChange, self.infoRefresh, self)
  self:closeDoTween()
  self:configTouch("-")
  self:showShortCut(16, false, false)
  self:showShortCut(17, false, false)
  self:showShortCut(18, false, false)
  self._btnGo = nil
  if self.cdTimer then
    Timer.remove(self.cdTimer)
    self.cdTimer = nil
  end
  self._lastIsMount = nil
  self._lastSatietyStatus = nil
  L_TimerManager:clearTimer(self)
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:show(options)
  L_ShortCutManager:addListener(L_ShortCutConst.event.Mount, self.onEvent_shortCutPress, self)
  self:setShortcutActive(16, true)
  self:setShortcutActive(17, true)
  self:setShortcutActive(18, true)
end

function this:hide(options)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.Mount, self.onEvent_shortCutPress, self)
  self:setShortcutActive(16, false)
  self:setShortcutActive(17, false)
  self:setShortcutActive(18, false)
end

function this:refreshMountCd()
  if self.cdTimer then
    Timer.remove(self.cdTimer)
    self.cdTimer = nil
  end
  if C_PlayerHelper.CheckMyPlayerIsMountCD() then
    self.showMaskTime = C_PlayerHelper.GetMyPlayerMountCDTime()
    self:cdCountDown()
    self.cdTimer = Timer.repeated(0.1, function()
      self:cdCountDown()
    end, self, self.gameObject)
  else
    self.showMaskTime = nil
    self.bind.slider_mask = 0
  end
end

function this:cdCountDown()
  if self.showMaskTime then
    local offset = self.showMaskTime - C_TimeManager.globalTime
    if offset < 0 then
      self.showMaskTime = nil
      self.bind.slider_mask = 0
    else
      self.bind.slider_mask = offset / (L_GameConstTpl:getData("SCAN_MOUNT_CD", L_Const.GameTplType.int, 50000) * 1.0E-4)
    end
  end
end

function this:infoRefresh()
  local bSystemUnlock = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  local bSceneCanMount = C_MountUtil.CheckSceneCanMount()
  local isInBossBattle = L_BattleStore:getIsInBattle() and self:isBossFight()
  local canMount = L_BattleDataManager:getIsCanMount()
  self.needShowMount = bSystemUnlock and bSceneCanMount and (not isInBossBattle or not not canMount)
  self.bind.go_rider = bSystemUnlock and not self.isPc
  self.bind.go_speedBar = self.needShowMount
  self.bind.toggle_disableMount = not self.needShowMount
  local bChange = L_CommonUtil.setObjActive(self.gameObject, bSystemUnlock)
  if bChange then
    L_BattleDataManager:sendEvent(L_BattleDataManager.event.refreshPageMainLeftBottomLayout)
  end
  self.bind.go_root = not L_DeviceTpl:getIsPc()
  if not self.needShowMount then
    local isAdd = bSceneCanMount and not isInBossBattle
    self:showShortCut(16, isAdd, true)
    return
  end
  local isMount = L_PlayerStore:playerInMountStatus()
  self.bind.go_mountDown = isMount
  self.bind.go_mountUp = not isMount
  self:showShortCut(16, not isMount and not isInBossBattle, false)
  self:showShortCut(17, isMount, false)
  self:showShortCut(18, not isInBossBattle, false)
  if self._lastIsMount ~= isMount then
    self._lastIsMount = isMount
    if isMount then
      L_MountStore:recordMountSatietyPercent(1)
      self:showSpeedBar()
      return
    end
    self:closeSpeedBar(true)
    return
  end
  if not isMount then
    return
  end
  self:refreshSatiety()
end

function this:isBossFight()
  if C_BattleManager.battleFieldEntity ~= nil then
    local EMonsterType = CS.Lens.Gameplay.Modules.BigWorld.EMonsterType
    local monsters = C_BattleManager.battleNormalCenter:GetNowBattleInfoList()
    for i = 0, monsters.Count - 1 do
      local monster = monsters[i]
      if monster.enemyGroup:HasMonsterType(EMonsterType.BOSS) then
        return true
      end
    end
  end
  return false
end

function this:showSpeedBar()
  L_TimerManager:clearTimer(self)
  self:closeDoTween(DoTweenName.ImgChangeFill)
  self:closeDoTween(DoTweenName.ImgSatietyFill)
  self:closeDoTween(DoTweenName.SpeedTxtChange)
  self.bind.go_speedBarContent = true
  local mountId = L_PlayerStore:getPlayerMount()
  local oldSatietyPercent = L_MountStore:getRecordMountSatietyPercent()
  local oldStatus = L_SatietyStore:getPetSatietyStatus(mountId, oldSatietyPercent)
  local oldSpeed = L_MountManager:getMountSpeed(mountId, oldSatietyPercent)
  self.bind.fillAmount_satiety = oldSatietyPercent
  self.bind.fillAmount_change = oldSatietyPercent
  self.bind.txt_speed = L_GameUtil.fillColor(oldSpeed, L_PetConst.SatietyTextColor[oldStatus])
  self.bind.color_satiety = L_PetConst.SatietyStatusColor[oldStatus]
  local curSatietyPercent = L_SatietyStore:getPetSatietyPercent(mountId)
  local curStatus = L_SatietyStore:getPetSatietyStatus(mountId)
  local curSpeed = L_MountManager:getMountSpeed(mountId)
  L_TimerManager:newOrResetTimer(self, "setSatietyColor", function()
    self.bind.color_satiety = L_PetConst.SatietyStatusColor[curStatus]
    self.bind.txt_speed = L_GameUtil.fillColor(curSpeed, L_PetConst.SatietyTextColor[curStatus])
  end, 0.632)
  L_TimerManager:newOrResetTimer(self, "imgChangeDoTweenStart", function()
    local function getter()
      return oldSatietyPercent
    end
    
    local function setter(r)
      self.bind.fillAmount_change = r
    end
    
    self._doTweenMap[DoTweenName.ImgChangeFill] = DOTween.To(getter, setter, curSatietyPercent, 0.799)
    self._doTweenMap[DoTweenName.ImgChangeFill]:SetEase(Tweening.Ease.InOutQuart)
    if oldStatus ~= curStatus then
      self.bindComponents.ani_txt:Stop()
      self.bindComponents.ani_txt:Play("anim_speedBar_number")
    end
  end, 0.366)
  L_TimerManager:newOrResetTimer(self, "imgSatietyDoTweenStart", function()
    local function getter()
      return oldSatietyPercent
    end
    
    local function setter(r)
      self.bind.fillAmount_satiety = r
      self.bind.color_satiety = L_PetConst.SatietyStatusColor[L_SatietyStore:getPetSatietyStatus(mountId, r)]
    end
    
    self._doTweenMap[DoTweenName.ImgSatietyFill] = DOTween.To(getter, setter, curSatietyPercent, 0.832)
    self._doTweenMap[DoTweenName.ImgSatietyFill]:SetEase(Tweening.Ease.InOutQuart)
  end, 0.2)
  L_TimerManager:newOrResetTimer(self, "txtSpeedChangeStart", function()
    local function getter()
      return oldSpeed
    end
    
    local function setter(r)
      local status = L_MountManager:getStatusBySpeed(mountId, math.round(r))
      self.bind.txt_speed = L_GameUtil.fillColor(math.round(r), L_PetConst.SatietyTextColor[status])
    end
    
    self._doTweenMap[DoTweenName.SpeedTxtChange] = DOTween.To(getter, setter, curSpeed, 0.6)
    self._doTweenMap[DoTweenName.SpeedTxtChange]:SetEase(Tweening.Ease.Linear)
  end, 0.599)
  self:closeSpeedBar()
  L_MountStore:recordMountSatietyPercent(curSatietyPercent)
end

function this:closeSpeedBar(isForce)
  if self.bind.go_speedBarContent then
    local function hideFX()
      self.bindComponents.ani_satiety:Stop()
      
      self.bindComponents.ani_satiety:Play("anim_speedBar_hide")
      L_TimerManager:newOrResetTimer(self, "playHideAni", function()
        self.bind.go_speedBarContent = false
      end, 0.5)
    end
    
    if isForce then
      L_TimerManager:clearTimer(self)
      self:closeDoTween(DoTweenName.ImgChangeFill)
      self:closeDoTween(DoTweenName.ImgSatietyFill)
      self:closeDoTween(DoTweenName.SpeedTxtChange)
      hideFX()
      return
    end
    L_TimerManager:newOrResetTimer(self, "showSpeedBar", hideFX, 4)
  end
end

function this:refreshSystem()
  self:infoRefresh()
end

function this:playLongPressAni()
  local function getter()
    return 0
  end
  
  local function setter(r)
    self.bind.fillAmount_longPress = r
  end
  
  self._doTweenMap[DoTweenName.LongPressFill] = DOTween.To(getter, setter, 1, 0.42)
  self._doTweenMap[DoTweenName.LongPressFill].onComplete = function()
    L_UI:open("pageMountRoulette")
  end
  self._doTweenMap[DoTweenName.LongPressFill]:SetEase(Tweening.Ease.Linear)
end

function this:clickMountBtn()
  if not self.needShowMount then
    if not C_MountUtil.CheckSceneCanMount() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_unable_scene"))
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_notAvailable"))
    end
    return
  end
  if AzurWorld.mountMgr:GetIsRouletteEmpty() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_notice_mount_ride"))
    return
  end
  if L_PlayerStore:playerInMountStatus() then
    AzurWorld.mountMgr:ReqLeaveMount()
  else
    AzurWorld.mountMgr:ReqRideMount(AzurWorld.mountMgr:GetEquipMountId())
  end
  self.bindComponents.ani_btn_rider:Stop()
  self.bindComponents.ani_btn_rider:Play("anim_mounticon_chick")
  C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Mount")
end

function this:closeDoTween(name)
  self._doTweenMap = self._doTweenMap or {}
  if name then
    if L_CommonUtil.isValid(self._doTweenMap[name]) then
      self._doTweenMap[name]:Kill()
      self._doTweenMap[name] = nil
    end
    if name == DoTweenName.LongPressFill then
      self.bind.fillAmount_longPress = 0
    end
  else
    for i, v in pairs(self._doTweenMap) do
      v:Kill()
      v = nil
    end
    self._doTweenMap = {}
  end
end

function this:onEvent_shortCutPress()
  self:clickMountBtn()
end

function this:onEvent_longPress(isPress)
  if isPress then
    if not self.needShowMount then
      if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount) then
        return
      end
      if not C_MountUtil.CheckSceneCanMount() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_unable_scene"))
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_notAvailable"))
      end
      return
    end
    if C_PlayerHelper.CheckMyPlayerIsMountCD() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mount_touch_too_fast"))
      return
    end
    self:playLongPressAni()
  else
    if not self.needShowMount then
      return
    end
    self:closeDoTween(DoTweenName.LongPressFill)
  end
end

function this:refreshSatiety()
  local satietyStatus = L_SatietyStore:getPetSatietyStatus(L_PlayerStore:getPlayerMount())
  if self._lastSatietyStatus == L_PetConst.SatietyStatus.FULL and satietyStatus == L_PetConst.SatietyStatus.MIDDLE or satietyStatus == L_PetConst.SatietyStatus.LESS and self._lastSatietyStatus == L_PetConst.SatietyStatus.MIDDLE then
    self:showSpeedBar()
  end
  self._lastSatietyStatus = satietyStatus
end

function this:configTouch(operator)
  self._onUITouchHandle = self._onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self._onUIClickHandle = self._onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  C_ScreenTouch.OnUI_Touch(operator, self._onUITouchHandle)
  C_ScreenTouch.OnUI_Click(operator, self._onUIClickHandle)
end

function this:onUI_touchHandle(gesture)
  if not self.isBind then
    return
  end
  if not self.needShowMount then
    return
  end
  if C_PlayerHelper.CheckMyPlayerIsMountCD() then
    return
  end
  local go = gesture.go
  self._btnGo = self._btnGo or self.bindComponents.rTransRider.gameObject
  if go ~= self._btnGo then
    return
  end
  L_FlyMsgManager:startLongPress(gesture, 0.5, function()
    L_UI:open("pageMountRoulette")
  end)
end

function this:onUI_clickHandle(gesture)
  if not self.isBind then
    return
  end
  local go = gesture.go
  self._btnGo = self._btnGo or self.bindComponents.rTransRider.gameObject
  if go ~= self._btnGo then
    return
  end
  self:clickMountBtn()
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

function this:showShortCut(id, idAdd, isGray)
  if not self.isPc then
    return
  end
  local bSystemUnlock = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount)
  if not bSystemUnlock then
    return
  end
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = isGray
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function this:setShortcutActive(id, isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideActiveEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isHide = not isShow
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcActive, args)
end

return this
