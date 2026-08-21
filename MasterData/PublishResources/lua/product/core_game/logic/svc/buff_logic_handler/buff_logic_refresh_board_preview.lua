_class("BuffLogicRefreshBoardPreview", BuffLogicBase)
BuffLogicRefreshBoardPreview = BuffLogicRefreshBoardPreview

function BuffLogicRefreshBoardPreview:Constructor(buffInstance, logicParam)
end

function BuffLogicRefreshBoardPreview:DoLogic()
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end
