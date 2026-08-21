_class("UIN13IntroController", UIController)
UIN13IntroController = UIN13IntroController

function UIN13IntroController:OnShow(uiParams)
  self:_GetComponent()
  self:_OnValue(uiParams)
  self:_Flush()
  self:_OnShow()
end

function UIN13IntroController:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._title_shade = self:GetUIComponent("UILocalizationText", "Titleyy")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UIN13IntroController:_OnValue(uiParams)
  self._param = uiParams[1]
  self._select = uiParams[2]
  self._cfg = Cfg.cfg_activityintro[self._param]
end

function UIN13IntroController:_OnShow()
  local title_txt = StringTable.Get(self._cfg.Title)
  self._title:SetText(title_txt)
  self._title_shade:SetText(title_txt)
  if self._cfg and not string.isnullorempty(self._cfg.ShowAnim) then
    self._animation:Play(self._cfg.ShowAnim)
  end
end

function UIN13IntroController:_Flush()
  local n = 0
  local str_head = ""
  local str_body = ""
  StringTable.Get("str_n13_name")
  if self._select then
    str_head = "str_n13_intro_head_"
    str_body = "str_n13_intro_body_"
  else
    str_head = "str_n13_intro_head_map_"
    str_body = "str_n13_intro_body_map_"
  end
  while true do
    n = n + 1
    local keyHead = StringTable.Has(str_head .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    return
  end
  self._content:SpawnObjects("UIN13IntroItem", n)
  local uis = self._content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get(str_head .. i)
    local body = StringTable.Get(str_body .. i)
    ui:Flush(head, body)
  end
end

function UIN13IntroController:ConfirmBtnOnClick(go)
  self:Lock("UIN13IntroController:OnHide")
  if self._cfg and not string.isnullorempty(self._cfg.HideAnim) then
    self._animation:Play(self._cfg.HideAnim)
  end
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UIN13IntroController:OnHide")
    self:CloseDialog()
  end, self)
end
