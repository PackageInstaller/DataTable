_class("StateBounceBase", State)
StateBounceBase = StateBounceBase

function StateBounceBase:Init()
  if not self.coreController then
    self.coreController = self.fsm:GetData()
    self.bounceData = self.coreController:GetData()
    self.uiController = self.coreController:GetUIController()
    self.monsterPool = self.coreController:GetMonsterPool()
    self.objMgr = self.coreController:GetObjMgr()
    self.monsterGenerator = self.coreController:GetMonsterGenerator()
  end
end

function StateBounceBase:GetPlayer()
  return self.objMgr.player
end

function StateBounceBase:Destroy()
end

function StateBounceBase:OnJump()
end

function StateBounceBase:OnAttack()
end
