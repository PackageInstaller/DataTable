local Animator = CS.UnityEngine.Animator
local typeof = _ENV.typeof
local AwakerPage = CommonDefine.AwakerPage
local UIAnimationController = CS.Z1Client.UIAnimationController
local PanelState = CommonDefine.AwakerPanelState
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local showPageList = {
  AwakerPage.List,
  AwakerPage.Detail,
  AwakerPage.Skill,
  AwakerPage.Talent,
  AwakerPage.Potency,
  AwakerPage.Trinket,
  AwakerPage.Story
}
local AwakerBasePanel, Super = System.NewClass("AwakerBasePanel", UIBasePanel)
AwakerBasePanel.uiResCls = UI_Awaker_Panel_MainResource

function AwakerBasePanel:ctor(data)
  Super.ctor(self)
  self.data = data
  self.showAwakerName = Vue.ref(true)
  self.pageItemMap = {}
  AwakerDataUtils.isPreviewingAwakersData = false
  if self.data and self.data.previewAwakersData then
    AwakerDataUtils.isPreviewingAwakersData = true
    AwakerDataUtils.InitMockAwakerMap(table.clone(self.data.previewAwakersData.awakers))
    ItemDataUtils.InitMockItemData(table.clone(self.data.previewAwakersData.items))
    AwakerDataUtils.OpenHandleMockDataLock(Urls.AwakerBasePanel)
    ItemDataUtils.OpenHandleMockDataLock(Urls.AwakerBasePanel)
    AwakerDataUtils.isPreviewingAwakersData = false
  end
end

function AwakerBasePanel:SetChildPageCfg()
  local AwakerPageCfg = {
    [AwakerPage.Detail] = {
      showMiniHead = true,
      gameObject = self.ui.UI_Awaker_Item_Info,
      cls = AwakerInfoComp,
      useScreenSpaceMask = true,
      portraitMask = CommonRes.UIPortraitMask.awakerDetail
    },
    [AwakerPage.Skill] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Nurturance/UI_Awaker_Item_Skill_Training.prefab",
      cls = AwakerSkillComp,
      showMiniHead = true
    },
    [AwakerPage.SkillDetail] = {showMiniHead = false},
    [AwakerPage.Potency] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Potency/UI_Awaker_Popup_Potency_Main.prefab",
      cls = AwakerPotencyComp,
      showMiniHead = true,
      useScreenSpaceMask = true,
      portraitMask = CommonRes.UIPortraitMask.awakerPotency
    },
    [AwakerPage.PotencyDetail] = {
      showMiniHead = false,
      useScreenSpaceMask = true,
      portraitMask = CommonRes.UIPortraitMask.PotencyDetail
    },
    [AwakerPage.Talent] = {
      gameObject = nil,
      gamePrefab = CommonRes.AwakerTalentPrefab,
      cls = AwakerTalentComp,
      useScreenSpaceMask = true,
      portraitMask = CommonRes.UIPortraitMask.PotencyDetail,
      showMiniHead = true
    },
    [AwakerPage.TalentDetail] = {
      showMiniHead = false,
      useScreenSpaceMask = true,
      portraitMask = CommonRes.UIPortraitMask.PotencyDetail
    },
    [AwakerPage.TrinketBind] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Trinket/UI_Awaker_Popup_Trinket_Bind.prefab",
      cls = AwakerTrinketBindComp,
      showMiniHead = true,
      useScreenSpaceMask = true
    },
    [AwakerPage.Story] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Story/UI_Awaker_Story_Main.prefab",
      cls = AwakerStoryMainComp,
      showMiniHead = true,
      useScreenSpaceMask = true
    },
    [AwakerPage.BackTrack] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Backtrace/UI_Awaker_Item_Preview.prefab",
      cls = AwakerBackTrackComp,
      showMiniHead = true
    },
    [AwakerPage.Breakthrough] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Topped/UI_Awaker_Item_Topped_Detail.prefab",
      cls = AwakerBreakthroughComp,
      showMiniHead = false
    },
    [AwakerPage.NewLevelUp] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Topped/UI_Awaker_Item_Topped_DetailUp.prefab",
      cls = AwakerNewLevelUpComp,
      detailAnim = "UI_Awaker_Panel_Main_Info_Alpha_Open",
      showMiniHead = false
    },
    [AwakerPage.LevelLimitIncrease] = {
      gamePrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Topped/UI_Awaker_Popup_Potential.prefab",
      cls = AwakerLevelLimitIncreaseComp,
      showMiniHead = false
    },
    [AwakerPage.StoryDetail] = {showMiniHead = false},
    [AwakerPage.VoiceDetail] = {showMiniHead = false}
  }
  self.awakerPageCfg = AwakerPageCfg
end

function AwakerBasePanel:OnBind(binder)
  self.binder = binder
  binder:SetActive(self.ui.Image_Awaker, true)
  local model = binder:createModel(AwakerModel, self.data)
  self.model = model
  self.animator = self.ui.uiNode:GetComponent(typeof(Animator))
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.imageGradientAnimController = self.ui.Image_Gradient:GetComponent(typeof(UIAnimationController))
  self:_BindAwakerName(binder)
  self.uiAnimController:StopPlayableGraph()
  binder:BindToRaw(function(cbinder, awakerTidOrResNum)
    local awakerTid = tonumber(awakerTidOrResNum)
    local resNum = not awakerTid and awakerTidOrResNum
    local extParams = {animationMode = true, allowFaceChange = true}
    local portaitComp = cbinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, awakerTid, resNum, self.data and self.data.testFace, nil, extParams))
    self.portaitComp = portaitComp
    PortraitManager.Instance:AddAwakerPortrait(self.portaitComp)
    local scaleMap = self:GetAnimodeDefaultScale()
    local scale = scaleMap[model.page] or CS.UnityEngine.Vector3(1, 1, 1)
    self:ForceScaleAnimodePortrait(false, scale)
    cbinder:SetAssetTarget(cbinder)
    cbinder:onDestroy(function()
      ResLoadMgr.UnloadAssetByTarget(cbinder)
      PortraitManager.Instance:RemoveAwakerPortrait(portaitComp)
    end)
  end, function()
    local awakerTid = model.selectAwakerId
    local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(awakerTid)
    local resNum
    if dressedSkinTid and dressedSkinTid ~= CommonDefine.DefaultSkinTid then
      resNum = AwakerSkinUtils.GetSkinResNum(dressedSkinTid)
    end
    return resNum or awakerTid
  end)
  self.ui.Container_Awaker:SetActive(true)
  self.portaitComp:SetUseScreenSpaceMask(true)
  self:SetChildPageCfg()
  self:BindChildPages()
  self:BindPanelState()
  self.backOps = {}
  self:OnBindCloseBtn()
  local group_Btn = self.ui.UI_Common_Btn_Back3.transform:Find("Group_Back/Group_Btn")
  if group_Btn then
    local closeBtnCanvasGroup = group_Btn:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if closeBtnCanvasGroup then
      closeBtnCanvasGroup.alpha = 1
    end
  end
  binder:BindComponent(AwakerTextVoiceCom(self.model, self.ui.ScrollView, self.ui.Text_Voice))
  binder:BindToRaw(function(_, nVal, _)
    if "" ~= nVal then
      if self.ui.Image_Gradient.activeSelf then
        return
      end
      binder:SetActive(self.ui.Image_Gradient, true)
      self.ui.Image_Gradient.transform.localScale = CS.UnityEngine.Vector3(0, 0, 0)
      self.imageGradientAnimController:PlayState("UI_Awaker_Panel_Main_Image_Gradient_Open")
    else
      binder:SetActive(self.ui.Image_Gradient, false)
    end
  end, function()
    return model.curAwakerVoiceContent
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    local function func()
      self:StopPlayAwakerVoice()
    end
    
    local ret = table.contains(showPageList, self.model.page) and self.model:HasOwnedAwaker(self.model.selectAwakerId)
    binder:SetActive(self.ui.Image_Awaker_Click, ret)
    if nil == oVal then
      binder:BindTimer(0.2, 1, nil, func)
    elseif nVal ~= oVal then
      func()
    end
  end, function()
    return model.selectAwakerId
  end, nil)
  binder:BindToRaw(function(_, nVal, oVal)
    local ret = table.contains(showPageList, self.model.page) and self.model:HasOwnedAwaker(self.model.selectAwakerId)
    binder:SetActive(self.ui.Image_Awaker_Click, ret)
    if nVal == AwakerPage.Skill then
      binder:SetActive(self.ui.Image_Gradient, false)
    end
    if not (nVal == oVal or self:CanPlayAudio()) or nVal == AwakerPage.List and nil ~= oVal or oVal == AwakerPage.List then
      self:StopPlayAwakerVoice()
    end
  end, function()
    return model.page
  end, nil)
  binder:BindToVisible(self.ui.Btn_Click_Mask, function()
    return false
  end)
  binder:BindEvent(EventMgr.Instance.AwakerShowVoice, System.fn(self, self.ShowAwakerVoice))
  if not self.pageItemMap[AwakerPage.Detail] then
    self.pageItemMap[AwakerPage.Detail] = binder:BindComponent(AwakerInfoComp(self.ui.UI_Awaker_Item_Info, model))
  end
  binder:BindComponent(AwakerFullListComp(self.ui.UI_Awaker_Item_Fullhead_List, model))
  local showOriginBtn = self.model:GetShowOriginBtn()
  binder:SetActive(self.ui.Btn_Origin, showOriginBtn)
  if showOriginBtn then
    binder:BindComponent(AwakerOriginChangeComp(self.ui, model))
  end
  AudioManager.Instance:PostSoundEvent("Set_State_Ingame_DoubleSpeed_None")
end

function AwakerBasePanel:BindChildPages()
  self.binder:BindToRaw(function(childBinder, page, oldPage)
    self:OnChangePage(page, oldPage)
    local pageInfo = page and self.awakerPageCfg[page]
    if pageInfo then
      local newPageItem = self.pageItemMap[page]
      if not newPageItem then
        newPageItem = self:CreatePageItem(page)
        if newPageItem then
          self.pageItemMap[page] = newPageItem
        end
      end
      if pageInfo.showMiniHead then
        if self.model.panelState ~= PanelState.MiniHead or nil == oldPage then
          self.model:EnterMiniHeadState()
        else
          self:RefreshPanelState()
        end
      else
        self.model:EnterDetailState()
      end
      if pageInfo.useScreenSpaceMask then
        self.portaitComp:SetUseScreenSpaceMask(true)
      end
      if pageInfo.portraitMask then
        self.portaitComp:ChangeMaterialMask(pageInfo.portraitMask)
      else
        self.portaitComp:ChangeMaterialMask(CommonRes.UIPortraitMask.commonMaskb)
      end
    end
  end, function()
    return self.model.page
  end)
end

function AwakerBasePanel:CreatePageItem(page)
  local pageInfo = self.awakerPageCfg[page] or {}
  local gameObject = pageInfo.gameObject
  if not gameObject and pageInfo.gamePrefab then
    local asset = self.binder:LoadAsset(pageInfo.gamePrefab)
    gameObject = self.binder:Instantiate(asset, self.ui.Awaker_P.transform)
    gameObject.name = gameObject.name:replace("(Clone)", "", true)
    self.binder:UpdateLocalizedTextAndResouce(gameObject)
  end
  if gameObject then
    self.binder:SetActive(gameObject, true)
    if pageInfo.cls then
      assert(System.is(pageInfo.cls, AwakerBasePageComp), pageInfo.cls.__name .. "需要继承AwakerBasePageComp并实现其播放动画方法")
      local item = self.binder:BindComponent(pageInfo.cls(gameObject, self.model))
      return item
    end
  end
end

function AwakerBasePanel:OnChangePage(page, oldPage)
  self:OnPortraitChange(page, oldPage)
  if page == AwakerPage.List or self:IsJumpPage() then
    local scaleMap = self:GetAnimodeDefaultScale()
    local scale = scaleMap[page]
    if scale then
      self:ForceScaleAnimodePortrait(true, scale)
    end
  else
    self.portaitComp:ForceScale(false)
  end
end

function AwakerBasePanel:OnPortraitChange(page, oldPage)
end

function AwakerBasePanel:BindPanelState()
  self.binder:BindToRaw(function(cbinder, newState, oldState)
    self:ChangePanelState(newState, oldState)
    local closeBtnGo = GuidePanelUtils.GetNodeGo("UI_Awaker_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon")
    if newState == PanelState.BigHead then
      NewbieGuideManager.Instance:UnregisterNewbieGo("GuideGo_AwakerBackBtn")
      NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_AwakerCloseBtn", closeBtnGo, Urls.AwakerBasePanel)
    elseif newState == PanelState.MiniHead then
      NewbieGuideManager.Instance:UnregisterNewbieGo("GuideGo_AwakerCloseBtn")
      NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_AwakerBackBtn", closeBtnGo, Urls.AwakerBasePanel)
    end
  end, function()
    return self.model.panelState
  end)
end

function AwakerBasePanel:RefreshPanelState()
  self:ChangePanelState(self.model.panelState)
end

function AwakerBasePanel:ChangePanelState(newState, oldState)
  local baseAnim = ""
  local pageAction, oldPageAction
  if newState == PanelState.BigHead then
    baseAnim, pageAction, oldPageAction = self:GetEnterBigHeadMotion(oldState)
  elseif newState == PanelState.MiniHead then
    if not self.MiniListComp then
      self.MiniListComp = self.binder:BindComponent(AwakerMiniListComp(self.ui.UI_Awaker_Item_Minihead_List, self.model))
    end
    if oldState ~= PanelState.Detail then
      self.MiniListComp:ScrollToCurrentAwaker()
    end
    baseAnim, pageAction, oldPageAction = self:GetEnterMiniHeadMotion(oldState)
  elseif newState == PanelState.Detail then
    baseAnim, pageAction, oldPageAction = self:GetEnterDetailMotion(oldState)
  end
  local page, oldPage = self.model.page, self.model.oldPage
  self:OnPageAction(page, pageAction)
  self:OnPageAction(oldPage, oldPageAction)
  local pageAnim = self:GetPageActionAnim(page, pageAction)
  local oldPageAnim = self:GetPageActionAnim(oldPage, oldPageAction)
  baseAnim = AddClipToPlay(AddClipToPlay(oldPageAnim, pageAnim), baseAnim)
  
  local function animFinishCb()
    self:AfterPageAction(page, pageAction)
    self:AfterPageAction(oldPage, oldPageAction)
    self:OnPageAnimFinish(page)
  end
  
  self:_UpdateAnimodePortraitScale(page)
  if #baseAnim > 0 then
    self.isInUiAnim = true
    self.uiAnimController:PlayMultiState(baseAnim, function()
      self.isInUiAnim = false
      animFinishCb()
    end, 1.5)
  else
    animFinishCb()
  end
end

function AwakerBasePanel:_UpdateAnimodePortraitScale(page)
  local scaleMap = self:GetAnimodeDefaultScale()
  local scale = scaleMap[page]
  if scale then
    self:ForceScaleAnimodePortrait(true, scale)
    if page == AwakerPage.List then
      self:ResetAniPortraitPos(scale)
    end
  end
end

function AwakerBasePanel:OnPageAnimFinish(page, oldPage)
  self:_UpdateAnimodePortraitScale(page)
  Logger.Debug("调用Lua的回调")
  self.model:SetPlayingTransAnim(false)
  if self.model.haveJump then
    self:_AfterJumpToggleSet()
    self.model:SetHaveJump(false)
  end
  EventMgr.Instance.OnAwakerPageClosed:Dispatch(oldPage)
  if not NewbieGuideManager.Instance:GetRegisterGameObject("GuideGo_EnterAwakerDetailBtn") then
    local gameObj = GuidePanelUtils.GetNodeGo("UI_Awaker_Panel_Main(Clone).Awaker_Z.UI_Awaker_Item_Info.Btn_Confirm")
    if gameObj then
      NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_EnterAwakerDetailBtn", gameObj, Urls.AwakerBasePanel)
    end
  end
end

function AwakerBasePanel:GetEnterBigHeadMotion(oldState)
  local baseAnim, pageAction, oldPageAction
  if nil == oldState then
    baseAnim = "UI_Awaker_Panel_Main_Fullhead_Open"
    pageAction = nil
  elseif oldState == PanelState.MiniHead then
    baseAnim = "UI_Awaker_Panel_Main_Detail_Close"
    pageAction = CommonDefine.AwakerPageAction.Close
    oldPageAction = CommonDefine.AwakerPageAction.Close
  end
  return baseAnim, pageAction, oldPageAction
end

function AwakerBasePanel:GetEnterMiniHeadMotion(oldState)
  local baseAnim, pageAction, oldPageAction
  if nil == oldState then
    if not self.model.oldPage then
      baseAnim = "UI_Awaker_Panel_Main_Minihead_Dateil_Open"
    end
    pageAction = CommonDefine.AwakerPageAction.Open
    oldPageAction = CommonDefine.AwakerPageAction.Close
  elseif oldState == PanelState.BigHead then
    baseAnim = "UI_Awaker_Panel_Main_Minihead_Open"
    pageAction = CommonDefine.AwakerPageAction.Open
    oldPageAction = CommonDefine.AwakerPageAction.Close
  elseif oldState == PanelState.Detail then
    baseAnim = "UI_Awaker_Panel_Main_MiniheadList_Open"
    pageAction = CommonDefine.AwakerPageAction.ExitDetail
    oldPageAction = CommonDefine.AwakerPageAction.ExitDetail
  end
  return baseAnim, pageAction, oldPageAction
end

function AwakerBasePanel:GetEnterDetailMotion(oldState)
  local baseAnim, pageAction, oldPageAction
  pageAction = CommonDefine.AwakerPageAction.EnterDetail
  oldPageAction = CommonDefine.AwakerPageAction.EnterDetail
  if oldState == PanelState.MiniHead then
    baseAnim = "UI_Awaker_Panel_Main_MiniheadList_Close"
  end
  return baseAnim, pageAction, oldPageAction
end

function AwakerBasePanel:OnPageAction(page, action)
  local pageItem = page and self.pageItemMap[page]
  if action and pageItem and action then
    local pageActionFuncName = string.format("On%s", action)
    local onActionFun = pageItem[pageActionFuncName]
    onActionFun(pageItem)
  end
end

function AwakerBasePanel:GetPageActionAnim(page, action)
  local pageItem = page and self.pageItemMap[page]
  if action and pageItem and action then
    local pageActionFuncName = string.format("Get%sAnim", action)
    local getAnimAndCbFun = pageItem[pageActionFuncName]
    do return getAnimAndCbFun end
    return getAnimAndCbFun, pageItem
  end
end

function AwakerBasePanel:AfterPageAction(page, action)
  local pageItem = page and self.pageItemMap[page]
  if action and pageItem and action then
    local pageActionFuncName = string.format("On%sAnimFinish", action)
    local onActionFun = pageItem[pageActionFuncName]
    onActionFun(pageItem)
  end
end

function AwakerBasePanel:ResetAniPortraitPos(vec)
  if self.portaitComp then
    self.portaitComp:ResetAniPortraitPos(vec)
  end
end

function AwakerBasePanel:ForceScaleAnimodePortrait(state, vec)
  if self.portaitComp then
    self.portaitComp:ForceScale(state)
    self.portaitComp:SetForceScaleValue(vec)
  end
end

function AwakerBasePanel:GetAnimodeDefaultScale()
  if not self.scaleFix then
    self.scaleFix = {
      [AwakerPage.List] = CS.UnityEngine.Vector3(1, 1, 1),
      [AwakerPage.Detail] = CS.UnityEngine.Vector3(0.7672858, 0.7672858, 0.7672858),
      [AwakerPage.Potency] = CS.UnityEngine.Vector3(0.7672858, 0.7672858, 0.7672858),
      [AwakerPage.Talent] = CS.UnityEngine.Vector3(0.7672858, 0.7672858, 0.7672858),
      [AwakerPage.Story] = CS.UnityEngine.Vector3(0.7672858, 0.7672858, 0.7672858),
      [AwakerPage.BackTrack] = CS.UnityEngine.Vector3(0.7672858, 0.7672858, 0.7672858),
      [AwakerPage.PotencyDetail] = CS.UnityEngine.Vector3(0.5653685, 0.5653685, 0.5653685)
    }
  end
  return self.scaleFix
end

function AwakerBasePanel:_ClearAnimMaskTimer()
  if self.playingMaskTimer then
    self.binder:StopTimer(self.playingMaskTimer)
    self.playingMaskTimer = nil
  end
end

function AwakerBasePanel:Close()
  self:_ResumeAllCanvasGroupInteractable()
  AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
  self:ClearTimer()
  self:_ClearAnimMaskTimer()
  self:ReleasePortraitTexture()
  Super.Close(self)
  DataCenter.mainInterfaceData.curNaviFunc = CommonDefine.MainNaviTab.Battle
end

function AwakerBasePanel:ReleasePortraitTexture()
  if self.portaitComp and self.portaitComp.LuaBakeRenderTexture then
    self.portaitComp.LuaBakeRenderTexture:ReleaseRenderture()
    self.portaitComp.LuaBakeRenderTexture.enabled = false
  end
end

function AwakerBasePanel:IsJumpPage()
  return self.model.jumpPage and (self.model.jumpPage == CommonDefine.AwakerPage.Detail or self.model.jumpPage == CommonDefine.AwakerPage.Skill or self.model.jumpPage == CommonDefine.AwakerPage.Trinket or self.model.jumpPage == CommonDefine.AwakerPage.Weapon)
end

function AwakerBasePanel:CanPlayAudio()
  local ret = table.contains(showPageList, self.model.page) and self.model:HasOwnedAwaker(self.model.selectAwakerId)
  return ret
end

function AwakerBasePanel:ShowAwakerVoice(voiceId, boolNotPlaySound)
  if 0 == voiceId then
    self:StopPlayAwakerVoice()
    return
  end
  local voiceConfig = DT.Voice[voiceId]
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  self.model:SetCurAwakerVoice(voiceConfig.AwakerVoiceContent, soundEventName)
  self:ClearTimer()
  self.timer = self.binder:BindTimer(duration + 1, 0, nil, function()
    self.model:SetCurAwakerVoice("", "")
    AwakerFaceManager.Instance:StopSwitchFace()
  end)
  if not boolNotPlaySound then
    AudioManager.Instance:PostSoundEvent(soundEventName)
    AwakerFaceManager.Instance:SwitchFace(voiceConfig.AwakerID, voiceConfig.FacialExpressionSwitch)
  end
end

function AwakerBasePanel:StopPlayAwakerVoice()
  AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
  self.model:SetCurAwakerVoice("", "")
  AwakerFaceManager.Instance:StopSwitchFace()
end

function AwakerBasePanel:_AfterJumpToggleSet()
  if not self.MiniListComp then
    return
  end
  if self.model.jumpPage == AwakerPage.Skill then
    self.MiniListComp.binder:SetZ1Toggle(self.MiniListComp.ui.Toggle_Skill, true)
  elseif self.model.jumpPage == AwakerPage.Trinket then
    self.MiniListComp.binder:SetZ1Toggle(self.MiniListComp.ui.Toggle_Trinket, true)
  elseif self.model.jumpPage == AwakerPage.Weapon then
    self.MiniListComp.binder:SetZ1Toggle(self.MiniListComp.ui.Toggle_Weapon, true)
  end
end

function AwakerBasePanel:_NeedHideAwakerImage(page)
  do return table.contains, {
    AwakerPage.Skill,
    AwakerPage.SkillDetail,
    AwakerPage.Weapon,
    AwakerPage.WeaponRefine,
    AwakerPage.WeaponChange,
    AwakerPage.WeaponEnhance,
    AwakerPage.Trinket,
    AwakerPage.TrinketChange,
    AwakerPage.TrinketStrengthen
  } end
  return table.contains, {
    AwakerPage.Skill,
    AwakerPage.SkillDetail,
    AwakerPage.Weapon,
    AwakerPage.WeaponRefine,
    AwakerPage.WeaponChange,
    AwakerPage.WeaponEnhance,
    AwakerPage.Trinket,
    AwakerPage.TrinketChange,
    AwakerPage.TrinketStrengthen
  }, page, AwakerPage.SkillDetail, AwakerPage.Weapon, AwakerPage.WeaponRefine, AwakerPage.WeaponChange, AwakerPage.WeaponEnhance, AwakerPage.Trinket, AwakerPage.TrinketChange, AwakerPage.TrinketStrengthen
end

function AwakerBasePanel:OnBindCloseBtn()
  local function backFunc()
    if self:IgnorePushBackCommand() then
      return
    end
    AwakerTrinketDataUtils.ToggleTrinkFilterPanel(false)
    if self.model.page == AwakerPage.WeaponEnhance and CommonDefine.enhanceComp.refineComp:IsShowingMtrlSelectionPanel() then
      CommonDefine.enhanceComp.refineComp:HideMtrlSelectionPanel()
      CommonDefine.enhanceComp:ShowRefine()
      return
    end
    local panelState = self.model.panelState
    if panelState == CommonDefine.AwakerPanelState.BigHead then
      UIManager.Instance:ReShowBehindPanel(self)
      self:ReleasePortraitTexture()
      self.closeBtn:PlayCloseAnim()
      self:RemovePortraitComp()
      self:_DisableAllCanvasGroupInteractable()
      self.uiAnimController:PlayState("UI_Awaker_Panel_Main_Fullhead_Close", System.fn(self, self.Close))
    elseif panelState == CommonDefine.AwakerPanelState.MiniHead then
      if self:IsJumpPage() then
        local closeAnim
        if closeAnim then
          self:_DisableAllCanvasGroupInteractable()
          self.uiAnimController:PlayMultiState(closeAnim, System.fn(self, self.Close), 1.5)
        else
          self:Close()
        end
      else
        self.model:SetAwakerPage(AwakerPage.List)
        self.model:ExitMiniHeadState()
      end
    elseif panelState == CommonDefine.AwakerPanelState.Detail then
      self.model:GotoPrePage()
    end
  end
  
  self.closeBtn = self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    backFunc()
  end, function()
    local panelState = self.model.panelState
    if panelState == CommonDefine.AwakerPanelState.BigHead then
      return "UIResources/AtlasSource/HD/UI_Common_Image/UI_Common_D_Image_Btn_Close_Icon.png"
    elseif panelState == CommonDefine.AwakerPanelState.MiniHead and self:IsJumpPage() then
      return "UIResources/AtlasSource/HD/UI_Common_Image/UI_Common_D_Image_Btn_Close_Icon.png"
    else
      return "UIResources/AtlasSource/UI_Common_Image/UI_Common_D_Image_Btn_Back_Icon.png"
    end
  end, function()
    local page = self.model.page
    if page <= AwakerPage.List then
      do return LT.Text end
      return LT.Text, "AwakerSystemClose"
    else
      do return LT.Text end
      return LT.Text, "AwakerSystemBack"
    end
  end))
  UIManager.Instance:UpdateBackExpandFunc(backFunc)
  self.binder:BindToRaw(function(_, nVal)
    if nVal and nVal == AwakerPage.Quit then
      self:ReleasePortraitTexture()
      self.closeBtn:PlayCloseAnim()
    end
  end, function()
    return self.model.page
  end)
end

function AwakerBasePanel:_BindAwakerName(binder)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerTitle(tid)
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
  binder:BindToVisible(self.ui.Text_Awaker_Name, function()
    return self.showAwakerName.value
  end)
  binder:BindEvent(EventMgr.Instance.OnShowAwakerWeaponRefineList, function(showRefineList)
    self.showAwakerName.value = not showRefineList
  end)
end

function AwakerBasePanel:ClearTimer()
  if self.timer ~= nil then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function AwakerBasePanel:DestroyUI()
  Super.DestroyUI(self)
  for page, _ in pairs(self.backOps) do
    UIBackCommandStack.Remove("AwakerPage_" .. tostring(page))
  end
  UIManager.Instance:ClearBackExpandFuc()
end

function AwakerBasePanel:OnUnbind()
  AwakerDataUtils.CloseHandleMockDataLock(Urls.AwakerBasePanel)
  ItemDataUtils.CloseHandleMockDataLock(Urls.AwakerBasePanel)
  AwakerDataUtils.ResetMockAwakerMap()
  ItemDataUtils.ResetMockItemData()
  self:RemovePortraitComp()
end

function AwakerBasePanel:RemovePortraitComp()
  if self.portaitComp then
    PortraitManager.Instance:RemoveAwakerPortrait(self.portaitComp)
    self.portaitComp = nil
  end
end

return AwakerBasePanel
