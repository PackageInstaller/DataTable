local this = class("conditionNode_2", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  L_EntityManager:addListener(L_EntityManager.event.destroyEntity, self.refresh, self)
  L_EntityManager:addListener(L_EntityManager.event.destroyAllEntity, self.refresh, self)
end

function this:onDestroy()
  this.super.onDestroy(self)
  L_EntityManager:removeListener(L_EntityManager.event.destroyEntity, self.refresh, self)
  L_EntityManager:removeListener(L_EntityManager.event.destroyAllEntity, self.refresh, self)
end

function this.checkFunc(condition)
  printf("大世界", "npc逻辑删除，请优化此代码逻辑")
  return false
end

return this
