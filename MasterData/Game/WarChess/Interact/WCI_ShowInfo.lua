local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_ShowInfo = class("WCI_ShowInfo", base)

function WCI_ShowInfo:ctor()
  self.needWalk = false
end

function WCI_ShowInfo:WCActPlay()
  local interactentityData = self.interactCtrl:GetCurInteractData()
  if interactentityData == nil then
    error("show info interactentityData not exist")
    base.WCActOver(self, false)
    return
  end
  local isGrid = self.interactCtrl:GetCurIsGrid()
  local isMonster = false
  if not isGrid then
    isMonster = interactentityData:GetEntityIsMonster()
  end
  if isMonster then
    self.wcCtrl.mapCtrl:TryShowWCMonsterCouldMoveRange(true, interactentityData)
    local battleRoomID = interactentityData:GetBattleRoomID()
    local worldPos = self.interactCtrl:GetCurInteractPos()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessMonsterDetail, function(win)
      if win == nil then
        return
      end
      win:InitWCIntro(battleRoomID, worldPos, function()
        self.wcCtrl.mapCtrl:TryShowWCMonsterCouldMoveRange(false)
      end)
    end)
  else
    local pms = self.interactCtrl:GetCurInteractPMS()
    if pms == nil or pms[1] == nil then
      error("show info desId not exist")
      base.WCActOver(self, false)
      return
    end
    local desId = pms[1]
    local worldPos = self.interactCtrl:GetCurInteractPos()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessObjDetail, function(win)
      if win == nil then
        return
      end
      win:InitWCIntro(desId, worldPos, function()
      end)
    end)
  end
  base.WCActOver(self, true)
end

function WCI_ShowInfo:PlayWCActOverAudio()
  AudioManager:PlayAudioById(1234)
end

return WCI_ShowInfo
