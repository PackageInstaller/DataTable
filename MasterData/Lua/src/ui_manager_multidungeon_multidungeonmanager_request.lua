local this = {}

function this:invitePlayer(pid, pos, isQuit)
  L_MultiDungeonStore:req_CSProtoInviteJoinMatchTeam(pid, pos, isQuit, function(rspData, errorCode)
    if not isQuit then
      if errorCode == L_Const.errorCode.ErrCodeSucc then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_fightTeam_15"))
      elseif errorCode == L_Const.errorCode.ErrCodeIsInMatchTeam then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_fightTeam_16"))
      end
    end
  end)
end

function this:replyInvite(isAccept)
  if self._isDealInvite then
    return
  end
  self._isDealInvite = true
  self:_stopAutoDealWithInviteTimer()
  L_MultiDungeonStore:req_CSProtoReplyInviteJoinMatchTeam(isAccept, function(rspData, errCode)
    if errCode == L_Const.errorCode.ErrCodeInviteMatchTeamExpired or errCode == L_Const.errorCode.ErrCodeNotInMatchTeam then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_fightTeam_17"))
    end
  end)
end

function this:leaveTeam()
  local data_tip = {
    txtContent = L_WordsTpl:getValue("notice_fightTeam_18"),
    confirmCallback = function()
      local matchStatus = L_MultiDungeonStore:getMatchStatus()
      if matchStatus == L_MultiDungeonConst.MatchStatus.Prepare then
        L_MultiDungeonStore:req_CSProtoLeaveMatchTeam()
      elseif matchStatus == L_MultiDungeonConst.MatchStatus.Matching then
        L_MultiDungeonStore:req_CSProtoStopMatch(function()
          L_MultiDungeonStore:req_CSProtoLeaveMatchTeam()
        end)
      elseif matchStatus == L_MultiDungeonConst.MatchStatus.Matched then
        self:readyMatch(false, function()
          L_MultiDungeonStore:req_CSProtoLeaveMatchTeam()
        end)
      end
    end
  }
  L_GameUtil.showCommonTip(data_tip)
end

function this:readyMatch(isReady, callback)
  if self._isDealReady then
    return
  end
  self._isDealReady = true
  self:_stopAutoDealWithReadyTimer()
  L_MultiDungeonStore:req_CSProtoMatchedReady(isReady, callback)
end

return this
