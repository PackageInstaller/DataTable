local PostalTaskPanel = class("PostalTaskPanel", BasePanel)
PostalTaskPanel._sUIResRootPath = "UI_Activity/"
PostalTaskPanel._tbDefine = {
  {
    sPrefabPath = "10106/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function PostalTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.SizeDelta
  end
end

return PostalTaskPanel
