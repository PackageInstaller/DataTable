local LongestDayTaskPanel = class("LongestDayTaskPanel", BasePanel)
LongestDayTaskPanel._sUIResRootPath = "UI_Activity/"
LongestDayTaskPanel._tbDefine = {
  {
    sPrefabPath = "10112/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function LongestDayTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.SizeDelta
  end
end

return LongestDayTaskPanel
