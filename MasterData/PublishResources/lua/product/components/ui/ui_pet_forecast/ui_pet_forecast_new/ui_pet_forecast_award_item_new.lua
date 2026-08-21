_class("UIPetForecastAwardItemNew", UICustomWidget)
UIPetForecastAwardItemNew = UIPetForecastAwardItemNew

function UIPetForecastAwardItemNew:OnShow()
  self._trans = self:GetGameObject()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtDay = self:GetUIComponent("UILocalizedTMP", "day")
  self.getMask = self:GetGameObject("get")
  self.awardGO = self:GetGameObject("reward")
  self.unlock = self:GetGameObject("unlock")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.eff = self:GetGameObject("eff")
end

function UIPetForecastAwardItemNew:Flush(day, tplId, count, IsCurDay, state, callback)
  local tb = {
    [1] = "main_general_di08",
    [2] = "main_general_di10",
    [3] = "main_general_di08"
  }
  local animTb = {
    [1] = "uieff_UIPetForecastAwardItemNew_Start_out",
    [2] = "uieff_UIPetForecastAwardItemNew_Start_in",
    [3] = "uieff_UIPetForecastAwardItemNew_in"
  }
  self.tplId = tplId
  local cfgv = Cfg.cfg_item[tplId]
  self.icon:LoadImage(cfgv.Icon)
  self.txtCount:SetText(count)
  self.callback = callback
  UIWidgetHelper.SetImageSprite(self, "bg", "UINewPetForecast.spriteatlas", tb[state])
  self.unlock:SetActive(state == PredictionStatus.PRES_UnReach and not IsCurDay)
  if IsCurDay then
    UIWidgetHelper.SetImageSprite(self, "dayIcon", "UINewPetForecast.spriteatlas", "main_general_di05")
    self.txtDay.fontSize = 80
    self.txtDay:SetText("<color=#24252c>" .. day .. "</color>")
  else
    UIWidgetHelper.SetImageSprite(self, "dayIcon", "UINewPetForecast.spriteatlas", "main_general_di06")
    self.txtDay.fontSize = 64
    self.txtDay:SetText(tostring(day))
  end
  local isNewGet = not self.getMask.activeSelf
  self.getMask:SetActive(state == PredictionStatus.PRES_Accepted)
  self.eff:SetActive(state == PredictionStatus.PRES_UnAccept)
  if day % 2 == 0 then
    self.awardGO:GetComponent("RectTransform").localPosition = Vector3(0, -40, 0)
  end
  if isNewGet then
    self:StartTask(function(TT)
      self:PlayAnim(animTb[state])
      YIELD(TT, self.anim:GetClip(animTb[state]).length * 1000)
    end)
  end
end

function UIPetForecastAwardItemNew:Trans()
  return self._trans
end

function UIPetForecastAwardItemNew:PlayAnim(anim)
  self.anim:Play(anim)
end

function UIPetForecastAwardItemNew:bgOnClick(go)
  if self.callback then
    self.callback()
  end
end
