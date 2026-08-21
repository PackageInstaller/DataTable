_class("UIN21IntrController", UIController)
UIN21IntrController = UIN21IntrController

function UIN21IntrController:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIN21IntrController] self._cfg is nil. param --> ", self._param)
  end
  self:InitWidget()
  self:_OnValue()
end

function UIN21IntrController:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
end

function UIN21IntrController:Flush()
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
    Log.fatal("### no [" .. key .. "head_n] in str_n21.xlsx")
    return
  end
  local uis = UIWidgetHelper.SpawnObjects(self, "Content", "UIN21IntrItem", n)
  for i, ui in ipairs(uis) do
    local head = StringTable.Get(key .. "head_" .. i)
    local body = StringTable.Get(key .. "body_" .. i)
    ui:Flush(head, body)
  end
end

function UIN21IntrController:_OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self:Flush()
end

function UIN21IntrController:BtnCloseOnClick(go)
  self:CloseDialog()
end
