require("buff_logic_base")
_class("BuffLogicSMCostHPAddCoin", BuffLogicBase)
BuffLogicSMCostHPAddCoin = BuffLogicSMCostHPAddCoin

function BuffLogicSMCostHPAddCoin:Constructor(buffInstance, logicParam)
  self._damageParam = logicParam
  self._addCoin = logicParam.addCoin
end

function BuffLogicSMCostHPAddCoin:DoLogic(notify)
  local casterEntity = self._buffInstance:Entity()
  local attrCmpt = casterEntity:Attributes()
  local curHP = attrCmpt:GetCurrentHP()
  if curHP <= self._damageParam.fixedDamage then
    return
  end
  local buffSvc = self._world:GetService("BuffLogic")
  local damageInfo = buffSvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, casterEntity, self._damageParam)
  local seasonMazeSvc = self._world:GetService("SeasonMaze")
  if seasonMazeSvc then
    seasonMazeSvc:AddRewardGoldCoin(self._addCoin)
  end
  local buffResult = BuffResultDamage:New(damageInfo)
  return buffResult
end

function BuffLogicSMCostHPAddCoin:DoOverlap()
  return self:DoLogic()
end
