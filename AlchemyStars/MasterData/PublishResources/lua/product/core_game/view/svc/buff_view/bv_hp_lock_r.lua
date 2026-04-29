_class("BuffViewHPLock", BuffViewBase)
BuffViewHPLock = BuffViewHPLock

function BuffViewHPLock:PlayView(TT)
  local result = self:GetBuffResult()
  local index = result:GetLockIndex()
  local param = self._viewInstance:BuffConfigData():GetViewParams()
  local skillID
  for k, v in pairs(param) do
    if v.index == index then
      skillID = v.SkillID
      break
    end
  end
  local skillHolder = self:Entity()
  local playSkillSvc = self._world:GetService("PlaySkill")
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID, skillHolder)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    playSkillSvc:_SkillRoutineTask(TT, skillHolder, skillPhaseArray, skillID)
  end)
  local previewEntity = self._world:GetPreviewEntity()
  local renderState = previewEntity:RenderState()
  if not renderState then
    previewEntity:AddRenderState()
    renderState = previewEntity:RenderState()
  end
  renderState:SetRenderStateAndParam(RenderStateType.WaitPlayTask, taskID)
end
