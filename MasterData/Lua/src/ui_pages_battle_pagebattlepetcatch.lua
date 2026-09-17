local page = class("pageBattlePetCatch", G_UIPageBase)
local _lockTargetId = 0
local _inLockStayState = false
local _moveTween, _firstLockPos
local _LockTargetPoint = "HitPoint"
local posTab = {
  [0] = 180,
  [1] = 100,
  [2] = 18
}
page.isShowingTip = true
page.catchBonusActivate = false

function page.bind()
  return {
    moduleCapture = {
      moduleName = "pages/Battle/moduleCapture"
    },
    list_cardItem = {
      moduleName = "pages/battle/cellCaptureCardInfo"
    },
    moduleScanPetTip = {
      moduleName = "pages/pet/new/moduleScanPetTip"
    },
    moduleUseScanItem = {
      moduleName = "pages/battle/moduleCatchUseBuffItem"
    },
    moduleUseProbabilityBuffItem = {
      moduleName = "pages/battle/moduleCatchUseBuffItem"
    },
    moduleUseLockHpBuffItem = {
      moduleName = "pages/battle/moduleCatchUseBuffItem"
    },
    modulesBattlePetCatchBonus = {
      type = "toggleModule",
      isAsync = true,
      moduleBattlePetCatchBonus = {
        assetName = "UI/Pages/PetBox/modulePetCatchBonus",
        moduleName = "pages/battle/moduleBattlePetCatchBonus"
      }
    },
    toggleBattlePetCatchBonus = "",
    goPetCatch = true,
    goMask = true,
    active_shortKey = false,
    active_beginCatchKey = true
  }
end

function page.methods()
  return {
    onClose = function(self)
      self:onClick_close()
    end,
    onPetCatch = function(self)
      self:onPet_Catch()
    end,
    onPetCatchLeft = function(self)
      self:onPet_CatchLeft()
    end,
    onPetCatchRight = function(self)
      self:onPet_CatchRight()
    end,
    onBattlePetCatchBonusActivate = function(self, moduleName)
      if not string.isEmpty(moduleName) then
        C_MJLog.LogInfo("星结成功率提升料理buff道具激活: UI打开完成 pageBattlePetCatch " .. C_Time.realtimeSinceStartup, C_ELogModule.PetCatch)
        self.catchBonusActivate = true
        if L_BattleDataManager.noticeCatchEnterMsgReceiveData and L_BattleDataManager.noticeCatchEnterMsgReceiveData.petInfo then
          self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:setPetData(L_BattleDataManager.noticeCatchEnterMsgReceiveData.petInfo)
          if self.isShowingTip then
            self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:showTip()
          else
            self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:hideTip()
          end
        end
      end
    end,
    list_cardItem = {
      onClick_sphere = function(self, sphereId, cnt, quality, selectType)
        if self.selectData and self.selectData.sphereId == sphereId then
          return
        end
        self.isPlayingAnim = true
        if self.playingAnimTimer then
          Timer.remove(self.playingAnimTimer)
          self.playingAnimTimer = nil
        end
        self.playingAnimTimer = Timer.once(0.2, function()
          self.isPlayingAnim = false
        end, self)
        for i = 1, #self.bind.list_cardItem do
          self.bind.list_cardItem:getItemCls(i):playSelectAnim(self.selectData.sphereId, sphereId)
        end
        self.selectData = {
          cnt = cnt,
          quality = quality,
          sphereId = sphereId,
          type = selectType
        }
        local keyString = table.concat({
          tostring(L_PlayerStore:getPlayerId()),
          "_",
          "SelectedCapturePetBall"
        })
        C_PlayerPrefsUtility.SetInt(keyString, self.selectData.type)
        L_BattleDataManager:setCapturePetBallData(self.selectData)
      end
    }
  }
end

function page:onPet_Catch()
  L_PlayerManager:fireStartCatch()
end

function page:set_select(select)
  self.bind.goPetCatch = not select
end

function page:onPet_CatchLeft()
  AzurWorld.PetCatchManagerMgr:LeftSelect()
end

function page:onPet_CatchRight()
  AzurWorld.PetCatchManagerMgr:RightSelect()
end

function page:onLeftBtnEff()
  self.bindComponents.LeftBtnAnimation:SetTrigger("Pressed")
  self:playFrontSightAnim(true)
end

function page:onRightBtnEff()
  self.bindComponents.RightBtnAnimation:SetTrigger("Pressed")
  self:playFrontSightAnim(true)
end

function page:onClick_close()
  if self.catchIsStart or self.isClose then
    return
  end
  C_InputManager.SetInputmap(C_InputManager_MapType.MainInputMap, true)
  if self.closeTimer then
    Timer.remove(self.closeTimer)
    self.closeTimer = nil
  end
  self.isClose = true
  self.bindComponents.anim:Play("anim_capture_hide")
  self.modules.moduleScanPetTip:PlayHide()
  self.closeTimer = Timer.once(0.167, function()
    L_UI:close("pageBattlePetCatch")
  end, self)
end

function page:escHandle()
  self:onClick_close()
end

function page:preOpen(options)
  if L_UIManager.bInputBlocked then
    L_UI:close("pageBattlePetCatch")
    return
  end
  C_MJLog.LogInfo("星结开始: UI打开完成 pageBattlePetCatch " .. C_Time.realtimeSinceStartup, C_ELogModule.PetCatch)
  L_ProfilerUtil.BeginSample("pageBattlePetCatch 1")
  self.scanLevel = L_PetManager:judgeShowScanPet()
  if L_BattleDataManager.noticeCatchEnterMsgReceiveData and L_BattleDataManager.noticeCatchEnterMsgReceiveData.petInfo then
    self.modules.moduleScanPetTip:showTip(self.scanLevel)
  end
  L_BattleDataManager:addListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_petCatch, self)
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch 2")
  self._onEnterTarget = handler(self, self.onEvent_CameraEnterTarget)
  self._onExitTarget = handler(self, self.onEvent_CameraExitTarget)
  self._mouseScrollWheelHandle = handler(self, self.onListen_mouseScrollWheel)
  C_WorldEvent.instance:Listen(C_EWorldEvent.PetCatchCameraLockTarget, self._onEnterTarget)
  C_WorldEvent.instance:Listen(C_EWorldEvent.PetCatchCameraLoseTarget, self._onExitTarget)
  C_InputManager.AddSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  self.onClickMainQuickItemBarHandle = handler(self, self.onClickMainQuickItemBar)
  C_InputManager.AddKeyListener(C_InputManager_KeyType.EMainQuickItemBar, self.onClickMainQuickItemBarHandle)
  L_UI:addListener(L_UI.pageEvent.showed, self.onEvent_showPage, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
  self._lateUpdateHandle = L_CommonUtil.handle(self.onLateUpdate_displayFollow, self)
  C_UpdateSource.AddLateUpdateEventHandler(self._lateUpdateHandle, "FormationMainPage.lateUpdate")
  L_ProfilerUtil.EndSample()
  self.modules.moduleCapture:preOpen()
  if L_DeviceTpl:getIsMobile() then
    self.bind.active_shortKey = true
    self.bind.active_beginCatchKey = false
  end
end

function page:onListen_mouseScrollWheel(dv)
  if not self.modules.moduleUseScanItem:checkOpenScanList() then
    return
  end
  local oldScale = self.scanScale
  self.scanScale = self.scanScale + (dv < 0 and 1 or 0 < dv and -1 or 0)
  self.scanScale = math.clamp(self.scanScale, 0, 2)
  if oldScale ~= self.scanScale and L_AudioUtil and L_AudioUtil.playSound then
    L_AudioUtil.playSound("Play_SFX_System_UI_CatchLens_Switch")
  end
  self.scanFunc(self.scanScale)
  self.bindComponents.rect_Handle.anchoredPosition = C_Vector2(0, posTab[self.scanScale])
end

function page:onSetScanScalePos(ketId)
  self.scanScale = ketId
  self.bindComponents.rect_Handle.anchoredPosition = C_Vector2(0, posTab[ketId])
end

function page:open(options)
  self.itemId = options and options.itemId and options.itemId or 0
  self.isClose = false
  self.catchIsStart = false
  self.bBlockHand = true
  self.bind.goMask = false
  self.isPlayingAnim = false
  self.isMove = false
  self.startTime = 0
  self.startCompensateTime = 0
  self.frontSightAnimPlayed = false
  self.scanScale = 0
  self.onReconnectedHandler = handler(self, self.onReconnected)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onReconnectedHandler)
  C_InputManager.ForbidInput(false, C_InputManager_LockReason.PetCatch)
  self._frameStage = 0
end

function page:update()
  if self._frameStage == 6 then
    return
  end
  if self._frameStage == 0 then
    self:initUseBuffItem()
    self:initCardData()
    self._frameStage = 1
    return
  elseif self._frameStage == 1 then
    self:initCardInfo()
    self._frameStage = 2
    return
  elseif self._frameStage == 2 then
    self:playInitAnim()
    self._frameStage = 3
    return
  elseif self._frameStage == 3 then
    self:playFrontSightAnimNormal(true)
    self:playFrontSightAnim(true)
    self._frameStage = 4
    return
  elseif self._frameStage == 4 then
    self:showShortCut(31, true)
    self:showShortCut(32, true)
    self:showShortCut(33, true)
    self:showShortCut(37, true)
    self._frameStage = 5
    return
  elseif self._frameStage == 5 then
    self._frameStage = 6
    return
  end
end

function page:initUseBuffItem()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initUseBuffItem 1")
  local itemId = L_GameConstTpl:getData("STAR_LINK_UI_QUICK_USE_MEAL_LUCKY", L_Const.GameTplType.int)
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initUseBuffItem 2")
  if itemId then
    self.modules.moduleUseProbabilityBuffItem:setBuffItemData(itemId, L_Const.resType.commonItem)
    self.modules.moduleUseProbabilityBuffItem:bindShortCutData(C_InputManager_KeyType.EMainPetCatchUseBuffItem1, "Q")
  end
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initUseBuffItem 3")
  itemId = L_GameConstTpl:getData("STAR_LINK_UI_QUICK_USE_MEAL_MERCY", L_Const.GameTplType.int)
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initUseBuffItem 4")
  if itemId then
    self.modules.moduleUseLockHpBuffItem:setBuffItemData(itemId, L_Const.resType.commonItem)
    self.modules.moduleUseLockHpBuffItem:bindShortCutData(C_InputManager_KeyType.EMainPetCatchUseBuffItem2, "E")
  end
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initUseBuffItem 5")
  local usingItemId = C_BagMgr:getScanUsingItemId()
  if C_BagMgr:getItemNumByItemId(usingItemId) == 0 then
    usingItemId = 0
  end
  local scanLevel = usingItemId == 0 and L_PetManager:getScanLevelById(C_BagMgr:getCurScanDefultEquip()) or L_PetManager:judgeShowScanPet()
  itemId = scanLevel == 0 and L_PetConst.PetCatchLensItemIds[1] or L_PetConst.PetCatchLensItemIds[scanLevel]
  if itemId then
    if C_BagMgr:getItemNumByItemId(itemId) > 0 then
      self._pendingScanItemId = itemId
      C_BagMgr:setScanUsingItemId(itemId)
      C_BagMgr:UseBagItem(itemId, function(rspData, errCode)
        C_BagMgr:setScanUsingItemId(itemId)
      end)
    end
    L_ProfilerUtil.BeginSample("pageBattlePetCatch initUseBuffItem 6")
    self.modules.moduleUseScanItem:setBuffItemData(itemId, L_Const.resType.commonItem, nil, true)
    self.modules.moduleUseScanItem:bindShortCutData(C_InputManager_KeyType.EMainPetCatchUseBuffItem3, "T")
    L_ProfilerUtil.EndSample()
  end
  L_ProfilerUtil.EndSample()
end

function page:OnSetScanSelectState(func)
  self.scanFunc = func
end

function page:check(options, callback)
  local result = self:checkInitCardData()
  if result < 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_noPetcatchitem"))
    callback(false)
    return
  end
  callback(true)
end

function page:checkInitCardData()
  local data = C_BagMgr:GetAllCapturePetBall()
  local size = data.Count
  local selectData
  local qualityInt = -1
  local keyString = table.concat({
    tostring(L_PlayerStore:getPlayerId()),
    "_",
    "SelectedCapturePetBall"
  })
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsBattleSimulator then
    qualityInt = C_PlayerPrefsUtility.GetInt(keyString, -1)
    if qualityInt < 0 then
      qualityInt = 4
    end
  else
    qualityInt = C_PlayerPrefsUtility.GetInt(keyString, -1)
    if 0 <= qualityInt and data[qualityInt - 1] and 0 < data[qualityInt - 1].num then
      selectData = {
        quality = data[qualityInt].quality
      }
    end
    for i = 0, size - 1 do
      if not selectData and 0 < data[i].num then
        qualityInt = data[i].quality
      end
    end
  end
  return qualityInt
end

function page:initCardData()
  self.bind.toggleBattlePetCatchBonus = "moduleBattlePetCatchBonus"
  local data = C_BagMgr:GetAllCapturePetBall()
  table.sort(data, function(a, b)
    return tonumber(a.type) < tonumber(b.type)
  end)
  local size = data.Count
  self.sphereDatas = {}
  self.selectData = nil
  local qualityInt = -1
  local keyString = table.concat({
    tostring(L_PlayerStore:getPlayerId()),
    "_",
    "SelectedCapturePetBall"
  })
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsBattleSimulator then
    local iconPath = {
      "Battle/tex_petcapture_icon_greysj.png",
      "Battle/tex_petcapture_icon_greensj.png",
      "Battle/tex_petcapture_icon_purplesj.png",
      "Battle/tex_petcapture_icon_bluesj.png",
      "Battle/tex_petcapture_icon_goldsj.png"
    }
    qualityInt = C_PlayerPrefsUtility.GetInt(keyString, -1)
    if qualityInt < 0 then
      qualityInt = 4
    end
    for i = 1, 5 do
      local sphereData = {
        sphereId = 1000000 + i,
        cnt = 6 * i,
        quality = i - 1,
        icon = iconPath[i]
      }
      table.insert(self.sphereDatas, sphereData)
    end
    self.selectData = {
      cnt = (qualityInt + 1) * 6,
      quality = qualityInt,
      sphereId = 1000001 + qualityInt
    }
  else
    local quaCnt = 0
    local saveId = 0
    local slectQuality = 0
    local selectType = 0
    qualityInt = C_PlayerPrefsUtility.GetInt(keyString, -1)
    if 0 <= qualityInt and data[qualityInt - 1] and 0 < data[qualityInt - 1].num then
      self.selectData = {
        cnt = data[qualityInt - 1].num,
        quality = data[qualityInt - 1].quality,
        sphereId = data[qualityInt - 1].id,
        selectType = data[qualityInt - 1].type
      }
    end
    for i = 0, size - 1 do
      local sphereData = {
        sphereId = data[i].id,
        cnt = data[i].num,
        quality = data[i].quality,
        icon = data[i].icon,
        selectType = data[i].type
      }
      table.insert(self.sphereDatas, sphereData)
      if not self.selectData and 0 < data[i].num and saveId == 0 then
        slectQuality = data[i].quality
        quaCnt = data[i].num
        saveId = data[i].id
        selectType = data[i].type
      end
    end
    if not self.selectData then
      self.selectData = {
        cnt = quaCnt,
        quality = slectQuality,
        sphereId = saveId,
        type = selectType
      }
    end
  end
  return qualityInt
end

function page:initCardInfo()
  self.cShortCutEnable = true
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initCardInfo 1")
  L_BattleDataManager:setCapturePetBallData(self.selectData)
  L_ProfilerUtil.EndSample()
  L_ProfilerUtil.BeginSample("pageBattlePetCatch initCardInfo 2")
  self.bind.list_cardItem:insert_array(self.sphereDatas)
  L_ProfilerUtil.EndSample()
  self.tipsRoot = self.bindComponents.PetCatchTipsRoot
  self.moveRoot = self.bindComponents.root
  self.rootInited = true
end

function page:playInitAnim()
  self:clearTimer()
  self.timer1 = Timer.once(0.033, function()
    self.bind.list_cardItem:getItemCls(6):playInitAnim(self.selectData.sphereId)
  end, self)
  self.timer2 = Timer.once(0.067, function()
    self.bind.list_cardItem:getItemCls(5):playInitAnim(self.selectData.sphereId)
  end, self)
  self.timer3 = Timer.once(0.133, function()
    self.bind.list_cardItem:getItemCls(4):playInitAnim(self.selectData.sphereId)
  end, self)
  self.timer4 = Timer.once(0.233, function()
    self.bind.list_cardItem:getItemCls(3):playInitAnim(self.selectData.sphereId)
  end, self)
  self.timer5 = Timer.once(0.367, function()
    self.bind.list_cardItem:getItemCls(2):playInitAnim(self.selectData.sphereId)
  end, self)
  self.timer6 = Timer.once(0.533, function()
    self.bind.list_cardItem:getItemCls(1):playInitAnim(self.selectData.sphereId)
    self.bBlockHand = false
  end, self)
end

function page:clearTimer()
  if self.timer1 then
    Timer.remove(self.timer1)
    self.timer1 = nil
  end
  if self.timer2 then
    Timer.remove(self.timer2)
    self.timer2 = nil
  end
  if self.timer3 then
    Timer.remove(self.timer3)
    self.timer3 = nil
  end
  if self.timer4 then
    Timer.remove(self.timer4)
    self.timer4 = nil
  end
  if self.timer5 then
    Timer.remove(self.timer5)
    self.timer5 = nil
  end
  if self.timer6 then
    Timer.remove(self.timer6)
    self.timer6 = nil
  end
end

function page:refreshSelectedSphereCnt()
  local data = C_BagMgr:GetAllCapturePetBall()
  for i = 1, #self.bind.list_cardItem do
    local cnt = data[i - 1].num
    self.bind.list_cardItem:getItemCls(i):refreshCnt(cnt)
  end
end

function page:setCShortCutEnable(enable)
  self.cShortCutEnable = enable
end

function page:onEvent_petCatch(args)
  if args.noticeType == "noticeExitCatch" then
    L_UI:close("pageBattlePetCatch")
  elseif args.noticeType == "noticeSelectStart" then
    self.isShowingTip = false
    if self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus and self.catchBonusActivate then
      self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:hideTip()
    end
  elseif args.noticeType == "noticeSelectEnd" then
    self.isShowingTip = true
    if self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus and self.catchBonusActivate then
      self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:showTip()
    end
  elseif args.noticeType == "noticeCatchPress" then
    self.selectChangeDuration = args.selectChangeDuration or 0.5
    if args.entityId == 0 then
      self:onLeftBtnEff()
    else
      self:onRightBtnEff()
    end
  elseif args.noticeType == "noticeCatchStart" then
    self.bind.goMask = true
    if args.catchIsSucc then
      local curCatchPetGuid = AzurWorld.PetCatchManagerMgr:GetCurCatchPetGuid()
      if curCatchPetGuid then
        if CS.Lens.Gameplay.Modules.Azur.WorldAdapter.IsFirstGetPet(curCatchPetGuid) or L_PetManager.gmForceGetPetNew then
          C_UIMgr.PreloadPage("pageGetPet", 60.0, function()
            C_MJLog.LogInfo("pageGetPet 预加载完成", C_ELogModule.PetCatch)
          end)
          C_UIMgr.GetPreloader("pageGetPet"):PreloadGameObject("Program/UIScene/pre_petget_ui.prefab", function(isOk)
            C_MJLog.LogInfo("Program/UIScene/pre_petget_ui.prefab 预加载完成", C_ELogModule.PetCatch)
          end)
          C_UIMgr.GetPreloader("pageGetPet"):PreloadGameObject("Program/UIScene/pre_KiboAddBlack.prefab", function(isOk)
            C_MJLog.LogInfo("Program/UIScene/pre_petget_ui.prefab 预加载完成", C_ELogModule.PetCatch)
          end)
        end
      else
        C_MJLog.LogError("预加载判断失败：CurCatchPetGuid 为 nil")
      end
    end
    self:refreshSelectedSphereCnt()
    self:setCShortCutEnable(false)
    self.isShowingTip = false
    if self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus and self.catchBonusActivate then
      self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:hideTip()
    end
    self:showShortCut(31, false)
    self:showShortCut(32, false)
    self:showShortCut(33, false)
    self:showShortCut(37, false)
  elseif args.noticeType == "noticeSendStartCatch" then
    L_ProfilerUtil.BeginSample("pageBattlePetCatch noticeSendStartCatch")
    local data = L_BattleDataManager:getCapturePetBallData()
    if data == nil or data.cnt == 0 then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_catchitem_not_enough"))
      return
    end
    L_ProfilerUtil.EndSample()
    self.catchIsStart = true
    L_ProfilerUtil.BeginSample("pageBattlePetCatch SingleSendPetCatch")
    AzurWorld.PetCatchManagerMgr:SingleSendPetCatch()
    L_ProfilerUtil.EndSample()
    L_ProfilerUtil.BeginSample("pageBattlePetCatch UIAnim Items")
    for i = 1, #self.bind.list_cardItem do
      self.bind.list_cardItem:getItemCls(i):playUnSelectAnim(self.selectData.sphereId)
    end
    L_ProfilerUtil.EndSample()
    L_ProfilerUtil.BeginSample("pageBattlePetCatch UIAnim Modules")
    self.modules.moduleUseScanItem:onLimitScanPet()
    self.bindComponents.anim:Play("anim_capture_play")
    self.modules.moduleUseProbabilityBuffItem:onStartCatch()
    self.modules.moduleUseLockHpBuffItem:onStartCatch()
    L_ProfilerUtil.EndSample()
  elseif args.noticeType == "noticeCatchEnterMsgReceive" and L_BattleDataManager.noticeCatchEnterMsgReceiveData and L_BattleDataManager.noticeCatchEnterMsgReceiveData.petInfo then
    if self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus and self.catchBonusActivate then
      self.modules.modulesBattlePetCatchBonus.moduleBattlePetCatchBonus:setPetData(L_BattleDataManager.noticeCatchEnterMsgReceiveData.petInfo)
    end
    AzurWorld.PetCatchManagerMgr:SelectMonsterIdx(AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex())
    if self.selectData then
      L_BattleDataManager:setCapturePetBallData(self.selectData)
    end
  end
end

function page:onEvent_tmpPauseInput()
  L_UI:close(self.pageName)
end

function page:onEvent_CameraEnterTarget()
  local index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if index < 0 or index >= AzurWorld.PetCatchManagerMgr:GetSelectMonsterList().Count then
    errorf("奇波星结，目标选择单位的index不正确index=" .. index, 2)
    return
  end
  local entityHandle = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[index]
  local entityId = entityHandle.data.entityId
  if not entityHandle.entity:CanBeChosen() then
    return
  end
  if entityId ~= _lockTargetId then
    self.isMove = true
  end
end

function page:onEvent_CameraExitTarget()
  if _lockTargetId ~= 0 then
    printf("奇波星结", "移除目标，configId=" .. _lockTargetId)
    _lockTargetId = 0
    _inLockStayState = false
    _firstLockPos = {
      x = 0,
      y = 0,
      z = 0
    }
    if _moveTween then
      _moveTween:Kill()
      _moveTween = nil
    end
    local entityId = self:getSelectedMonsterId()
    if entityId ~= 0 then
      return
    end
    local tweenEase = Tweening.Ease.InOutQuad
    if self.tipsRoot.gameObject ~= nil then
      local curveHolder = self.tipsRoot.gameObject:GetComponent(typeof(C_LAnimationCurveHolder)).curves
      if curveHolder ~= nil and curveHolder.Count > 1 then
        tweenEase = curveHolder[1]
      else
        errorf("奇波星结", "PetCatchTipsRoot节点上没有找到索引为1运动曲线")
      end
      local centerUiPos = {
        x = 0,
        y = 0,
        z = 0
      }
      if self.moveRoot then
        _moveTween = self.moveRoot:DOLocalMove(centerUiPos, 0.3):SetEase(tweenEase):SetEase(tweenEase):OnComplete(function()
          if _moveTween then
            _moveTween:Kill()
            _moveTween = nil
          end
        end)
      end
      self:playFrontSightAnim(false)
    end
  end
end

function page:moveEnterTarget()
  local index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if index < 0 or index >= AzurWorld.PetCatchManagerMgr:GetSelectMonsterList().Count then
    errorf("奇波星结，目标选择单位的index不正确index=" .. index, 2)
    return
  end
  local entity = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[index]
  local entityId = entity.data.entityId
  if entityId ~= _lockTargetId then
    printf("奇波星结", "锁定目标，configId=" .. entityId)
    _lockTargetId = entityId
  end
  _inLockStayState = false
  local spine = L_GameUtil.findTranByName(entity.data.transform.gameObject, _LockTargetPoint)
  local worldPos = {
    x = 0,
    y = 0,
    z = 0
  }
  if spine == nil then
    worldPos = entity.data.transform.worldPosition
  else
    worldPos = spine.position
  end
  printf("奇波星结", "锁定目标，世界坐标=" .. worldPos.x .. "," .. worldPos.y .. "," .. worldPos.z)
  local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(worldPos)
  printf("奇波星结", "锁定目标，屏幕坐标=" .. screenPos.x .. "," .. screenPos.y .. "," .. screenPos.z)
  if self.tipsRoot:IsNull() then
    return
  end
  local uiPos = L_Vector3.screenToLocalInRectangle(self.tipsRoot, screenPos)
  printf("奇波星结", "锁定目标，UI坐标=" .. uiPos.x .. "," .. uiPos.y .. "," .. uiPos.z)
  if _moveTween then
    _moveTween:Kill()
    _moveTween = nil
  end
  local tweenEase = Tweening.Ease.InOutQuad
  local curveHolder = self.tipsRoot:GetComponent(typeof(C_LAnimationCurveHolder)).curves
  if curveHolder ~= nil and 0 < curveHolder.Count then
    tweenEase = curveHolder[0]
  else
    errorf("奇波星结", "PetCatchTipsRoot节点上没有找到索引为0运动曲线")
  end
  _firstLockPos = uiPos
  self.startTime = C_Time.time
  self.startCompensateTime = 0
  self.compensateMove = true
  self.moveDeltaTime = self.selectChangeDuration or 0.5
  if self.moveRoot then
    _moveTween = self.moveRoot:DOLocalMove(uiPos, self.moveDeltaTime):SetEase(tweenEase):SetAutoKill(false):OnComplete(function()
      _inLockStayState = true
      if _moveTween then
        _moveTween:Kill()
        _moveTween = nil
      end
      self.compensateMove = false
    end)
  end
  self:playFrontSightAnim(true)
end

function page:getUIPos()
  local index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if index < 0 or index >= AzurWorld.PetCatchManagerMgr:GetSelectMonsterList().Count then
    return nil
  end
  local entity = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[index]
  local spine = L_GameUtil.findTranByName(entity.data.transform.gameObject, _LockTargetPoint)
  local worldPos = {
    x = 0,
    y = 0,
    z = 0
  }
  if spine == nil then
    worldPos = entity.data.transform.worldPosition
  else
    worldPos = spine.position
  end
  local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(worldPos)
  local uiPos = L_Vector3.screenToLocalInRectangle(self.tipsRoot, screenPos)
  return uiPos
end

function page:subLockTargetMove()
  if self.compensateMove and _lockTargetId ~= 0 then
    local pos = self:getUIPos()
    if pos ~= nil then
      local error = C_Vector3.Distance(pos, _firstLockPos)
      local compensateThreshold = math.max(1, C_Time.deltaTime * 60)
      if error > compensateThreshold then
        if _moveTween then
          _moveTween:Kill()
          _moveTween = nil
        end
        _firstLockPos = pos
        local tweenEase = Tweening.Ease.InOutQuad
        local curveHolder = self.tipsRoot:GetComponent(typeof(C_LAnimationCurveHolder)).curves
        if curveHolder ~= nil and 0 < curveHolder.Count then
          tweenEase = curveHolder[0]
        else
          errorf("奇波星结", "PetCatchTipsRoot节点上没有找到索引为0运动曲线")
        end
        if self.startTime ~= 0 then
          self.moveDeltaTime = self.moveDeltaTime - (C_Time.time - self.startTime)
          self.startTime = 0
        end
        if self.startCompensateTime ~= 0 then
          self.moveDeltaTime = self.moveDeltaTime - (C_Time.time - self.startCompensateTime)
          printf("奇波星结", "第一阶段消耗补偿时间=" .. C_Time.time - self.startCompensateTime)
          self.startCompensateTime = 0
        end
        if 0 > self.moveDeltaTime then
          self.moveDeltaTime = 0.01
        end
        self.startCompensateTime = C_Time.time
        if self.moveRoot then
          _moveTween = self.moveRoot:DOLocalMove(pos, self.moveDeltaTime):SetEase(tweenEase):SetAutoKill(false):OnComplete(function()
            _inLockStayState = true
            if _moveTween then
              _moveTween:Kill()
              _moveTween = nil
            end
            self.compensateMove = false
            self.startCompensateTime = 0
          end)
        end
      end
    end
  end
end

function page:onLateUpdate_displayFollow()
  if not self.rootInited then
    return
  end
  if self.isMove then
    self:moveEnterTarget()
    self.isMove = false
  end
  self:subLockTargetMove()
  if _inLockStayState then
    local pos = self:getUIPos()
    if pos ~= nil then
      self.moveRoot.localPosition = pos
    end
  end
end

function page:removeListener()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_petCatch, self)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.PetCatchCameraLockTarget, self._onEnterTarget)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.PetCatchCameraLoseTarget, self._onExitTarget)
end

function page:close()
  self:removeListener()
  AzurWorld.PetCatchManagerMgr:ExitSinglePetCatch()
  L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onReconnectedHandler)
  C_InputManager.RemoveSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  self:showShortCut(31, false)
  self:showShortCut(32, false)
  self:showShortCut(33, false)
  self:showShortCut(37, false)
  self.bind.toggleBattlePetCatchBonus = ""
  self:clearTimer()
  if self.closeTimer then
    Timer.remove(self.closeTimer)
    self.closeTimer = nil
  end
  if self.playingAnimTimer then
    Timer.remove(self.playingAnimTimer)
    self.playingAnimTimer = nil
  end
  L_ShortCutManager:removeShortCut(self.pageName)
  C_InputManager.RemoveKeyListener(C_InputManager_KeyType.EMainQuickItemBar, self.onClickMainQuickItemBarHandle)
  L_UI:removeListener(L_UI.pageEvent.showed, self.onEvent_showPage, self)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
  if self._lateUpdateHandle then
    C_UpdateSource.RemoveLateUpdateEventHandler(self._lateUpdateHandle)
  end
  self._lateUpdateHandle = nil
  _inLockStayState = false
  if _moveTween then
    _moveTween:Kill()
    _moveTween = nil
  end
  local pageGetPetOpen = L_UI:checkPageOpen("pageGetPet")
  if not pageGetPetOpen then
    AzurWorld.HUDMgr:SetAllVisible(true)
  end
  C_UIMgr.uiListenerMiddleware:ControlTimeLock("pageBattlePetCatch", false)
  C_UIMgr.CancelPreload("pageGetPet", 5.0)
end

function page:onReconnected()
  self.catchIsStart = false
  self:onClick_close()
  L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onReconnectedHandler)
end

function page:playFrontSightAnim(isActive)
  local index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if index < 0 then
    self:playFrontSightAnimNormal(false)
    return
  end
  local entityHandle = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[index]
  if isActive and entityHandle.entity and entityHandle.entity:CanBeChosen() then
    self:playFrontSightAnimActive()
  else
    self:playFrontSightAnimNormal(false)
  end
end

function page:playFrontSightAnimNormal(forcedPlay)
  if not self.frontSightAnimPlayed and not forcedPlay then
    return
  end
  local anim = self.tipsRoot.gameObject:GetComponent(typeof(C_Animation))
  if anim ~= nil then
    anim:Play("anim_battlecapture_frame_normal")
    self.frontSightAnimPlayed = false
  end
end

function page:playFrontSightAnimActive()
  if self.frontSightAnimPlayed then
    return
  end
  local anim = self.tipsRoot.gameObject:GetComponent(typeof(C_Animation))
  if anim ~= nil then
    anim:Play("anim_battlecapture_frame_active")
    self.frontSightAnimPlayed = true
  end
end

function page:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function page:getSelectedMonsterId()
  local index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if index < 0 or index >= AzurWorld.PetCatchManagerMgr:GetSelectMonsterList().Count then
    return 0
  end
  local entity = AzurWorld.PetCatchManagerMgr:GetSelectMonsterList()[index]
  local entityId = entity.data.entityId
  return entityId
end

function page:moveToCenter()
  self.moveRoot.localPosition = {
    x = 0,
    y = 0,
    z = 0
  }
end

function page:onClickMainQuickItemBar()
  local pageQuickItemBar = C_UIMgr.GetPage("PageQuickItemBar")
  if pageQuickItemBar and pageQuickItemBar.isShowed then
    return
  end
  C_UIMgr.Open("PageQuickItemBar")
end

function page:onEvent_showPage(pageName)
  if pageName ~= "PageQuickItemBar" then
    return
  end
  self.bindComponents.PetCatchRoot.localScale = L_Vector3.zero
  self.bindComponents.AdditionModule.localScale = L_Vector3.zero
end

function page:onEvent_closePage(pageName)
  if pageName ~= "PageQuickItemBar" then
    return
  end
  self.bindComponents.PetCatchRoot.localScale = L_Vector3.one
  self.bindComponents.AdditionModule.localScale = L_Vector3.one
end

function page:onQuickItemBarUseScanItem(itemId)
  local moduleCatchUseBuffItem = self.modules.moduleUseScanItem
  if moduleCatchUseBuffItem.isLimitScan then
    return
  end
  moduleCatchUseBuffItem.index = AzurWorld.PetCatchManagerMgr:GetCatchCurSelectIndex()
  if moduleCatchUseBuffItem.index < 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_lens_no_kibo_target"))
    return
  end
  local itemNum = C_BagMgr:getItemNumByItemId(itemId)
  if itemId == 0 or itemNum <= 0 then
    C_MJLog.LogError("透镜道具的id或者数目不对")
    return
  end
  moduleCatchUseBuffItem:SendScanPetInfo(itemId)
end

function page:onQuickItemBarUseLuckyMealItem()
  local moduleCatchUseBuffItem = self.modules.moduleUseProbabilityBuffItem
  moduleCatchUseBuffItem:onBtnUseItem()
end

function page:onQuickItemBarUseMercyMealItem()
  local moduleCatchUseBuffItem = self.modules.moduleUseLockHpBuffItem
  moduleCatchUseBuffItem:onBtnUseItem()
end

return page
