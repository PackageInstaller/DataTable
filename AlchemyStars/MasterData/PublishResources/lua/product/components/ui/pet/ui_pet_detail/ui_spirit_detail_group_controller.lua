require("rawimage_loader_helper")
require("spine_loader_helper")
_class("UISpiritDetailGroupController", UIController)
UISpiritDetailGroupController = UISpiritDetailGroupController

function UISpiritDetailGroupController:Constructor()
  self._spriteWithElement = {
    [1] = "spirit_xiangqing_di7",
    [2] = "spirit_xiangqing_di4",
    [3] = "spirit_xiangqing_di6",
    [4] = "spirit_xiangqing_di5",
    [6] = "spirit_xiangqing_di37"
  }
  self._colorWithElement = {
    [1] = Color(0.06274509803921569, 0.5176470588235295, 0.8352941176470589),
    [2] = Color(0.8274509803921568, 0.17254901960784313, 0.03529411764705882),
    [3] = Color(0.5372549019607843, 0.615686274509804, 0 / 255),
    [4] = Color(0.8196078431372549, 0.6509803921568628, 0.00784313725490196),
    [6] = Color(0.6705882352941176, 0.6705882352941176, 0.6705882352941176)
  }
  self._currentTaskID = -1
  self._petInfos = nil
  self._maxStarLevel = 6
  self._maxCountElement = 3
  self._listShowItemCount = 0
  self._openDetailIndex = 1
  self._cgStateTable = nil
  self._index = 0
  self._intimacyTweener = nil
  self._expTweener = nil
  self._showBtnTweener = nil
  self._showMoodTweener = nil
  self._firstIn = 0
  self._uiPetDeTailAtlas = self:GetAsset("UIPetDetail.spriteatlas", LoadType.SpriteAtlas)
  self._uiPetElementAtlas = self:GetAsset("UIPetElement.spriteatlas", LoadType.SpriteAtlas)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._prof2Img = {
    [2001] = "spirit_prof_5",
    [2002] = "spirit_prof_1",
    [2003] = "spirit_prof_3",
    [2004] = "spirit_prof_7"
  }
  self._prof2Tex = {
    [2001] = "str_pet_tag_job_name_color_change",
    [2002] = "str_pet_tag_job_name_return_blood",
    [2003] = "str_pet_tag_job_name_attack",
    [2004] = "str_pet_tag_job_name_function"
  }
  self._elem2str = {
    [1] = "str_pet_filter_water_element",
    [2] = "str_pet_filter_fire_element",
    [3] = "str_pet_filter_sen_element",
    [4] = "str_pet_filter_electricity_element",
    [6] = "str_tale_pet_att_none"
  }
end

function UISpiritDetailGroupController:OnShow(uiParams)
  self:Lock("UIOpenPetDetail")
  self._customPetData = uiParams[3]
  self._cfg_pet_element = Cfg.cfg_pet_element({})
  if not self._cfg_pet_element then
    Log.fatal("[error] cfg_pet_element is nil")
    return
  end
  self._fromSeasonMaze = uiParams[5]
  self:InitWigets()
  self._heartItem = uiParams[4]
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._mazeModule = self:GetModule(MazeModule)
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  if self._customPetData and self._customPetData:IsShowBtnInfo() or self._fromSeasonMaze then
    self._backBtns:SetData(function()
      self:CallUIMethod("UIHeartSpiritController", "RefreshEquipRed")
      GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"backBtn"}, true)
      self:CloseDialog()
    end)
    local lookBtnTran = self:GetUIComponent("RectTransform", "LookBtn")
    lookBtnTran.anchoredPosition = Vector2(405, lookBtnTran.anchoredPosition.y)
  else
    self._backBtns:SetData(function()
      self:CallUIMethod("UIHeartSpiritController", "RefreshEquipRed")
      GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"backBtn"}, true)
      self:CloseDialog()
    end, function()
      self:ShowDialog("UIHelpController", "UISpiritDetailGroupController")
    end)
  end
  self:GetUIComponents()
  self._BtnsPos = self._Btns.anchoredPosition
  self._btnsIsOpen = true
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._canvas = self._safeArea.parent:GetComponent("RectTransform")
  self._redPoint = self:GetGameObject("gradeRedPoiot")
  local petID = uiParams[1]
  self._fromMaze = uiParams[2]
  self:ShowMazeInfo()
  self:RequestAllPetInfos()
  if petID then
    self._currIndex = self:FindOpenPetIndex(petID)
  else
    self._currIndex = 1
  end
  self._currIndexTemp = self._currIndex
  self._rawImageLoaderHelper = RawImageLoaderHelper:New()
  self._rawImageLoaderHelper:Init(20)
  self._spineLoaderHelper = SpineLoaderHelper:New()
  self._spineLoaderHelper:Init(self._root, 20)
  self._itemTable = {}
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "PetScrollView", "UIPetDetailItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end, function(index, uiwidget)
    return self:_OnHideItem(index, uiwidget)
  end)
  local safesize = self._canvas.rect.size
  safesize.x = safesize.x + 1
  safesize.y = safesize.y + 1
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._listShowItemCount then
      return
    end
    self:ShowCurrIndexInfo(index + 1)
  end)
  self._scrollViewHelper:SetValueChangedCallback(function(group, value, contentSize, itemSize)
    self:OnValueChangedCallBack(group + 1, value, contentSize, itemSize)
  end)
  self._groupSizeX = safesize.x
  self._scrollViewHelper:Init(self._listShowItemCount, self._currIndex, safesize)
  self._scrollViewHelper:SetNextPageOffset(0.06)
  self:CustomPetInfo()
  self:AttachEvents()
  self:CheckRedPoint()
  self:CheckSkinRedPoint()
  self:_RefreshFunctionLockStatus()
  self:PlayItemAnim(1)
  self:UnLock("UIOpenPetDetail")
end

function UISpiritDetailGroupController:InitWigets()
  self.equipRedGo = self:GetGameObject("equipRedPoint")
end

function UISpiritDetailGroupController:CustomPetInfo()
  local btnInfo = self:GetGameObject("BtnInfo")
  local customLevel = self:GetGameObject("CustomLevel")
  if self._customPetData then
    local rightAnchor = self:GetGameObject("RightAnchor")
    rightAnchor:SetActive(false)
    self._openBtns:SetActive(false)
    self._levelInfoGo:SetActive(false)
    self._mazeGrade:SetActive(false)
    customLevel:SetActive(true)
    local profImg = self:GetUIComponent("Image", "CustomProf")
    local prof = self._petInfos[self._currIndex]:GetProf()
    profImg.sprite = self._uiHeartItemAtlas:GetSprite(self._prof2Img[prof])
    local gradImg = self:GetUIComponent("Image", "CustomAwake")
    local pet = self._petInfos[self._currIndex]
    local petId = pet:GetTemplateID()
    local awaken = pet:GetPetGrade()
    gradImg.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, awaken))
    btnInfo:SetActive(self._customPetData:IsShowBtnInfo())
    local btnInfoImageLoader = self:GetUIComponent("RawImageLoader", "BtnInfo")
    btnInfoImageLoader:LoadImage(self._customPetData:GetBtnInfoName())
  else
    customLevel:SetActive(false)
    btnInfo:SetActive(false)
  end
end

function UISpiritDetailGroupController:BtnInfoOnClick()
  if self._customPetData then
    local callback = self._customPetData:GetBtnInfoCallback()
    if callback then
      callback()
    end
  end
end

function UISpiritDetailGroupController:GuideTrigger()
  local guideModule = self:GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    return
  end
  local petInfo = self._petInfos and self._petInfos[self._currIndex]
  local petTempId = petInfo and petInfo:GetTemplateID()
  local grade = petInfo and petInfo:GetPetGrade()
  local triggerGrade = false
  if not petTempId then
    return
  end
  if grade == 0 then
    local cfg = Cfg.cfg_pet_grade({PetID = petTempId, Grade = 1})[1]
    if petInfo:GetPetLevel() >= cfg.NeedLevel and self:HasGuideItems(cfg.NeedItem) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideGrade, function(trigger)
        triggerGrade = trigger
      end)
    end
  end
  if not triggerGrade then
    local cfg = Cfg.cfg_pet_awakening({PetID = petTempId, Awakening = 1})[1]
    if self:HasGuideItems(cfg.NeedItem) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideAwake)
    end
  end
end

function UISpiritDetailGroupController:CheckRedPoint()
  if self._fromSeasonMaze or self._customPetData ~= nil then
    self._redPoint:SetActive(false)
    return
  end
  local petId = self._petInfos[self._currIndex]:GetTemplateID()
  local petModule = GameGlobal.GetModule(PetModule)
  local pet = petModule:GetPetByTemplateId(petId)
  local isShow = pet:CanPetBreak()
  self._redPoint:SetActive(isShow)
end

function UISpiritDetailGroupController:HasGuideItems(needItems)
  local roleModule = self:GetModule(RoleModule)
  for _, value in ipairs(needItems) do
    local b = string.split(value, ",")
    local itemId = tonumber(b[1])
    local itemCount = tonumber(b[2])
    local ownItemCount = roleModule:GetAssetCount(itemId)
    if itemCount > ownItemCount then
      return false
    end
  end
  return true
end

function UISpiritDetailGroupController:_RefreshFunctionLockStatus()
  local s = self:GetUIComponent("UISelectObjectPath", "book")
  local bookButtonFunction = s:SpawnObject("UIFunctionLockButton")
  bookButtonFunction:SetFunctionType(GameModuleID.MD_PetStory, ButtonLockType.OnlyTips)
  local s = self:GetUIComponent("UISelectObjectPath", "giftImg")
  local bookButtonFunction = s:SpawnObject("UIFunctionLockButton")
  bookButtonFunction:SetFunctionType(GameModuleID.MD_PetStory, ButtonLockType.OnlyTips)
  local clothGo = self:GetGameObject("clothes")
  if clothGo then
    clothGo:SetActive(true)
    if EngineGameHelper.EnableAppleVerifyBulletin() then
      clothGo:SetActive(false)
    end
  end
  local s = self:GetUIComponent("UISelectObjectPath", "clothes")
  local clothesButtonFunction = s:SpawnObject("UIFunctionLockButton")
  clothesButtonFunction:SetFunctionType(GameModuleID.MD_PetStory, ButtonLockType.OnlyTips)
end

function UISpiritDetailGroupController:OnValueChangedCallBack(group, value, contentSize, itemSize)
  local di = contentSize - itemSize
  if di <= 0 then
    return
  end
  local rate = itemSize / (contentSize - itemSize)
  if rate <= 0 then
    return
  end
  local centerRate = group * rate - 0.5 * rate
  local distance = value - centerRate
  local a = math.abs(distance) / (rate * 0.5) + 0.05
  a = 1.0 - a
  if a < 0 then
    a = 0
  elseif 1 < a then
    a = 1
  end
  local leftRightDis = math.abs(self._left.position.x - self._right.position.x)
  local centerPosition = self._center.position
  for i = self._currIndex - 1, self._currIndex + 1 do
    if self._itemTable[i] then
      self._itemTable[i]:ChangeCanvasGroupAlpha(leftRightDis, centerPosition.x)
    end
  end
  local diff = distance * self._diffValue
  self._logoRect.anchoredPosition = Vector2(diff, self._logoRect.anchoredPosition.y)
  self._logoGroup.alpha = a
  self._infoRect.anchoredPosition = Vector2(diff, self._infoRect.anchoredPosition.y)
  self._infoGroup.alpha = a
  self._leftDownRect.anchoredPosition = Vector2(diff, self._leftDownRect.anchoredPosition.y)
  self._leftDownGroup.alpha = a
  self._rightAnchorRect.anchoredPosition = Vector2(diff, self._rightAnchorRect.anchoredPosition.y)
  self._rightAnchorGroup.alpha = a
  self._skillsRect.anchoredPosition = Vector2(diff * -0.5 + 278, self._skillsRect.anchoredPosition.y)
  self._breakGroup.alpha = a
  self._gradeGroup.alpha = a
end

function UISpiritDetailGroupController:SetMazeInfo()
  local pet = self._petInfos[self._currIndex]
  local petId = pet:GetTemplateID()
  local awaken = pet:GetPetGrade()
  self._mazeGradeImg.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, awaken))
  local prof = pet:GetProf()
  self._mazeProfImg.sprite = self._uiHeartItemAtlas:GetSprite(self._prof2Img[prof])
end

function UISpiritDetailGroupController:ShowCurrIndexInfo(index)
  local temp_info = self._petInfos[index]
  if temp_info then
    local l_pet_info = "{ID:" .. temp_info:GetTemplateID() .. ", level:" .. temp_info:GetPetLevel() .. "}"
    GameGlobal.UAReportForceGuideEvent("UIPetViewShowPet", {l_pet_info}, true)
  end
  self._currIndex = index
  self._currIndexTemp = index
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoudPetDetail)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckIsCurrent, self._currIndexTemp)
  self:ShowEquipBtn()
  self:GuideTrigger()
  self:ShowElement()
  self:ShowLogoImg()
  self:ShowName()
  self:ShowStarLevel()
  self:_SetEquipLv()
  self:ShowFeatureTag()
  self:RefreshLevelInfo()
  self:RefreshAtt()
  self:ShowProf()
  self:SetMazeInfo()
  self:CheckRedPoint()
  self:ShowLimitTag()
  self:CheckSkinRedPoint()
  self:RefreshPetLike()
  self:ShowStaticAndDynamic()
  self:RefreshIntimacyInfo()
  self:RefreshPetSKill()
  local imageLoader = self:GetUIComponent("RawImageLoader", "BgLoader")
  UICommonHelper:GetInstance():ChangePetTagBackground(self._petInfos[index]:GetTemplateID(), imageLoader, true)
  if self._firstIn == 0 then
    self._firstIn = 1
  end
  local tid = self._petInfos[self._currIndex]:GetTemplateID()
  if self._petModule:BeNewPet(tid) then
    self:StartTask(function(TT)
      local res = self._petModule:DelNewPetMark(TT, tid)
      if res:GetSucc() then
      end
    end, self)
  end
end

function UISpiritDetailGroupController:ShowEquipBtn()
  local grade = self._petInfos[self._currIndex]:GetPetGrade()
  self._equipUnLock = 0 < grade
  self._equipLockBtn:SetActive(not self._equipUnLock)
  if not self._equipUnLock then
    self._equipTex.color = Color(0.24705882352941178, 0.23529411764705882, 0.24705882352941178)
    self.equipRedGo:SetActive(false)
  else
    self._equipTex.color = Color(1, 1, 1)
    self.equipRedGo:SetActive(UIPetEquipHelper.CheckRefineRed(self._petInfos[self._currIndex]))
  end
end

function UISpiritDetailGroupController:RefreshEquipRed()
  self.equipRedGo:SetActive(UIPetEquipHelper.CheckRefineRed(self._petInfos[self._currIndex]))
end

function UISpiritDetailGroupController:ShowMazeInfo()
  if not self._fromSeasonMaze then
    self._mazeInfoTipMask:SetActive(false)
    self._openBtns:SetActive(not self._fromMaze)
    self._IntimacyInfo:SetActive(not self._fromMaze)
    self._showMazeInfoTipMask:SetActive(self._fromMaze)
    self._mazeGrade:SetActive(self._fromMaze)
    self._levelInfoGo:SetActive(not self._fromMaze)
    self._mazeTipTitle:SetText(StringTable.Get("str_pet_detail_maze_value_intr"))
    self._mazeTipDesc:SetText(StringTable.Get("str_pet_detail_maze_value_desc"))
    self._favBtnGo:SetActive(true)
  else
    self._mazeInfoTipMask:SetActive(false)
    self._openBtns:SetActive(false)
    self._IntimacyInfo:SetActive(false)
    self._showMazeInfoTipMask:SetActive(true)
    self._mazeGrade:SetActive(false)
    self._levelInfoGo:SetActive(true)
    self._mazeTipTitle:SetText(StringTable.Get("str_season_maze_pet_detail_title"))
    self._mazeTipDesc:SetText(StringTable.Get("str_season_maze_pet_detail_tips"))
    self._favBtnGo:SetActive(false)
  end
end

function UISpiritDetailGroupController:ShowStaticAndDynamic()
  self:ChangeStaticAndDynamicTween(self._cgStateTable[self._currIndex])
end

function UISpiritDetailGroupController:mazeInfoTipMaskOnClick()
  self._mazeInfoTips:SetActive(false)
  self._mazeInfoTipMask:SetActive(false)
end

function UISpiritDetailGroupController:showMazeInfoTipMaskOnClick()
  self._mazeInfoTips:SetActive(true)
  self._mazeInfoTipMask:SetActive(true)
end

function UISpiritDetailGroupController:GetUIComponents()
  self._equipLockBtn = self:GetGameObject("equipLockBtn")
  self._equipTex = self:GetUIComponent("Graphic", "equipTex")
  self._infoTex = self:GetUIComponent("UILocalizationText", "infoTex")
  self._infoTexContent = self:GetUIComponent("RectTransform", "infoTexContent")
  self._stars = self:GetUIComponent("UISelectObjectPath", "stars")
  self.firstBg = self:GetGameObject("firstBg")
  self.secondBg = self:GetGameObject("secondBg")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._firstElement = self:GetUIComponent("Image", "firstElement")
  self._secondElement = self:GetUIComponent("Image", "secondElement")
  self._elementTex = self:GetUIComponent("UILocalizationText", "elementTex")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._englishNameText = self:GetUIComponent("UILocalizationText", "EnglishName")
  self._logoImg = self:GetUIComponent("RawImageLoader", "logoImg")
  self._leveExpSlider = self:GetUIComponent("Slider", "LeveExpSlider")
  self._levelText = self:GetUIComponent("UILocalizationText", "levelText")
  self._attackText = self:GetUIComponent("UILocalizationText", "attackText")
  self._defenceText = self:GetUIComponent("UILocalizationText", "defenceText")
  self._healthText = self:GetUIComponent("UILocalizationText", "healthText")
  self._dynamicText = self:GetUIComponent("UILocalizationText", "dynamicText")
  self._staticText = self:GetUIComponent("UILocalizationText", "staticText")
  self._staticAndDynamicImg = self:GetUIComponent("RectTransform", "bar")
  self._dynamicRect = self:GetUIComponent("RectTransform", "dynamicRect")
  self._staticRect = self:GetUIComponent("RectTransform", "staticRect")
  self._intimacyLevel = self:GetUIComponent("UILocalizationText", "intimacyLevel")
  self._IntimacyInfo = self:GetGameObject("Intimacy")
  self._intimateSlider = self:GetUIComponent("Slider", "IntimateSlider")
  self._LeftAnchorPos = self:GetUIComponent("RectTransform", "LeftAnchorPos")
  self._colorSkillImg = self:GetUIComponent("Image", "colorSkillImg")
  self._colorSkillImgBg = self:GetUIComponent("Image", "colorSkillImgBg")
  self._goldSkill1 = self:GetGameObject("goldSkill1")
  self._goldSkill2 = self:GetGameObject("goldSkill2")
  self._goldSkill3 = self:GetGameObject("goldSkill3")
  self._goldSkill4 = self:GetGameObject("goldSkill4")
  self._BtnsCanvasGroup = self:GetUIComponent("CanvasGroup", "Btns")
  self._Btns = self:GetUIComponent("RectTransform", "Btns")
  self._root = self:GetUIComponent("RectTransform", "spinePool")
  self._left = self:GetUIComponent("RectTransform", "leftPos")
  self._right = self:GetUIComponent("RectTransform", "rightPos")
  self._center = self:GetUIComponent("RectTransform", "centerPos")
  self._skillOpen = self:GetGameObject("skillOpen")
  self._awakeCount = self:GetUIComponent("Image", "awakeCount")
  self._awakeCount2 = self:GetUIComponent("Image", "awakeCount2")
  self._profTex = self:GetUIComponent("UILocalizationText", "profTex")
  self._profImg = self:GetUIComponent("Image", "profImg")
  self._uiAnim = self:GetUIComponent("Animation", "uianim")
  self._openBtns = self:GetGameObject("openBtns")
  self._showMazeInfoTipMask = self:GetGameObject("showMazeInfoTipMask")
  self._mazeGradeImg = self:GetUIComponent("Image", "mazeGradeImg")
  self._mazeProfImg = self:GetUIComponent("Image", "mazeProfImg")
  self._levelInfoGo = self:GetGameObject("Level")
  self._mazeGrade = self:GetGameObject("MazeGrade")
  self._mazeInfoTipMask = self:GetGameObject("mazeInfoTipMask")
  self._mazeInfoTips = self:GetGameObject("mazeTips")
  self._logoRect = self:GetUIComponent("RectTransform", "logoImg")
  self._infoRect = self:GetUIComponent("RectTransform", "info")
  self._leftDownRect = self:GetUIComponent("RectTransform", "LeftDown")
  self._rightAnchorRect = self:GetUIComponent("RectTransform", "RightAnchor")
  self._skillsRect = self:GetUIComponent("RectTransform", "skills")
  self._logoGroup = self:GetUIComponent("CanvasGroup", "logoImg")
  self._infoGroup = self:GetUIComponent("CanvasGroup", "info")
  self._leftDownGroup = self:GetUIComponent("CanvasGroup", "LeftDown")
  self._rightAnchorGroup = self:GetUIComponent("CanvasGroup", "RightAnchor")
  self._gradeGroup = self:GetUIComponent("CanvasGroup", "gradeGroup")
  self._breakGroup = self:GetUIComponent("CanvasGroup", "breakGroup")
  self._limitTag = self:GetUIComponent("RawImageLoader", "limitTag")
  self._limitTagGo = self:GetGameObject("limitTag")
  self._clothRedPoint = self:GetGameObject("clothRedPoint")
  self._mazeTipTitle = self:GetUIComponent("UILocalizationText", "mazeTipTitle")
  self._mazeTipDesc = self:GetUIComponent("UILocalizationText", "mazeTipDesc")
  self._favBtnImg = self:GetUIComponent("Image", "FavBtn")
  self._favBtnGo = self:GetGameObject("FavBtn")
end

function UISpiritDetailGroupController:PlayInOutAnimation(inAnim)
  if inAnim then
    if self._uiAnim then
      self._uiAnim:Play("uieff_SpiritDetail_Back")
    end
  elseif self._uiAnim then
    self._uiAnim:Play("uieff_SpiritDetail_Goto")
  end
  local state = 0
  if inAnim then
    state = 3
  else
    state = 2
  end
  self:PlayItemAnim(state)
end

function UISpiritDetailGroupController:OnUpdate(dms)
  if not self._alphaState or self._alphaState == 0 then
    return
  end
  if self._alphaState == 1 then
    self._alphaValue = self._alphaValue + 0.05
  elseif self._alphaState == 2 then
    self._alphaValue = self._alphaValue - 0.066
  elseif self._alphaState == 3 then
    self._alphaValue = self._alphaValue + 0.09
  end
  if 1 < self._alphaValue then
    self._alphaValue = 1
    self._alphaState = 0
    self._itemTable[self._currIndex]:OpenAndCloseOtherAlpha(true)
  end
  if 0 > self._alphaValue then
    self._alphaValue = 0
    self._alphaState = 0
  end
  self._itemTable[self._currIndex]:SetAnimAlpha(self._alphaValue)
end

function UISpiritDetailGroupController:PlayItemAnim(state)
  if state == 1 then
    self._itemTable[self._currIndex]:OpenAndCloseOtherAlpha(false)
    self._alphaState = state
    self._alphaValue = 0
  elseif state == 2 then
  elseif state == 3 then
  end
end

function UISpiritDetailGroupController:DisposeComponents()
  self._nameText = nil
  self._englishNameText = nil
  self._logoImg = nil
  self._leveExpSlider = nil
  self._levelText = nil
  self._intimateSlider = nil
  self._attackText = nil
  self._defenceText = nil
  self._healthText = nil
  self._uiPetDeTailAtlas = nil
  self._uiPetElementAtlas = nil
  self._uiHeartItemAtlas = nil
  self._dynamicText = nil
  self._staticText = nil
  self._intimacyLevel = nil
  self._LeftAnchorPos = nil
  self._goldSkill1 = nil
  self._goldSkill2 = nil
  self._goldSkill3 = nil
  self._goldSkill4 = nil
end

function UISpiritDetailGroupController:AttachEvents()
  self:AttachEvent(GameEventType.OnPetListIndexChanged, self.OnPetListIndexChanged)
  self:AttachEvent(GameEventType.PlayInOutAnimation, self.PlayInOutAnimation)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.ObservationRefresh)
  self:AttachEvent(GameEventType.OnPetSkinChange, self.ObservationRefresh)
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
  self:AttachEvent(GameEventType.WatchPetSkinStory, self.CheckSkinRedPoint)
end

function UISpiritDetailGroupController:RemoveEvents()
  self:DetachEvent(GameEventType.PetDataChangeEvent, self.ObservationRefresh)
  self:DetachEvent(GameEventType.PlayInOutAnimation, self.PlayInOutAnimation)
  self:DetachEvent(GameEventType.OnPetSkinChange, self.ObservationRefresh)
  self:DetachEvent(GameEventType.OnPetListIndexChanged, self.OnPetListIndexChanged)
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
  self:DetachEvent(GameEventType.WatchPetSkinStory, self.CheckSkinRedPoint)
  if self._alphaEvent then
    GameGlobal.Timer():CancelEvent(self._alphaEvent)
  end
end

function UISpiritDetailGroupController:ShowName()
  local name = self._petInfos[self._currIndex]:GetPetName()
  self._nameText:SetText(StringTable.Get(name))
  local nameEn = StringTable.Get(self._petInfos[self._currIndex]:GetPetEnglishName())
  self:CheckStringLen(nameEn)
end

function UISpiritDetailGroupController:CheckStringLen(nameEn)
  self._englishNameText:SetText("")
  local scale = GameObjectHelper.GetTextScale(self._englishNameText, nameEn, 437)
  self._englishNameText:GetComponent("Transform").localScale = Vector3(scale, 1, 1)
end

function UISpiritDetailGroupController:ShowStarLevel()
  local petStar = self._petInfos[self._currIndex]:GetPetStar()
  local awakenStep = self._petInfos[self._currIndex]:GetPetAwakening()
  local awakenLock = self._petInfos[self._currIndex]:GetAwakeMatch()
  self._stars:SpawnObjects("UIPetIntimacyStar", petStar)
  local stars = self._stars:GetAllSpawnList()
  for i = 1, #stars do
    local isBackBreak = i > awakenLock and i <= awakenStep
    stars[i]:Refresh(i <= awakenStep, isBackBreak)
  end
  for i = 1, 6 do
    local starImg = self:GetUIComponent("Image", "star" .. i)
    if i <= petStar then
      starImg.gameObject:SetActive(true)
      if i <= awakenStep then
        starImg.sprite = self._uiPetDeTailAtlas:GetSprite("spirit_xiangqing_icon22")
      else
        starImg.sprite = self._uiPetDeTailAtlas:GetSprite("spirit_xiangqing_icon21")
      end
    else
      starImg.gameObject:SetActive(false)
    end
  end
  local pet = self._petInfos[self._currIndex]
  local petId = pet:GetTemplateID()
  local awaken = pet:GetPetGrade()
  local spriteName = UIPetModule.GetAwakeSpriteName(petId, awaken)
  self._awakeCount.sprite = self._atlasAwake:GetSprite(spriteName)
  self._awakeCount2.sprite = self._atlasAwake:GetSprite(spriteName)
end

function UISpiritDetailGroupController:_SetEquipLv()
  local obj = UIWidgetHelper.SpawnObject(self, "_equipLv", "UIPetEquipLvIcon")
  obj:SetData(self._petInfos[self._currIndex], true)
  local btnIcon = UIWidgetHelper.SpawnObject(self, "_equipLvBtnIcon", "UIPetEquipLvIcon")
  btnIcon:SetData(self._petInfos[self._currIndex], false)
end

function UISpiritDetailGroupController:ShowFeatureTag()
  local petTags = self._petInfos[self._currIndex]:GetPetTags()
  local realFeatureCount = table.count(petTags)
  local tagLine1 = self:GetGameObject("tagLine1")
  local tagLine2 = self:GetGameObject("tagLine2")
  tagLine1:SetActive(true)
  tagLine2:SetActive(true)
  if realFeatureCount == 1 then
    tagLine1:SetActive(false)
    tagLine2:SetActive(false)
  elseif realFeatureCount == 2 then
    tagLine2:SetActive(false)
  end
  for index = 1, self._maxCountElement do
    local _tagGo = self:GetGameObject("tagIcon" .. index)
    if index <= realFeatureCount then
      _tagGo:SetActive(true)
      local tagID = petTags[index]
      local cfg = Cfg.cfg_pet_tags[tagID]
      if cfg ~= nil then
        local _tagText = self:GetUIComponent("UILocalizationText", "Text" .. index)
        _tagText:SetText(StringTable.Get(cfg.Name))
      end
    else
      _tagGo:SetActive(false)
    end
  end
end

function UISpiritDetailGroupController:ShowProf()
  local prof = self._petInfos[self._currIndex]:GetProf()
  self._profTex:SetText(StringTable.Get(self._prof2Tex[prof]))
  self._profImg.sprite = self._uiHeartItemAtlas:GetSprite(self._prof2Img[prof])
end

function UISpiritDetailGroupController:RefreshLevelInfo()
  local curGrateMaxLevel = self._petInfos[self._currIndex]:GetMaxLevel()
  local curLevel = self._petInfos[self._currIndex]:GetPetLevel()
  self._levelText:SetText(curLevel .. "<size=45><color=#acacac>/</color><color=#f96601>" .. curGrateMaxLevel .. "</color></size>")
  self._infoTexContent.anchoredPosition = Vector2(self._infoTexContent.anchoredPosition.x, 0)
  local cfg_pet = Cfg.cfg_pet[self._petInfos[self._currIndex]:GetTemplateID()]
  if cfg_pet then
    self._infoTex:SetText(StringTable.Get(cfg_pet.Desc))
  else
    Log.fatal("###pet_detail -- cfg_pet is nil ! id -- " .. self._petInfos[self._currIndex]:GetTemplateID())
  end
  local itemIcon = self._petInfos[self._currIndex]:GetPetItemIcon(PetSkinEffectPath.ITEM_ICON_PET_DETAIL)
  self.uiItem:SetData({
    icon = itemIcon,
    itemId = self._petInfos[self._currIndex]:GetTemplateID()
  })
  self:ExpSlider(curGrateMaxLevel, curLevel)
end

function UISpiritDetailGroupController:ExpSlider(curGrateMaxLevel, curLevel)
  local rate = 0
  if curGrateMaxLevel <= curLevel then
    rate = 1
  else
    local curLevelExp = self._petInfos[self._currIndex]:GetPetExp()
    local upLevelAllExp = self._petInfos[self._currIndex]:GetLevelUpNeedExp()
    if curLevelExp ~= nil and upLevelAllExp ~= nil then
      rate = curLevelExp / upLevelAllExp
    else
      rate = 1
    end
  end
  if self._firstIn == 0 then
    self._leveExpSlider.value = rate
  else
    if self._expTweener then
      self._expTweener:Kill()
    end
    self._expTweener = self._leveExpSlider:DOValue(0, 0.2):OnComplete(function()
      self._expTweener = self._leveExpSlider:DOValue(rate, 0.2)
    end)
  end
end

function UISpiritDetailGroupController:_RefreshIntimacyExpBar()
  local petData = self._petInfos[self._currIndex]
  local level = petData:GetPetAffinityLevel()
  local maxLevel = petData:GetPetAffinityMaxLevel()
  local curExp = petData:GetPetAffinityExp() - Cfg.cfg_pet_affinity_exp[level].NeedAffintyExp
  local maxExp = petData:GetPetAffinityMaxExp(level)
  local percent = curExp / maxExp
  if level >= maxLevel then
    percent = 1
  end
  self._intimateSlider.value = percent
end

function UISpiritDetailGroupController:RefreshIntimacyInfo()
  local petData = self._petInfos[self._currIndex]
  local level = petData:GetPetAffinityLevel()
  local maxLevel = petData:GetPetAffinityMaxLevel()
  local cfg = Cfg.cfg_pet_affinity_exp[level]
  if not cfg then
    Log.fatal("### cfg_pet_affinity_exp not exist level:", level)
    return
  end
  local curExp = petData:GetPetAffinityExp() - cfg.NeedAffintyExp
  local maxExp = petData:GetPetAffinityMaxExp(level)
  local percent = curExp / maxExp
  if level >= maxLevel then
    percent = 1
  end
  self._intimacyLevel:SetText(level)
  self:ChangeIntiValueAnimation(percent)
end

function UISpiritDetailGroupController:ChangeIntiValueAnimation(value)
  if self._intimacyTweener then
    self._intimacyTweener:Kill()
  end
  self._intimacyTweener = self._intimateSlider:DOValue(value, 0.2)
end

function UISpiritDetailGroupController:RefreshAtt()
  local _attackValue, _defenceValue, _healthValue
  if self._customPetData then
    if self._customPetData._className == "Pet" then
      _attackValue = self._customPetData._attack
      _defenceValue = self._customPetData._defense
      _healthValue = self._customPetData._maxhp
    else
      _attackValue = self._petInfos[self._currIndex]:GetPetAttack()
      _defenceValue = self._petInfos[self._currIndex]:GetPetDefence()
      _healthValue = self._petInfos[self._currIndex]:GetPetHealth()
    end
  elseif self._fromMaze then
    _attackValue, _defenceValue, _healthValue = self._mazeModule:GetCalPetADH(self._petInfos[self._currIndex]:GetPstID())
  else
    _attackValue = self._petInfos[self._currIndex]:GetPetAttack()
    _defenceValue = self._petInfos[self._currIndex]:GetPetDefence()
    _healthValue = self._petInfos[self._currIndex]:GetPetHealth()
  end
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local teams = ctx:Teams()
  local teamOpenerType = ctx.teamOpenerType
  if teamOpenerType == TeamOpenerType.AniPopStar then
    local anipopModule = GameGlobal.GetModule(AnipopModule)
  end
  self._attackText:SetText(_attackValue)
  self._defenceText:SetText(_defenceValue)
  self._healthText:SetText(_healthValue)
end

function UISpiritDetailGroupController:SkillBtnOnClick()
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"jineng"}, true)
  self:ShowDialog("UIPetSkillDetailController", self._petInfos[self._currIndex], self._LeftAnchorPos.anchoredPosition.x, function()
    self._skillOpen:SetActive(false)
  end)
  self._skillOpen:SetActive(true)
end

function UISpiritDetailGroupController:ShowLogoImg()
  self._logoImg:LoadImage(self._petInfos[self._currIndex]:GetPetLogo())
end

function UISpiritDetailGroupController:RefreshPetLike()
  self._bLike = self._petInfos[self._currIndex]:IsLike()
  if self._bLike then
    self._favBtnImg.sprite = self._uiHeartItemAtlas:GetSprite("tjxa_icon2")
  else
    self._favBtnImg.sprite = self._uiHeartItemAtlas:GetSprite("tjxa_icon1")
  end
end

function UISpiritDetailGroupController:ShowElement()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local elementTex = ""
  if cfg_pet_element then
    local f = self._petInfos[self._currIndex]:GetPetFirstElement()
    local s = self._petInfos[self._currIndex]:GetPetSecondElement()
    self._firstElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[f].Icon))
    if s and 0 < s then
      self.secondBg:SetActive(true)
      self._secondElement.gameObject:SetActive(true)
      self._secondElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[s].Icon))
      elementTex = StringTable.Get("str_pet_detail_element_" .. f) .. "  " .. StringTable.Get("str_pet_detail_element_" .. s)
    else
      elementTex = StringTable.Get(self._elem2str[f])
      self._secondElement.gameObject:SetActive(false)
      self.secondBg:SetActive(false)
    end
  end
  self._elementTex:SetText(elementTex)
end

function UISpiritDetailGroupController:RefreshPetSKill()
  local _creatCount = 0
  local uiModule = self._petModule.uiModule
  self._skillDetailInfos = uiModule:GetSkillDetailInfoBySkillTypeHideExtra(self._petInfos[self._currIndex])
  _creatCount = table.count(self._skillDetailInfos)
  local tempTab = {}
  if _creatCount == 0 then
    self._goldSkill1:SetActive(false)
    self._goldSkill2:SetActive(false)
    self._goldSkill3:SetActive(false)
    self._goldSkill4:SetActive(false)
    return
  elseif _creatCount == 1 then
    table.insert(tempTab, self._goldSkill1)
    self._goldSkill1:SetActive(true)
    self._goldSkill2:SetActive(false)
    self._goldSkill3:SetActive(false)
    self._goldSkill4:SetActive(false)
  elseif _creatCount == 2 then
    table.insert(tempTab, self._goldSkill1)
    table.insert(tempTab, self._goldSkill2)
    self._goldSkill1:SetActive(true)
    self._goldSkill2:SetActive(true)
    self._goldSkill3:SetActive(false)
    self._goldSkill4:SetActive(false)
  elseif _creatCount == 3 then
    table.insert(tempTab, self._goldSkill1)
    table.insert(tempTab, self._goldSkill2)
    table.insert(tempTab, self._goldSkill3)
    self._goldSkill1:SetActive(true)
    self._goldSkill2:SetActive(true)
    self._goldSkill3:SetActive(true)
    self._goldSkill4:SetActive(false)
  elseif _creatCount == 4 then
    table.insert(tempTab, self._goldSkill1)
    table.insert(tempTab, self._goldSkill2)
    table.insert(tempTab, self._goldSkill3)
    table.insert(tempTab, self._goldSkill4)
    self._goldSkill1:SetActive(true)
    self._goldSkill2:SetActive(true)
    self._goldSkill3:SetActive(true)
    self._goldSkill4:SetActive(true)
  end
  self._colorSkillImg.color = self._colorWithElement[self._petInfos[self._currIndex]:GetPetFirstElement()]
  self._colorSkillImgBg.sprite = self._uiPetDeTailAtlas:GetSprite(self._spriteWithElement[self._petInfos[self._currIndex]:GetPetFirstElement()])
  for index = 1, _creatCount do
    local skillItem = tempTab[index]
    local cfg_skill = BattleSkillCfg(self._skillDetailInfos[index].skillList[1])
    if cfg_skill then
      local skillTypeStr = ""
      if cfg_skill.Type == PetSkillType.SkillType_ChainSkill then
        skillTypeStr = "str_pet_detail_left_down_skill_chain"
      elseif cfg_skill.Type == PetSkillType.SkillType_Active then
        skillTypeStr = "str_pet_detail_left_down_skill_active"
      elseif cfg_skill.Type == PetSkillType.SkillType_Passive then
        skillTypeStr = "str_pet_detail_left_down_skill_equip"
      end
      local skillName = skillItem:GetComponent("Transform"):GetChild(1):GetComponent("UILocalizationText")
      local skillIcon = skillItem:GetComponent("Transform"):GetChild(0):GetComponent("RawImageLoader")
      skillName:SetText(StringTable.Get(skillTypeStr))
      skillIcon:LoadImage(cfg_skill.Icon)
    end
  end
end

function UISpiritDetailGroupController:clothesBtnOnClick(go)
  local petid = self._petInfos[self._currIndex]:GetTemplateID()
  local pstid = self._petInfos[self._currIndex]:GetPstID()
  self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_SHOW_LIST, petid, pstid)
end

function UISpiritDetailGroupController:bookBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"dangan"}, true)
  local petid = self._petInfos[self._currIndex]:GetTemplateID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, false)
  self:ShowDialog("UIPetIntimacyMainController", petid, PetIntimacyWindowType.FilesPanel)
end

function UISpiritDetailGroupController:IntimacyBtnOnClick()
  if GameSingle then
    return
  end
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"haogandu"}, true)
  local petid = self._petInfos[self._currIndex]:GetTemplateID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, false)
  self:ShowDialog("UIPetIntimacyMainController", petid, PetIntimacyWindowType.GiftPanel)
end

function UISpiritDetailGroupController:staticAndDynamicOnClick()
  if self._cgStateTable[self._currIndex] == DynamicAndStaticState.Static then
    GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"dynamic"}, true)
    self._cgStateTable[self._currIndex] = DynamicAndStaticState.Dynamic
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  else
    GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"static"}, true)
    self._cgStateTable[self._currIndex] = DynamicAndStaticState.Static
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlide)
  end
  self:ChangeStaticAndDynamicTween(self._cgStateTable[self._currIndex])
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetDetailChangeCgState, self._currIndex, self._cgStateTable[self._currIndex])
end

function UISpiritDetailGroupController:ChangeStaticAndDynamicTween(state)
  if self._dsTween then
    self._dsTween:Kill()
  end
  if state == DynamicAndStaticState.Dynamic then
    local pos = self._dynamicRect.anchoredPosition
    self._dsTween = self._staticAndDynamicImg:DOAnchorPos(pos, 0.3):SetEase(DG.Tweening.Ease.InOutCubic)
    self._dynamicText.color = Color.black
    self._staticText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
  else
    local pos = self._staticRect.anchoredPosition
    self._dsTween = self._staticAndDynamicImg:DOAnchorPos(pos, 0.3):SetEase(DG.Tweening.Ease.InOutCubic)
    self._staticText.color = Color.black
    self._dynamicText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
  end
end

function UISpiritDetailGroupController:UPLevelBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"shengji"}, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, false)
  self:ShowDialog("UIUpLevelInterfaceController", self._petInfos[self._currIndex]:GetTemplateID())
end

function UISpiritDetailGroupController:awakenBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"juexing"}, true)
  local grade = self._petInfos[self._currIndex]:GetPetGrade()
  local maxGrade = self._petInfos[self._currIndex]:GetMaxGrade()
  if grade >= maxGrade then
    ToastManager.ShowToast(StringTable.Get("str_pet_config_reach_grade_max"))
    return
  end
  local starLevel = self._petInfos[self._currIndex]:GetPetStar()
  local openAwakenCfg = Cfg.cfg_global.pet_open_grade
  if starLevel <= openAwakenCfg.IntValue then
    ToastManager.ShowToast(StringTable.Get("str_pet_config_reach_grade_max"))
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, false)
  local aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
  aps:SetTrack(true)
  self:ShowDialog("UIGradeInterfaceController", self._petInfos[self._currIndex]:GetTemplateID())
end

function UISpiritDetailGroupController:gradeBtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundPetBreak)
  local star = self._petInfos[self._currIndex]:GetPetStar()
  local cfgStar = Cfg.cfg_global.pet_open_awaken
  if star <= cfgStar.IntValue then
    ToastManager.ShowToast(StringTable.Get("str_pet_config_reach_awake_max"))
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, false)
  self:ShowDialog("UIBreakController", self._petInfos[self._currIndex]:GetTemplateID())
end

function UISpiritDetailGroupController:equipBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"zhuangbei"}, true)
  if self._equipUnLock then
    self:ShowDialog("UIPetEquipController", self._petInfos[self._currIndex])
  end
end

function UISpiritDetailGroupController:equipLockBtnOnClick()
  ToastManager.ShowToast(StringTable.Get("str_pet_equip_func_unlock"))
end

function UISpiritDetailGroupController:OpenBtnsOnClick()
  GameGlobal.UAReportForceGuideEvent("UIPetDetailClick", {"lihui"}, true)
  local petData = self._petInfos[self._currIndex]
  self:ShowDialog("UISpiritDetailLookCgAndSpineController", petData, self._cgStateTable[self._currIndex])
end

function UISpiritDetailGroupController:_OnShowItem(index, uiwidget)
  self._itemTable[index] = uiwidget
  local petData = self._petInfos[index]
  local matCgName = petData:GetPetStaticBody(PetSkinEffectPath.BODY_PET_DETAIL)
  local spineName = petData:GetPetSpine(PetSkinEffectPath.BODY_PET_DETAIL)
  uiwidget:SetData(index, petData, self._cgStateTable[index], matCgName, spineName, self._root, self._currIndexTemp)
end

function UISpiritDetailGroupController:_OnHideItem(index, uiwidget)
  if self._itemTable[index] == nil then
    return
  end
  uiwidget:OnHideCallBack()
end

function UISpiritDetailGroupController:OnHide()
  self:DisposeComponents()
  self:RemoveEvents()
  self._petModule.uiModule:SetTeamPets(nil)
  self._showBtnTweener = nil
  self._showMoodTweener = nil
  self._backBtns = nil
  self._cgStateTable = nil
  self._petInfos = nil
  self._petModule = nil
  self._listShowItemCount = 0
  self._openDetailIndex = 1
  self._firstIn = 0
  self._expTweener = nil
  self._intimacyTweener = nil
  self._scrollViewHelper:Dispose()
  self._rawImageLoaderHelper:Dispose()
  self._spineLoaderHelper:Dispose()
end

function UISpiritDetailGroupController:RequestAllPetInfos()
  self._petInfos = self._petModule.uiModule:GetSortedPets()
  if self._petInfos ~= nil then
    self._listShowItemCount = table.count(self._petInfos)
    self._cgStateTable = {}
    for i = 1, self._listShowItemCount do
      self._cgStateTable[i] = DynamicAndStaticState.Dynamic
    end
  end
  self._diffValue = self._listShowItemCount * -300
end

function UISpiritDetailGroupController:FindOpenPetIndex(petid)
  if self._petInfos then
    for index = 1, #self._petInfos do
      if self._petInfos[index]:GetTemplateID() == petid then
        return index
      end
    end
  end
  return 0
end

function UISpiritDetailGroupController:FindOpenPetIndexByPetTempId(petTempIdtId)
  if self._petInfos then
    for index = 1, #self._petInfos do
      if self._petInfos[index]:GetTemplateID() == petTempIdtId then
        return index
      end
    end
  end
  return 0
end

function UISpiritDetailGroupController:ObservationRefresh()
  if self._handlePetLike then
    return
  end
  self:ShowCurrIndexInfo(self._currIndex)
  self:_RefreshCurPetSkinAppearance(self._currIndex)
end

function UISpiritDetailGroupController:_RefreshCurPetSkinAppearance(index)
  local uiwidget = self._itemTable[index]
  local petData = self._petInfos[index]
  if not uiwidget or not petData then
    return
  end
  local matCgName = petData:GetPetStaticBody(PetSkinEffectPath.BODY_PET_DETAIL)
  local spineName = petData:GetPetSpine(PetSkinEffectPath.BODY_PET_DETAIL)
  uiwidget:RefreshSkinAppearance(matCgName, spineName)
end

function UISpiritDetailGroupController:OnPetListIndexChanged(petid)
  local idx = self:FindOpenPetIndex(petid)
  self._currIndex = idx
  self._currIndexTemp = idx
  local sizex = self._groupSizeX * (idx - 1) * -1
  self:GetUIComponent("RectTransform", "Content").anchoredPosition = Vector2(sizex, 0)
  self._scrollViewHelper:MovePanelToIndex(idx)
end

function UISpiritDetailGroupController:ShowLimitTag()
  local petId = self._petInfos[self._currIndex]:GetTemplateID()
  local cfg = Cfg.cfg_pet_limit_tag[petId]
  if cfg then
    self._limitTagGo:SetActive(true)
    self._limitTag:LoadImage(cfg.Res)
    local rect = self:GetUIComponent("RectTransform", "limitTag")
    rect.sizeDelta = Vector2(cfg.Size[1], cfg.Size[2])
  else
    self._limitTagGo:SetActive(false)
  end
end

function UISpiritDetailGroupController:OnItemCountChange()
  self:CheckRedPoint()
end

function UISpiritDetailGroupController:GetCurrentPetInfos()
  return self._petInfos[self._currIndex]
end

function UISpiritDetailGroupController:FavBtnOnClick()
  local pstId = self._petInfos[self._currIndex]:GetPstID()
  self:Lock("UISpiritDetailGroupController:FavBtnOnClick")
  self:StartTask(function(TT)
    self._handlePetLike = true
    local res = self._petModule:HandlePetLike(TT, pstId, not self._bLike)
    self:RefreshPetLike()
    self._handlePetLike = false
    self:UnLock("UISpiritDetailGroupController:FavBtnOnClick")
  end)
end

function UISpiritDetailGroupController:CheckSkinRedPoint()
  if self._fromSeasonMaze or self._customPetData ~= nil then
    self._clothRedPoint:SetActive(false)
    return
  end
  local petId = self._petInfos[self._currIndex]:GetTemplateID()
  local petModule = GameGlobal.GetModule(PetModule)
  local pet = petModule:GetPetByTemplateId(petId)
  local isShow = pet:IsShowSkinRedPoint()
  self._clothRedPoint:SetActive(isShow)
end
