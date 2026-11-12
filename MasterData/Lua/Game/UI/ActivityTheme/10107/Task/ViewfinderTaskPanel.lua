local ViewfinderTaskPanel = class("ViewfinderTaskPanel", BasePanel)
ViewfinderTaskPanel._sUIResRootPath = "UI_Activity/"
ViewfinderTaskPanel._tbDefine = {
  {
    sPrefabPath = "10107/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function ViewfinderTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.FillAmount
  end
end

return ViewfinderTaskPanel
