local SwimTask_11100Panel = class("SwimTask_11100Panel", BasePanel)
SwimTask_11100Panel._sUIResRootPath = "UI_Activity/"
SwimTask_11100Panel._tbDefine = {
  {
    sPrefabPath = "11100/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.TaskCommon.TaskCommonCtrl_01"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function SwimTask_11100Panel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.SizeDelta
  end
end

return SwimTask_11100Panel
