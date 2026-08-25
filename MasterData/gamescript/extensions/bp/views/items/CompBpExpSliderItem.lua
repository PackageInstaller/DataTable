local TYPEOF_Slider = typeof(CS.UnityEngine.UI.Slider)
local DOTween = CS.DG.Tweening.DOTween
local GuideNotePage = GuideNoteDefine.Page
local CompBpExpSliderItem, Super = NewViewComponent("CompBpExpSliderItem")
local SLIDER_ANIM_DURATION = 1

function CompBpExpSliderItem:ctor(uiNode, view, resource)
  Super.ctor(self, uiNode, view)
  self.ui = resource(uiNode)
end

function CompBpExpSliderItem:OnEnterComponent()
  self:_OnBindEvent()
  self:_RefreshView()
end

function CompBpExpSliderItem:_OnBindEvent()
  self:AddButtonClickListener(self.ui.Btn_Buy_Level, System.fn(self, self.OpenBpLevelPurchasePanel))
  if self.ui.Btn_GainExperience then
    self:AddButtonClickListener(self.ui.Btn_GainExperience, function()
      GuideNoteDataUtils.OpenMainView(GuideNotePage.DailyTraining)
    end)
  end
  self:BindEvent(EventMgr.Instance.BpExpSliderAnim, System.fn(self, self.PlaySliderAnim))
  self:BindEvent(EventMgr.Instance.BpSyncData, System.fn(self, self._RefreshView))
end

function CompBpExpSliderItem:_RefreshView()
  self:_OnInitSlider()
  self:_OnInitBtn()
end

function CompBpExpSliderItem:_OnInitBtn()
  local btnState = BattlePassDataUtils.CheckIsMaxLevel() and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.High
  self:SetButtonState(self.ui.Btn_Buy_Level, btnState)
end

function CompBpExpSliderItem:_OnInitSlider()
  self.sliderObj = self.ui.Slider_Schedule:GetComponent(TYPEOF_Slider)
  self.sliderObj.minValue = 0
  self.sliderObj.maxValue = BattlePassDataUtils.GetLevelUpExp()
  self.sliderObj.value = BpModel.Instance.showExp
  self:RefreshSlider()
end

function CompBpExpSliderItem:RefreshSlider()
  self:SetText(self.ui.Text_Grade, BpModel.Instance.showLevel)
  self:SetText(self.ui.Text_Experience_Value, LT.Text(string.format("%s/%s", BpModel.Instance.showExp, BattlePassDataUtils.GetLevelUpExp())))
  self:SetText(self.ui.Text_Online_Value, "")
  self:SetActive(self.ui.Text_Online_Value, false)
  self.sliderObj.value = BpModel.Instance.showExp
end

function CompBpExpSliderItem:PlaySliderAnim()
  local startExp = BpModel.Instance.showExp
  local startLevel = BpModel.Instance.showLevel
  local endExp = BattlePassDataUtils.GetExp()
  local endLevel = BattlePassDataUtils.GetLevel()
  if startLevel == endLevel then
    if startLevel == BattlePassDataUtils.GetMaxBpLevel() then
      self:PlaySameMaxLevelAnim(startExp, startLevel, endExp, endLevel)
    else
      self:PlaySameLevelAnim(startExp, startLevel, endExp, endLevel)
    end
  else
    self:PlayLevelUpAnim(startExp, startLevel, endExp, endLevel, true)
  end
end

function CompBpExpSliderItem:PlaySameMaxLevelAnim(startExp, startLevel, endExp, endLevel)
  if BattlePassDataUtils.GetExtraLvAwardNum() > BattlePassDataUtils.GetOldExtraLvAwardNum() then
    self:PlayLevelUpAnim(startExp, startLevel, endExp, endLevel, false)
    return
  end
  self:PlaySameLevelAnim(startExp, startLevel, endExp, endLevel)
end

function CompBpExpSliderItem:PlaySameLevelAnim(startExp, _, endExp, _)
  local delta = endExp - startExp
  if 0 == delta then
    return
  end
  local showVal = startExp
  DOTween.To(function()
    return showVal
  end, function(newV)
    newV = math.floor(newV)
    showVal = newV
    BpModel.Instance:SetShowExp(showVal)
    self:RefreshSlider()
  end, BattlePassDataUtils.GetExp(), SLIDER_ANIM_DURATION, self)
end

function CompBpExpSliderItem:PlayLevelUpAnim(startExp, _, _, endLevel, showLevelUp)
  local perLevelExp = BattlePassDataUtils.GetLevelUpExp()
  local showVal = startExp
  DOTween.To(function()
    return showVal
  end, function(newV)
    newV = math.floor(newV)
    showVal = newV
    BpModel.Instance:SetShowExp(showVal)
    self:RefreshSlider()
  end, perLevelExp, SLIDER_ANIM_DURATION / 2, self)
  self.binder:BindTimer(SLIDER_ANIM_DURATION / 2, 0, nil, function()
    showVal = showVal - perLevelExp
    if showLevelUp then
      BpModel.Instance:SetShowLevel(endLevel)
      BattlePassDataUtils.OpenLevelUpTips(endLevel)
    end
    DOTween.To(function()
      return showVal
    end, function(newV)
      newV = math.floor(newV)
      showVal = newV
      BpModel.Instance:SetShowExp(showVal)
      self:RefreshSlider()
    end, BattlePassDataUtils.GetExp(), SLIDER_ANIM_DURATION / 2, self)
  end)
end

function CompBpExpSliderItem:OpenBpLevelPurchasePanel()
  if BattlePassDataUtils.CheckIsMaxLevel() then
    Alert.ShowStr(LT.Text("BpUnPurchaseLevelClickTips"))
    return
  end
  UIManager.Instance:Reopen(Urls.BpExchangeLevelView)
end

function CompBpExpSliderItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompBpExpSliderItem
