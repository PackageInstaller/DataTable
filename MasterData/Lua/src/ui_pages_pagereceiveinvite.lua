local page = class("pageReceiveInvite", G_UIPageBase)
local tag = "page:pageReceiveInvite"
local _wordsTpl = L_GameTpl:getWordsTpl()
page.data = {teamId = 0, id = 0}

function page.bind()
  return {nameText = nil, information = nil}
end

function page.methods()
  return {
    refuseOnClick = function(self)
      local data = {}
      data.u32 = self.data.id
      L_UI:close("pageReceiveInvite")
      L_Net:sendMessage(MsgGenCode.CSProtoBattleGroupInviteRefuse, data, function(rsp_data, errorCode)
      end)
    end,
    joinOnClick = function(self)
      if not self:curentScene() then
        L_FlyMsgManager:showNormalMsg(_wordsTpl:getTplById("notice_multiplayer_cannotJoin"))
        return
      end
      local page = L_UI:getPage("pageFormTeam")
      if page then
        page.cls:inviteJoinSet(self.data.teamId)
      end
      L_UI:close("pageReceiveInvite")
    end
  }
end

function page:preOpen(options)
  local data = require("ui/pages/pageFormTeam").new()
  if data.data.formTeam ~= nil then
    local currentDifficulty, currentGamePlay
    for key, value in pairs(data.data.formTeam) do
      if value.id == options.dungeon_id then
        currentDifficulty = L_Config:getConfigDirectly("multiplayer_battle", key, "difficultyName", true)
        currentGamePlay = L_Config:getConfigDirectly("multiplayer_battle", key, "typeName", true)
      end
    end
    self.bind.nameText = L_WordsTpl:getValue("ui_pageReceiveInvite", {
      [0] = options.name
    })
    self.data.teamId = options.guid
    self.data.id = options.plid
    self.bind.information = string.format("%s  %s", currentGamePlay, currentDifficulty)
  end
end

function page:curentScene()
  return false
end

return page
