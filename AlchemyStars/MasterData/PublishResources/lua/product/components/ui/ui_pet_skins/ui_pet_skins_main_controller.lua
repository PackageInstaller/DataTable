_class("UIPetSkinsMainController", UIController)
UIPetSkinsMainController = UIPetSkinsMainController

function UIPetSkinsMainController:Constructor()
  self._rawImageLoaderHelper = RawImageLoaderHelper:New()
  self._rawImageLoaderHelper:Init(1)
  self._cardWidth = 70
  self._cardHeight = 488
  self._havePet = true
  self._aniReqs = {}
  self._cgPreviewSwitchTimer = 2000
  self._cgPreviewSwitchIndex = 1
  self._curSelSkinIndex = 1
  self._curSelSkinId = 0
  self._3DModelShow = false
  self._DesignInfoShow = false
  self._skinsCellCount = 0
  self._count = 0
  self._isScrollReady = false
  self._petModule = self:GetModule(PetModule)
  self._skinsStateData = nil
  self._cgState = DynamicAndStaticState.Dynamic
  self._campBg = {
    [PetFilterType.BaiYeCheng] = "sbc_byc",
    [PetFilterType.BaiYeXiaCheng] = "sbc_xc",
    [PetFilterType.QiGuang] = "sbc_qg",
    [PetFilterType.BeiJing] = "sbc_bj",
    [PetFilterType.HongYouBanShou] = "sbc_hybs",
    [PetFilterType.TaiYangJiaoTuan] = "sbc_zljs",
    [PetFilterType.YouMin] = "sbc_wzy",
    [PetFilterType.LongZhou] = "sbc_lz"
  }
  self._campSubTitleAreaColor = {
    [PetFilterType.BaiYeCheng] = Color(0.8784313725490196, 0.5294117647058824, 0),
    [PetFilterType.BaiYeXiaCheng] = Color(0.47843137254901963, 0.19607843137254902, 0.7607843137254902),
    [PetFilterType.QiGuang] = Color(0.7215686274509804, 0.6235294117647059, 0.027450980392156862),
    [PetFilterType.BeiJing] = Color(0, 0.6, 0.7372549019607844),
    [PetFilterType.HongYouBanShou] = Color(0.7803921568627451, 0.2, 0),
    [PetFilterType.TaiYangJiaoTuan] = Color(0.5803921568627451, 0, 0),
    [PetFilterType.YouMin] = Color(0.22745098039215686, 0.5725490196078431, 0.5490196078431373),
    [PetFilterType.LongZhou] = Color(0.9411764705882353, 0.30980392156862746, 0.12549019607843137)
  }
  self._sortTb = {}
  self._lastContentPosX = 0
  self._modelShowMng = PetSkinShowModelManager:New()
  self._shareSkinDatas = {}
end

function UIPetSkinsMainController:ShowStaticAndDynamic()
  self:ChangeStaticAndDynamicTween(self._cgState)
end

function UIPetSkinsMainController:StaticAndDynamicOnClick()
  if self._cgState == DynamicAndStaticState.Static then
    self._cgState = DynamicAndStaticState.Dynamic
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  else
    self._cgState = DynamicAndStaticState.Static
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlide)
  end
  self:ChangeStaticAndDynamicTween(self._cgState)
end

function UIPetSkinsMainController:ChangeStaticAndDynamicTween(state)
  if self._dsTween then
    self._dsTween:Kill()
  end
  if state == DynamicAndStaticState.Dynamic then
    self._cgRoot:SetActive(false)
    self._spineRoot:SetActive(true)
    local pos = self._dynamicRect.anchoredPosition
    self._dsTween = self._staticAndDynamicImg:DOAnchorPos(pos, 0.3):SetEase(DG.Tweening.Ease.InOutCubic)
    self._dynamicText.color = Color.black
    self._staticText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
  else
    self._cgRoot:SetActive(true)
    self._spineRoot:SetActive(false)
    local pos = self._staticRect.anchoredPosition
    self._dsTween = self._staticAndDynamicImg:DOAnchorPos(pos, 0.3):SetEase(DG.Tweening.Ease.InOutCubic)
    self._staticText.color = Color.black
    self._dynamicText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
  end
end

function UIPetSkinsMainController:OpenBtnsOnClick()
  local tempData = pet_data:New()
  tempData.template_id = self._petId
  tempData.current_skin = self._curSelSkinId
  local pet = Pet:New(tempData)
  local maxGrade = pet:GetMaxGrade()
  tempData.grade = maxGrade
  tempData.level = pet:GetMaxLevel()
  tempData.awakening = pet:GetMaxAwakening()
  tempData.equip_lv = ResourceHelper:GetInstance():GetPetEquip():GetMaxLv(pet:GetTemplateID())
  tempData.affinity_level = pet:GetPetAffinityMaxLevel()
  pet:SetData(tempData)
  self:ShowDialog("UISpiritDetailLookCgAndSpineController", pet, self._cgState)
end

function UIPetSkinsMainController:OnShow(uiParams)
  self:Lock("UIPetSkinsMainController_Anim")
  if self._animEvent then
    GameGlobal.Timer():CancelEvent(self._animEvent)
    self._animEvent = nil
  end
  self._animEvent = GameGlobal.Timer():AddEvent(633, function()
    self:UnLock("UIPetSkinsMainController_Anim")
    self._animEvent = nil
  end)
  self.atlas = self:GetAsset("UIPetSkin.spriteatlas", LoadType.SpriteAtlas)
  self._openType = uiParams[1]
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
    self._petId = uiParams[2]
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL then
    self._shopGoodData = uiParams[2]
    if self._shopGoodData then
      self._curSelSkinId = self._shopGoodData._skinId
    end
    local skinCfg = Cfg.cfg_pet_skin[self._curSelSkinId]
    if skinCfg then
      self._petId = skinCfg.PetId
    end
    self._shopModule = self:GetModule(ShopModule)
    self._clientShop = self._shopModule:GetClientShop()
  elseif self._openType == PetSkinUiOpenType.PSUOT_TIPS then
    self._curSelSkinId = uiParams[2]
    local skinCfg = Cfg.cfg_pet_skin[self._curSelSkinId]
    if skinCfg then
      self._petId = skinCfg.PetId
    end
    self._hideHomeBtn = true
  elseif self._openType == PetSkinUiOpenType.PSUOT_SEASON_SKIN then
    self._curSelSkinId = uiParams[2]
    local skinCfg = Cfg.cfg_pet_skin[self._curSelSkinId]
    if skinCfg then
      self._petId = skinCfg.PetId
    end
    self._hideHomeBtn = true
    self._seasonID = uiParams[3]
    self._seasonComp = uiParams[4]
    self._seasonCompItemInfo = uiParams[5]
  elseif self._openType == PetSkinUiOpenType.PSUT_ACTIVITY_DETAIL then
    self._curSelSkinId = uiParams[2]
    local skinCfg = Cfg.cfg_pet_skin[self._curSelSkinId]
    if skinCfg then
      self._petId = skinCfg.PetId
    end
    self._hideHomeBtn = true
    self._activityShopData = uiParams[3]
    self._buyCallback = uiParams[4]
  end
  self._cfgPet = Cfg.cfg_pet[self._petId]
  self._isScrollReady = false
  self:InitWidget()
  self:_InitSkinListData()
  self:_RefreshPetInfo()
  self:_initSkinsListScroll()
  self:_selDefaultIndex()
  self._isScrollReady = true
  self:AttachEvent(GameEventType.OnCurrencyBySkinSuccess, self._OnCurrencyBuySkinSuccess)
  self:AttachEvent(GameEventType.OnPetSkinChange, self._ForceRefreshUi)
  self:AttachEvent(GameEventType.OpenShop, self.OpenShop)
end

function UIPetSkinsMainController:OnHide()
  self:DetachEvent(GameEventType.OnCurrencyBySkinSuccess, self._OnCurrencyBuySkinSuccess)
  self:DetachEvent(GameEventType.OnPetSkinChange, self._ForceRefreshUi)
  self:DetachEvent(GameEventType.OpenShop, self.OpenShop)
  if self._unlockCgTaskID then
    GameGlobal.TaskManager():KillTask(self._unlockCgTaskID)
    self._unlockCgTaskID = nil
  end
  if self._tryUseSkinTaskId then
    GameGlobal.TaskManager():KillTask(self._tryUseSkinTaskId)
    self._tryUseSkinTaskId = nil
  end
  if self._modelShowMng then
    self._modelShowMng:Dispose()
    self._modelShowMng = nil
  end
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
  if self._timeEvents._cgSwitchTimer then
    GameGlobal.Timer():CancelEvent(self._timeEvents._cgSwitchTimer)
    self._timeEvents._cgSwitchTimer = nil
  end
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
end

function UIPetSkinsMainController:InitWidget()
  self._campBgLoader = self:GetUIComponent("RawImageLoader", "CampBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "BackBtns")
  local lookBtnRect = self:GetUIComponent("RectTransform", "LookBtn")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local hideHomeBtn = not self._hideHomeBtn and nil and self._homeLandModule:IsRunning()
  if hideHomeBtn then
    local pos = lookBtnRect.anchoredPosition
    lookBtnRect.anchoredPosition = Vector3(pos.x - 130, pos.y, pos.z)
  end
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, hideHomeBtn)
  self._petLogoIconLoader = self:GetUIComponent("RawImageLoader", "PetIcon")
  self._petSkinNameText = self:GetUIComponent("UILocalizationText", "PetSkinName")
  self._petNameCHLabel = self:GetUIComponent("UILocalizationText", "PetNameCH")
  self._petNameENLabel = self:GetUIComponent("UILocalizationText", "PetNameEN")
  self._petNameENBgGo = self:GetGameObject("PetNameENBg")
  self._skinsNumText = self:GetUIComponent("UILocalizationText", "SkinsNumText")
  self._skinsNumAreaGo = self:GetGameObject("SkinsNumArea")
  self._skinsNumTextGo = self:GetGameObject("SkinsNumText")
  self._subPanelTitleAreaImg = self:GetUIComponent("Image", "SubPanelTitleArea")
  self._subPanelTitleText = self:GetUIComponent("UILocalizationText", "SubPanelTitleText")
  self._subPanelAreaGo = self:GetGameObject("SubPanelShowArea")
  self._closeSubPanelAreaGo = self:GetGameObject("CloseSubPanelArea")
  self._3DPanelGo = self:GetGameObject("3DPanel")
  self._designPanelGo = self:GetGameObject("DesignPanel")
  self._designText = self:GetUIComponent("UILocalizationText", "DesignText")
  self._designTextTrans = self:GetUIComponent("RectTransform", "DesignText")
  self._cgBtnAreaGo = self:GetGameObject("CgBtnArea")
  self._cgMiniImgLoader = self:GetUIComponent("RawImageLoader", "CgPreview")
  self._cgTipsText = self:GetUIComponent("UILocalizationText", "CgTipsText")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._swithArrowAreaGo = self:GetGameObject("SwithArrowArea")
  self._scrollRect = self:GetUIComponent("ScrollRect", "SkinsList")
  self._curSkinAreaGo = self:GetGameObject("CurSkinArea")
  self._useBtnGo = self:GetGameObject("UseBtn")
  self._buyBtnGo = self:GetGameObject("BuyBtn")
  self._getPathAreaGo = self:GetGameObject("GetPathArea")
  self._gotSkinAreaGo = self:GetGameObject("GotSkinArea")
  self._stateAreas = {
    [PetSkinStateType.PSST_CUR_SKIN] = self._curSkinAreaGo,
    [PetSkinStateType.PSST_CAN_USE] = self._useBtnGo,
    [PetSkinStateType.PSST_SHOP_BUY] = self._buyBtnGo,
    [PetSkinStateType.PSST_NOT_OBTAIN] = self._getPathAreaGo,
    [PetSkinStateType.PSST_SHOP_OBTAINED] = self._gotSkinAreaGo
  }
  self._getPathText = self:GetUIComponent("RollingText", "GetPathText")
  self._priceText = self:GetUIComponent("UILocalizationText", "PriceText")
  self._imgPrice = self:GetUIComponent("Image", "ImgPrice")
  self._modelBtnGo = self:GetGameObject("ModelBtn")
  if self._modelBtnGo then
    self._modelBtnGo:SetActive(false)
  end
  self._designInfoBtnGo = self:GetGameObject("DesignInfoBtn")
  self._modelBtnImg = self:GetUIComponent("Image", "ModelBtn")
  self._designInfoBtnImg = self:GetUIComponent("Image", "DesignInfoBtn")
  self._modelBtnText = self:GetUIComponent("UILocalizationText", "ModelBtnText")
  self._designInfoBtnText = self:GetUIComponent("UILocalizationText", "DesignInfoBtnText")
  self._designScroll = self:GetUIComponent("ScrollRect", "DesignInfoScroll")
  self._designScrollRect = self:GetUIComponent("RectTransform", "DesignInfoScroll")
  self._dynamicText = self:GetUIComponent("UILocalizationText", "dynamicText")
  self._staticText = self:GetUIComponent("UILocalizationText", "staticText")
  self._staticAndDynamicImg = self:GetUIComponent("RectTransform", "bar")
  self._dynamicRect = self:GetUIComponent("RectTransform", "dynamicRect")
  self._staticRect = self:GetUIComponent("RectTransform", "staticRect")
  self._storyInfoBtnObj = self:GetGameObject("StoryInfoBtn")
  self._StoryInfoBtnText = self:GetUIComponent("UILocalizationText", "StoryInfoBtnText")
  self._storyRedPointObj = self:GetGameObject("storyRedPoint")
  self._storyLockObj = self:GetGameObject("story_lock")
  self._ui3DRawImg = self:GetUIComponent("RawImage", "TmpUi3d")
  if self._modelShowMng then
    self._modelShowMng:SetRenderTexture(self._ui3DRawImg.mainTexture)
  end
  self._ui3DGo = self:GetGameObject("TmpUi3d")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._ui3DGo), UIEvent.Drag, function(eventData)
    self:_3dDrag(eventData)
  end)
  self._cgRoot = self:GetGameObject("cgRoot")
  self._spineRoot = self:GetGameObject("spineRoot")
  self._cg_mid = self:GetUIComponent("RawImageLoader", "cgMid")
  self._cg_mid_rect = self:GetUIComponent("RectTransform", "cgMid")
  self._cgRect = self:GetUIComponent("RectTransform", "cgNormal")
  self._cgNormal = self:GetUIComponent("MultiplyImageLoader", "cgNormal")
  self._img = self:GetUIComponent("RawImage", "cgNormal")
  self._atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._bgAnim = self:GetUIComponent("Animation", "BgAnim")
  self._uiAnim = self:GetUIComponent("Animation", "UiAnim")
  self._animNames = {
    show_3d = {
      name = "UIPetSkinsMainController_u_in_3D",
      time_len = 500
    },
    show_design = {
      name = "UIPetSkinsMainController_u_in_Design",
      time_len = 500
    },
    left_out = {
      name_bg = "UIPetSkinsMainController_b_out_l",
      name_ui = "UIPetSkinsMainController_u_out_l",
      time_len = 233
    },
    left_in = {
      name_bg = "UIPetSkinsMainController_b_in_l",
      name_ui = "UIPetSkinsMainController_u_in_l",
      time_len = 500
    },
    right_out = {
      name_bg = "UIPetSkinsMainController_b_out_r",
      name_ui = "UIPetSkinsMainController_u_out_r",
      time_len = 233
    },
    right_in = {
      name_bg = "UIPetSkinsMainController_b_in_r",
      name_ui = "UIPetSkinsMainController_u_in_r",
      time_len = 500
    }
  }
  self._timeEvents = {}
  self._binderCurrency = self:GetGameObject("binderCurrency")
  self._binderCurrencyPrice = self:GetUIComponent("UILocalizationText", "binderCurrencyPrice")
  self._binderNormalPrice = self:GetUIComponent("UILocalizationText", "binderNormalPrice")
  self._binderNormalImg = self:GetUIComponent("Image", "binderNormalImg")
  self._cgSpecial = self:GetUIComponent("RawImageLoader", "cgSpecial")
  self._topTipGo = self:GetGameObject("topMenu")
  local toptipPool = self:GetUIComponent("UISelectObjectPath", "topMenu")
  self._topTip = toptipPool:SpawnObject("UICurrencyMenu")
  self._petLogoGo = self:GetGameObject("petLogo")
  self._petLogoImageLoader = self:GetUIComponent("RawImageLoader", "petLogo")
  self._petLogoGo:SetActive(false)
  self._pets = self:GetGameObject("Pets")
  self._petHeadIcon = {}
  self._petHeadIcon[1] = self:GetUIComponent("RawImageLoader", "HeadIcon1")
  self._petHeadIcon[2] = self:GetUIComponent("RawImageLoader", "HeadIcon2")
  self._petDesc = self:GetUIComponent("UILocalizationText", "PetDesc")
  self._petMark = self:GetUIComponent("RectTransform", "PetMark")
end

function UIPetSkinsMainController:_selDefaultIndex()
  local defaultIndex = 1
  if self._uiSkinsData then
    for index, uiData in ipairs(self._uiSkinsData) do
      if uiData:IsCurrentSkin() then
        defaultIndex = index
        break
      end
    end
  end
  self:_SelectSkinCellIdx(defaultIndex, true)
  self:_SetMoveToCurSelIdx()
end

function UIPetSkinsMainController:_initSkinsListScroll()
  if not self._petSkinCfg then
    return
  end
  self._skinsCellCount = #self._petSkinCfg
  self._count = self._skinsCellCount
  self._curSelSkinIndex = 1
  self:_CreateScrollItem()
  self:_RefreshScrollItemStateData()
  self:_RefreshScrollItemUiState()
  if self._count <= 1 then
    self._scrollRect.horizontal = false
  else
    self._scrollRect.horizontal = true
  end
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
    self._swithArrowAreaGo:SetActive(true)
    self._skinsNumAreaGo:SetActive(true)
    self._skinsNumTextGo:SetActive(true)
    self._skinsNumText:SetText(StringTable.Get("str_pet_skin_list_num", self._skinsCellCount))
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL then
    self._swithArrowAreaGo:SetActive(false)
    self._skinsNumAreaGo:SetActive(false)
    self._skinsNumTextGo:SetActive(false)
  elseif self._openType == PetSkinUiOpenType.PSUOT_TIPS then
    self._swithArrowAreaGo:SetActive(false)
    self._skinsNumAreaGo:SetActive(false)
    self._skinsNumTextGo:SetActive(false)
  elseif self._openType == PetSkinUiOpenType.PSUOT_SEASON_SKIN then
    self._swithArrowAreaGo:SetActive(false)
    self._skinsNumAreaGo:SetActive(false)
    self._skinsNumTextGo:SetActive(false)
  elseif self._openType == PetSkinUiOpenType.PSUT_ACTIVITY_DETAIL then
    self._swithArrowAreaGo:SetActive(false)
    self._skinsNumAreaGo:SetActive(false)
    self._skinsNumTextGo:SetActive(false)
  end
end

function UIPetSkinsMainController:_ForceRefreshUi()
  self:_RefreshScrollItemStateData()
  self:_RefreshScrollItemUiState()
  self:_RefreshUiByCurSkinIndex()
end

function UIPetSkinsMainController:_SelectSkinCellIdx(idx, bNoAnim)
  local useAnim = true
  if bNoAnim then
    useAnim = false
  end
  if idx == self._curSelSkinIndex then
    useAnim = false
  end
  local bLeft = idx >= self._curSelSkinIndex
  self._curSelSkinIndex = idx
  if useAnim then
    if bLeft then
      self:PlayLeftOut()
      self._timeEvents._swithLeftTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.left_out.time_len, function()
        self:_RefreshUiByCurSkinIndex()
        self:PlayLeftIn()
      end)
    else
      self:PlayRightOut()
      self._timeEvents._swithLeftTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.right_out.time_len, function()
        self:_RefreshUiByCurSkinIndex()
        self:PlayRightIn()
      end)
    end
  else
    self:_RefreshUiByCurSkinIndex()
  end
end

function UIPetSkinsMainController:_SetMoveToCurSelIdx()
  self._targetPosX = self:_CalcPosX(self._curSelSkinIndex)
  self:_RefreshClothListSibling()
end

function UIPetSkinsMainController:_CreateScrollItem()
  self._contentWidth = self._cardWidth * self._skinsCellCount
  self._contentCenterPosX = self._contentWidth / 2
  self._sortTb = {}
  local itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
  local y = self._content.sizeDelta.y
  self._content.sizeDelta = Vector2(self._contentWidth, y)
  itemPool:SpawnObjects("UIPetSkinsSelectCell", self._skinsCellCount)
  local items = itemPool:GetAllSpawnList()
  self._items = items
  for i = 1, self._skinsCellCount do
    local cellSortTb = {}
    cellSortTb.idx = 0
    cellSortTb.posX = 0
    cellSortTb.absDis = 0
    self._sortTb[i] = cellSortTb
    local itemGo = items[i]:GetGameObject()
    itemGo.transform.anchorMin = Vector2(0, 0.5)
    itemGo.transform.anchorMax = Vector2(0, 0.5)
    itemGo.transform.sizeDelta = Vector2(self._cardWidth, self._cardHeight)
    local posY = items[i]:GetGameObject().transform.anchoredPosition.y
    itemGo.transform.anchoredPosition = Vector2(self._cardWidth * (i - 1) + self._cardWidth / 2, posY)
    items[i]:SetData(self._petSkinCfg[i], i, function(idx)
      if self._count <= 1 then
        return
      end
      self._cgBtnAreaGo:SetActive(false)
      self:_SelectSkinCellIdx(idx)
      self:_SetMoveToCurSelIdx()
      self._isDarging = false
    end, function(eventData)
      if self._count <= 1 then
        return
      end
      self._bDragPosX = eventData.position.x
      self._isDarging = true
      self._tmpContentPosX = self._content.anchoredPosition.x
      self._cgBtnAreaGo:SetActive(false)
    end, function(eventData)
    end, function(eventData)
      if self._count <= 1 then
        return
      end
      local lPosX = self._content.anchoredPosition.x - self._contentWidth / 2
      if 0 <= lPosX then
        lPosX = -self._cardWidth / 2
      elseif lPosX <= -self._contentWidth then
        lPosX = -self._contentWidth + self._cardWidth / 2
      end
      local absLPosX = math.abs(lPosX)
      local c = math.ceil(absLPosX / self._cardWidth)
      local _, d = math.modf(absLPosX / self._cardWidth)
      local tmpIdx = self._curSelSkinIndex
      self._eDragPosX = eventData.position.x
      tmpIdx = c
      if tmpIdx == self._curSelSkinIndex then
        if self._eDragPosX < self._bDragPosX then
          if 0.7 < d then
            tmpIdx = tmpIdx + 1
          end
        elseif d < 0.3 then
          tmpIdx = tmpIdx - 1
        end
      end
      local finalIdx = 1
      if tmpIdx > self._count then
        finalIdx = self._count
      elseif tmpIdx <= 0 then
        finalIdx = 1
      else
        finalIdx = tmpIdx
      end
      self:_SelectSkinCellIdx(finalIdx)
      self:_SetMoveToCurSelIdx()
      self._isDarging = false
    end)
  end
end

function UIPetSkinsMainController:_RefreshScrollItemStateData()
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
    self:_Detail_RefreshScrollItemStateData()
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL then
    self:_Shop_RefreshScrollItemStateData()
  elseif self._openType == PetSkinUiOpenType.PSUOT_TIPS then
    self:_Tips_RefreshScrollItemStateData()
  elseif self._openType == PetSkinUiOpenType.PSUOT_SEASON_SKIN then
    self:_Shop_RefreshScrollItemStateData()
  elseif self._openType == PetSkinUiOpenType.PSUT_ACTIVITY_DETAIL then
    self:_ACTIVITY_RefreshScrollItemStateData()
  end
end

function UIPetSkinsMainController:_Detail_RefreshScrollItemStateData()
  if not self._petModule then
    return
  end
  self._uiSkinsData = {}
  local petModuleInfo = self._petModule:GetPetByTemplateId(self._petId)
  if not petModuleInfo then
    return
  end
  self._cfg_grade = Cfg.cfg_pet_grade({
    PetID = self._petId,
    Grade = petModuleInfo:GetPetGrade()
  })
  self._skinsStateData = self._petModule:GetPetSkinsData(self._petId)
  if self._skinsStateData then
  end
  if self._petSkinCfg then
    for idx, skinCfg in ipairs(self._petSkinCfg) do
      local uiSkinData = DPetSkinDetailCard:New(skinCfg)
      uiSkinData:SetIsShopDetail(false)
      local is_obtain = false
      if self._skinsStateData then
        local curSkin = self._skinsStateData.current_skin
        local isCurSkin = curSkin == skinCfg.id
        if curSkin == 0 then
          isCurSkin = idx == 1
        end
        uiSkinData:SetIsCurrentSkin(isCurSkin)
        local obtainedSkinInfo = self._skinsStateData.skin_info
        if obtainedSkinInfo then
          for _, skinInfo in pairs(obtainedSkinInfo) do
            if skinInfo and skinInfo.skin_id == skinCfg.id then
              is_obtain = true
              uiSkinData:SetUnlockCg(skinInfo.unlock_CG)
              break
            end
          end
        end
      else
        local isCurSkin = idx == 1
        uiSkinData:SetIsCurrentSkin(isCurSkin)
      end
      uiSkinData:SetObtained(is_obtain)
      table.insert(self._uiSkinsData, uiSkinData)
    end
  end
end

function UIPetSkinsMainController:_Shop_RefreshScrollItemStateData()
  if not self._petModule then
    return
  end
  self._havePet = true
  self._uiSkinsData = {}
  local petModuleInfo = self._petModule:GetPetByTemplateId(self._petId)
  if not petModuleInfo then
    self._havePet = false
  end
  self._skinsStateData = self._petModule:GetPetSkinsData(self._petId)
  if self._skinsStateData then
  end
  if self._petSkinCfg then
    for idx, skinCfg in ipairs(self._petSkinCfg) do
      local uiSkinData = DPetSkinDetailCard:New(skinCfg)
      uiSkinData:SetIsShopDetail(true)
      local is_obtain = false
      uiSkinData:SetIsCurrentSkin(false)
      if self._skinsStateData then
        local obtainedSkinInfo = self._skinsStateData.skin_info
        if obtainedSkinInfo then
          for _, skinInfo in pairs(obtainedSkinInfo) do
            if skinInfo and skinInfo.skin_id == skinCfg.id then
              is_obtain = true
              uiSkinData:SetUnlockCg(skinInfo.unlock_CG)
              break
            end
          end
        end
      else
      end
      uiSkinData:SetObtained(is_obtain)
      table.insert(self._uiSkinsData, uiSkinData)
    end
  end
end

function UIPetSkinsMainController:_Tips_RefreshScrollItemStateData()
  if not self._petModule then
    return
  end
  self._havePet = true
  self._uiSkinsData = {}
  local petModuleInfo = self._petModule:GetPetByTemplateId(self._petId)
  if not petModuleInfo then
    self._havePet = false
  end
  self._skinsStateData = self._petModule:GetPetSkinsData(self._petId)
  if self._skinsStateData then
  end
  if self._petSkinCfg then
    for idx, skinCfg in ipairs(self._petSkinCfg) do
      local uiSkinData = DPetSkinDetailCard:New(skinCfg)
      uiSkinData:SetIsTipsDetail(true)
      local is_obtain = false
      uiSkinData:SetIsCurrentSkin(false)
      if self._skinsStateData then
        local obtainedSkinInfo = self._skinsStateData.skin_info
        if obtainedSkinInfo then
          for _, skinInfo in pairs(obtainedSkinInfo) do
            if skinInfo and skinInfo.skin_id == skinCfg.id then
              is_obtain = true
              uiSkinData:SetUnlockCg(skinInfo.unlock_CG)
              break
            end
          end
        end
      else
      end
      uiSkinData:SetObtained(is_obtain)
      table.insert(self._uiSkinsData, uiSkinData)
    end
  end
end

function UIPetSkinsMainController:_ACTIVITY_RefreshScrollItemStateData()
  if not self._petModule then
    return
  end
  self._havePet = true
  self._uiSkinsData = {}
  local petModuleInfo = self._petModule:GetPetByTemplateId(self._petId)
  if not petModuleInfo then
    self._havePet = false
  end
  self._skinsStateData = self._petModule:GetPetSkinsData(self._petId)
  if self._skinsStateData then
  end
  if self._petSkinCfg then
    for idx, skinCfg in ipairs(self._petSkinCfg) do
      local uiSkinData = DPetSkinDetailCard:New(skinCfg)
      uiSkinData:SetIsShopDetail(true)
      local is_obtain = false
      uiSkinData:SetIsCurrentSkin(false)
      if self._skinsStateData then
        local obtainedSkinInfo = self._skinsStateData.skin_info
        if obtainedSkinInfo then
          for _, skinInfo in pairs(obtainedSkinInfo) do
            if skinInfo and skinInfo.skin_id == skinCfg.id then
              is_obtain = true
              uiSkinData:SetUnlockCg(skinInfo.unlock_CG)
              break
            end
          end
        end
      else
      end
      uiSkinData:SetObtained(is_obtain)
      table.insert(self._uiSkinsData, uiSkinData)
    end
  end
end

function UIPetSkinsMainController:_RefreshScrollItemUiState()
  if not self._uiSkinsData then
    return
  end
  for idx, item in ipairs(self._items) do
    local data = self._uiSkinsData[idx]
    item:RefreshData(data)
  end
end

function UIPetSkinsMainController:_CalcPosX(idx)
  local posx = 0
  if not idx or self._count <= 1 then
    return posx
  end
  local startPos = self._contentWidth / 2 + self._cardWidth / 2
  posx = startPos - idx * self._cardWidth
  return posx
end

function UIPetSkinsMainController:_RefreshPetInfo()
  if not self._cfgPet then
    return
  end
  self._petNameCHLabel:SetText(StringTable.Get(self._cfgPet.Name))
  local enName = self._cfgPet.EnglishName
  local strEnName = StringTable.Get(enName)
  self._petNameENLabel:SetText(strEnName)
  self._petLogoIconLoader:LoadImage(self._cfgPet.Logo)
  self:_SetSubTitleColor()
end

function UIPetSkinsMainController:_Refresh3DModel()
  if self._modelShowMng then
    self._modelShowMng:ShowPetSkinModel(self._curSelSkinId)
  end
end

function UIPetSkinsMainController:_Release3d()
  if self._modelShowMng then
    self._modelShowMng:Reset()
  end
end

function UIPetSkinsMainController:_RefreshDesignInfo()
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  if cfgSkin then
    self._designText:SetText(StringTable.Get(cfgSkin.DesignStr))
    local timerEvent = GameGlobal.Timer():AddEventTimes(100, 1, function()
      if self._designTextTrans.sizeDelta.y < self._designScrollRect.sizeDelta.y then
        self._designScroll.vertical = false
      else
        self._designScroll.vertical = true
      end
    end)
  end
end

function UIPetSkinsMainController:CloseSubPanelAreaOnClick(go)
  if self._3DModelShow then
    self:ModelBtnOnClick(nil)
  elseif self._DesignInfoShow then
    self:DesignInfoBtnOnClick(nil)
  end
end

function UIPetSkinsMainController:ModelBtnOnClick(go)
  do return end
  self._3DModelShow = not self._3DModelShow
  self._DesignInfoShow = false
  self._designInfoBtnImg.sprite = self.atlas:GetSprite("fashion_main_frame9")
  self._designInfoBtnText:SetText(StringTable.Get("str_pet_skin_show_design_info"))
  self._subPanelAreaGo:SetActive(self._3DModelShow)
  self._closeSubPanelAreaGo:SetActive(self._3DModelShow)
  self._3DPanelGo:SetActive(self._3DModelShow)
  self._designPanelGo:SetActive(false)
  if self._3DModelShow then
    self:_Set3DModelTitle()
    self:_Refresh3DModel()
    self._modelBtnImg.sprite = self.atlas:GetSprite("fashion_main_frame10")
    self._modelBtnText:SetText(StringTable.Get("str_pet_skin_hide_model"))
  else
    self:_Release3d()
    self._modelBtnImg.sprite = self.atlas:GetSprite("fashion_main_frame9")
    self._modelBtnText:SetText(StringTable.Get("str_pet_skin_show_model"))
  end
  if self._3DModelShow then
    self:Lock("UIPetSkinsMainController:ModelBtnOnClick")
    if self._uiAnim then
      self._uiAnim:Play(self._animNames.show_3d.name)
    end
    self._timeEvents._show3dTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.show_3d.time_len, function()
      self:UnLock("UIPetSkinsMainController:ModelBtnOnClick")
    end)
  end
end

function UIPetSkinsMainController:DesignInfoBtnOnClick(go)
  self._DesignInfoShow = not self._DesignInfoShow
  self._3DModelShow = false
  self._modelBtnImg.sprite = self.atlas:GetSprite("fashion_main_frame9")
  self._modelBtnText:SetText(StringTable.Get("str_pet_skin_show_model"))
  self:_Release3d()
  self._subPanelAreaGo:SetActive(self._DesignInfoShow)
  self._closeSubPanelAreaGo:SetActive(self._DesignInfoShow)
  self._designPanelGo:SetActive(self._DesignInfoShow)
  self._3DPanelGo:SetActive(false)
  if self._DesignInfoShow then
    self:_SetDesignTitle()
    self:_RefreshDesignInfo()
    self._designInfoBtnImg.sprite = self.atlas:GetSprite("fashion_main_frame10")
    self._designInfoBtnText:SetText(StringTable.Get("str_pet_skin_hide_design_info"))
  else
    self._designInfoBtnImg.sprite = self.atlas:GetSprite("fashion_main_frame9")
    self._designInfoBtnText:SetText(StringTable.Get("str_pet_skin_show_design_info"))
  end
  if self._DesignInfoShow then
    self:Lock("UIPetSkinsMainController:DesignInfoBtnOnClick")
    if self._uiAnim then
      self._uiAnim:Play(self._animNames.show_design.name)
    end
    self._timeEvents._showDesignTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.show_design.time_len, function()
      self:UnLock("UIPetSkinsMainController:DesignInfoBtnOnClick")
    end)
  end
end

function UIPetSkinsMainController:FullScreenAnimBtnOnClick()
  if self._playSpineAnim then
    return
  end
  local cfg_pet_skin = Cfg.cfg_pet_skin[self._curSelSkinId]
  if not cfg_pet_skin then
    Log.error("###[UIMainLobbyFinal] cfg_pet_skin is nil ! id --> ", skinid)
    return
  end
  local spineAnims = cfg_pet_skin.MainLobbySpineAnim
  if not spineAnims then
    return
  end
  local animList = {}
  for i = 1, #spineAnims do
    local spineAnim = spineAnims[i]
    table.insert(animList, spineAnim)
  end
  if #animList == 0 then
    Log.error("###[UIMainLobbyFinal] animList is nil ! skinid --> ", skinid)
    return
  end
  local randomVal = math.random(#animList)
  local anim = animList[randomVal]
  local animationName = anim
  if not self._dcgHandle then
    Log.debug("###[UIMainLobbyFinal] self._dcgHandle is nil --> ", self._dynamicSpineSettings)
    return
  end
  local entry = self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, false)
  self._dcgHandle:SetAnimMixTime(0)
  self._dcgHandle:Update(0)
  if self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Spine or self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.None then
    self:PlayClickAnimBackIdleBySpine(entry)
  elseif self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Live2D then
    self:PlayClickAnimBackIdleByLive2d(entry)
  end
end

function UIPetSkinsMainController:PlayClickAnimBackIdleBySpine(entry)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  self._playSpineAnim = true
  self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._playSpineAnim = false
    local animationName = "idle"
    self._dcgHandle:SetAnimation(0, animationName, true)
    self._dcgHandle:SetAnimMixTime(0)
    self._dcgHandle:Update(0)
  end)
  Log.debug("###[UIMainLobbyFinal] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
end

function UIPetSkinsMainController:PlayClickAnimBackIdleByLive2d(anim)
  if anim then
    local duration = anim.length
    local yieldTime = math.floor(duration * 1000)
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
      self._playSpineAnim = false
    end
    self._playSpineAnim = true
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = "idle"
      self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, true)
    end)
  end
end

function UIPetSkinsMainController:CgBtnOnClick(go)
  local curUiData = self._uiSkinsData[self._curSelSkinIndex]
  local skinCfg = self._petSkinCfg[self._curSelSkinIndex]
  if curUiData and skinCfg then
    if curUiData:IsObtained() then
      if skinCfg.CgId then
        if curUiData:IsUnlockCg() then
          self:_PlayCurSelSkinCg(false)
        else
          ToastManager.ShowToast(StringTable.Get("str_pet_skin_cg_lock_story"))
        end
      end
    else
      ToastManager.ShowToast(StringTable.Get("str_pet_skin_cg_lock_story"))
    end
  end
end

function UIPetSkinsMainController:_ConfirmToPlayCurSelSkinStory(bFirst)
  local strTitle = ""
  local strText = ""
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  if cfgSkin then
    local storyId = cfgSkin.StoryId
    local storyCfg = Cfg.cfg_pet_story[storyId]
    if storyCfg then
      local tipsStr = "str_pet_skin_collect_fashion_story_tips_2"
      local titleStr = "str_quest_base_type_stroy"
      if cfgSkin.CgId then
        tipsStr = "str_pet_skin_collect_fashion_story_tips_1"
        titleStr = "str_pet_skin_collect_fashion_story"
      end
      strText = StringTable.Get(tipsStr, StringTable.Get(storyCfg.Title))
      strTitle = StringTable.Get(titleStr)
    else
      Log.exception("cfg_pet_story 中缺少配置:", storyId)
    end
  end
  
  local function okCb()
    self:_PlayCurSelSkinStory(bFirst)
  end
  
  local okBtnText = StringTable.Get("str_pet_skin_enter")
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, strTitle, strText, okCb, nil, nil, nil, nil, okBtnText)
end

function UIPetSkinsMainController:_PlayCurSelSkinStory(bFirst)
  local isFirst = bFirst or false
  local skinCfg = self._petSkinCfg[self._curSelSkinIndex]
  if skinCfg and skinCfg.StoryId then
    local storyCfg = Cfg.cfg_pet_story[skinCfg.StoryId]
    if storyCfg then
      GameGlobal.GetModule(StoryModule):StartStory(storyCfg.StoryID, function()
        self:_StoryPlayEnd(skinCfg.StoryId, isFirst, skinCfg.CgId)
      end, true)
    end
  end
end

function UIPetSkinsMainController:_PlayCurSelSkinCg(bFirst)
  local isFirst = bFirst or false
  local skinCfg = self._petSkinCfg[self._curSelSkinIndex]
  if skinCfg and skinCfg.CgId then
    local cgCfg = Cfg.cfg_cg_book[skinCfg.CgId[1]]
    if cgCfg then
      self:ShowDialog("UIPetSkinsGetCgController", cgCfg.StaticPic, isFirst, skinCfg.CgId, 1)
    end
  end
end

function UIPetSkinsMainController:_StoryPlayEnd(storyid, isFirst, cgId)
  if isFirst then
    self._unlockCgTaskID = self:StartTask(function(TT)
      self:Lock("UIPetSkinsMainController:_StoryPlayEnd")
      local res = self._petModule:UnlockSkinCG(TT, self._curSelSkinId)
      if res:GetSucc() then
        if cgId then
          self:_PlayCurSelSkinCg(true)
        else
          self:_ShowStoryTips()
        end
        GameGlobal.EventDispatcher():Dispatch(GameEventType.WatchPetSkinStory)
      end
      self:_ForceRefreshUi()
      self:UnLock("UIPetSkinsMainController:_StoryPlayEnd")
    end)
  end
end

function UIPetSkinsMainController:_ShowStoryTips()
  self:Lock("UIPetSkinsMainController:_ShowStoryTips")
  self:ShowDialog("UIAircraftUnlockFileController", StringTable.Get("str_aircraft_review_story"), StringTable.Get("str_aircraft_review_story_en"))
  GameGlobal.Timer():AddEvent(3000, function()
    GameGlobal.UIStateManager():CloseDialog("UIAircraftUnlockFileController")
    self:UnLock("UIPetSkinsMainController:_ShowStoryTips")
  end)
end

function UIPetSkinsMainController:_ConfirmToUseNewSkin()
  local strTitle = StringTable.Get("str_pet_skin_get_new_skin")
  local petName = StringTable.Get(self._cfgPet.Name)
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  local skinName = ""
  local skinType = ""
  if cfgSkin then
    skinName = StringTable.Get(cfgSkin.SkinName)
    if cfgSkin.SkinType == PetSkinFlag.PSF_NORMAL then
      skinType = StringTable.Get("str_pet_skin_fashion")
    elseif cfgSkin.SkinType == PetSkinFlag.PSF_COLLECTION then
      skinType = StringTable.Get("str_pet_skin_collect_fashion")
    end
  end
  local strText = StringTable.Get("str_pet_skin_net_skin_tips", petName, skinType, skinName)
  
  local function okCb()
    self:_TryUseSkin(self._curSelSkinId, true)
  end
  
  local okBtnText = StringTable.Get("str_pet_skin_change")
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, strTitle, strText, okCb, nil, nil, nil, nil, okBtnText)
end

function UIPetSkinsMainController:_TryUseSkin(skinId, inShop)
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  if not cfgSkin then
    return
  end
  if not self._petModule:HasPet(cfgSkin.PetId) then
    ToastManager.ShowToast(StringTable.Get("str_pet_skin_change_fail_tips"))
    return
  end
  if GameSingle then
    PlayerPrefsSetPersonString("PetSkin_" .. cfgSkin.PetId, skinId)
    local skindata = self._petModule:GetPetSkinsData(cfgSkin.PetId)
    if skindata ~= nil then
      skindata.current_skin = skinId
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetSkinChange)
    end
    self:_ForceRefreshUi()
    return
  end
  self._tryUseSkinTaskId = self:StartTask(self._TaskTryUseSkin, self, skinId, inShop)
end

function UIPetSkinsMainController:_TaskTryUseSkin(TT, skinId, inShop)
  self:Lock("UIPetSkinsMainController_UseSkin")
  local res = self._petModule:PetSkinChange(TT, skinId)
  if res:GetSucc() then
    if inShop then
      ToastManager.ShowToast(StringTable.Get("str_pet_skin_change_success_tips"))
    end
    self:_ForceRefreshUi()
    self:UnLock("UIPetSkinsMainController_UseSkin")
  else
    self:UnLock("UIPetSkinsMainController_UseSkin")
  end
end

function UIPetSkinsMainController:UseBtnOnClick(go)
  self:_TryUseSkin(self._curSelSkinId, false)
end

function UIPetSkinsMainController:_Set3DModelTitle()
  if not self._cfgPet then
    return
  end
  local petName = StringTable.Get(self._cfgPet.Name)
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  local skinName = ""
  if cfgSkin then
    skinName = StringTable.Get(cfgSkin.SkinName)
  end
  local title = StringTable.Get("str_pet_skin_show_model_title")
  self._subPanelTitleText:SetText(title)
end

function UIPetSkinsMainController:_SetDesignTitle()
  if not self._cfgPet then
    return
  end
  local petName = StringTable.Get(self._cfgPet.Name)
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  local skinName = ""
  if cfgSkin then
    skinName = StringTable.Get(cfgSkin.SkinName)
  end
  local title = StringTable.Get("str_pet_skin_show_design_info")
  self._subPanelTitleText:SetText(title)
end

function UIPetSkinsMainController:_SetSubTitleColor()
  local petCfg = self._cfgPet
  local tags = petCfg.Tags
  if not tags or tags[1] == nil then
    return
  end
  local tag = tags[1]
  local color = self._campSubTitleAreaColor[tag]
  if color then
    self._subPanelTitleAreaImg.color = color
  end
end

function UIPetSkinsMainController:_SetCampBg(templateId, skinId, imageLoader)
  local skinCfg = Cfg.cfg_pet_skin[skinId]
  if skinCfg and skinCfg.CampBg then
    imageLoader:LoadImage(skinCfg.CampBg)
    return
  end
  local petCfg = self._cfgPet
  local tags = petCfg.Tags
  if not tags or tags[1] == nil then
    return
  end
  local tag = tags[1]
  local campBg = self._campBg[tag]
  if campBg then
    imageLoader:LoadImage(campBg)
  end
end

function UIPetSkinsMainController:LeftArrowOnClick(go)
  if self._count <= 1 then
    return
  end
  if 1 >= self._curSelSkinIndex then
    return
  end
  local idx = self._curSelSkinIndex - 1
  self:_SelectSkinCellIdx(idx)
  self:_SetMoveToCurSelIdx()
  self._isDarging = false
end

function UIPetSkinsMainController:RightArrowOnClick(go)
  if self._count <= 1 then
    return
  end
  if self._curSelSkinIndex >= self._count then
    return
  end
  local idx = self._curSelSkinIndex + 1
  self:_SelectSkinCellIdx(idx)
  self:_SetMoveToCurSelIdx()
  self._isDarging = false
end

function UIPetSkinsMainController:_InitSkinListData()
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
    self._petSkinCfg = Cfg.cfg_pet_skin({
      PetId = self._petId
    })
    table.sort(self._petSkinCfg, function(a, b)
      return a.id < b.id
    end)
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL then
    self._petSkinCfg = {}
    self._petSkinCfg[1] = Cfg.cfg_pet_skin[self._curSelSkinId]
  elseif self._openType == PetSkinUiOpenType.PSUOT_TIPS then
    self._petSkinCfg = {}
    self._petSkinCfg[1] = Cfg.cfg_pet_skin[self._curSelSkinId]
  elseif self._openType == PetSkinUiOpenType.PSUOT_SEASON_SKIN then
    self._petSkinCfg = {}
    self._petSkinCfg[1] = Cfg.cfg_pet_skin[self._curSelSkinId]
  else
    if self._openType == PetSkinUiOpenType.PSUT_ACTIVITY_DETAIL then
      self._petSkinCfg = {}
      self._petSkinCfg[1] = Cfg.cfg_pet_skin[self._curSelSkinId]
    else
    end
  end
end

function UIPetSkinsMainController:_RefreshUiByCurSkinIndex()
  local curCfg = self._petSkinCfg[self._curSelSkinIndex]
  if not curCfg then
    return
  end
  if string.isnullorempty(curCfg.Logo) then
    self._petLogoGo:SetActive(false)
  else
    self._petLogoGo:SetActive(true)
    self._petLogoImageLoader:LoadImage(curCfg.Logo)
  end
  self._curSelSkinId = curCfg.id
  self:_SetCgBySkin(self._curSelSkinId)
  self:_SetSpineBySkin(curCfg.Spine)
  self:_SetSkinNameBySkin(self._curSelSkinId)
  self:_SetCampBg(self._petId, self._curSelSkinId, self._campBgLoader)
  self:_CheckInfoBtnShow()
  if self._3DModelShow then
    self:_Refresh3DModel()
  elseif self._DesignInfoShow then
    self:_RefreshDesignInfo()
  end
  self:ShowStaticAndDynamic()
  self:_RefreshStateAreaByCurSkinIndex()
  self:_RefreshCgMiniBtnAreaByCurSkinIndex(curCfg)
  self:_CheckOtherSkin()
end

function UIPetSkinsMainController:_CheckInfoBtnShow()
  local curUiData = self._uiSkinsData[self._curSelSkinIndex]
  local skinCfg = Cfg.cfg_pet_skin[self._curSelSkinId]
  if not skinCfg then
    return
  end
  if not skinCfg.DesignStr or skinCfg.DesignStr == "" then
    self._designInfoBtnGo:SetActive(false)
    if self._DesignInfoShow then
      self:DesignInfoBtnOnClick(nil)
    end
  else
    self._designInfoBtnGo:SetActive(true)
  end
  if skinCfg.StoryId then
    self._storyInfoBtnObj:SetActive(true)
    if curUiData:IsObtained() then
      self._StoryInfoBtnText:SetText(StringTable.Get("str_pet_skin_story_obtained"))
      self._storyLockObj:SetActive(false)
      if curUiData:IsUnlockCg() then
        self._storyRedPointObj:SetActive(false)
      else
        self._storyRedPointObj:SetActive(true)
      end
    else
      self._storyRedPointObj:SetActive(false)
      self._storyLockObj:SetActive(true)
      self._StoryInfoBtnText:SetText(StringTable.Get("str_pet_skin_story_unobtained"))
    end
  else
    self._storyInfoBtnObj:SetActive(false)
  end
end

function UIPetSkinsMainController:_SetSkinNameBySkin(skinId)
  local skinCfg = Cfg.cfg_pet_skin[skinId]
  if not skinCfg then
    return
  end
  local skinTitleFmt = "\"%s\""
  local title = string.format(skinTitleFmt, StringTable.Get(skinCfg.SkinName))
  self._petSkinNameText:SetText(title)
end

function UIPetSkinsMainController:_RefreshStateAreaByCurSkinIndex()
  if not self._uiSkinsData then
    return
  end
  local curUiData = self._uiSkinsData[self._curSelSkinIndex]
  if curUiData then
    if curUiData:IsShopDetail() then
      if curUiData:IsObtained() then
        self:_ShowStateArea(PetSkinStateType.PSST_SHOP_OBTAINED)
      else
        self:_ShowStateArea(PetSkinStateType.PSST_SHOP_BUY)
        self:_RefreshPriceBtn()
      end
    elseif curUiData:IsTipsDetail() then
      if curUiData:IsObtained() then
        self:_ShowStateArea(PetSkinStateType.PSST_SHOP_OBTAINED)
      else
        self:_ShowStateArea(PetSkinStateType.PSST_NOT_OBTAIN)
        self:_RefreshSkinGetPathText()
      end
    elseif curUiData:IsCurrentSkin() then
      self:_ShowStateArea(PetSkinStateType.PSST_CUR_SKIN)
    elseif curUiData:IsObtained() then
      self:_ShowStateArea(PetSkinStateType.PSST_CAN_USE)
    else
      self:_ShowStateArea(PetSkinStateType.PSST_NOT_OBTAIN)
      self:_RefreshSkinGetPathText()
    end
  end
end

function UIPetSkinsMainController:_RefreshCgMiniBtnAreaByCurSkinIndex(skinCfg)
  local showArea = false
  if self._timeEvents._cgSwitchTimer then
    GameGlobal.Timer():CancelEvent(self._timeEvents._cgSwitchTimer)
    self._timeEvents._cgSwitchTimer = nil
  end
  if skinCfg then
    if skinCfg.CgId then
      showArea = true
      local cgCfg = Cfg.cfg_cg_book[skinCfg.CgId[1]]
      if cgCfg then
        if cgCfg.SkinCgPreview then
          self._cgMiniImgLoader:LoadImage(cgCfg.SkinCgPreview)
        end
        if 1 < table.count(skinCfg.CgId) then
          self._timeEvents._cgSwitchTimer = GameGlobal.Timer():AddEventTimes(self._cgPreviewSwitchTimer, TimerTriggerCount.Infinite, function()
            if tolua.isnull(self._cgMiniImgLoader) then
              return
            end
            local lastIndex = self._cgPreviewSwitchIndex + 1
            self._cgPreviewSwitchIndex = lastIndex > table.count(skinCfg.CgId) and 1 or lastIndex
            local cgCfg = Cfg.cfg_cg_book[skinCfg.CgId[self._cgPreviewSwitchIndex]]
            self._cgMiniImgLoader:LoadImage(cgCfg.SkinCgPreview)
          end)
        end
      end
    else
      showArea = false
    end
  end
  self._cgBtnAreaGo:SetActive(showArea)
  if showArea then
    if table.count(skinCfg.CgId) > 1 then
      self._cgTipsText:SetText(StringTable.Get("str_pet_skin_double_text", table.count(skinCfg.CgId)))
    else
      self._cgTipsText:SetText(StringTable.Get("str_pet_skin_cg_text"))
    end
  end
end

function UIPetSkinsMainController:_ShowStateArea(state)
  for key, value in pairs(self._stateAreas) do
    value:SetActive(key == state)
  end
  if state == PetSkinStateType.PSST_SHOP_OBTAINED then
    self._binderCurrency:SetActive(false)
  end
  self._topTipGo:SetActive(false)
end

function UIPetSkinsMainController:_RefreshSkinGetPathText()
  local skinCfg = self._petSkinCfg[self._curSelSkinIndex]
  if skinCfg then
    local getPathStr = ""
    if skinCfg.ObtainPathStr then
      getPathStr = skinCfg.ObtainPathStr
    elseif skinCfg.UnlockType then
      local unlockType = skinCfg.UnlockType[1]
      if unlockType == PetSkinUnlockType.PSUT_BASE then
      elseif unlockType == PetSkinUnlockType.PSUT_GRADE then
        getPathStr = "str_pet_skin_get_path_1"
      elseif unlockType == PetSkinUnlockType.PSUT_SHOP then
        getPathStr = "str_pet_skin_get_path_2"
      elseif unlockType == PetSkinUnlockType.PSUT_Dream then
        getPathStr = "str_pet_skin_get_path_6"
      end
    end
    self._getPathText:RefreshText(StringTable.Get(getPathStr))
  end
end

function UIPetSkinsMainController:_RefreshPriceBtn()
  if self._shopGoodData then
    local binderItem = self._shopGoodData:GetBinderSkin()
    if binderItem then
      self._buyBtnGo:SetActive(false)
      self._binderCurrency:SetActive(true)
      local img = self._shopGoodData:GetPriceIcon()
      self._binderNormalImg.sprite = self._atlas:GetSprite(self._shopGoodData:GetPriceIcon())
      self._binderNormalPrice:SetText(self._shopGoodData:GetPrice())
      self._binderCurrencyPrice:SetText(binderItem:GetPriceWithCurrencySymbol())
    else
      self._buyBtnGo:SetActive(true)
      self._binderCurrency:SetActive(false)
      local itemtType = self._shopGoodData:GetType()
      if itemtType == SkinsPayType.Currency then
        self._imgPrice.gameObject:SetActive(false)
        self._priceText:SetText(self._shopGoodData:GetPriceWithCurrencySymbol())
      elseif itemtType == SkinsPayType.Free then
        self._imgPrice.gameObject:SetActive(false)
        self._priceText:SetText(StringTable.Get("str_pay_free"))
      else
        self._imgPrice.gameObject:SetActive(true)
        self._imgPrice.sprite = self._atlas:GetSprite(self._shopGoodData:GetPriceIcon())
        self._priceText:SetText(self._shopGoodData:GetPrice())
      end
    end
    local id
    local type = self._shopGoodData:GetType()
    if type == SkinsPayType.Guangpo then
      id = RoleAssetID.RoleAssetGlow
    elseif type == SkinsPayType.Yaojing then
      id = RoleAssetID.RoleAssetDiamond
    elseif type == SkinsPayType.Item then
      id = self._shopGoodData:GetPriceItemId()
    elseif type == SkinsPayType.ConvertCost then
      id = self._shopGoodData:GetPriceItemId()
    end
    if id then
      self._topTipGo:SetActive(true)
      self._topTip:SetData({id}, false)
    end
  elseif self._activityShopData then
    self._buyBtnGo:SetActive(true)
    self._binderCurrency:SetActive(false)
    self._imgPrice.gameObject:SetActive(true)
    local costItemID = self._activityShopData:GetCostItemId()
    local topCfg = Cfg.cfg_top_tips[costItemID]
    self._imgPrice.sprite = self._atlas:GetSprite(topCfg.Icon)
    self._priceText:SetText(self._activityShopData:GetSalePrice())
    self._topTipGo:SetActive(true)
    self._topTip:SetData({costItemID}, false)
  elseif self._seasonID then
    self._buyBtnGo:SetActive(true)
    self._binderCurrency:SetActive(false)
    self._imgPrice.gameObject:SetActive(true)
    local costItemID = self._seasonCompItemInfo.m_cost_item_id
    local topCfg = Cfg.cfg_top_tips[costItemID]
    self._imgPrice.sprite = self._atlas:GetSprite(topCfg.Icon)
    self._priceText:SetText(self._seasonCompItemInfo.m_cost_count)
    self._topTipGo:SetActive(true)
    self._topTip:SetData({costItemID}, false)
  end
end

function UIPetSkinsMainController:_SetCgBySkin(skinId)
  local skinCfg = Cfg.cfg_pet_skin[skinId]
  if not skinCfg then
    return
  end
  local staticBody
  if skinCfg.MainLobbyCg then
    staticBody = skinCfg.MainLobbyCg
  else
    staticBody = skinCfg.StaticBody
  end
  if staticBody then
    local uiName = self:GetName()
    local isSpecial = false
    if skinCfg.MainLobbySize then
      isSpecial = true
      self._cgSpecial:LoadImage(staticBody)
    else
      isSpecial = false
      UICG.SetTransform(self._cg_mid.transform, uiName .. "_mid", staticBody)
      UICG.SetTransform(self._cgRect, uiName, staticBody)
      Log.debug("UIPetSkinsMainController cgNormal Load ", skinId, " ", staticBody)
      self._cgNormal:Load(staticBody)
    end
    self._cgNormal.gameObject:SetActive(not isSpecial)
    self._cgSpecial.gameObject:SetActive(isSpecial)
    self._cg_mid:LoadImage(staticBody)
  else
    Log.fatal("### [error] pet [", skinId, "] no StaticBody")
  end
end

function UIPetSkinsMainController:_SetSpineBySkin(spineName)
  if self._dcgHandle == nil then
    self._dcgHandle = DynamicCG.SyncLoad(spineName, nil, self._spineRoot)
  else
    self._dcgHandle:ChangeDynamicCGSync(spineName)
  end
  UICG.SetTransform(self._spineRoot.transform, self:GetName(), spineName)
end

function UIPetSkinsMainController:OnUpdate(deltaTimeMS)
  if self._isScrollReady then
    if self._count <= 1 then
      return
    end
    if not self._isDarging then
      local absDis = math.abs(self._content.anchoredPosition.x - self._targetPosX)
      if 1 < absDis then
        local moveTime = 0.5
        self._content.anchoredPosition = Vector2(Mathf.Lerp(self._content.anchoredPosition.x, self._targetPosX, moveTime), self._content.anchoredPosition.y)
      else
        self._content.anchoredPosition = Vector2(self._targetPosX, self._content.anchoredPosition.y)
      end
    end
    if self._content.anchoredPosition.x ~= self._lastContentPosX then
      self._lastContentPosX = self._content.anchoredPosition.x
      self:_RefreshClothListSibling()
    end
  end
end

function UIPetSkinsMainController:_CalSkinListOrderLayer(absDis)
  local param = self._cardWidth
  if param <= 0 then
    return 1
  end
  local a, b = math.modf(absDis / param)
  return a
end

function UIPetSkinsMainController:_RefreshClothListSibling()
  if not self._items then
    return
  end
  local curCenterPosX = self._contentCenterPosX - self._content.anchoredPosition.x
  local minAbs = -1
  local topCellPos = -1
  for index, item in ipairs(self._items) do
    local posX = item:GetGameObject().transform.anchoredPosition.x
    local absDis = math.abs(curCenterPosX - posX)
    local tmpCell = self._sortTb[index]
    if minAbs < 0 or minAbs > absDis then
      minAbs = absDis
      topCellPos = posX
    end
    if tmpCell then
      tmpCell.idx = index
      tmpCell.posX = posX
      tmpCell.absDis = absDis
    end
  end
  table.sort(self._sortTb, function(a, b)
    return a.absDis > b.absDis
  end)
  for index, value in ipairs(self._sortTb) do
    local item = self._items[value.idx]
    local itemGo = item:GetGameObject()
    itemGo.transform:SetSiblingIndex(index - 1)
    if index == self._skinsCellCount then
      item:SetIsOnTop(true)
    else
      item:SetIsOnTop(false)
    end
    local absToTop = math.abs(value.posX - topCellPos)
    local orderLayer = self:_CalSkinListOrderLayer(absToTop + 1)
    item:SetOrderLayer(orderLayer)
  end
end

function UIPetSkinsMainController:BuyBtnOnClick(go)
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL then
    if self._shopGoodData then
      local itemtType = self._shopGoodData:GetType()
      if itemtType == SkinsPayType.Yaojing then
        self:_buyConfirmForYaojing()
      else
        self:_goBuyFunc()
      end
    end
  elseif self._openType == PetSkinUiOpenType.PSUT_ACTIVITY_DETAIL then
    if self._buyCallback then
      self._buyCallback()
    end
  elseif self._openType == PetSkinUiOpenType.PSUOT_SEASON_SKIN then
    self:BuySeasonSkin()
  end
end

function UIPetSkinsMainController:BuySeasonSkin(go)
  self:ShowDialog("UISeasonSkinConfirmNormalController", self._seasonID, self._seasonComp, self._seasonCompItemInfo)
end

function UIPetSkinsMainController:binderNormalBuyBtnOnClick(go)
  self:BuyBtnOnClick(go)
end

function UIPetSkinsMainController:binderCurrencyBuyBtnOnClick(go)
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL and self._shopGoodData then
    ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
  end
end

function UIPetSkinsMainController:OnCurrencyBtnOnClick()
  local binderItem = self._shopGoodData:GetBinderSkin()
  local midasId = binderItem:GetMidasId()
  if string.isnullorempty(midasId) then
    GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "midasId_is_empty")
    Log.fatal("###[UIPetSkinsMainController] [Pay] midasId can't be empty")
    return
  end
  self:StartTask(function(TT)
    local ret = self._shopModule:CEventBuyPetSkin(TT, binderItem:GetId())
    if ClientShop.CheckShopCode(ret:GetResult()) then
      self:CanCharge(midasId, binderItem)
    end
  end, self)
end

function UIPetSkinsMainController:_buyConfirmForYaojing()
  local price = self._shopGoodData:GetPrice()
  local petName = StringTable.Get(self._cfgPet.Name)
  local cfgSkin = Cfg.cfg_pet_skin[self._curSelSkinId]
  local skinName = ""
  local msgStrKey = ""
  if cfgSkin then
    skinName = StringTable.Get(cfgSkin.SkinName)
    if cfgSkin.SkinType == PetSkinFlag.PSF_NORMAL then
      msgStrKey = "str_shop_skin_confirm_to_buy_1"
    elseif cfgSkin.SkinType == PetSkinFlag.PSF_COLLECTION then
      msgStrKey = "str_shop_skin_confirm_to_buy_2"
    elseif cfgSkin.SkinType == PetSkinFlag.PSF_MEMORY then
      msgStrKey = "str_shop_skin_confirm_to_buy_4"
    end
    if cfgSkin.UnlockSkinID and self._shareSkinDatas[1] and self._shareSkinDatas[2] then
      petName = StringTable.Get(self._shareSkinDatas[1].petCfg.Name) .. "/" .. StringTable.Get(self._shareSkinDatas[2].petCfg.Name)
    end
  end
  local strText = StringTable.Get(msgStrKey, price, petName, skinName)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", strText, function(param)
    self:_goBuyFunc()
  end, nil, nil, nil)
end

function UIPetSkinsMainController:_goBuyFunc()
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
  elseif self._openType == PetSkinUiOpenType.PSUT_SHOP_DETAIL and self._shopGoodData then
    local itemtType = self._shopGoodData:GetType()
    if itemtType == SkinsPayType.Currency then
      local midasId = self._shopGoodData:GetMidasId()
      if string.isnullorempty(midasId) then
        GameGlobal.GetUIModule(ShopModule):ReportPayStep(PayStep.ClickPurchaseButton, false, -1, "midasId_is_empty")
        Log.fatal("### [Pay]midasId can't be empty")
        return
      end
      ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
    elseif itemtType == SkinsPayType.Yaojing then
      local price = self._shopGoodData:GetPrice()
      if self._clientShop:CheckEnoughYJ(price, true, function()
        self:CloseDialog()
      end) then
        self:RequestBuySkin()
      else
      end
    elseif itemtType == SkinsPayType.Guangpo then
      local price = self._shopGoodData:GetPrice()
      if self._clientShop:CheckEnoughGP(price) then
        self:RequestBuySkin()
      else
        self:CloseDialog()
      end
    elseif itemtType == SkinsPayType.Item then
      local mRole = self:GetModule(RoleModule)
      local price = self._shopGoodData:GetPrice()
      local assetId = self._shopGoodData:GetPriceItemId()
      local count = mRole:GetAssetCount(assetId)
      if count and price and price <= count then
        if assetId == RoleAssetID.RoleAssetHistory then
          self:RequestBuySkinWithSeason()
        else
          self:RequestBuySkin()
        end
      else
        PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_item_not_enough"))
      end
    elseif itemtType == SkinsPayType.Free then
      self:RequestBuySkin()
    elseif itemtType == SkinsPayType.ConvertCost then
      local itemtConvertType = self._shopGoodData:GetConvertType()
      if itemtConvertType == SkinsConvertPayType.BattlePass then
        self:RequestBuySkinWithBattlePass()
      end
    else
      Log.fatal("### invalid SkinsPayType. itemtType=", itemtType)
    end
  end
end

function UIPetSkinsMainController:RequestBuySkin()
  self:StartTask(function(TT)
    self:Lock("UIPetSkinsMainControllerRequestBuySkin")
    local id = self._shopGoodData:GetId()
    local ret = self._shopModule:CEventBuyPetSkin(TT, id)
    if ClientShop.CheckShopCode(ret:GetResult()) then
      self._clientShop:SendProtocal(TT, ShopMainTabType.Skins)
      self:_ShowSkinObtain(self._curSelSkinId)
      self:_ForceRefreshUi()
    end
    self:UnLock("UIPetSkinsMainControllerRequestBuySkin")
  end, self)
end

function UIPetSkinsMainController:RequestBuySkinWithSeason()
  self:StartTask(function(TT)
    self:Lock("UIPetSkinsMainControllerRequestBuySkin")
    local shopModule = self:GetModule(ShopModule)
    local result = shopModule:BuyItem(TT, MarketType.Shop_Season, self._shopGoodData:GetId(), 1, self._shopGoodData:GetPriceItemId(), self._shopGoodData:GetPrice())
    if result and ClientShop.CheckShopCode(result) then
      self._clientShop:SendProtocal(TT, ShopMainTabType.Exchange)
      self:_ShowSkinObtain(self._curSelSkinId)
      self:_ForceRefreshUi()
    end
    self:UnLock("UIPetSkinsMainControllerRequestBuySkin")
  end, self)
end

function UIPetSkinsMainController:RequestBuySkinWithBattlePass()
  self:StartTask(function(TT)
    self:Lock("UIPetSkinsMainControllerRequestBuySkinWithBattlePass")
    local shopModule = self:GetModule(ShopModule)
    local result = shopModule:BuyItem(TT, MarketType.Shop_BattlePass, self._shopGoodData:GetId(), 1, self._shopGoodData:GetCostPriceItemId(), self._shopGoodData:GetCostPrice())
    if result and ClientShop.CheckShopCode(result) then
      self._clientShop:SendProtocal(TT, ShopMainTabType.Secret, MarketType.Shop_BattlePass)
      self:_ShowSkinObtain(self._curSelSkinId)
      self:_ForceRefreshUi()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateSecretBattlePassShop)
    end
    self:UnLock("UIPetSkinsMainControllerRequestBuySkinWithBattlePass")
  end, self)
end

function UIPetSkinsMainController:_OnCurrencyBuySkinSuccess()
  self:_ShowSkinObtain(self._curSelSkinId)
end

function UIPetSkinsMainController:_ShowSkinObtain(skinId)
  local roleAsset = RoleAsset:New()
  roleAsset.assetid = skinId
  roleAsset.count = 1
  local tempPets = {roleAsset}
  self:ShowDialog("UIPetSkinObtainController", roleAsset, function()
    GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
    self:_ConfirmToUseNewSkin()
  end)
end

function UIPetSkinsMainController:testbtnOnClick()
  local id = 90303
  local roleAsset = RoleAsset:New()
  roleAsset.assetid = id
  roleAsset.count = 1
  local tempPets = {roleAsset}
  self:ShowDialog("UIPetSkinObtainController", roleAsset, function()
  end)
end

function UIPetSkinsMainController:CanCharge(midasId, buyItem)
  self:Lock("UIPetSkinsMainController_CanCharge")
  GameGlobal.TaskManager():StartTask(self.CanChargeCoro, self, midasId, buyItem)
end

function UIPetSkinsMainController:CanChargeCoro(TT, midasId, buyItem)
  local roleModule = GameGlobal.GetModule(RoleModule)
  if not roleModule:IsJapanZone() then
    self:StartTask(self.BuyGoodsTask, self, midasId, 1, buyItem)
    self:UnLock("UIPetSkinsMainController_CanCharge")
    return
  end
  local payModule = GameGlobal.GetModule(PayModule)
  if payModule:NeedSelectAge(TT) then
    self:ShowDialog("UISetAgeConfirmController")
    self:UnLock("UIPetSkinsMainController_CanCharge")
    return
  end
  self:StartTask(self.BuyGoodsTask, self, midasId, 1, buyItem)
  self:UnLock("UIPetSkinsMainController_CanCharge")
end

function UIPetSkinsMainController:BuyGoodsTask(TT, itemId, itemCount, buyItem)
  local mPay = self:GetModule(PayModule)
  if IsAndroid() or IsUnityEditor() or IsPc() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local res, replyEvent = mPay:SendBuyGoodsRequest(TT, itemId, itemCount)
      Log.debug("UIDemoPayController:BuyGoodsTask IsAndroid start res ", res.m_result)
      if not res:GetSucc() then
        if res.m_result == PayErrorCode.PAY_ERROR_NOT_USE_MIDAS then
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_need_open_switch"))
        else
          PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_pay_direct_buy_fail_try_later"))
        end
      elseif not replyEvent then
        Log.debug("UIDemoPayController:BuyGoodsTask failed no replyEvent")
      elseif res.m_result == PayErrorCode.PAY_SUCC then
        local token = replyEvent.token
        local url = replyEvent.url_params
        Log.debug("UIDemoPayController:BuyGoodsTask success token ", token, " url ", url)
        mPay:BuySkinGoodsByUrl(url, buyItem)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      mPay:BuyGoodsBySkinShopItem(buyItem, itemCount)
    end
  elseif IsIos() then
    mPay:BuyGoodsBySkinShopItem(buyItem, itemCount)
  end
end

function UIPetSkinsMainController:_3dDrag(eventData)
  if self._modelShowMng then
    self._modelShowMng:OnDrag(eventData)
  end
end

function UIPetSkinsMainController:PlayLeftOut()
  self:Lock("UIPetSkinsMainController:PlayLeftOut")
  if self._uiAnim and self._bgAnim then
    self._uiAnim:Play(self._animNames.left_out.name_ui)
    self._bgAnim:Play(self._animNames.left_out.name_bg)
  end
  self._timeEvents._leftOutTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.left_out.time_len, function()
    self:UnLock("UIPetSkinsMainController:PlayLeftOut")
  end)
end

function UIPetSkinsMainController:PlayLeftIn()
  self:Lock("UIPetSkinsMainController:PlayLeftIn")
  if self._uiAnim and self._bgAnim then
    self._uiAnim:Play(self._animNames.left_in.name_ui)
    self._bgAnim:Play(self._animNames.left_in.name_bg)
  end
  self._timeEvents._leftInTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.left_in.time_len, function()
    self:UnLock("UIPetSkinsMainController:PlayLeftIn")
  end)
end

function UIPetSkinsMainController:PlayRightOut()
  self:Lock("UIPetSkinsMainController:PlayRightOut")
  if self._uiAnim and self._bgAnim then
    self._uiAnim:Play(self._animNames.right_out.name_ui)
    self._bgAnim:Play(self._animNames.right_out.name_bg)
  end
  self._timeEvents._rightOutTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.right_out.time_len, function()
    self:UnLock("UIPetSkinsMainController:PlayRightOut")
  end)
end

function UIPetSkinsMainController:PlayRightIn()
  self:Lock("UIPetSkinsMainController:PlayRightIn")
  if self._uiAnim and self._bgAnim then
    self._uiAnim:Play(self._animNames.right_in.name_ui)
    self._bgAnim:Play(self._animNames.right_in.name_bg)
  end
  self._timeEvents._rightInTimeEvent = GameGlobal.Timer():AddEvent(self._animNames.right_in.time_len, function()
    self:UnLock("UIPetSkinsMainController:PlayRightIn")
  end)
end

function UIPetSkinsMainController:OpenShop()
  self:CloseDialog()
end

function UIPetSkinsMainController:StoryInfoBtnOnClick()
  if self:IsShareSkin() then
    local data = self._shareSkinDatas[self._curShareSkinIndex]
    if data and data.skinCfg then
      local isObtained, isUnlock = self:_IsObtainUnlock(data)
      if isObtained then
        local isFirst = not isUnlock
        self:_ConfirmToPlayCurSelSkinStory(isFirst)
      else
        ToastManager.ShowToast(StringTable.Get("str_pet_skin_story_lock_buy"))
      end
    end
  else
    local curUiData = self._uiSkinsData[self._curSelSkinIndex]
    local skinCfg = self._petSkinCfg[self._curSelSkinIndex]
    if curUiData and skinCfg then
      if curUiData:IsObtained() then
        local isFirst = not curUiData:IsUnlockCg()
        self:_ConfirmToPlayCurSelSkinStory(isFirst)
      else
        ToastManager.ShowToast(StringTable.Get("str_pet_skin_story_lock_buy"))
      end
    end
  end
end

_class("ShareSkinData", Object)
ShareSkinData = ShareSkinData

function ShareSkinData:Constructor(petCfg, skinCfg)
  self.petCfg = petCfg
  self.skinCfg = skinCfg
end

function UIPetSkinsMainController:IsShareSkin()
  return #self._shareSkinDatas > 0
end

function UIPetSkinsMainController:_CheckOtherSkin()
  if self._openType == PetSkinUiOpenType.PSUOT_SHOW_LIST then
    self._pets:SetActive(false)
    return
  end
  local showPets = false
  local curSkinCfg = Cfg.cfg_pet_skin[self._curSelSkinId]
  local skinNameStr = StringTable.Get(curSkinCfg.SkinName)
  local petNameStr = ""
  if curSkinCfg and curSkinCfg.UnlockSkinID then
    local otherSkinCfg = Cfg.cfg_pet_skin[curSkinCfg.UnlockSkinID]
    if otherSkinCfg then
      local petCfg = Cfg.cfg_pet[curSkinCfg.PetId]
      local otherPetCfg = Cfg.cfg_pet[otherSkinCfg.PetId]
      if petCfg and otherPetCfg then
        self._shareSkinDatas[1] = ShareSkinData:New(petCfg, curSkinCfg)
        self._shareSkinDatas[2] = ShareSkinData:New(otherPetCfg, otherSkinCfg)
        local grade1 = 0
        local grade2 = 0
        local pet1 = self._petModule:GetPetByTemplateId(petCfg.ID)
        if pet1 then
          grade1 = pet1:GetPetGrade()
        end
        local pet2 = self._petModule:GetPetByTemplateId(otherPetCfg.ID)
        if pet2 then
          grade2 = pet2:GetPetGrade()
        end
        local icon1 = HelperProxy:GetInstance():GetPetHead(petCfg.ID, grade1, curSkinCfg.ID, PetSkinEffectPath.HEAD_ICON_PLAYER_INFO_HELP)
        local icon2 = HelperProxy:GetInstance():GetPetHead(otherPetCfg.ID, grade2, otherSkinCfg.ID, PetSkinEffectPath.HEAD_ICON_PLAYER_INFO_HELP)
        self._petHeadIcon[1]:LoadImage(icon1)
        self._petHeadIcon[2]:LoadImage(icon2)
        petNameStr = StringTable.Get(petCfg.Name) .. "/" .. StringTable.Get(otherPetCfg.Name)
        showPets = true
      end
    end
  end
  self._pets:SetActive(showPets)
  self._petDesc:SetText(StringTable.Get("str_pet_skin_sp_skin_desc", skinNameStr, petNameStr))
  self:_OnPetHeadOnClick(self._curShareSkinIndex)
end

function UIPetSkinsMainController:PetHead1OnClick(go)
  self:_OnPetHeadOnClick(1)
end

function UIPetSkinsMainController:PetHead2OnClick(go)
  self:_OnPetHeadOnClick(2)
end

function UIPetSkinsMainController:_OnPetHeadOnClick(index)
  index = index or 1
  self._curShareSkinIndex = index
  local data = self._shareSkinDatas[self._curShareSkinIndex]
  if data then
    if self._curShareSkinIndex == 1 then
      self._petMark.anchoredPosition = Vector2(-327.7, 0)
    else
      self._petMark.anchoredPosition = Vector2(-146.3, 0)
    end
    self:_RefreshNameStoryCG(data)
  end
end

function UIPetSkinsMainController:_RefreshNameStoryCG(data)
  local skinCfg = data.skinCfg
  self:_RefreshName(data.petCfg)
  if self._DesignInfoShow then
    self:DesignInfoBtnOnClick(nil)
  end
  self._designInfoBtnGo:SetActive(not string.isnullorempty(skinCfg.DesignStr))
  self._petLogoIconLoader:LoadImage(data.petCfg.Logo)
  self:_RefreshStoryBtn(data)
  self:_RefreshCgMiniBtnAreaByCurSkinIndex(skinCfg)
  self:RefreshCell(data)
end

function UIPetSkinsMainController:RefreshCell(data)
  if self._items then
    local item = self._items[self._curSelSkinIndex]
    if item then
      item:RefreshLogo(data.petCfg.Logo)
    end
  end
end

function UIPetSkinsMainController:_RefreshName(cfgPet)
  self._petNameCHLabel:SetText(StringTable.Get(cfgPet.Name))
  self._petNameENLabel:SetText(StringTable.Get(cfgPet.EnglishName))
end

function UIPetSkinsMainController:_RefreshStoryBtn(data)
  if data.skinCfg.StoryId then
    self._storyInfoBtnObj:SetActive(true)
    local isObtained, isUnlock = self:_IsObtainUnlock(data)
    if isObtained then
      self._StoryInfoBtnText:SetText(StringTable.Get("str_pet_skin_story_obtained"))
      if isUnlock then
        self._storyRedPointObj:SetActive(false)
      else
        self._storyRedPointObj:SetActive(true)
      end
      self._storyLockObj:SetActive(false)
    else
      self._storyLockObj:SetActive(true)
      self._storyRedPointObj:SetActive(false)
      self._StoryInfoBtnText:SetText(StringTable.Get("str_pet_skin_story_unobtained"))
    end
  else
    self._storyInfoBtnObj:SetActive(false)
  end
end

function UIPetSkinsMainController:_IsObtainUnlock(data)
  local isObtain = false
  local isUnlock = false
  local skinData = self._petModule:GetPetSkinsData(data.petCfg.ID)
  if skinData then
    local obtainedSkinInfo = skinData.skin_info
    if obtainedSkinInfo then
      for _, skinInfo in pairs(obtainedSkinInfo) do
        if skinInfo and skinInfo.skin_id == data.skinCfg.id then
          isObtain = true
          if skinInfo.unlock_CG == 1 and data.skinCfg.StoryId then
            isUnlock = true
          end
          break
        end
      end
    end
  end
  return isObtain, isUnlock
end
