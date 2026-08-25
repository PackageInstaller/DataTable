local TaskDispatchController = NewClass("TaskDispatchController", BaseController)

function TaskDispatchController:OnInit()
end

function TaskDispatchController:OnReset()
end

function TaskDispatchController:OnOpenDispatchView()
  UIManager.Instance:Reopen(Urls.TaskDispatchView)
end

return TaskDispatchController
