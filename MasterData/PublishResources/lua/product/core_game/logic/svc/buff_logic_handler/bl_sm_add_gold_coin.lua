require("buff_logic_base")
_class("BuffLogicSMAddGoldCoin", BuffLogicBase)
BuffLogicSMAddGoldCoin = BuffLogicSMAddGoldCoin

function BuffLogicSMAddGoldCoin:Constructor(buffInstance, logicParam)
  self._addCoin = logicParam.addCoin
end

function BuffLogicSMAddGoldCoin:DoLogic(notify)
  local seasonMazeSvc = self._world:GetService("SeasonMaze")
  if seasonMazeSvc then
    seasonMazeSvc:AddRewardGoldCoin(self._addCoin)
  end
end

function BuffLogicSMAddGoldCoin:DoOverlap()
  return self:DoLogic()
end
