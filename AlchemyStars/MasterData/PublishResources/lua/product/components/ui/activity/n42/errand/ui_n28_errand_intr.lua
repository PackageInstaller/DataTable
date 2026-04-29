_class("UIN28ErrandIntr", UIController)
UIN28ErrandIntr = UIN28ErrandIntr

function UIN28ErrandIntr:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIN28ErrandIntr] self._cfg is nil. param --> ", self._param)
  end
  self:InitWidget()
  self:_OnValue()
end

function UIN28ErrandIntr:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
end

function UIN28ErrandIntr:Flush()
  if not self._cfg then
    return
  end
  local key = self._cfg.Title
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has(key .. "head_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("### no [" .. key .. "head_n] in str_n28_errand.xlsx")
    return
  end
  local uis = UIWidgetHelper.SpawnObjects(self, "Content", "UIN28ErrandIntrItem", n)
  for i, ui in ipairs(uis) do
    local head = StringTable.Get(key .. "head_" .. i)
    local body = StringTable.Get(key .. "body_" .. i)
    ui:Flush(head, body)
  end
end

function UIN28ErrandIntr:_OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self:Flush()
end

function UIN28ErrandIntr:BtnCloseOnClick(go)
  self:CloseDialog()
end
