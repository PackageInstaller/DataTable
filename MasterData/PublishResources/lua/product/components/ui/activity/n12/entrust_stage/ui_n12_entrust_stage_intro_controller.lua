_class("UIN12EntrustStageIntroController", UIController)
UIN12EntrustStageIntroController = UIN12EntrustStageIntroController

function UIN12EntrustStageIntroController:OnShow(uiParams)
  self._param = uiParams[1]
  self._cfg = Cfg.cfg_activityintro[self._param]
  self:_GetComponent()
  self:_OnValue()
  self:_Flush()
end

function UIN12EntrustStageIntroController:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UIN12EntrustStageIntroController:_OnValue()
  local title_txt = StringTable.Get(self._cfg.Title)
  self._title:SetText(title_txt)
  self:_Flush()
  if self._cfg and not string.isnullorempty(self._cfg.ShowAnim) then
    self._animation:Play(self._cfg.ShowAnim)
  end
end

function UIN12EntrustStageIntroController:_Flush()
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has("str_n12_entrust_stage_intro_head_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("### no [str_n12_entrust_stage_intro_head_n] in str_n12")
    return
  end
  self._content:SpawnObjects("UIN12EntrustStageIntroItem", n)
  local uis = self._content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get("str_n12_entrust_stage_intro_head_" .. i)
    local body = StringTable.Get("str_n12_entrust_stage_intro_body_" .. i)
    ui:Flush(head, body)
  end
end

function UIN12EntrustStageIntroController:ConfirmBtnOnClick(go)
  self:Lock("UIN12EntrustStageIntroController:OnHide")
  if self._cfg and not string.isnullorempty(self._cfg.HideAnim) then
    self._animation:Play(self._cfg.HideAnim)
  end
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UIN12EntrustStageIntroController:OnHide")
    self:CloseDialog()
  end, self)
end
