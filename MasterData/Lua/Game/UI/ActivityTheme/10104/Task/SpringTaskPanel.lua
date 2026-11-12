local SpringTaskPanel = class("SpringTaskPanel", BasePanel)
SpringTaskPanel._sUIResRootPath = "UI_Activity/"
SpringTaskPanel._tbDefine = {
  {
    sPrefabPath = "10104/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function SpringTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.SizeDelta
  end
end

return SpringTaskPanel
