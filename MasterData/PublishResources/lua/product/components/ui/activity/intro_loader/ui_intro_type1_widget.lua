_class("UIIntroType1Widget", UICustomWidget)
UIIntroType1Widget = UIIntroType1Widget

function UIIntroType1Widget:_PlayAnimation(animName, duration, callback)
  if not string.isnullorempty(animName) then
    UIWidgetHelper.PlayAnimation(self, "_root", animName, duration, callback)
  elseif callback then
    callback()
  end
end

function UIIntroType1Widget:CloseDialog()
  self._uiView:CloseDialogWithAnimation()
end

function UIIntroType1Widget:SetData(uiView, cfgId)
  self._uiView = uiView
  self._cfg = Cfg.cfg_intro_loader_type_1[cfgId]
  if not self._cfg then
    Log.exception("UIIntroType1Widget:SetData() cfg_intro_loader_type_1[", cfgId, "] error")
    self:CloseDialog()
    return
  end
  self:_SetTitle()
  self:_SetSubTitle()
  self:_SetIntro()
  local animName = self._cfg and self._cfg.ShowAnim
  local duration = self._cfg and self._cfg.ShowAnimTime or 0
  self:_PlayAnimation(animName, duration, nil)
end

function UIIntroType1Widget:_SetTitle()
  local id = self._cfg.Title
  if not string.isnullorempty(id) then
    local txt = StringTable.Get(id)
    UIWidgetHelper.SetLocalizationText(self, "_title", txt)
  end
end

function UIIntroType1Widget:_SetSubTitle()
  local id = self._cfg.SubTitle
  if not string.isnullorempty(id) then
    local txt = StringTable.Get(self._cfg.SubTitle)
    UIWidgetHelper.SetLocalizationText(self, "_subTitle", txt)
  end
end

function UIIntroType1Widget:_SetIntro()
  local id = self._cfg.Intro
  if not string.isnullorempty(id) then
    local head = UIActivityHelper.GetStringTableArray(id .. "head_")
    local body = UIActivityHelper.GetStringTableArray(id .. "body_")
    local uis = UIWidgetHelper.SpawnObjects(self, "_pool", "UIIntroType1Item", #head)
    for i, ui in ipairs(uis) do
      ui:SetData(StringTable.Get(head[i]), StringTable.Get(body[i]))
    end
  end
end

function UIIntroType1Widget:CloseBtnOnClick(go)
  local animName = self._cfg and self._cfg.HideAnim
  local duration = self._cfg and self._cfg.HideAnimTime or 0
  local voice = self._cfg and self._cfg.ExitVoice or nil
  self:_PlayAnimation(animName, duration, function()
    self:CloseDialog()
  end)
  if voice then
    AudioHelperController.PlayUISoundAutoRelease(voice)
  end
end
