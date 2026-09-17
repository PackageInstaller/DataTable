local this = class("moduleQuickUse", G_UIModuleBase)
local _Input = Unity.Input
local DoTweenName = {
  LongPressFill = "LongPressFill"
}

function this.bind()
  return {
    activeUsebtn = true,
    iconName = "",
    slider_mask = 0,
    fillAmount_longPress = 0,
    activeInfo = false,
    activeEmpty = true,
    num_txt = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:onEvent_shortCutPress()
    end
  }
end

function this:open()
  self:initData()
  self.infoRefreshHandle = handler(self, self.infoRefresh)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.infoRefreshHandle)
  L_QuickRouletteStore:listenCallFunc(L_QuickRouletteStore.event.curSelectChange, self.infoRefresh, self)
  L_ShortCutManager:addListener(L_ShortCutConst.event.UseRoulette, self.onEvent_shortCutPress, self)
  self:configTouch("+")
  self:infoRefresh()
end

function this:initData()
  self.openPageName = "pageQuickRoulette"
  self._doTweenMap = {}
end

function this:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.infoRefreshHandle)
  L_QuickRouletteStore:unListenCallFunc(L_QuickRouletteStore.event.curSelectChange, self.infoRefresh, self)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.UseRoulette, self.onEvent_shortCutPress, self)
  self:configTouch("-")
end

function this:update()
  if self._isPaues then
    return
  end
  self:checkLongPressAction()
end

function this:infoRefresh()
  local needShowMount = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.quickRoulette)
  self.bind.activeUsebtn = needShowMount
  local showInfo
  if needShowMount then
    local curSelectGuid = L_QuickRouletteStore:getCurSelectGuid()
    showInfo = curSelectGuid and 0 < curSelectGuid
    if showInfo then
      local info = L_QuickRouletteManager:getItemInfo(curSelectGuid)
      self.bind.iconName = info.icon
      self.bind.num_txt = tostring(C_BagMgr:getItemNumByItemId(curSelectGuid))
      self.bindComponents.dirTrans.localRotation = C_Quaternion.Euler(C_Vector3(0, 0, 180 - (L_QuickRouletteStore:getCurSelectIndex() - 1) * 45))
    else
      self.bind.iconName = ""
      self.bind.num_txt = ""
    end
  end
  showInfo = L_CommonUtil.toBoolean(showInfo)
  self.bind.activeInfo = showInfo
  self.bind.activeEmpty = not showInfo
end

function this:refreshSystem()
  self:infoRefresh()
end

function this:clickUseBtn()
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.catchPet)
  if not result then
    return
  end
  if L_QuickRouletteStore:checkIsEmpty() then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("ui_roulette_empty_tip"),
      confirmCallback = function()
        L_UI:open("pageQuickEditRoulette")
      end
    })
  else
    local guid = L_QuickRouletteStore:getCurSelectGuid()
    L_QuickRouletteManager:useItem(guid, function()
      L_QuickRouletteStore:refreshRouletteData()
    end)
  end
end

function this:checkLongPressAction()
  if not self.longPressKey then
    self.longPressKey = Unity.KeyCode.Tab
  end
  if L_UI:checkPageOpen("pageBattleFailed") then
    self.isPressed = false
    self:onEvent_longPress(false)
    return
  end
  if _Input.GetKeyDown(self.longPressKey) then
    self.isPressed = true
    self:onEvent_longPress(true)
  elseif self.isPressed and not _Input.GetKey(self.longPressKey) then
    self.isPressed = false
    self:onEvent_longPress(false)
  elseif _Input.GetKeyUp(self.longPressKey) then
    self.isPressed = false
    self:onEvent_longPress(false)
  end
end

function this:onEvent_shortCutPress()
  if not self.bind.activeUsebtn then
    return
  end
  self:clickUseBtn()
end

function this:onEvent_longPress(isPress)
  if not self.bind.activeUsebtn then
    return
  end
  local isOpen = L_UI:checkPageOpen(self.openPageName)
  if isPress and not isOpen then
    local nowTime = L_TimeUtil.getServerTime()
    if self.lastOpenTime and nowTime == self.lastOpenTime then
      self.lastOpenTime = nowTime
      return
    end
    self.lastOpenTime = nowTime
    L_QuickRouletteStore.rouletteNeedClose = false
    self:playLongPressAni()
  elseif not isPress then
    L_QuickRouletteStore.rouletteNeedClose = true
    self:closeDoTween(DoTweenName.LongPressFill)
  end
end

function this:configTouch(operator)
  self._onUITouchHandle = self._onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self._onUIClickHandle = self._onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  self._onUITouchEndHandle = self._onUITouchEndHandle or L_CommonUtil.handle(self.onUI_TouchEnd, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self._onUITouchHandle)
  C_ScreenTouch.OnUI_Click(operator, self._onUIClickHandle)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self._onUITouchEndHandle)
end

function this:onUI_TouchEnd(gesture)
  self:onEvent_longPress(false)
end

function this:onUI_touchHandle(gesture)
  if not self.isBind then
    return
  end
  local go = gesture.go
  self._btnGo = self._btnGo or self.bindComponents.rTransBtn.gameObject
  if go ~= self._btnGo then
    return
  end
  self:onEvent_longPress(true)
end

function this:onUI_clickHandle(gesture)
  if not self.isBind then
    return
  end
  local go = gesture.go
  self._btnGo = self._btnGo or self.bindComponents.rTransBtn.gameObject
  if go ~= self._btnGo then
    return
  end
  self:clickUseBtn()
end

function this:playLongPressAni()
  L_UI:open(self.openPageName)
  do return end
  
  local function getter()
    return 0
  end
  
  local function setter(r)
    self.bind.fillAmount_longPress = r
  end
  
  self._doTweenMap[DoTweenName.LongPressFill] = DOTween.To(getter, setter, 1, 0.3)
  self._doTweenMap[DoTweenName.LongPressFill].onComplete = function()
    L_UI:open(self.openPageName)
  end
  self._doTweenMap[DoTweenName.LongPressFill]:SetEase(Tweening.Ease.Linear)
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
end

return this
