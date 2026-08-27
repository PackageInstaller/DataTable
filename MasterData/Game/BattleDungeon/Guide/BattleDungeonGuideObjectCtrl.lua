local BattleDungeonObjectCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonObjectCtrl")
local BattleDungeonGuideObjectCtrl = class("BattleDungeonGuideObjectCtrl", BattleDungeonObjectCtrl)

function BattleDungeonGuideObjectCtrl:ctor(bdCtrl, guideType)
  self.guideType = guideType
end

function BattleDungeonGuideObjectCtrl:DungeonOverRewardsLogic(rewardMsg)
  if self.guideType == 2 then
    self.battleWin = rewardMsg.result
    self.dontShowResult = true
  else
    BattleDungeonObjectCtrl.DungeonOverRewardsLogic(self, rewardMsg)
  end
end

return BattleDungeonGuideObjectCtrl
