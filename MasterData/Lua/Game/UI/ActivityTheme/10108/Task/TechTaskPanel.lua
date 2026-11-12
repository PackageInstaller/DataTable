local TechTaskPanel = class("TechTaskPanel", BasePanel)
TechTaskPanel._sUIResRootPath = "UI_Activity/"
TechTaskPanel._tbDefine = {
  {
    sPrefabPath = "10108/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function TechTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.FillAmount
  end
end

return TechTaskPanel
