local this = class("cellEntrustPlayerInfo", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_level = "",
    img_headIcon = "",
    txt_sign = "",
    active_btn_invite = true,
    active_btn_inviteWait = false,
    active_btn_pass = false,
    active_btn_refuse = false,
    txt_waitTime = "",
    txt_noSignName = "",
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    }
  }
end

function this.methods()
  return {
    onClick_head = function(self)
    end,
    onClick_invite = function(self)
      if self.bind.action and not self.bind.action() then
        return
      end
      C_MultiTeam.StartTimer("Invite" .. tostring(self.bind.uid), 1, nil, 30, 30, false, true)
      self.initTime = 30
      self._onEvent_WaitTimerHandle = self._onEvent_WaitTimerHandle or handler(self, self.onWaitTimer)
      C_MultiTeam.AddEventTimer("Invite" .. tostring(self.bind.uid), self._onEvent_WaitTimerHandle)
      self.bind.active_btn_invite = false
      self.bind.active_btn_inviteWait = true
    end,
    onClick_inviteWait = function(self)
      if self.initTime ~= nil then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_multiplayer_tips", {
          [0] = self.initTime
        }))
      end
    end,
    onClick_pass = function(self)
    end,
    onClick_refuse = function(self)
    end
  }
end

function this:open()
  local isCD = C_MultiTeam.IsExitTimer("Invite" .. tostring(self.bind.uid))
  self.bind.active_btn_invite = not isCD
  self.bind.active_btn_inviteWait = isCD
  if isCD then
    self._onEvent_WaitTimerHandle = self._onEvent_WaitTimerHandle or handler(self, self.onWaitTimer)
    C_MultiTeam.AddEventTimer("Invite" .. tostring(self.bind.uid), self._onEvent_WaitTimerHandle)
  end
  self.modules.cellHeadPic:setInfoByPlayerId(self.bind.uid)
  self.bindComponents.go_sign.gameObject:SetActive(not self.bind.sign_empty)
  self.bindComponents.go_noSign.gameObject:SetActive(self.bind.sign_empty)
  self.bind.txt_noSignName = L_WordsTpl:getValue("residual_code_cellfriendchatinfo_02")
end

function this:onWaitTimer(time)
  self.initTime = math.floor(time)
  if time <= 1 then
    self.bind.active_btn_invite = true
    self.bind.active_btn_inviteWait = false
  end
  self.bind.txt_waitTime = L_WordsTpl:getValue("residual_code_cellentrustplayerinfo_03") .. tostring(time)
end

function this:openTickTimer()
  if not self.initTime then
    self.initTime = 30
  end
  
  local function func()
    self.initTime = self.initTime - 1
    if self.initTime > 0 then
      self.bind.active_btn_invite = false
      self.bind.active_btn_inviteWait = true
      self.bind.txt_waitTime = L_WordsTpl:getValue(L_WordsTpl:getValue("residual_code_cellentrustplayerinfo_03") .. self.initTime)
    else
      self.bind.active_btn_invite = true
      self.bind.active_btn_inviteWait = false
      L_TimerManager:clearTimer(self)
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "inviteWait", func, 1, -1)
  func()
end

function this:refresh()
end

function this:close(options)
  L_TimerManager:clearTimer(self)
  if self._onEvent_WaitTimerHandle ~= nil then
    C_MultiTeam.RemoveEventTimer("Invite" .. tostring(self.bind.uid), self._onEvent_WaitTimerHandle)
  end
end

return this
