local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_LobbyDoorInfo = class("WCI_LobbyDoorInfo", base)

function WCI_LobbyDoorInfo:ctor()
  self.needWalk = false
end

function WCI_LobbyDoorInfo:WCActPlay()
  if WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    local datas = WarChessSeasonManager:GetWCSCtrl():WCSGetLobbyNextRoomDataMsg()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSeasonSelectLevel, function(win)
      if win == nil then
        return
      end
      win:InitWCSLevelInfo(datas)
      win:WCSPlayAniSelectLevel(false, nil, 1.25)
      self:WCActOver(true)
    end)
  end
end

return WCI_LobbyDoorInfo
