local WorldStageOpeningAnim, Super = System.NewClass("WorldStageOpeningAnim", UIBasePanel)
WorldStageOpeningAnim.uiResCls = UI_Dbgcopy_WorldStageOpeningAnimResource

function WorldStageOpeningAnim:ctor()
  Super.ctor(self)
end

function WorldStageOpeningAnim:OnBind(binder)
  binder:BindTimer(5, 0, nil, function()
    self:Close()
  end)
end

return WorldStageOpeningAnim
