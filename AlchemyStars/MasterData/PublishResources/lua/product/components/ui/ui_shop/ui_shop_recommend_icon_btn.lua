_class("UIShopRecommendIconBtn", UICustomWidget)
UIShopRecommendIconBtn = UIShopRecommendIconBtn

function UIShopRecommendIconBtn:OnShow()
  self._isSelected = false
  self.nameSelect = self:GetUIComponent("UILocalizedTMP", "nameSelect")
  self.nameNormal = self:GetUIComponent("UILocalizationText", "nameNormal")
  self.normalImg = self:GetGameObject("normalImg")
  self.selectImg = self:GetGameObject("selectImg")
  self.animation = self:GetGameObject():GetComponent("Animation")
end

function UIShopRecommendIconBtn:Init(index, shopRecommendTabDataGroup, callback)
  self.index = index
  self.shopRecommendTabDataGroup = shopRecommendTabDataGroup
  self.callback = callback
  self.nameSelect:SetText(StringTable.Get(self.shopRecommendTabDataGroup:GetGroupName()))
  self.nameNormal:SetText(StringTable.Get(self.shopRecommendTabDataGroup:GetGroupName()))
end

function UIShopRecommendIconBtn:Select(select, playAnimation)
  local preSelected = self._isSelected
  self._isSelected = select
  self.normalImg:SetActive(not select)
  self.selectImg:SetActive(select)
  self.nameSelect.gameObject:SetActive(select)
  self.nameNormal.gameObject:SetActive(not select)
  if playAnimation and preSelected ~= self._isSelected then
    if self._isSelected then
      self.animation:Play("uianim_UIShopRecommendIconBtn_in")
    else
      self.selectImg:SetActive(true)
      self.animation:Play("uianim_UIShopRecommendIconBtn_out")
      local animLength = 250
      self:StartSafeTask("UIShopRecommendIconBtn::PlayOutAnimation", function(lockName, TT)
        self:Lock(lockName)
        YIELD(TT, animLength)
        self:UnLock(lockName)
        self.selectImg:SetActive(self._isSelected)
      end)
    end
  end
end

function UIShopRecommendIconBtn:BtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self.callback then
    self.callback(self.index)
  end
end

function UIShopRecommendIconBtn:IsSelected()
  return self._isSelected
end

function UIShopRecommendIconBtn:PlayAnimation(animName)
  self.animation:Play(animName)
end
