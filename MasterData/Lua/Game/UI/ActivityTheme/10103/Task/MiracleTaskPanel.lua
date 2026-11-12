local MiracleTaskPanel = class("MiracleTaskPanel", BasePanel)
MiracleTaskPanel._sUIResRootPath = "UI_Activity/"
MiracleTaskPanel._tbDefine = {
  {
    sPrefabPath = "10103/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function MiracleTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.SizeDelta
  end
end

return MiracleTaskPanel
