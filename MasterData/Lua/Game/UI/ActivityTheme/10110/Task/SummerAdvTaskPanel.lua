local SummerAdvTaskPanel = class("SummerAdvTaskPanel", BasePanel)
SummerAdvTaskPanel._sUIResRootPath = "UI_Activity/"
SummerAdvTaskPanel._tbDefine = {
  {
    sPrefabPath = "10110/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function SummerAdvTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.FillAmount
  end
end

return SummerAdvTaskPanel
