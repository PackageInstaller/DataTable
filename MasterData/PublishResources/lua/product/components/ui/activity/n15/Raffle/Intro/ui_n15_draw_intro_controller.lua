_class("UIN15DrawIntroController", UIController)
UIN15DrawIntroController = UIN15DrawIntroController

function UIN15DrawIntroController:OnShow(uiParams)
  self:_GetComponent()
  self:_InitParams(uiParams)
  self:_RefView()
end

function UIN15DrawIntroController:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._title_shade = self:GetUIComponent("UILocalizationText", "Titleyy")
  self._content = self:GetUIComponent("UISelectObjectPath", "_content")
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UIN15DrawIntroController:_InitParams(uiParams)
  self._cfg = Cfg.cfg_activityintro[self._param]
  self._param = uiParams[1]
end

function UIN15DrawIntroController:_RefView()
  if self._cfg and not string.isnullorempty(self._cfg.ShowAnim) then
    self._animation:Play(self._cfg.ShowAnim)
  end
  local n = 0
  local str_head = ""
  local str_body = ""
  StringTable.Get("str_n15_name")
  str_head = "str_n15_draw_intro_head_"
  str_body = "str_n15_draw_intro_body_"
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
  self._content:SpawnObjects("UIN15IntroItem", n)
  local uis = self._content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get(str_head .. i)
    local body = StringTable.Get(str_body .. i)
    ui:RefView(head, body)
  end
end

function UIN15DrawIntroController:ConfirmBtnOnClick(go)
  self:Lock("UIN15DrawIntroController:OnHide")
  if self._cfg and not string.isnullorempty(self._cfg.HideAnim) then
    self._animation:Play(self._cfg.HideAnim)
  end
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UIN15DrawIntroController:OnHide")
    self:CloseDialog()
  end, self)
end
