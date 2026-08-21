require("monster_behavior_base")
_class("MonsterBeHaviorChgCampWhenAttacked", MonsterBeHaviorBase)
MonsterBeHaviorChgCampWhenAttacked = MonsterBeHaviorChgCampWhenAttacked

function MonsterBeHaviorChgCampWhenAttacked:Name()
  return "MonsterBeHaviorChgCampWhenAttacked"
end

function MonsterBeHaviorChgCampWhenAttacked:Exec()
  local monsterData = self:GetMonsterData()
  monsterData:ChgCamp()
  local coreController = self:GetCoreController()
  coreController:GetObjMgr():ChgMonsterCampToPlayer(self.monster)
end

function MonsterBeHaviorChgCampWhenAttacked:OnInit(param)
end

function MonsterBeHaviorChgCampWhenAttacked:OnShow()
end

function MonsterBeHaviorChgCampWhenAttacked:OnReset()
end

function MonsterBeHaviorChgCampWhenAttacked:OnRelease()
end
