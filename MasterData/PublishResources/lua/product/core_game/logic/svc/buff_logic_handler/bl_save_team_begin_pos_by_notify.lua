_class("BuffLogicSaveTeamBeginPosByNotify", BuffLogicBase)
BuffLogicSaveTeamBeginPosByNotify = BuffLogicSaveTeamBeginPosByNotify

function BuffLogicSaveTeamBeginPosByNotify:Constructor(buffInstance, logicParam)
  self._skillEffectList = logicParam.skillEffectList or {}
  self._validParentNotifyType = logicParam.validParentNotifyType or {}
end

function BuffLogicSaveTeamBeginPosByNotify:DoLogic(notify)
  local pos
  if notify:GetNotifyType() == NotifyType.EntityMoveEnd and table.intable(self._validParentNotifyType, notify:GetParentNotifyType()) then
    pos = notify:GetPosOld()
    local convertInfoArray = notify:GetConvertInfoArray()
    local convertInfo = convertInfoArray[1]
    pos = convertInfo:GetPos()
  end
  if notify:GetNotifyType() == NotifyType.Teleport then
    pos = notify:GetPosOld()
  end
  if notify:GetNotifyType() == NotifyType.AfterPieceRefreshBeginChainSkill and 1 < notify:GetChainPathCount() then
    pos = notify:GetBeginPos()
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  teamEntity:BuffComponent():SetBuffValue("SaveTeamBeginPos", pos)
end
