_class("UIN17IntroController", UIController)
UIN17IntroController = UIN17IntroController

function UIN17IntroController:OnShow(uiParams)
  self._param = uiParams[1]
  self._cfg = Cfg.cfg_activityintro[self._param]
  if not self._cfg then
    self:CloseDialog()
    return
  end
  self:_GetComponent()
  self:_OnValue()
  self:_Flush()
end

function UIN17IntroController:_GetComponent()
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UIN17IntroController:_OnValue()
  local title_txt = StringTable.Get(self._cfg.Title .. "title")
  UIWidgetHelper.SetLocalizationText(self, "Title", title_txt)
  self:_Flush()
  local animName = self._cfg and self._cfg.ShowAnim
  self:_PlayAnimation(animName, 600, nil)
end

function UIN17IntroController:_Flush()
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
    Log.fatal("### no [" .. key .. "head_n] in str_n17.xlsx")
    return
  end
  local uis = UIWidgetHelper.SpawnObjects(self, "Content", "UIN17IntroItem", n)
  for i, ui in ipairs(uis) do
    local head = StringTable.Get(key .. "head_" .. i)
    local body = StringTable.Get(key .. "body_" .. i)
    ui:Flush(head, body)
  end
end

function UIN17IntroController:ConfirmBtnOnClick(go)
  local animName = self._cfg and self._cfg.HideAnim
  self:_PlayAnimation(animName, 600, function()
    self:CloseDialog()
  end)
end

function UIN17IntroController:_PlayAnimation(animName, duration, callback)
  if not string.isnullorempty(animName) then
    UIWidgetHelper.PlayAnimation(self, "uianim", animName, duration, callback)
  elseif callback then
    callback()
  end
end
