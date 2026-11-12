local UnchartedMapTaskPanel = class("UnchartedMapTaskPanel", BasePanel)
UnchartedMapTaskPanel._sUIResRootPath = "UI_Activity/"
UnchartedMapTaskPanel._tbDefine = {
  {
    sPrefabPath = "10113/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function UnchartedMapTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.FillAmount
  end
end

return UnchartedMapTaskPanel
