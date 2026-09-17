local this = class("teamChannelData", require(L_R.store .. "chat.data.chatChannelBaseData"))

function this:ctor(channelDataList)
  local channelType = L_Const.chatType.team
  self.init(self, channelType, channelDataList)
end

function this:getRefreshEventId()
  return L_ChatStore.event.refreshCurrentTeamChannelId
end

function this:getRedDotEnum()
  return L_ReddotManager.DotDef.FriendChannelTeamChat
end

function this:getInitChannelChatCD()
  return L_GameTpl:getGameConstTpl():getTeamChatCD()
end

function this:onRoomSync(sysId)
  if AzurWorldInstance.inGame and sysId == self.channelId then
    return
  end
  self.super.onRoomSync(self, sysId)
end

function this:syncChannelConversation(chat)
  if C_MultiTeam.IsInMultiTeam() and not C_MultiTeam.IsTeamMember(chat.player_id) then
    return
  end
  self.super.syncChannelConversation(self, chat)
end

function this:getCurrentChannelId()
  if C_MultiTeam.IsInMultiTeam() then
    return L_MultiDungeonStore:getMatchTeamData().team_id
  end
  if CS.Lens.Gameplay.UI.TeamMatchStore.GetStore().Beh:IsCreateSTeamed() then
    return CS.Lens.Gameplay.UI.TeamMatchStore.GetStore().Beh.CurTeam.teamId
  end
  return 0
end

function this:getChannelActive()
  return C_MultiTeam.IsInMultiTeam() or CS.Lens.Gameplay.UI.TeamMatchStore.GetStore().Beh:IsCreateSTeamed()
end

return this
