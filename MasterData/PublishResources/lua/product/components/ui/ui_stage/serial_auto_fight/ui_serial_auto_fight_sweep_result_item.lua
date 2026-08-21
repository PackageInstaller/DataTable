_class("UISerialAutoFightSweepResultItem", UICustomWidget)
UISerialAutoFightSweepResultItem = UISerialAutoFightSweepResultItem

function UISerialAutoFightSweepResultItem:OnShow(uiParams)
end

function UISerialAutoFightSweepResultItem:SetStyleUI(styleName)
  self._styleName = styleName
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "line03", self, "_line")
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "titleColor", self, "_txtTitle")
end

function UISerialAutoFightSweepResultItem:SetData(total, index, rewards, svRect, tipsCallback)
  self._total = total
  self._index = index
  self._rewards = rewards
  self._svRect = svRect
  self._tipsCallback = tipsCallback
  self:_SetTitle(index)
  self:_SetRewards(rewards)
end

function UISerialAutoFightSweepResultItem:_SetTitle(index)
  local str = UIActivityHelper.FormatNumber_PreZero(2, index) .. "."
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", str)
end

function UISerialAutoFightSweepResultItem:_SetRewards(rewards)
  local className = "UISerialAutoFightSweepResultItem2"
  if self._styleName == "season" then
    local sop = self:GetUIComponent("UISelectObjectPath", "Content")
    sop:Engine():SetObjectName("UISerialAutoFightSweepResult_Item2_S1.prefab")
    className = "UISerialAutoFightSweepResultItem2S1"
  end
  local objs = UIWidgetHelper.SpawnObjects(self, "Content", className, #rewards)
  for i, v in ipairs(objs) do
    v:SetData(rewards[i].type, rewards[i].roleAsset, self._svRect, self._tipsCallback)
  end
  self._objs = objs
  local trans = self:GetUIComponent("RectTransform", "Content")
  trans.anchoredPosition = Vector2(0, trans.anchoredPosition.y)
end

function UISerialAutoFightSweepResultItem:PlayAnimationIn()
  local isPlay = self._total == self._index
  local animName = "uieff_UISerialAutoFightSweepResult_Item_in"
  UIWidgetHelper.SetAnimationReset(self, "_anim", animName)
  if isPlay then
    UIWidgetHelper.SetAnimationPlay(self, "_anim", animName)
  end
  if isPlay then
    for i, v in ipairs(self._objs) do
      v:PlayAnimationInSequence(i)
    end
  end
end
