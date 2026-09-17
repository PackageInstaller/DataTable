local this = class("pageFishing", G_UIPageBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _fishTpl = L_GameTpl:getFishTpl()
local TK = {fishWait = "fishWait", fishLoop = "fishLoop"}
local STATE_HANDLE = {
  [L_FishingConst.State.Idle] = "handleIdleState",
  [L_FishingConst.State.Start] = "handleStartState",
  [L_FishingConst.State.Wait] = "handleWaitState",
  [L_FishingConst.State.Loop] = "handleLoopState",
  [L_FishingConst.State.Game] = "handleGameState",
  [L_FishingConst.State.Cancel] = "handleCancelState",
  [L_FishingConst.State.Lost] = "handleLostState",
  [L_FishingConst.State.Success] = "handleSuccessState"
}
local _isPC = false

function this.bind()
  return {
    txt_fishLeftNum = "",
    go_fishingLoop = false,
    go_takeUp = false,
    go_fishingPanel = false,
    go_bait_normal = false,
    go_bait_empty = false,
    img_rod = nil,
    img_bait = nil,
    txt_baitNum = "",
    go_tip = false,
    go_moduleGame = false,
    module_fishingGame = {
      moduleName = "pages/fishing/moduleFishingGame"
    },
    go_btn_takeUp = true,
    go_btn_takeUpMobile = false,
    go_takeUp_ready = false,
    go_takeUp_readyMobile = false,
    go_fishingStart = false,
    go_fishingStartMobile = false,
    go_finshingGearBg = true,
    hook_anim = "",
    hook_anim_stop = false,
    hook_anim_mobile = "",
    hook_anim_stop_mobile = false
  }
end

function this.methods()
  return {
    onClick_fishing = function(self)
      if L_FishingManager:checkFishing(self._pointId) then
        self:switchFishingState(L_FishingConst.State.Start)
      end
    end,
    onClick_fishingMobile = function(self)
      if L_FishingManager:checkFishing(self._pointId) then
        self:switchFishingState(L_FishingConst.State.Start)
      end
    end,
    onClick_takeUp = function(self)
      if self._pageState == L_FishingConst.State.Wait then
        self:switchFishingState(L_FishingConst.State.Cancel)
      elseif self._pageState == L_FishingConst.State.Loop then
        self:switchFishingState(L_FishingConst.State.Game)
      end
    end,
    onClick_takeUpMobile = function(self)
      if self._pageState == L_FishingConst.State.Wait then
        self:switchFishingState(L_FishingConst.State.Cancel)
      elseif self._pageState == L_FishingConst.State.Loop then
        self:switchFishingState(L_FishingConst.State.Game)
      end
    end,
    onClick_replaceRod = function(self)
      L_FishingManager:replaceRod(self._pointId)
    end,
    onClick_replaceBait = function(self)
      L_FishingManager:replaceBait(self._pointId)
    end
  }
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:setTopBarCloseFunc(function()
    self:escHandle()
  end)
  C_IntegrateMgr.TopBarModule:setTopBarMainBtnFunc(function()
    self:escHandle()
  end)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  L_LoadingManager:closeLoading()
  L_FishingStore:listenCallFunc(L_FishingStore.event.refreshFishPoint, self.onEvent_refreshFishPoint, self)
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshFishPoint, self)
  L_FishingStore:listenCallFunc(L_FishingStore.event.refreshFishingGear, self.onEvent_refreshFishingGear, self)
  self.onEvent_refreshFishingGearHandle = handler(self, self.onEvent_refreshFishingGear)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshFishingGearHandle)
  self._pointId = options.pointId
  self:initPage()
end

function this:show()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EFishOperate, function()
    if self._pageState == L_FishingConst.State.Idle then
      self.methods.onClick_fishing(self)
    elseif self._pageState == L_FishingConst.State.Wait then
      self:switchFishingState(L_FishingConst.State.Cancel)
    elseif self._pageState == L_FishingConst.State.Loop then
      self:switchFishingState(L_FishingConst.State.Game)
    end
  end)
end

function this:close(options)
  this.super.close(self, options)
  L_FishingManager:reqFishing(false, self._pointId)
  L_FishingStore:unListenCallFunc(L_FishingStore.event.refreshFishPoint, self.onEvent_refreshFishPoint)
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.onEvent_refreshFishPoint)
  L_FishingStore:unListenCallFunc(L_FishingStore.event.refreshFishingGear, self.onEvent_refreshFishingGear)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshFishingGearHandle)
  L_TimerManager:clearTimer(self)
end

function this:escHandle()
  if self._pageState ~= L_FishingConst.State.Idle then
    return
  end
  local data = {
    txtTitle = L_WordsTpl:getValue("notice_title_hint"),
    txtContent = L_WordsTpl:getValue("notice_exit_fishing"),
    confirmCallback = function()
      L_FishingManager:reqFishing(false, self._pointId)
    end
  }
  L_GameUtil.showCommonTip(data)
end

function this:initPage()
  self:initMultiPlatform()
  self:initRodAndBait()
  self:switchFishingState(L_FishingConst.State.Idle)
  self.bind.txt_fishLeftNum = L_WordsTpl:getValue("info_fish_lastfish", {
    [0] = L_FishingManager:getFishPointFishCountSum(self._pointId)
  })
end

function this:switchFishingState(state)
  self._pageState = state
  L_TimerManager:clearTimer(self)
  self.bind.go_fishingStart = false and _isPC
  self.bind.go_fishingStartMobile = false and not _isPC
  self.bind.go_fishingLoop = false
  self.bind.go_moduleGame = false
  self.bind.go_takeUp = false
  self.bind.go_takeUp_ready = false
  self.bind.go_takeUp_readyMobile = false
  self.bind.go_fishingPanel = false
  self.bind.go_tip = false
  self[STATE_HANDLE[state]](self)
end

function this:handleIdleState()
  self.bind.go_fishingStart = _isPC
  self.bind.go_fishingStartMobile = not _isPC
  self.bind.go_fishingPanel = true
  self.bindComponents.ani_fishPanel:Stop()
  self.bindComponents.ani_fishPanel:Play("anim_fishing_gear_show")
  L_FishingManager:switchToFishingState(L_FishingConst.State.Idle)
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(true)
end

function this:handleStartState()
  self.bindComponents.ani_fishPanel:Stop()
  self.bindComponents.ani_fishPanel:Play("anim_fishing_gear_hide")
  L_TimerManager:newOrResetTimer(self, "closeFishingPanel", function()
    self.bind.go_fishingPanel = false
  end, 0.167)
  L_FishingManager:switchToFishingState(L_FishingConst.State.Start, function()
    self:switchFishingState(L_FishingConst.State.Wait)
  end)
  C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
end

function this:handleWaitState()
  self.bind.go_takeUp = true
  self.bindComponents.ani_TakeUpRoot:Stop()
  self.bindComponents.ani_TakeUpRoot:Play("anim_fishing_game_btn2_show")
  self.bind.go_tip = true
  self.bind.hook_anim_stop = true
  self.bind.hook_anim_stop_mobile = true
  L_FishingManager:switchToFishingState(L_FishingConst.State.Wait)
  L_TimerManager:newOrResetTimer(self, TK.fishWait, function()
    if L_FishingManager:checkBait(self._pointId) then
      L_FishingStore:req_CSProtoFishStart(self._pointId, function(fishId)
        self._getFishId = fishId
        self:switchFishingState(L_FishingConst.State.Loop)
      end)
    else
      self:switchFishingState(L_FishingConst.State.Cancel)
    end
  end, 5)
end

function this:handleLoopState()
  self.bind.go_fishingLoop = true
  self.bind.go_takeUp = true
  self.bind.go_takeUp_ready = true
  self.bind.go_takeUp_readyMobile = true
  L_FishingManager:switchToFishingState(L_FishingConst.State.Loop)
  local item = L_ItemManager:parseCommonItem(self._getFishId)
  local tpl = _fishTpl:getTplById(item.subId)
  local baitTime = _fishTpl:getBaitTime(tpl)
  local ranDomTime = math.random(baitTime[1], baitTime[2])
  self.bind.hook_anim = "anim_fish_hook_loop"
  self.bind.hook_anim_mobile = "anim_fish_hook_loop"
  L_TimerManager:newOrResetTimer(self, TK.fishLoop, function()
    self:switchFishingState(L_FishingConst.State.Lost)
  end, ranDomTime / 1000 + 1)
end

function this:handleGameState()
  self.bind.go_moduleGame = true
  self.bind.go_takeUp = true
  self.bindComponents.ani_TakeUpRoot:Stop()
  self.bindComponents.ani_TakeUpRoot:Play("anim_fishing_game_btn2_hide")
  L_TimerManager:newOrResetTimer(self, "hideTakeUpRoot", function()
    self.bind.go_takeUp = false
  end, 0.167)
  self.modules.module_fishingGame:setFishId(self._getFishId, function(res)
    if res then
      self:switchFishingState(L_FishingConst.State.Success)
    else
      self:switchFishingState(L_FishingConst.State.Lost)
    end
  end, self.bindComponents.rectPageFishingRoot)
end

function this:handleCancelState()
  L_FishingManager:switchToFishingState(L_FishingConst.State.Cancel, function()
    self:switchFishingState(L_FishingConst.State.Idle)
  end)
end

function this:handleLostState()
  self.bind.hool_anim_stop = true
  L_FishingManager:switchToFishingState(L_FishingConst.State.Lost, function()
    L_FishingManager:reqFinishFish(false, function()
      self:switchFishingState(L_FishingConst.State.Idle)
    end)
  end)
end

function this:handleSuccessState()
  L_FishingManager:reqFinishFish(true, function()
    self:switchFishingState(L_FishingConst.State.Idle)
  end)
end

function this:initRodAndBait()
  self._curRodId = L_FishingStore:getCurRodId()
  self._curBaitId = L_FishingStore:getCurBaitId()
  if not math.isEmpty(self._curRodId) then
    local tpl_commonItem = _commonItemTpl:getTplById(self._curRodId)
    self.bind.txt_rodName = _commonItemTpl:getName(tpl_commonItem)
    self.bind.img_rod = _commonItemTpl:getIcon(tpl_commonItem)
  end
  if math.isEmpty(self._curBaitId) or not math.isEmpty(self._curBaitId) and C_BagMgr:getItemNumByItemId(self._curBaitId) <= 0 then
    self.bind.go_bait_normal = false
    self.bind.go_bait_empty = true
    self.bind.txt_baitName = ""
  else
    self.bind.go_bait_normal = true
    self.bind.go_bait_empty = false
    local tpl_commonItem = _commonItemTpl:getTplById(self._curBaitId)
    self.bind.txt_baitName = _commonItemTpl:getName(tpl_commonItem)
    self.bind.img_bait = _commonItemTpl:getIcon(tpl_commonItem)
    self.bind.txt_baitNum = tostring(C_BagMgr:getItemNumByItemId(self._curBaitId))
  end
end

function this:onEvent_refreshFishPoint()
  self.bindComponents.ani_fishNum:Stop()
  self.bindComponents.ani_fishNum:Play("anim_fishing_nums_fresh")
  L_TimerManager:newOrResetTimer(self, "refreshFishNum", function()
    self.bind.txt_fishLeftNum = L_WordsTpl:getValue("info_fish_lastfish", {
      [0] = L_FishingManager:getFishPointFishCountSum(self._pointId)
    })
  end, 0.033)
end

function this:onEvent_refreshFishingGear()
  if self._curRodId ~= L_FishingStore:getCurRodId() then
    L_FishingManager:replaceRodMod()
  end
  self:initRodAndBait()
end

function this:initMultiPlatform()
  _isPC = L_DeviceTpl:getIsPc()
  self.bind.go_btn_takeUp = _isPC
  self.bind.go_btn_takeUpMobile = not _isPC
  self.bind.go_finshingGearBg = _isPC
end

return this
