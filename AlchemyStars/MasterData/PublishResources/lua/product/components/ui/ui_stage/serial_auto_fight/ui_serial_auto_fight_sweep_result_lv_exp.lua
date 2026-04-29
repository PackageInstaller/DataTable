_class("UISerialAutoFightSweepResultLvExp", UICustomWidget)
UISerialAutoFightSweepResultLvExp = UISerialAutoFightSweepResultLvExp

function UISerialAutoFightSweepResultLvExp:OnShow()
end

function UISerialAutoFightSweepResultLvExp:OnHide()
end

function UISerialAutoFightSweepResultLvExp:SetStyleUI(styleName)
  self._styleName = styleName
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "titleColor", self, "txtLv")
end

function UISerialAutoFightSweepResultLvExp:SetData()
  local lv, exp = self:_GetRoleLvExp()
  local curValue = self:_Convert_Exp2Value(lv, exp)
  self:_SetLvExpSlider(lv, curValue)
  self:_SetLvExpText(lv, curValue)
  self:_SetAddExpText()
end

function UISerialAutoFightSweepResultLvExp:Refresh(matchRes)
  local addExp, lv, exp = self:_Calc_AddExp(matchRes)
  if addExp == nil then
    return
  end
  local curValue = self:_Convert_Exp2Value(lv, exp)
  self:_SetLvExpSlider(lv, curValue)
  self:_SetLvExpText(lv, curValue)
  local targetLv, targetExp = self:_GetRoleLvExp()
  local targetValue = self:_Convert_Exp2Value(targetLv, targetExp)
  self:_SetExpUpgrade(addExp, lv, targetLv, targetValue)
end

function UISerialAutoFightSweepResultLvExp:_SetAddExpText(exp)
  local isShow = exp ~= nil
  self:GetGameObject("txtExpAdd"):SetActive(isShow)
  if isShow then
    UIWidgetHelper.SetLocalizationText(self, "txtExpAdd", "+" .. exp)
  end
end

function UISerialAutoFightSweepResultLvExp:_SetLvExpText(lv, curValue)
  local maxValue = self:_GetExp_LvNeed(lv)
  local str = StringTable.Get("str_battle_auto_fight_sweep_lv", lv)
  UIWidgetHelper.SetLocalizationText(self, "txtLv", str)
  local a, b, c = math.floor(curValue), "/", maxValue
  local str = UIActivityHelper.GetColorText("#D8D8D8", a, "#00F8FF", b, "#D8D8D8", c)
  UIWidgetHelper.SetLocalizationText(self, "ExpNumberText", str)
end

function UISerialAutoFightSweepResultLvExp:_SetLvExpSlider(lv, curValue)
  local maxValue = self:_GetExp_LvNeed(lv)
  UIWidgetHelper.SetSliderValue(self, "ExpSlider", curValue, maxValue)
end

function UISerialAutoFightSweepResultLvExp:_SetExpUpgrade(addExp, curLv, targetLv, targetValue)
  local duration = UISerialAutoFightConst.GetSweepDuration() / 1000
  self:_SetAddExpText(addExp)
  if curLv < targetLv then
    self:_DoValue_ExpSlider(curLv, self:_GetExp_LvNeed(curLv), duration / 2, function()
      self:_SetLvExpText(targetLv, 0)
      self:_SetLvExpSlider(targetLv, 0)
      self:_DoValue_ExpSlider(targetLv, targetValue, duration / 2, function()
        self:_SetAddExpText()
      end)
    end)
  else
    self:_DoValue_ExpSlider(targetLv, targetValue, duration, function()
      self:_SetAddExpText()
    end)
  end
end

function UISerialAutoFightSweepResultLvExp:_DoValue_ExpSlider(lv, targetValue, duration, callback)
  local obj = self:GetUIComponent("Slider", "ExpSlider")
  obj:DOValue(targetValue, duration, false):OnUpdate(function()
    local curValue = obj.value
    self:_SetLvExpText(lv, curValue)
  end):OnComplete(function()
    self:_SetLvExpText(lv, targetValue)
    if callback then
      callback()
    end
  end)
end

function UISerialAutoFightSweepResultLvExp:_GetRoleLvExp()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local lv = roleModule:GetLevel()
  local exp = roleModule:GetRoleExp()
  return lv, exp
end

function UISerialAutoFightSweepResultLvExp:_GetExp_LvStart(lv)
  local lvExpStart = HelperProxy:GetInstance():GetLevelExp(lv)
  return lvExpStart
end

function UISerialAutoFightSweepResultLvExp:_GetExp_LvNeed(lv)
  local lvProp = Cfg.cfg_role_level[lv]
  local lvExpNeed = lvProp.NeedExp
  return lvExpNeed
end

function UISerialAutoFightSweepResultLvExp:_Convert_Exp2Value(lv, exp)
  local lvExpStart = self:_GetExp_LvStart(lv)
  local curValue = exp - lvExpStart
  return curValue
end

function UISerialAutoFightSweepResultLvExp:_Calc_BeforeExp(matchRes)
  local matchResRoleInfo = matchRes.m_matchResRolInfo
  local expBefore = matchResRoleInfo.exp_before
  local lvBefore = HelperProxy:GetInstance():GetLvByExp(expBefore)
  return lvBefore, expBefore
end

function UISerialAutoFightSweepResultLvExp:_Calc_AddExp(matchRes)
  local normalRewards = matchRes.m_vecAwardNormal
  for i, roleAsset in ipairs(normalRewards) do
    if roleAsset.assetid == RoleAssetID.RoleAssetExp then
      local lvBefore, expBefore = self:_Calc_BeforeExp(matchRes)
      if lvBefore < HelperProxy:GetInstance():GetMaxLevel() then
        local addExp = roleAsset.count
        return addExp, lvBefore, expBefore
      end
    end
  end
end
