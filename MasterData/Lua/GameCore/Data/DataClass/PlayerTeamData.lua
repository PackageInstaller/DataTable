local PlayerTeamData = class("PlayerTeamData")

function PlayerTeamData:Init()
  self._tbTeam = nil
end

function PlayerTeamData:CacheFormationInfo(mapData)
  if mapData == nil then
    return
  end
  if self._tbTeam == nil then
    self._tbTeam = {}
    for i = 1, AllEnum.Const.MAX_TEAM_COUNT do
      self._tbTeam[i] = {
        nCaptainIndex = 0,
        tbTeamMemberId = {
          0,
          0,
          0
        },
        tbTeamDiscId = {
          0,
          0,
          0
        },
        nPreselectionId = 0
      }
    end
  end
  if mapData.Info ~= nil then
    for k, v in pairs(mapData.Info) do
      local nTeamId = v.Number
      local mapTeamData = self._tbTeam[nTeamId]
      if mapTeamData ~= nil then
        mapTeamData.nCaptainIndex = 1
      else
        mapTeamData = {
          nCaptainIndex = 1,
          tbTeamMemberId = {
            0,
            0,
            0
          },
          tbTeamDiscId = {
            0,
            0,
            0
          },
          nPreselectionId = 0
        }
      end
      for nIndex, nCharId in ipairs(v.CharIds) do
        mapTeamData.tbTeamMemberId[nIndex] = nCharId
      end
      for nIndex, nDiscId in ipairs(v.DiscIds) do
        mapTeamData.tbTeamDiscId[nIndex] = nDiscId
      end
      mapTeamData.nPreselectionId = v.PreselectionId
    end
  end
  if mapData.Record ~= nil then
    PlayerData.StarTower:CacheFormationInfo(mapData.Record)
  end
end

function PlayerTeamData:UpdateFormationInfo(nTeamId, tbCharIds, tbDiscIds, nPreselectionId, callback)
  local PlayerFormationReq = {}
  PlayerFormationReq.Formation = {}
  PlayerFormationReq.Formation.Number = nTeamId
  PlayerFormationReq.Formation.Captain = 1
  PlayerFormationReq.Formation.CharIds = tbCharIds
  PlayerFormationReq.Formation.DiscIds = tbDiscIds
  PlayerFormationReq.Formation.PreselectionId = nPreselectionId
  
  local function Callback()
    if self._tbTeam == nil then
      self._tbTeam = {}
    end
    local mapTeamData = self._tbTeam[nTeamId]
    mapTeamData.nCaptainIndex = 1
    for nIndex, nCharId in ipairs(tbCharIds) do
      mapTeamData.tbTeamMemberId[nIndex] = nCharId
    end
    if tbDiscIds then
      for nIndex, nDiscId in ipairs(tbDiscIds) do
        mapTeamData.tbTeamDiscId[nIndex] = nDiscId
      end
    end
    mapTeamData.nPreselectionId = nPreselectionId
    if callback ~= nil and type(callback) == "function" then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_formation_req, PlayerFormationReq, nil, Callback)
end

function PlayerTeamData:GetAllTeamData()
  return self._tbTeam
end

function PlayerTeamData:GetTeamData(nTeamId)
  if self._tbTeam == nil then
    return nil, nil
  end
  local mapTeamData = self._tbTeam[nTeamId]
  if mapTeamData ~= nil then
    return mapTeamData.nCaptainIndex, mapTeamData.tbTeamMemberId
  else
    return nil, nil
  end
end

function PlayerTeamData:GetTeamDiscData(nTeamId)
  if self._tbTeam == nil then
    return {
      0,
      0,
      0,
      0,
      0,
      0
    }
  end
  local mapTeamData = self._tbTeam[nTeamId]
  if mapTeamData ~= nil then
    return mapTeamData.tbTeamDiscId
  else
    return {
      0,
      0,
      0,
      0,
      0,
      0
    }
  end
end

function PlayerTeamData:GetTeamCharId(nTeamId)
  local mapTeamData = self._tbTeam[nTeamId]
  local tbCharId = {}
  if mapTeamData ~= nil then
    local nCaptainId = mapTeamData.tbTeamMemberId[mapTeamData.nCaptainIndex]
    table.insert(tbCharId, nCaptainId)
    for _nIdx, _nCharId in ipairs(mapTeamData.tbTeamMemberId) do
      if _nCharId ~= 0 and _nCharId ~= nCaptainId then
        table.insert(tbCharId, _nCharId)
      end
    end
  end
  return tbCharId
end

function PlayerTeamData:GetTeamPreselectionId(nTeamId)
  if self._tbTeam == nil then
    return 0
  end
  local mapTeamData = self._tbTeam[nTeamId]
  if mapTeamData ~= nil then
    return mapTeamData.nPreselectionId
  else
    return 0
  end
end

function PlayerTeamData:CheckTeamValid(nTeamId)
  if self._tbTeam == nil then
    return false
  end
  local mapTeam = self._tbTeam[nTeamId]
  if mapTeam == nil then
    return false
  elseif type(mapTeam.tbTeamMemberId) == "table" then
    for i, nCharId in ipairs(mapTeam.tbTeamMemberId) do
      if nCharId < 1 then
        return false
      end
    end
    return true
  else
    return false
  end
end

function PlayerTeamData:TempCreateRoguelikeTeam(tbTeamCharId)
  self._tbTeam = {}
  self._tbTeam[5] = {nCaptainIndex = 1, tbTeamMemberId = tbTeamCharId}
end

return PlayerTeamData
