_class("UIActivityN29NHardLevelNode", UIActivityNHardLevelNode)
UIActivityN29NHardLevelNode = UIActivityN29NHardLevelNode

function UIActivityN29NHardLevelNode:OnInit()
end

function UIActivityN29NHardLevelNode:GetLockTipsString()
  return "str_n27_hard_level_lock_tips"
end

function UIActivityN29NHardLevelNode:PlayAnimation()
  if self._isOpen and self._hasPass then
    self:StartTask(self.PlayAnimCoro, self)
  end
end

function UIActivityN29NHardLevelNode:PlayAnimCoro(TT)
  self._complete:SetActive(false)
  self:Lock("UIActivityN29NHardLevelNode_PlayAnimCoro")
  YIELD(TT, 120)
  self._complete:SetActive(true)
  self:UnLock("UIActivityN29NHardLevelNode_PlayAnimCoro")
end
