_class("BuffLogicCloseAuroraTime", BuffLogicBase)
BuffLogicCloseAuroraTime = BuffLogicCloseAuroraTime

function BuffLogicCloseAuroraTime:Constructor(buffInstance, logicParam)
end

function BuffLogicCloseAuroraTime:DoLogic()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local com = teamEntity:BuffComponent()
  if com then
    com:SetBuffValue("CloseAuroraTime", true)
  end
end

_class("BuffLogicRevertCloseAuroraTime", BuffLogicBase)
BuffLogicRevertCloseAuroraTime = BuffLogicRevertCloseAuroraTime

function BuffLogicRevertCloseAuroraTime:Constructor(buffInstance, logicParam)
end

function BuffLogicRevertCloseAuroraTime:DoLogic()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local com = teamEntity:BuffComponent()
  if com then
    com:SetBuffValue("CloseAuroraTime", nil)
  end
end
