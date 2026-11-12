local GunStormTaskPanel = class("GunStormTaskPanel", BasePanel)
GunStormTaskPanel._sUIResRootPath = "UI_Activity/"
GunStormTaskPanel._tbDefine = {
  {
    sPrefabPath = "10109/Task.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10109.Task.GunStormTaskCtrl"
  }
}
local tbImgDbType = {SizeDelta = 1, FillAmount = 2}

function GunStormTaskPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and tbParam[3] == nil then
    tbParam[3] = tbImgDbType.FillAmount
  end
end

return GunStormTaskPanel
