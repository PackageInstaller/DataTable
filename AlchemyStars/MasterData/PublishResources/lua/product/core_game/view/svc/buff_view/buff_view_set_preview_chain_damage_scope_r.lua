_class("BuffViewSetPreviewChainDamageScope", BuffViewBase)
BuffViewSetPreviewChainDamageScope = BuffViewSetPreviewChainDamageScope

function BuffViewSetPreviewChainDamageScope:PlayView(TT)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  local skillID = result:GetSkillID()
  local reBoard = self._world:GetRenderBoardEntity()
  local chainPreviewMonsterBehaviorCmpt = reBoard:ChainPreviewMonsterBehavior()
  if chainPreviewMonsterBehaviorCmpt then
    chainPreviewMonsterBehaviorCmpt:SetPreviewMonsterRange(entityID, skillID)
  end
end

function BuffViewSetPreviewChainDamageScope:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end
