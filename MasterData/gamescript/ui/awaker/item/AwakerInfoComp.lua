local AwakerPage = CommonDefine.AwakerPage
local AwakerInfoComp, Super = System.NewComponent("AwakerInfoComp", AwakerBasePageComp)

function AwakerInfoComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_InfoResource(uiNode)
  self.model = model
  self.isPreview = Vue.ref(false)
end

function AwakerInfoComp:OnBind(binder)
  self.binder = binder
  self.attrModel = binder:createModel(AwakerAttrModel, self.model)
  self:_OnBindPreviewUIVisable()
  self:_OnBindPotentialBtn()
  self:_OnBindTeamBuildEnter()
  self.isPreview.value = false
  binder:BindZ1Button(self.ui.Btn_Level_Up, function()
    local awakerTid = self.model.selectAwakerId
    local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
    local currStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    if not self.model:HasOwnedAwaker(awakerTid) or self.model.page ~= AwakerPage.Detail or self.model:GetAwakerReachLevelLimit(awakerTid) and maxStar <= currStars then
      return
    end
    self.model:SetAwakerPage(AwakerPage.NewLevelUp)
  end, function()
    local awakerTid = self.model.selectAwakerId
    local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
    local currStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    if not self.model:HasOwnedAwaker(awakerTid) or self.model.page ~= AwakerPage.Detail or self.model:GetAwakerReachLevelLimit(awakerTid) and maxStar <= currStars then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    local awakerTid = self.model.selectAwakerId
    local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
    local currStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    if self.model:HasOwnedAwaker(awakerTid) and self.model.page == AwakerPage.Detail and self.model:GetAwakerReachLevelLimit(awakerTid) and maxStar <= currStars then
      do return LT.Text end
      return LT.Text, "AwakerUpgradeMaxBtnText", awakerTid
    end
    do return LT.Text end
    return LT.Text, "AwakerUpgradeBtnText", awakerTid
  end, function()
    return false
  end, nil, nil)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerTitle(tid)
    return name
  end)
  binder:BindToText(self.ui.Text_Name_English, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerNameEn(tid)
    return name
  end)
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    self.model:SetAwakerPage(AwakerPage.Detail)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_Details_Btn"
  end, function()
    local awakerTid = self.model.selectAwakerId
    local ret = false
    local data = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Awaker, awakerTid)
    if not data then
      return false
    end
    local showData = table.clone(data)
    showData.isNew = nil
    if showData then
      ret = RedPointDataUtils.ShowRedPointState(showData)
    end
    return ret
  end, nil, nil)
  binder:BindButtonClick(self.ui.Btn_More, function()
    if self.model.page > AwakerPage.Detail then
      return
    end
    UIManager.Instance:Reopen(Urls.AwakerFullAttrPanel, self.attrModel, AwakerPage.Detail, nil)
  end)
  binder:BindToVisible(self.ui.Tips_Notobtained, function()
    local owned = self.model:HasOwnedAwaker(self.model.selectAwakerId)
    return not owned and self.model.page ~= AwakerPage.List
  end)
  binder:BindToVisible(self.ui.Group_Score, function()
    if self.model.selectAwakerId <= 0 then
      return false
    end
    do return self.model.HasOwnedAwaker, self.model end
    return self.model.HasOwnedAwaker, self.model, self.model.selectAwakerId
  end)
  binder:BindToVisible(self.ui.Btn_Collect, function()
    if self.model.selectAwakerId <= 0 then
      return false
    end
    if self.model:IsMockOrOtherPlayer() then
      return false
    end
    do return self.model.HasOwnedAwaker, self.model end
    return self.model.HasOwnedAwaker, self.model, self.model.selectAwakerId
  end)
  binder:BindToVisible(self.ui.uiNode, function()
    local panelState = self.model.panelState
    local page = self.model.page
    local selectAwakerId = self.model.selectAwakerId
    if panelState == CommonDefine.AwakerPanelState.BigHead then
      return selectAwakerId > 0
    elseif panelState == CommonDefine.AwakerPanelState.MiniHead then
      return page == AwakerPage.Detail
    end
  end)
  binder:BindToText(self.ui.Text_Name_First, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerName(tid)
    return name
  end)
  binder:BindToText(self.ui.Text_Name_Sec, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerTitle(tid)
    return name
  end)
  binder:BindToText(self.ui.Text_Score_Count, function()
    local tid = self.model.selectAwakerId
    local fighting = self.model:GetAwakerFighting(tid)
    return fighting
  end)
  binder:BindToText(self.ui.Text_Quality, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    if config.Quality then
      local key = string.format("Quality%s", config.Quality)
      do return LT.Text end
      return LT.Text, key
    end
  end)
  binder:BindToImage(self.ui.Image_Quality_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Level_Count, function()
    local tid = self.model.selectAwakerId
    local currLevel = self.model:GetAwakerLevel(tid)
    local currLevelLimit = self.model:GetAwakerCurrLevelLimit(tid)
    if self.model:HasOwnedAwaker(tid) then
      do return string.format, "%s/%s", currLevel end
      return string.format, "%s/%s", currLevel, currLevelLimit
    else
      return currLevel
    end
  end)
  binder:BindToText(self.ui.Text_Career_Name, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    do return self.model.GetSchoolName, self.model end
    return self.model.GetSchoolName, self.model, config.School
  end)
  binder:BindToText(self.ui.Text_Name_type, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerType, self.model end
    return self.model.GetAwakerType, self.model, tid
  end)
  binder:BindToRaw(function(childBinder)
    self.isPreview.value = false
    childBinder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.Normal)
    self:_BindAwakerDataNow(binder)
    local collectState = AwakerDataUtils.GetAwakerCollectStateByTid(self.model.selectAwakerId)
    local btnState = collectState and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Normal
    childBinder:SetButtonState(self.ui.Btn_Collect, btnState)
  end, function()
    return {
      self.model.selectAwakerId,
      self.model.page,
      AwakerDataUtils.GetAwakerCollectStateByTid(self.model.selectAwakerId)
    }
  end)
  binder:BindToRaw(function(childBinder, result)
    local attrList = result[1]
    if not attrList then
      return
    end
    if not attrList or #attrList <= 0 then
      return
    end
    for i = 1, #attrList do
      local obj = self.ui["Prop_" .. i]
      if not obj then
      else
        local attr = attrList[i]
        local itemData = {
          clientAttr = attr,
          awakerTid = self.model.selectAwakerId,
          isPreview = result[2],
          previewLevel = self.attrModel:GetPreviewLevel(),
          awakerData = self.model:GetAwakerData(self.model.selectAwakerId),
          resourceCls = UI_Awaker_Item_Prop_DetailResource
        }
        childBinder:BindComponent(AwakerAttrItem(obj, itemData))
      end
    end
  end, function()
    return {
      self.attrModel.baseAttrs,
      self.isPreview.value
    }
  end)
  binder:BindToImageFillAmount(self.ui.Image_Love_Progress, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerLikeExpRate, self.model end
    return self.model.GetAwakerLikeExpRate, self.model, tid
  end)
  binder:BindButtonClick(self.ui.Btn_Homology, function()
    UIManager.Instance:Reopen(Urls.AwakerAffectionPanel, self.model.selectAwakerId)
  end)
  local homologyRedUi = Com_RedDotResource(self.ui.Com_RedDot_Btn_Homology)
  binder:BindToRaw(function(_, nVal, _)
    binder:SetActive(homologyRedUi.Group_RedDot, nVal)
  end, function()
    local result = RedPointDataUtils.HasAwakerAffectionRedShow(self.model.selectAwakerId) or RedPointDataUtils.IsAwakerAffectionBreakthroughRedShow(self.model.selectAwakerId)
    return result
  end)
  binder:BindToText(self.ui.Text_Love_Count, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerLikeLevel, self.model end
    return self.model.GetAwakerLikeLevel, self.model, tid
  end)
  binder:BindButtonClick(self.ui.Btn_BreakthroughPreview, function()
    UIManager.Instance:Reopen(Urls.AwakerBreakthroughPreviewPanel, self.model)
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Break_Preview, CommonDefine.RedDotType.Dot, System.fn(self, self._BindBreakPreviewRed)))
  binder:BindZ1Button(self.ui.Btn_Topped, function()
    self.model:SetAwakerPage(AwakerPage.Breakthrough)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "BreakThrough_Detail_Btn_Str"
  end, function()
    local awakerTid = self.model.selectAwakerId
    do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.AwakerBreakthrough end
    return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.AwakerBreakthrough, {awakerTid}, awakerTid
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    local canOpen = self.model.page == AwakerPage.List or self.model.page == AwakerPage.Detail
    if canOpen then
      local title = LT.Text("AwakerFavorability_Description_Title")
      local detail = LT.Text("AwakerFavorability_Description_Detail")
      UIManager.Instance:Reopen(Urls.CommonillustrateView, title, detail)
    end
  end)
  binder:BindZ1Button(self.ui.Btn_Check, function()
    local isMyAwaker = not self.model:IsMockOrOtherPlayer()
    UIManager.Instance:Reopen(Urls.AwakerPaintingView, self.model.selectAwakerId, nil, nil, isMyAwaker)
  end)
  binder:BindToVisible(self.ui.Btn_Check, function()
    if self.model:IsMockOrOtherPlayer() then
      return false
    end
    local isOwnAwaker = AwakerDataUtils.HasOwnedAwaker(self.model.selectAwakerId)
    local isOwnSkin = AwakerSkinUtils.IsAwakerOwnSkil(self.model.selectAwakerId)
    return isOwnAwaker or isOwnSkin
  end)
  binder:BindComponent(RedDotComponent(self.ui.RedDot_NewSkin, CommonDefine.RedDotType.TextNew, nil, function()
    if self.model:IsMockOrOtherPlayer() then
      return false
    end
    do return AwakerSkinUtils.IsAwakerHasNewSkin end
    return AwakerSkinUtils.IsAwakerHasNewSkin, self.model.selectAwakerId
  end))
  binder:BindToVisible(self.ui.Btn_MaxLv, function()
    return not self.attrModel:IsLevelMax()
  end)
  binder:BindButtonClick(self.ui.Btn_MaxLv, function()
    if not self.isPreview.value then
      binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.High)
      self.isPreview.value = true
      self:_BindAwakerDataMaxLv(binder)
    else
      binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.Normal)
      self.isPreview.value = false
      self:_BindAwakerDataNow(binder)
    end
  end)
  binder:BindToText(self.ui.Text_MaxLv, function()
    do return LT.Textf, "AwakerMaxLevelBtnPreview", self.attrModel:GetPreviewLevel() end
    return LT.Textf, "AwakerMaxLevelBtnPreview", self.attrModel:GetPreviewLevel()
  end)
  binder:BindZ1Button(self.ui.Btn_Collect, function()
    local isCollect = AwakerDataUtils.GetAwakerCollectStateByTid(self.model.selectAwakerId)
    if not isCollect then
      AwakerDataUtils.RequestAwakersCollectState(self.model.selectAwakerId, 1)
      Alert.Show("CollectAwakerTips")
    else
      Alert.Show("CancelCollectAwakerTips")
      self:_BindAwakerDataNow(binder)
      AwakerDataUtils.RequestAwakersCollectState(self.model.selectAwakerId, 0)
    end
  end)
  binder:BindToText(self.ui.Text_Love_Count, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerLikeLevel, self.model end
    return self.model.GetAwakerLikeLevel, self.model, tid
  end)
  self:_BindAwakerDataNow(binder)
  self:_BindPotencyShow(binder)
  self:_BindBtnConfirmRed(binder)
  self:_NewbieGuide()
end

function AwakerInfoComp:_BindAwakerDataMaxLv(binder)
  local previewLv = self.attrModel:GetPreviewLevel()
  local val = string.format("%s/%s", previewLv, previewLv)
  local maxLv = LT.Textf("MaxLvPreview_Txt", val)
  binder:SetText(self.ui.Text_Level_Count, maxLv)
end

function AwakerInfoComp:_BindAwakerDataNow(binder)
  local tid = self.model.selectAwakerId
  local currLevel = self.model:GetAwakerLevel(tid)
  local currLevelLimit = self.model:GetAwakerCurrLevelLimit(tid)
  if self.model:HasOwnedAwaker(tid) then
    currLevel = string.format("%s/%s", currLevel, currLevelLimit)
  end
  binder:SetText(self.ui.Text_Level_Count, currLevel)
  binder:BindToText(self.ui.Txt_SkillLv, function()
    if not self.model:HasOwnedAwaker(tid) then
      return "<color=#C8C971><size=30>1</size></color>/1/1/1/1/1"
    end
    local awakerData = AwakerDataUtils.GetAwakerData(tid)
    local skills = awakerData and awakerData.skills
    if not skills or not skills[1] then
      return "<color=#C8C971><size=30>1</size></color>/1/1/1/1/1"
    end
    local skillLv = string.format("<color=#C8C971><size=30>%s</size></color>", skills[1].level)
    for i = 2, #skills do
      skillLv = skillLv .. "/" .. skills[i].level
    end
    return skillLv
  end)
  binder:BindToText(self.ui.Txt_Talent, function()
    local awakerData = AwakerDataUtils.GetAwakerData(tid)
    do return TalentDataUtils.GetDisplayTalentLvDesc end
    return TalentDataUtils.GetDisplayTalentLvDesc, awakerData and awakerData.talents
  end)
end

function AwakerInfoComp:_NewbieGuide()
end

function AwakerInfoComp:_BindPotencyShow(binder)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.model.selectAwakerId)
    if not awakerData then
      return
    end
    return {
      self.model.selectAwakerId,
      awakerData and awakerData.potency or 0
    }
  end)
end

function AwakerInfoComp:_BindBtnConfirmRed(binder)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Detail, CommonDefine.RedDotType.TextNew, nil, function()
    if self.model:IsMockOrOtherPlayer() then
      return false
    end
    local chargeFormAwakerTid = AwakerDataUtils.GetChangerForm(self.model.selectAwakerId)
    if 0 ~= chargeFormAwakerTid and AwakerSkinUtils.IsAwakerHasNewSkin(chargeFormAwakerTid) then
      return RedPointDataUtils.RedAttrType.IsNew
    end
    return false
  end))
end

function AwakerInfoComp:_BindBreakPreviewRed()
  do return AwakerRedUtils.GetAllBreakthroughPreviewRed end
  return AwakerRedUtils.GetAllBreakthroughPreviewRed, self.model.selectAwakerId
end

function AwakerInfoComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerInfoComp:_OnBindPreviewUIVisable()
  local binder = self.binder
  local needShow = not table.next(AwakerDataUtils.GetMockAwakerMap())
  binder:BindToVisible(self.ui.Btn_BreakthroughPreview, function()
    return needShow
  end)
  binder:BindToVisible(self.ui.Group_Love, function()
    return needShow
  end)
  binder:BindToVisible(self.ui.Btn_Homology, function()
    return needShow
  end)
  binder:BindToVisible(self.ui.Btn_Confirm, function()
    if not needShow then
      return false
    end
    return self.model.selectAwakerId > 0 and self.model.page == AwakerPage.List
  end)
  binder:BindToVisible(self.ui.Btn_Level_Up, function()
    if not needShow then
      return false
    end
    local awakerTid = self.model.selectAwakerId
    local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
    local currStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    return self.model:HasOwnedAwaker(awakerTid) and self.model.page == AwakerPage.Detail and (not self.model:GetAwakerReachLevelLimit(awakerTid) or maxStar <= currStars)
  end)
  binder:BindToVisible(self.ui.Btn_Topped, System.fn(self, self._NeedShowBreakThroughBtn))
end

function AwakerInfoComp:_OnBindPotentialBtn()
  local binder = self.binder
  binder:BindToVisible(self.ui.Btn_Potential, System.fn(self, self._NeedShowPotentialBtn))
  binder:BindZ1Button(self.ui.Btn_Potential, function()
    self.model:SetAwakerPage(AwakerPage.LevelLimitIncrease)
  end, function()
    return CommonDefine.BtnType.High
  end, nil, function()
    if self:_NeedShowPotentialBtn() and AwakerDataUtils.CheckCostItemEnough(self.model.selectAwakerId) then
      return "red"
    end
    return false
  end)
end

function AwakerInfoComp:_NeedShowPotentialBtn()
  local needShow = not table.next(AwakerDataUtils.GetMockAwakerMap())
  if not needShow then
    return false
  end
  if self:_NeedShowBreakThroughBtn() then
    return false
  end
  local awakerLevel = AwakerDataUtils.GetAwakerLevel(self.model.selectAwakerId)
  return self.model:HasOwnedAwaker(self.model.selectAwakerId) and self.model.page == AwakerPage.Detail and awakerLevel == AwakerDataUtils.GetAwakerMaxLevelWithLimitIncrease(self.model.selectAwakerId) and awakerLevel < AwakerDataUtils.GetAwakerMaxLimitIncreaseLevel(self.model.selectAwakerId)
end

function AwakerInfoComp:_OnBindTeamBuildEnter()
  self.binder:BindButtonClick(self.ui.Btn_Configuration, function()
    local panelData = TeamAssignDataUtils.GetTeamBuildPanelDataWithoutStageCfg()
    DBGTeamDataUtils.EnterDBGTeamPanel(panelData)
  end)
  self.binder:SetText(self.ui.Text_Name, LT.Text("TeamFormation"))
  self.binder:BindToVisible(self.ui.Btn_Configuration, function()
    local isMockAwaker = table.next(AwakerDataUtils.GetMockAwakerMap())
    if isMockAwaker then
      return false
    end
    if not self.model:HasOwnedSelectAwaker() then
      return false
    end
    return true
  end)
end

function AwakerInfoComp:_NeedShowBreakThroughBtn()
  local needShow = not table.next(AwakerDataUtils.GetMockAwakerMap())
  if not needShow then
    return false
  end
  local awakerTid = self.model.selectAwakerId
  local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
  local currStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
  return self.model:HasOwnedAwaker(awakerTid) and self.model.page == AwakerPage.Detail and self.model:GetAwakerReachLevelLimit(awakerTid) and maxStar > currStars
end

function AwakerInfoComp:GetOpenAnim()
  if self.model.oldPage == CommonDefine.AwakerPage.List then
    return
  end
  return "UI_Awaker_Panel_Main_Info_Open", nil
end

function AwakerInfoComp:GetCloseAnim()
  if self.model.page == CommonDefine.AwakerPage.List then
    return
  end
  return "UI_Awaker_Panel_Main_Info_Move_Close", nil
end

function AwakerInfoComp:GetEnterDetailAnim()
  return "UI_Awaker_Panel_Main_Info_Alpha_Close", nil
end

function AwakerInfoComp:GetExitDetailAnim()
  return "UI_Awaker_Panel_Main_Info_Alpha_Open", nil
end

function AwakerInfoComp:OnOpen()
  if self.model:HasOwnedSelectAwaker() then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name, 81371)
  end
  NewbieGuideManager.Instance:RegisterNewbiePanel("GuidePanel_AwakerInfoDetail", self, Urls.AwakerBasePanel)
end

function AwakerInfoComp:OnClose()
  NewbieGuideManager.Instance:UnregisterNewbiePanel("GuidePanel_AwakerInfoDetail")
end

function AwakerInfoComp:OnEnterDetail()
  NewbieGuideManager.Instance:RegisterNewbiePanel("GuidePanel_AwakerLevelDetail", self, Urls.AwakerBasePanel)
end

function AwakerInfoComp:OnExitDetail()
  NewbieGuideManager.Instance:UnregisterNewbiePanel("GuidePanel_AwakerLevelDetail")
end

return AwakerInfoComp
