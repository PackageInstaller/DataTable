local BaseFloor = require("Game.Adventure.MainlineLevel.PrologueFloor.BasePrologueFloor")
local BattleFloor = class("BattleFloor", BaseFloor)
BattleFloor._mapEventConfig = {
  InteractiveNpc = "OnEvent_InteractiveNpc",
  InteractiveBoxGet = "OnEvent_InteractiveBoxGet"
}

function BattleFloor:OnEvent_InteractiveNpc(nNpcId, nNpcUid)
  local mapNpc = ConfigTable.GetData("NPC", nNpcId)
  if mapNpc == nil then
    print("NPC不存在" .. nNpcId)
    return
  end
  if mapNpc.type ~= GameEnum.npcType.PrologueReward then
    return
  end
  self.parent:GetRewardNpc(nNpcId, nNpcUid)
end

function BattleFloor:OnEvent_InteractiveBox(nBoxId, _, _, _)
  self.parent:GetRewardBox(nBoxId)
end

return BattleFloor
