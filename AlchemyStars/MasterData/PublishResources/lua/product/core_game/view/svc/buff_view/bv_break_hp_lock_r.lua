_class("BuffViewBreakHPLock", BuffViewBase)
BuffViewBreakHPLock = BuffViewBreakHPLock

function BuffViewBreakHPLock:PlayView(TT)
  local param = self._viewInstance:BuffConfigData():GetViewParams()
  local skillID = param.SkillID
  local skillHolder = self:Entity()
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(playSkillSvc._SkillRoutineTask, playSkillSvc, skillHolder, skillPhaseArray, skillID)
  local previewEntity = self._world:GetPreviewEntity()
  local renderState = previewEntity:RenderState()
  if not renderState then
    previewEntity:AddRenderState()
    renderState = previewEntity:RenderState()
  end
  renderState:SetRenderStateAndParam(RenderStateType.WaitPlayTask, taskID)
end
