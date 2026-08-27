local WarChessSeasonUtil = class("WarChessSeasonUtil")

function WarChessSeasonUtil.OpenSeasonSaveWindow(callback)
  local uiWindowType = UIWindowTypeID.WCSSavingPanel_Common
  local addtionData = WarChessSeasonManager:GetSeasonAddtionData()
  if addtionData ~= nil and addtionData:GetSeasonSaveUIType() ~= nil then
    uiWindowType = addtionData:GetSeasonSaveUIType()
  end
  UIManager:ShowWindowAsync(uiWindowType, function(win)
    if win ~= nil then
      win:InitWCSSavePanel(function(index)
        WarChessSeasonManager:SaveWCSSavingData(index)
      end)
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessSeasonUtil.TryReplaceBattleRoomId(curBattleRoomId)
  if not WarChessSeasonManager:GetIsInWCSeason() then
    return curBattleRoomId
  end
  local seasonId = WarChessSeasonManager:GetWCSSeasonId()
  local towerId = WarChessSeasonManager:GetWCSSeasonTowerID()
  local envId = WarChessSeasonManager:GetWCSCtrl():GetWCEnvId()
  if seasonId ~= nil then
    local towerCfgDic = ConfigData.warchess_monster_change[seasonId]
    if towerCfgDic ~= nil and towerId ~= nil then
      local envCfgDic = towerCfgDic[towerId]
      if envCfgDic ~= nil and envId ~= nil then
        local roomIdCfgDic = envCfgDic[envId]
        if roomIdCfgDic ~= nil then
          local newRoomCfg = roomIdCfgDic[curBattleRoomId]
          if newRoomCfg ~= nil then
            return newRoomCfg.team_id_new
          end
        end
      end
    end
  end
  return curBattleRoomId
end

return WarChessSeasonUtil
