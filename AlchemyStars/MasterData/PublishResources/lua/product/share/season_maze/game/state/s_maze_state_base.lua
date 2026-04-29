_class("SMazeStateBase", Object)
SMazeStateBase = SMazeStateBase

function SMazeStateBase:Constructor(si, sm, mn)
  self._stateID = si
  self._machine = sm
  self._manager = mn
  self._lockList = {}
  self._events = {}
  self._prefabReqs = {}
  self._valid = true
end

function SMazeStateBase:StateID()
  return self._stateID
end

function SMazeStateBase:OnEnter(...)
end

function SMazeStateBase:OnUpdate(dt)
end

function SMazeStateBase:OnExit()
end

function SMazeStateBase:Dispose()
  for k, v in pairs(self._events) do
    GameGlobal.EventDispatcher():RemoveCallbackListener(k, v)
  end
  self._events = nil
  for _, req in pairs(self._prefabReqs) do
    req:Dispose()
  end
  self._prefabReqs = nil
  self._machine = nil
  for _, v in pairs(self._lockList) do
    self._manager:UnLock(v)
  end
  self._lockList = {}
  self._manager = nil
  self._valid = false
end

function SMazeStateBase:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function SMazeStateBase:StartTask(func, ...)
  GameGlobal.TaskManager():StartTask(func, ...)
end

function SMazeStateBase:LoadPrefab(name)
  if not string.endwith(name, ".prefab") then
    name = name .. ".prefab"
  end
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
  table.insert(self._prefabReqs, req)
  local go = req.Obj
  go:SetActive(true)
  return go
end

function SMazeStateBase:_Log(...)
  Log.debug("[SMazeClient] ", ...)
end

function SMazeStateBase:_LogError(...)
  Log.error("[SMazeClient] ", ...)
end

function SMazeStateBase:Lock(name)
  self:_Log("锁定:", name)
  self._manager:Lock(name)
  table.insert(self._lockList, name)
end

function SMazeStateBase:UnLock(name)
  if self._manager then
    self._manager:UnLock(name)
    table.removev(self._lockList, name)
  end
end

function SMazeStateBase:Valid()
  return self._valid
end

function SMazeStateBase:OnObainedRelic(relicEfts, reason)
  self:StartTask(self._PlayRelicEffect, self, relicEfts, reason)
end

function SMazeStateBase:_PlayRelicEffect(TT, relicEfts, reason)
  local rdmCard = false
  for _, eft in ipairs(relicEfts) do
    if eft.type == SeasonMazeEffectType.SMET_RandomHandGold then
      rdmCard = true
    elseif eft.type == SeasonMazeEffectType.SMET_Relic then
      self:AddRelicEft(eft)
    elseif eft.type == SeasonMazeEffectType.SMET_BloodExchangeExp then
      local expEft = SeasonMazeEffect:New()
      expEft.type = SeasonMazeEffectType.SMET_Pro
      expEft.id = SeasonMazeAttrType.SMAT_Exp
      expEft.value_min = eft.value_min
      expEft.value_max = eft.value_max
      self:AddRelicEft(expEft)
    elseif eft.type == SeasonMazeEffectType.SMET_GoldExchangeExp then
      do
        local goldEft = SeasonMazeEffect:New()
        goldEft.type = SeasonMazeEffectType.SMET_Pro
        goldEft.id = SeasonMazeAttrType.SMAT_Gold
        goldEft.value_min = -eft.value_max
        goldEft.value_max = -eft.value_max
        self:AddRelicEft(goldEft)
      end
      local expEft = SeasonMazeEffect:New()
      expEft.type = SeasonMazeEffectType.SMET_Pro
      expEft.id = SeasonMazeAttrType.SMAT_Exp
      expEft.value_min = eft.value_min
      expEft.value_max = eft.value_max
      self:AddRelicEft(expEft)
    end
  end
  if rdmCard then
    local wait = true
    self:ShowDialog("UISeasonMazeRelicRdmCard", function(count)
      wait = false
      local expEft = SeasonMazeEffect:New()
      expEft.type = SeasonMazeEffectType.SMET_Pro
      expEft.id = SeasonMazeAttrType.SMAT_Gold_Round_Add
      expEft.value_min = count
      expEft.value_max = count
      self:AddRelicEft(expEft)
    end)
    while wait do
      if not self._valid then
        return
      end
      YIELD(TT)
    end
  end
  if reason == SMazeRelicReason.ChooseRelicLastTime then
    if self._stateID == SMazeStateID.ChooseRelic then
      local state = self
      state:Finish()
    else
      Log.exception("选圣物状态错误:", self._stateID)
    end
    return
  end
  local cpt = self._manager:GetMazeComponent()
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_BreakPet then
    self:_Log("选完圣物选择满破星灵")
    self._machine:ChangeStateTo(SMazeState_ChooseFullPet)
    return
  elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
    self:_Log("选完圣物升级了")
    self._machine:ChangeStateTo(SMazeState_Levelup)
    return
  elseif reason == SMazeRelicReason.Box then
    if self._stateID == SMazeStateID.RoomSettle then
      local state = self
      state:SettleFinish(state:CurRoom())
    else
      Log.exception("选圣物状态错误:", self._stateID)
    end
    return
  end
  self:_Log("圣物表现完成 当前状态:", cpt:CurOperate())
end

function SMazeStateBase:AddRelicEft(eft)
  self._machine:_AddRelicEft(eft)
end

function SMazeStateBase:GetAndClearRelicAssets()
  return self._machine:_GetAndClearRelicAssets()
end

function SMazeStateBase:PlayAssetToast(TT, assets)
  if assets and 0 < #assets then
    for _, asset in ipairs(assets) do
      if asset:Type() == SeasonMazeEffectType.SMET_Pro then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, asset:SubParam())
      end
    end
    local toastAssets = self:_FilterToastAssets(assets)
    self._manager:PlayToast(toastAssets)
  end
  local relicAssets = self:GetAndClearRelicAssets()
  if relicAssets and 0 < #relicAssets then
    for _, asset in ipairs(relicAssets) do
      if asset:Type() == SeasonMazeEffectType.SMET_Pro then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, asset:SubParam())
      end
    end
    SeasonMazeTool:GetInstance():SortAsset(relicAssets)
    local log = ""
    for _, asset in ipairs(relicAssets) do
      local name = asset:Name() or "未知名称"
      local count = asset:Count() or 0
      log = log .. name .. ":" .. count .. ","
    end
    self:_Log("播放圣物表现:", self._stateID, log)
    local toastAssets = self:_FilterToastAssets(relicAssets)
    self._manager:PlayToast(toastAssets)
  else
    self:_Log("无圣物奖励:", self._stateID)
  end
end

function SMazeStateBase:_FilterToastAssets(assets)
  local retAssets = {}
  if assets and 0 < #assets then
    for index, asset in ipairs(assets) do
      if asset:Type() == SeasonMazeEffectType.SMET_Relic or asset:Type() == SeasonMazeEffectType.SMET_Bead or asset:Type() == SeasonMazeEffectType.SMET_Bead_LV or asset:Type() == SeasonMazeEffectType.SMET_RandomRelic then
      else
        table.insert(retAssets, asset)
      end
    end
  end
  return retAssets
end

function SMazeStateBase:GetNodeState(node)
  local svrData = self._manager:GetMazeComponent():GetComponentInfo().rooms[node:ID()]
  if svrData then
    return svrData.state
  end
end
