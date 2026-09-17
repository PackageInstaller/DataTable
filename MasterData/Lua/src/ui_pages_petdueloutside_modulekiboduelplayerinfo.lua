local this = class("moduleKiboDuelPlayerInfo", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_nameRank = "",
    txt_rankName = "",
    toggle_isRank = false,
    img_rankIcon = "",
    active_root = false
  }
end

function this.methods()
  return {}
end

function this:initModule_playerSelf(isPvp)
  self.bind.active_root = true
  self.bind.toggle_isRank = isPvp
  if not isPvp then
    self.bind.txt_name = L_PlayerStore:getPlayerName()
  else
    self.bind.txt_nameRank = L_PlayerStore:getPlayerName()
    local rank = C_PetDuelArenaManager:GetPlayerKiboArenaRank()
    self.bind.txt_rankName = C_PetDuelArenaManager.GetPlayerRankName(rank)
    self.bind.img_rankIcon = C_PetDuelArenaManager.GetPlayerRankIcon(rank)
  end
end

function this:refreshModule_player(baseInfo)
  self.bind.toggle_isRank = true
  self.bind.txt_nameRank = L_FriendStore:getPlayerName(baseInfo)
  self.bind.txt_rankName = C_PetDuelArenaManager.GetEnemyRankName()
  self.bind.img_rankIcon = C_PetDuelArenaManager.GetEnemyRankIcon()
end

function this:initModule_pvpEnemy(playerId)
  self.bind.active_root = true
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_LEVEL
  }
  local players = {}
  table.insert(players, playerId)
  L_FriendManager:requestBaseInfo(types, players, function()
    local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
    self:refreshModule_player(baseInfo)
  end)
end

function this:initModule_npcEnmey(levelId)
  self.bind.active_root = true
  self.bind.toggle_isRank = false
  local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
  local _worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()
  local tpl = _kiBoDuelTpl:getTplById(levelId)
  if not tpl then
    return
  end
  local npcSpawnerID = _kiBoDuelTpl:getNpcSpawnerID(tpl)
  local tpl_worldSpawner = _worldSpawnerTpl:getTplById(npcSpawnerID)
  self.bind.txt_name = _worldSpawnerTpl:getName(tpl_worldSpawner)
end

return this
