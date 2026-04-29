_class("UISeasonTaskListController", UIController)
UISeasonTaskListController = UISeasonTaskListController

function UISeasonTaskListController:LoadDataOnEnter(TT, res, uiParams)
end

function UISeasonTaskListController:OnShow(uiParams)
  local className, prefabName = UISeasonHelper.GetCurSeasonTaskList("Content")
  if not string.isnullorempty(className) then
    local function closeFunc()
      self:CloseDialog()
    end
    
    local obj = UIWidgetHelper.SpawnObject(self, "_pool", className, prefabName)
    obj:SetData({closeCallback = closeFunc})
  else
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    if not seasonModule:IsOpen() then
      seasonModule.uiModule:ExitSeasonTo(UIStateType.UIMain)
    end
  end
end

function UISeasonTaskListController:OnHide()
end
