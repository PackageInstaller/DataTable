local this = {}
local _multiDungeonTpl = L_GameTpl:getMultiDungeonTpl()
local WaitTime = L_GameConstTpl:getData("MULIT_DUNGEON_FRIEND_READYTIME", L_Const.GameTplType.int)

function this:initMultiDungeonInvite()
  self._txtContent = L_GameUtil.findTranByName(self.multiDungeonInviteRoot.gameObject, "txt_content"):GetComponent(typeof(C_LTextMeshProUGUI))
  self._txtCountdown = L_GameUtil.findTranByName(self.multiDungeonInviteRoot.gameObject, "txt_countdown"):GetComponent(typeof(C_LTextMeshProUGUI))
  self._btnAccept = L_GameUtil.findTranByName(self.multiDungeonInviteRoot.gameObject, "btn_accept"):GetComponent(typeof(C_LButton))
  self._btnRefuse = L_GameUtil.findTranByName(self.multiDungeonInviteRoot.gameObject, "btn_refuse"):GetComponent(typeof(C_LButton))
  self._canvasGroup = self.multiDungeonInviteRoot:GetComponent(typeof(Unity.CanvasGroup))
  self._customTween = self.multiDungeonInviteRoot:GetComponent(typeof(C_LCustomTween))
  self._acceptCallback = handler(self, self.onClick_accept)
  self._refuseCallback = handler(self, self.onClick_refuse)
  self._btnAccept.onClick:RemoveAllListeners()
  self._btnAccept.onClick:AddListener(self._acceptCallback)
  self._btnRefuse.onClick:RemoveAllListeners()
  self._btnRefuse.onClick:AddListener(self._refuseCallback)
  self.multiDungeonInviteRoot.gameObject:ActiveTrans(false)
end

function this:showMultiDungeonInvite()
  local inviteData = L_MultiDungeonStore:getMatchTeamInviteData()
  local startTime = inviteData.start_time
  self._multiDungeonInviteEndTime = startTime + WaitTime
  local nowTime = L_TimeUtil.getServerTime()
  if nowTime >= self._multiDungeonInviteEndTime then
    return
  end
  self:setMultiDungeonShow(true)
  self:refreshMultiDungeonView()
  self._refreshMultiDungeonInviteCountdownHandle = self._refreshMultiDungeonInviteCountdownHandle or handler(self, self.refreshMultiDungeonCountdown)
  L_TimerManager:newOrResetTimer(self.multiDungeonInviteRoot, "showMultiDungeonInvite", self._refreshMultiDungeonInviteCountdownHandle, 0.5, -1)
  self:refreshMultiDungeonCountdown()
end

function this:setMultiDungeonShow(show, callback)
  if show then
    self.multiDungeonInviteRoot.gameObject:ActiveTrans(true)
  end
  local startValue = show and 0 or 1
  local endValue = show and 1 or 0
  self._canvasGroup.alpha = startValue
  self._customTween:DOFade_NoGCAlloc(self._canvasGroup, endValue, 0.5, function()
    if not show then
      self.multiDungeonInviteRoot.gameObject:ActiveTrans(false)
    end
    if callback then
      callback()
    end
  end)
end

function this:refreshMultiDungeonView()
  local inviteData = L_MultiDungeonStore:getMatchTeamInviteData()
  self._txtContent.text = ""
  L_FriendManager:requestBaseInfo({
    L_Const.PlayerBasicQueryType.PBQT_NAME
  }, {
    inviteData.pid
  }, function()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(inviteData.pid)
    local tpl_dungeon = _multiDungeonTpl:getTplById(inviteData.dungeon_id)
    self._txtContent.text = L_Lang:getFormatLangString(L_WordsTpl:getRawValue("ui_flyMsgManager"), L_FriendStore:getPlayerName(baseInfo), _multiDungeonTpl:getName(tpl_dungeon))
  end)
end

function this:onClick_accept()
  L_TimerManager:stopTimer(self.multiDungeonInviteRoot, "showMultiDungeonInvite")
  L_MultiDungeonManager:replyInvite(true)
  self:setMultiDungeonShow(false)
end

function this:onClick_refuse()
  L_TimerManager:stopTimer(self.multiDungeonInviteRoot, "showMultiDungeonInvite")
  L_MultiDungeonManager:replyInvite(false)
  self:setMultiDungeonShow(false)
end

function this:refreshMultiDungeonCountdown()
  local nowTime = L_TimeUtil.getServerTime()
  self._txtCountdown.text = string.format("%d", self._multiDungeonInviteEndTime - nowTime)
  if nowTime >= self._multiDungeonInviteEndTime then
    self:setMultiDungeonShow(false)
    L_TimerManager:stopTimer(self.multiDungeonInviteRoot, "showMultiDungeonInvite")
  end
end

function this:disposeMultiDungeonInvite()
  L_TimerManager:clearTimer(self.multiDungeonInviteRoot)
  self._txtContent = nil
  self._txtCountdown = nil
  self._btnAccept = nil
  self._btnRefuse = nil
  self._canvasGroup = nil
  self._customTween = nil
  self._acceptCallback = nil
  self._refuseCallback = nil
end

return this
