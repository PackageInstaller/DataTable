local UINCarnival22EnvDetail = class("UINCarnival22EnvDetail", UIBaseNode)
local base = UIBaseNode
local UINCarnival22EnvDetailItem = require("Game.ActivityCarnival.UI.CarnivalSelect.UINCarnival22EnvDetailItem")
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")

function UINCarnival22EnvDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.OnClickHide)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickHide)
  self._itemPool = UIItemPool.New(UINCarnival22EnvDetailItem, self.ui.theme)
  self.ui.theme:SetActive(false)
  self.__OnClickEnvSelectCallback = BindCallback(self, self.OnClickEnvSelect)
end

function UINCarnival22EnvDetail:InitEnvDetail(carnivalData, envId, clickFunc)
  self._carnivalData = carnivalData
  self._sortEnvList = {}
  self._clickFunc = clickFunc
  for i, envCfg in ipairs(self._carnivalData:GetCarnivalEnvCfg()) do
    table.insert(self._sortEnvList, envCfg)
  end
  self._count = #self._sortEnvList
  self:OpenEnvDetail(envId)
end

function UINCarnival22EnvDetail:OpenEnvDetail(envId)
  table.sort(self._sortEnvList, function(a, b)
    local aUnlock = self._carnivalData:IsCarnivalUnlockEnv(a.id)
    local bUnlock = self._carnivalData:IsCarnivalUnlockEnv(b.id)
    if aUnlock ~= bUnlock then
      return aUnlock
    end
    return a.id < b.id
  end)
  self._itemPool:HideAll()
  for i, envCfg in ipairs(self._sortEnvList) do
    local item = self._itemPool:GetOne()
    item:InitEnvDetailItem(self._carnivalData, envCfg, i == self._count, self.__OnClickEnvSelectCallback)
    item:SetEvnDetailItemCurrent(envId == envCfg.id)
  end
end

function UINCarnival22EnvDetail:OnClickEnvSelect(envId)
  if self._clickFunc ~= nil then
    self._clickFunc(envId)
    self:OnClickHide()
  end
end

function UINCarnival22EnvDetail:OnShow()
  base.OnShow(self)
  UIUtil.SetTopStatus(self, self.Hide)
end

function UINCarnival22EnvDetail:OnHide()
  base.OnHide(self)
end

function UINCarnival22EnvDetail:OnClickHide()
  UIUtil.OnClickBackByUiTab(self)
end

return UINCarnival22EnvDetail
