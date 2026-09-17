local this = class("cellBattlePetCatchDetailRate", require("ui.pages.pet.new.cellBattlePetCatchRate"))

function this:onRefreshEmpty()
  self:playCellAnim("anim_bonus_tips_init_hide")
end

function this:onEmptyToShow()
  self:showCell(false)
end

function this:onUpdateTextInfo(data)
  local petCatchRateIndex = data.petCatchRateIndex
  local colorStr = self.data.color[petCatchRateIndex]
  local alpha = self.data.alpha[petCatchRateIndex]
  local strKey = self.data.txtKey[petCatchRateIndex]
  self.bind.txt_bonusName = ("<color=%s>%s</color>"):format(colorStr, L_WordsTpl:getValue(strKey))
  self.bind.color_bonusName = C_Color(1, 1, 1, alpha)
  local targetLen = 420
  local txtComp = self.bindComponents.bonusNameTxt
  if txtComp and L_CommonUtil.isValid(txtComp.font) and L_CommonUtil.isValid(txtComp.fontMaterial) then
    targetLen = targetLen - txtComp.preferredWidth
  end
  self.bind.active_recommand = false
  targetLen = 0 < targetLen and targetLen or 0
  self.bind.rectSize_line = C_Vector2(targetLen, 1.0112)
end

function this:onRefreshConent(data)
  local isNew = data and data.isNew
  if not self.isInit or isNew then
    self:showCell(isNew)
  end
  self.isInit = true
end

function this:hideCell(isAnim)
  if not isAnim or not self:playCellAnim("anim_bonus_tips_hide") then
    return
  end
  self:newOrResetTimer("anim_bonus_tips_hide_timer", function()
    self:playCellAnim("anim_bonus_tips_init_hide")
  end, 1.7)
end

function this:showCell(isAnim)
  if not isAnim then
    self:playCellAnim("anim_bonus_tips_init_show")
    return
  end
  self:playCellAnim("anim_bonus_tips_init_hide")
  self:newOrResetTimer("anim_bonus_tips_show", function()
    self:playCellAnim("anim_bonus_tips_show")
  end, 0.2)
end

function this:playCellAnim(animName)
  if self.bindComponents.cellAnim then
    self.bindComponents.cellAnim:Stop()
    self.bindComponents.cellAnim:Play(animName)
    return true
  end
  return false
end

return this
