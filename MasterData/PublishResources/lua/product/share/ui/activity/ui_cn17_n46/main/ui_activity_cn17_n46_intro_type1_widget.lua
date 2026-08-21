require("ui_intro_type1_widget")
_class("UICNUIActivityCN17N46IntroType1Widget", UIIntroType1Widget)
UICNUIActivityCN17N46IntroType1Widget = UICNUIActivityCN17N46IntroType1Widget

function UICNUIActivityCN17N46IntroType1Widget:_PlayAnimation(animName, duration, callback)
  if not string.isnullorempty(animName) then
    UIWidgetHelper.PlayAnimation(self, "_root", animName, duration, callback)
  elseif callback then
    callback()
  end
end

function UICNUIActivityCN17N46IntroType1Widget:CloseDialog()
  self._uiView:CloseDialogWithAnimation()
end

function UICNUIActivityCN17N46IntroType1Widget:SetData(uiView, cfgId)
  self._uiView = uiView
  self._cfg = Cfg.cfg_intro_loader_type_1[cfgId]
  if not self._cfg then
    Log.exception("UICNUIActivityCN17N46IntroType1Widget:SetData() cfg_intro_loader_type_1[", cfgId, "] error")
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

function UICNUIActivityCN17N46IntroType1Widget:_SetTitle()
  local id = self._cfg.Title
  if not string.isnullorempty(id) then
    local txt = StringTable.Get(id)
    UIWidgetHelper.SetLocalizationText(self, "_title", txt)
  end
end

function UICNUIActivityCN17N46IntroType1Widget:_SetSubTitle()
  local id = self._cfg.SubTitle
  if not string.isnullorempty(id) then
    local txt = StringTable.Get(self._cfg.SubTitle)
    UIWidgetHelper.SetLocalizationText(self, "_subTitle", txt)
  end
end

function UICNUIActivityCN17N46IntroType1Widget:_SetIntro()
  local id = self._cfg.Intro
  if not string.isnullorempty(id) then
    local keyHead = id .. "head_"
    local keyBody = id .. "body_"
    local len = self:_CalcLen(keyHead)
    local uis = UIWidgetHelper.SpawnObjects(self, "_pool", "UIIntroType1Item", len)
    for i, ui in ipairs(uis) do
      local head = StringTable.Get(keyHead .. i)
      local body = StringTable.Get(keyBody .. i)
      ui:SetData(head, body)
    end
  end
end

function UICNUIActivityCN17N46IntroType1Widget:_CalcLen(keyHead)
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has(keyHead .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("UIIntroType1Widget:_CalcLen() no [", keyHead, n, "] in str_xxx.xlsx")
    return 0
  end
  return n
end

function UICNUIActivityCN17N46IntroType1Widget:CloseBtnOnClick(go)
  local animName = self._cfg and self._cfg.HideAnim
  local duration = self._cfg and self._cfg.HideAnimTime or 0
  self:_PlayAnimation(animName, duration, function()
    self:CloseDialog()
  end)
end
