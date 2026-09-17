local this = class("pageMultiCoopInviteTip", G_UIPageBase)
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillsubLogicTpl = L_GameTpl:getSkillsubLogicTpl()
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
local _nestcoopLevelTpl = L_GameTpl:getNestcoopLevelTpl()
local _dungeonTpl = L_GameTpl:getDungeonTpl()

function this.bind()
  return {
    list_friends = {
      moduleName = "pages/entrustTask/multiCoopTask/cellEntrustPlayerInfo"
    },
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    active_empty = false,
    txt_curTeamMemberTip = ""
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    },
    list_friends = {
      onClick_head = function(self, uid, position)
        local dropdowns = {
          L_DropdownsManager.option.viewInfo,
          L_DropdownsManager.option.visitHome,
          L_DropdownsManager.option.addRemarks,
          L_DropdownsManager.option.removeFriend,
          L_DropdownsManager.option.insertToBlackList,
          L_DropdownsManager.option.report
        }
        L_DropdownsManager:showPlayerDropdowns(position, dropdowns, uid)
      end,
      onClick_invite = function(self, uid)
      end,
      onClick_inviteWait = function(self, uid)
      end
    }
  }
end

function this:preOpen(options)
  options = options or {}
  self.pos = options.pos
  self.type = options.type
  L_FriendStore:listenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList, self)
  self:initCommonTipModule()
  self:initModule()
end

function this:close(options)
  L_FriendStore:unListenCallFunc(L_FriendStore.event.refreshIdList, self.onEvent_refreshIdList)
  this.super.close(self, options)
end

function this:initCommonTipModule()
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    hideConfirm = true,
    hideCancel = true,
    txtTitle = L_WordsTpl:getValue("residual_code_pagemulticoopinvitetip_01"),
    txtContent = ""
  })
end

function this:onEvent_refreshIdList()
  self:initModule()
end

function this:initModule()
  if self.type == 3 then
    self.type = 401
  end
  local dungeonId = C_MultiTeam.GetDungeonId()
  local levelId = 0
  if dungeonId ~= 0 then
    local levelTpl = _dungeonTpl:getTplById(dungeonId)
    if levelTpl ~= nil then
      levelId = _dungeonTpl:getgameplayID(levelTpl)
      if levelId == 0 then
        levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
      end
    end
  end
  L_FriendManager:requestCanInvitePlayerInfo(self.type, levelId, function()
    self:initFriendsList()
  end)
end

function this:getUnlockLv()
  local levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(C_MultiTeam.GetDungeonId())
  local cfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  local unlockCondition = _dungeonCrisisCrusadeTpl:getTaskUnlock(cfg)
  return unlockCondition[1][2] and unlockCondition[1][2] or 0
end

function this:initFriendsList()
  local tmp = {}
  local player = L_FriendStore:getFriendList()
  for i, v in pairs(player) do
    local baseInfo = L_FriendStore:getPlayerBaseInfo(v:getPlayerUid())
    if baseInfo and baseInfo.dungeon_unlock_list and #baseInfo.dungeon_unlock_list > 0 and baseInfo.dungeon_unlock_list[1].unlock then
      local player_uid = v:getPlayerUid()
      local isSignEmpty = false
      if (baseInfo.preffix_title == 0 or baseInfo.preffix_title == 171000) and (baseInfo.suffix_title == 0 or baseInfo.suffix_title == 172000) then
        isSignEmpty = true
      else
        isSignEmpty = false
      end
      table.insert(tmp, {
        uid = v:getPlayerUid(),
        txt_name = L_FriendManager:getFriendShowName(v:getPlayerUid()),
        txt_level = tostring(L_FriendStore:getPlayerLevel(baseInfo)),
        txt_sign = L_FriendStore:ParsePlayerTitle(baseInfo),
        sign_empty = isSignEmpty,
        action = function()
          if self.type == 2 then
            C_MultiTeamMgr:ReqInviteNestPlayer(player_uid, self.pos)
          elseif self.type == 1 then
            C_MultiTeam.InviteMember(player_uid, self.pos)
          else
            if C_MultiTeam.IsInMultiTeam() then
              L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_84"))
              return false
            end
            C_PetDuelArenaManager.ReqKiboArenaInvitePlayer(player_uid, 50000)
          end
          return true
        end
      })
    end
  end
  table.sort(tmp, function(a, b)
    local baseInfoA = L_FriendStore:getPlayerBaseInfo(a.uid)
    local baseInfoB = L_FriendStore:getPlayerBaseInfo(b.uid)
    local levelA = L_FriendStore:getPlayerLevel(baseInfoA)
    local levelB = L_FriendStore:getPlayerLevel(baseInfoB)
    if levelA ~= levelB then
      return levelA > levelB
    else
      return a.uid < b.uid
    end
  end)
  self.bind.active_empty = #tmp == 0
  self.bind.list_friends:clear()
  self.bind.list_friends:insert_array(tmp)
end

return this
