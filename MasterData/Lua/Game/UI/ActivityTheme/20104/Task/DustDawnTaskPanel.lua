local DustDawnTaskPanel = class("DustDawnTaskPanel", BasePanel)
DustDawnTaskPanel._sUIResRootPath = "UI_Activity/"
DustDawnTaskPanel._tbDefine = {
  {
    sPrefabPath = "20104/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function DustDawnTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.FillAmount
  end
end

return DustDawnTaskPanel
