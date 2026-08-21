_class("UIN29DetectiveCluePopController", UIController)
UIN29DetectiveCluePopController = UIN29DetectiveCluePopController

function UIN29DetectiveCluePopController:LoadDataOnEnter(TT, res, uiParams)
end

function UIN29DetectiveCluePopController:OnShow(uiParams)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20ShowNormalResult)
  self.clueId = uiParams[1]
  self.type = uiParams[2]
  self.callback = uiParams[3]
  self:InitWidget()
  self:InitData()
end

function UIN29DetectiveCluePopController:InitWidget()
  self._item = self:GetUIComponent("RawImageLoader", "Item")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._Info = self:GetUIComponent("UILocalizedTMP", "Info")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIN29DetectiveCluePopController:InitData()
  self:SetFontMat("ui_n29_detective_clue_pop_text_outline.mat")
  local cfg = Cfg.cfg_component_detective_item[self.clueId]
  local Name = cfg.Name
  local Icon = cfg.Icon
  local info = cfg.Info
  self._anim:Play("uieff_UIN29DetectiveCluePopController_in")
  self._item:LoadImage(Icon)
  self._name:SetText(StringTable.Get(Name))
  self._Info:SetText(StringTable.Get(info))
end

function UIN29DetectiveCluePopController:SetFontMat(resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if self._res and self._res.Obj then
    self.mat = self._res.Obj
    local oldMaterial = self._Info.fontMaterial
    self._Info.fontMaterial = self.mat
    self._Info.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  end
end

function UIN29DetectiveCluePopController:CloseOnClick()
  self._anim:Play("uieff_UIN29DetectiveCluePopController_out")
  self:CloseDialog()
  if self.callback then
    self.callback()
  end
end

function UIN29DetectiveCluePopController:OnHide()
end
