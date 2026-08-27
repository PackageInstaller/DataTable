local UINAdjEditorOperationHeroModify = class("UINAdjEditorOperationHeroModify", UIBaseNode)
local base = UIBaseNode
local baseScaleShowRadio = 100

function UINAdjEditorOperationHeroModify:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.slider, self, self.OnChangeSlider)
  UIUtil.AddButtonListener(self.ui.btn_ReSetPos, self, self.OnClickResetPos)
  UIUtil.AddButtonListener(self.ui.btn_IsMain, self, self.OnClickChangeMain)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSelect)
  self._negativeScaleRadio = ConfigData.game_config.adjCustonSizeLimit[1]
  self._positiveScaleRadio = ConfigData.game_config.adjCustonSizeLimit[2]
  self._ignoreSlier = true
  self.ui.slider.minValue = self._negativeScaleRadio * baseScaleShowRadio
  self.ui.slider.maxValue = self._positiveScaleRadio * baseScaleShowRadio
  self._ignoreSlier = nil
  self.ui.textMin.text = tostring(self._negativeScaleRadio) .. "x"
  self.ui.textMax.text = tostring(self._positiveScaleRadio) .. "x"
end

function UINAdjEditorOperationHeroModify:InitAdjHeroModify(editorMain, heroModifyData)
  self._editorMain = editorMain
  self._heroModifyData = heroModifyData
  self._heroId = heroModifyData.dataId
  local vowCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  self.ui.tex_HeroName.text = vowCtrl:GetHeroName(self._heroId, true)
  self.ui.mult:SetActive(self._editorMain:GetAdjCurCount() > 1)
  self.ui.img_Sel:SetActive(false)
  self:RefreshAdjHeroState()
  self:RefreshAdjHeroModify()
end

function UINAdjEditorOperationHeroModify:RefreshAdjHeroModify()
  self._ignoreSlier = true
  local showScale = self._heroModifyData.size or 1
  self.ui.slider.value = showScale * baseScaleShowRadio
  self.ui.tex_CurSize.text = tostring(showScale) .. "x"
  self._ignoreSlier = nil
  local _, isSelect = self._editorMain:IsAdjHeroIdInPreset(self._heroId)
  if isSelect then
    local canReset = self._heroModifyData.pos ~= nil or self._heroModifyData.size ~= nil
    self.ui.btn_ReSetPos.gameObject:SetActive(canReset)
  end
end

function UINAdjEditorOperationHeroModify:RefreshAdjHeroState()
  local _, isSelect = self._editorMain:IsAdjHeroIdInPreset(self._heroId)
  self.ui.img_Sel:SetActive(isSelect)
  self.ui.img_IsMain.gameObject:SetActive(self._editorMain:GetAdjMainHeroId() == self._heroId)
  if isSelect then
    local canReset = self._heroModifyData.pos ~= nil or self._heroModifyData.size ~= nil
    self.ui.btn_ReSetPos.gameObject:SetActive(canReset)
  else
    self.ui.btn_ReSetPos.gameObject:SetActive(false)
  end
end

function UINAdjEditorOperationHeroModify:OnClickResetPos()
  self._editorMain:ResetAdjEditHeroPostion(self._heroId)
  self:RefreshAdjHeroModify()
end

function UINAdjEditorOperationHeroModify:OnChangeSlider(value)
  if self._ignoreSlier then
    return
  end
  value = value / baseScaleShowRadio
  self.ui.tex_CurSize.text = tostring(value) .. "x"
  self._editorMain:SetAdjEditHeroScale(self._heroId, value)
end

function UINAdjEditorOperationHeroModify:OnClickChangeMain()
  if self._editorMain:GetAdjMainHeroId() == self._heroId then
    return
  end
  self._editorMain:ChangeAdjMainHero()
end

function UINAdjEditorOperationHeroModify:OnClickSelect()
  local curCount = self._editorMain:GetAdjCurCount()
  if curCount <= 1 then
    return
  end
  local heroIndexDic = self._editorMain:GetAdjEditAdjIndexDic()
  for modifyIndex = 1, curCount do
    if heroIndexDic[modifyIndex] == self._heroId then
      self._editorMain:ChangeAdjModifyIndex(modifyIndex)
      break
    end
  end
end

return UINAdjEditorOperationHeroModify
