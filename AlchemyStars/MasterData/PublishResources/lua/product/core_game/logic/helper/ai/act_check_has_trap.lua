require("ai_node_new")
_class("ActionCheckHasTrap", AINewNode)
ActionCheckHasTrap = ActionCheckHasTrap

function ActionCheckHasTrap:InitializeNode(cfg, context, parentNode, configData)
  ActionCheckHasTrap.super.InitializeNode(self, cfg, context, parentNode, configData)
  self._trapID = configData[1]
end

function ActionCheckHasTrap:OnUpdate()
  local trapLogicSvc = self._world:GetService("TrapLogic")
  local trapPosList = trapLogicSvc:FindTrapPosByTrapID(self._trapID)
  if 0 < #trapPosList then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
