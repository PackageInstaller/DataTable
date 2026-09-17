local this = class("modulePlayerReady", G_UIModuleBase)

function this.bind()
  return {
    selectTab = -1,
    active_root = false,
    toggle_ready = false,
    text_changeFormation = "",
    text_changeMap = "",
    text_changeMode = ""
  }
end

function this.methods()
  return {}
end

function this:initModule(tabId, playerId)
  self.playerId = playerId
  self.isPlayerSelf = playerId == L_PlayerStore:getPlayerId()
  self.bind.active_root = true
  self.bind.text_changeFormation = L_WordsTpl:getValue("ui_kiboDuel_21")
  self.bind.text_changeMap = L_WordsTpl:getValue("ui_kiboDuel_23")
  self.bind.text_changeMode = L_WordsTpl:getValue("ui_kiboDuel_21")
  self:setPlayerState(tabId)
end

function this:setReady(isReady)
  self.bind.toggle_ready = isReady
end

function this:setStateTab(tabId)
  if tabId == L_PetConst.PetDuelPlayerState.unReady then
    self.bind.selectTab = L_PetConst.PetDuelPlayerState.Ready
    if self.tabId == L_PetConst.PetDuelPlayerState.Ready then
      if self.isPlayerSelf then
        C_PetDuelArenaManager.ReqTeamV2Prepare(true)
        L_AudioUtil.playSound("Play_SFX_System_QiboBattle_18_BattleReady_Out_You")
      else
        L_AudioUtil.playSound("Play_SFX_System_QiboBattle_17_BattleReady_Out_Opponent")
      end
    end
  elseif tabId == L_PetConst.PetDuelPlayerState.Ready then
    self.bind.selectTab = tabId
    if self.tabId == L_PetConst.PetDuelPlayerState.unReady then
      if self.isPlayerSelf then
        C_PetDuelArenaManager.ReqTeamV2Prepare(false)
        L_AudioUtil.playSound("Play_SFX_System_QiboBattle_16_BattleReady_In_You")
      else
        L_AudioUtil.playSound("Play_SFX_System_QiboBattle_15_BattleReady_In_Opponent")
      end
    end
  else
    if not self.isPlayerSelf then
      L_AudioUtil.playSound("Play_SFX_System_QiboBattle_19_EditorReady_In_Opponent")
    end
    self.bind.selectTab = tabId
  end
  if self.tabId ~= tabId then
    self.tabId = tabId
    if self.isPlayerSelf then
      C_PetDuelArenaManager.ReqChangeUIStatus(self.playerId, tabId)
    end
  end
end

function this:setPlayerState(state)
  if self.curState == state then
    return
  end
  
  local function stateIn()
    self:setStateTab(state)
    self.curState = state
    if self.curState == L_PetConst.PetDuelPlayerState.Ready then
      self.bindComponents.readyAnimation:Play("anim_toggle_ready_on_in")
    elseif self.curState == L_PetConst.PetDuelPlayerState.unReady then
      self.bindComponents.readyAnimation:Play("anim_toggle_ready_off_in")
    elseif self.curState == L_PetConst.PetDuelPlayerState.Formation then
      self.bindComponents.petEditAnimation:Play("anim_state_changeFormation_in")
    elseif self.curState == L_PetConst.PetDuelPlayerState.MapEdit then
      self.bindComponents.mapEditAnimation:Play("anim_state_changeMap_in")
    elseif self.curState == L_PetConst.PetDuelPlayerState.ModeEdit then
      self.bindComponents.heroEditAnimation:Play("anim_state_changeMode_in")
    end
  end
  
  if self.curState ~= nil then
    if self.curState == L_PetConst.PetDuelPlayerState.Ready then
      self.bindComponents.readyAnimation:Play("anim_toggle_ready_on_out")
      Timer.once(0.12, function()
        stateIn()
      end, self, self.gameObject)
    elseif self.curState == L_PetConst.PetDuelPlayerState.unReady then
      self.bindComponents.readyAnimation:Play("anim_toggle_ready_off_out")
      Timer.once(0.12, function()
        stateIn()
      end, self, self.gameObject)
    elseif self.curState == L_PetConst.PetDuelPlayerState.Formation then
      self.bindComponents.petEditAnimation:Play("anim_state_changeFormation_out")
      Timer.once(0.12, function()
        stateIn()
      end, self, self.gameObject)
    elseif self.curState == L_PetConst.PetDuelPlayerState.MapEdit then
      self.bindComponents.mapEditAnimation:Play("anim_state_changeMap_out")
      Timer.once(0.12, function()
        stateIn()
      end, self, self.gameObject)
    elseif self.curState == L_PetConst.PetDuelPlayerState.ModeEdit then
      self.bindComponents.heroEditAnimation:Play("anim_state_changeMode_out")
      Timer.once(0.12, function()
        stateIn()
      end, self, self.gameObject)
    end
  else
    stateIn()
  end
end

return this
