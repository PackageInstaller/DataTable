local UINLoginLoading = class("UINLoginLoading", UIBaseNode)
local base = UIBaseNode

function UINLoginLoading:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.onProgressRefresh = BindCallback(self, self.RefreshSceneProgress)
  self.sizeDelta = self.ui.img_process.sizeDelta
end

function UINLoginLoading:InitLoginLoading()
  self.ui.tex_Value_author:SetIndex(0, PlayerDataCenter.playerName)
  self.ui.texinfo_Value_oasisSys:SetIndex(1)
  self.ui.texinfo_Value_basicSim:SetIndex(1)
  if CS.ClientConsts.HideLoadingBar then
    self.ui.progress:SetActive(false)
  end
end

function UINLoginLoading:RefreshSceneProgress(value)
  local p = value * 100
  self.ui.tex_Bar:SetIndex(0, tostring(Mathf.Ceil(p)))
  self.ui.img_process.sizeDelta = Vector2.New(self.sizeDelta.x * value, self.sizeDelta.y)
  self:UpdateDecorativeInfo(p)
end

function UINLoginLoading:UpdateDecorativeInfo(loadingPercent)
  if loadingPercent <= 10 then
    self.ui.texinfo_Value_basicSim:SetIndex(1)
    self.ui.tex_Value_basicSim.color = self.ui.color_process
    self.ui.texinfo_Value_oasisSys:SetIndex(1)
    self.ui.tex_Value_oasisSys.color = self.ui.color_process
    self:UpdateLoadingRate(0, 0)
  elseif loadingPercent <= 55 then
    self.ui.texinfo_Value_basicSim:SetIndex(1)
    self.ui.tex_Value_basicSim.color = self.ui.color_process
    self.ui.texinfo_Value_oasisSys:SetIndex(1)
    self.ui.tex_Value_oasisSys.color = self.ui.color_process
    self:UpdateLoadingRate(1 - (55 - loadingPercent) / 45, 0)
  else
    self.ui.texinfo_Value_basicSim:SetIndex(2)
    self.ui.tex_Value_basicSim.color = self.ui.color_solid
    self.ui.texinfo_Value_oasisSys:SetIndex(1)
    self.ui.tex_Value_oasisSys.color = self.ui.color_process
    self:UpdateLoadingRate(1, 1 - (100 - loadingPercent) / 45)
  end
end

function UINLoginLoading:UpdateLoadingRate(fit1, fit2)
  local length = #self.ui.tex_Arry_basicSim
  local taotalValue = math.ceil(100 * length * fit1)
  for i = 1, length do
    local text = self.ui.tex_Arry_basicSim[i]
    text.text = tostring(math.min(taotalValue, 100)) .. "%"
    taotalValue = math.max(taotalValue - 100, 0)
  end
  length = #self.ui.tex_Arry_oasisSys
  taotalValue = math.ceil(100 * length * fit2)
  for i = 1, length do
    local text = self.ui.tex_Arry_oasisSys[i]
    text.text = tostring(math.min(taotalValue, 100)) .. "%"
    taotalValue = math.max(taotalValue - 100, 0)
  end
end

function UINLoginLoading:OnShow()
  MsgCenter:AddListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
end

function UINLoginLoading:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
end

function UINLoginLoading:OnDelete()
  base.OnDelete(self)
end

return UINLoginLoading
