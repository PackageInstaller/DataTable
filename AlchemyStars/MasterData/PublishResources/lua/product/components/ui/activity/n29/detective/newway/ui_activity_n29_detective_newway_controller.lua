_class("UIActivityN29DetectiveNewwayController", UIController)
UIActivityN29DetectiveNewwayController = UIActivityN29DetectiveNewwayController

function UIActivityN29DetectiveNewwayController:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN29DetectiveNewwayController:OnShow(uiParams)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20ShowNormalResult)
  self._cfg = uiParams[1]
  self._callback = uiParams[2]
  self:_GetComponent()
  self:InitInfo()
end

function UIActivityN29DetectiveNewwayController:OnHide()
end

function UIActivityN29DetectiveNewwayController:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._info = self:GetUIComponent("UILocalizationText", "info")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIActivityN29DetectiveNewwayController:InitInfo()
  self._icon:LoadImage(self._cfg.Pic)
  self._name:SetText(StringTable.Get(self._cfg.ShowName))
  self._info:SetText(StringTable.Get(self._cfg.Info))
end

function UIActivityN29DetectiveNewwayController:MaskOnClick()
  self:StartTask(self._Close, self)
end

function UIActivityN29DetectiveNewwayController:_Close(TT)
  self._anim:Play("uieff_UIN29DetectiveNewWayController_out")
  YIELD(TT, 300)
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end
