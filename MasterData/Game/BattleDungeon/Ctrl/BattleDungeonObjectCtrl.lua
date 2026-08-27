local BattleDungeonCtrlBase = require("Game.BattleDungeon.Ctrl.BattleDungeonCtrlBase")
local BattleDungeonObjectCtrl = class("BattleDungeonObjectCtrl", BattleDungeonCtrlBase)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")

function BattleDungeonObjectCtrl:ctor(bdCtrl)
  self.__overRewardLogic = BindCallback(self, self.DungeonOverRewardsLogic)
  self.bdCtrl:RegisterDungeonLogic(DungeonConst.LogicType.OverRewards, self.__overRewardLogic)
  self.__OnChipDataDiff = BindCallback(self, self.OnChipDataDiff)
  MsgCenter:AddListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
end

function BattleDungeonObjectCtrl:OnChipDataDiff(diffData)
  local chipDiff = diffData[proto_csmsg_AlgModule.AlgModuleDungeon]
  if chipDiff ~= nil then
    self.bdCtrl.dynPlayer:UpdateChipDiff(chipDiff)
    local roomData = self.bdCtrl:GetBattleRoom()
    if roomData ~= nil then
      roomData:RollbackAllPlayerChipForMonster(self.bdCtrl.dynPlayer)
      roomData:UpdateMonsterChip()
      if BattleUtil.IsInGuardBattle() then
        roomData:ExecuteDungeonRoleChip(self.bdCtrl.dynPlayer)
      end
    end
  end
end

function BattleDungeonObjectCtrl:DungeonOverRewardsLogic(rewardMsg)
  self.rewardMsg = rewardMsg
  if rewardMsg.result then
    BattleDungeonManager:SaveDungeonDeploy(self.bdCtrl.dynPlayer)
  end
end

function BattleDungeonObjectCtrl:OnDelete()
  self.bdCtrl:UnRegisterDungeonLogic(DungeonConst.LogicType.OverRewards, self.__overRewardLogic)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
end

return BattleDungeonObjectCtrl
