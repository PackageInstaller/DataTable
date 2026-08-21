require("ai_node_new")
_class("ActionMoveGroupAllStepEnd", AINewNode)
ActionMoveGroupAllStepEnd = ActionMoveGroupAllStepEnd

function ActionMoveGroupAllStepEnd:OnBegin()
  self:GetAllGroupMonster()
  if #self._sameGroupMonsterList > 0 then
    for i, monster in ipairs(self._sameGroupMonsterList) do
      local aiCmpt = monster:AI()
      if aiCmpt then
        if self.m_entityOwn:GetID() == monster:GetID() then
          aiCmpt:ClearMobilityTotal()
          aiCmpt:SetMoveState(AIMoveState.MoveEnd)
          self:PrintLog("GroupID:", self:GetMonsterGroupID(), "本组移动结束 强制结束，清空本组行动力")
        elseif aiCmpt:GetMobilityValid() > 1 then
          aiCmpt:SetMobilityTotal(1)
        end
      end
    end
  else
    local aiCmpt = self.m_entityOwn:AI()
    if aiCmpt then
      aiCmpt:ClearMobilityTotal()
      aiCmpt:SetMoveState(AIMoveState.MoveEnd)
      self:PrintLog(" 强制结束，清空行动力")
    end
  end
end
