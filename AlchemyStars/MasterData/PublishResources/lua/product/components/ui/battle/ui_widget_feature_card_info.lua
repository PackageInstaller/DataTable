_class("UIWidgetFeatureCardInfo", UICustomWidget)
UIWidgetFeatureCardInfo = UIWidgetFeatureCardInfo

function UIWidgetFeatureCardInfo:OnShow(uiParams)
  self:InitWidget()
  self:ResetState()
  self:RefreshAll()
end

function UIWidgetFeatureCardInfo:OnHide()
  if self._players then
    for i, player in ipairs(self._players) do
      if player:IsPlaying() then
        player:Stop()
      end
    end
  end
  self._matRes = {}
end

function UIWidgetFeatureCardInfo:InitWidget()
  self.enableFakeInput = true
  self._selectMax = 3
  self._players = {}
  self.root = self:GetGameObject("Root")
  self.cardA = self:GetGameObject("CardA")
  self.cardB = self:GetGameObject("CardB")
  self.cardC = self:GetGameObject("CardC")
  self.cardImgA = self:GetUIComponent("RawImageLoader", "CardImgA")
  self.cardImgAGo = self:GetGameObject("CardImgA")
  self.cardImgB = self:GetUIComponent("RawImageLoader", "CardImgB")
  self.cardImgBGo = self:GetGameObject("CardImgB")
  self.cardImgC = self:GetUIComponent("RawImageLoader", "CardImgC")
  self.cardImgCGo = self:GetGameObject("CardImgC")
  self.cardNumBgA = self:GetGameObject("CardNumBgA")
  self.cardNumBgB = self:GetGameObject("CardNumBgB")
  self.cardNumBgC = self:GetGameObject("CardNumBgC")
  self.cardNumA = self:GetUIComponent("UILocalizationText", "CardNumA")
  self.cardNumB = self:GetUIComponent("UILocalizationText", "CardNumB")
  self.cardNumC = self:GetUIComponent("UILocalizationText", "CardNumC")
  self.selectedFillArea1 = self:GetUIComponent("RawImageLoader", "SelectedFillArea1")
  self.selectedFillAreaRect1 = self:GetUIComponent("RectTransform", "SelectedFillArea1")
  self.selectedFillAreaGo1 = self:GetGameObject("SelectedFillArea1")
  self.selectedFillArea2 = self:GetUIComponent("RawImageLoader", "SelectedFillArea2")
  self.selectedFillAreaRect2 = self:GetUIComponent("RectTransform", "SelectedFillArea2")
  self.selectedFillAreaGo2 = self:GetGameObject("SelectedFillArea2")
  self.selectedFillArea3 = self:GetUIComponent("RawImageLoader", "SelectedFillArea3")
  self.selectedFillAreaRect3 = self:GetUIComponent("RectTransform", "SelectedFillArea3")
  self.selectedFillAreaGo3 = self:GetGameObject("SelectedFillArea3")
  self.selectedCardImg1 = self:GetUIComponent("RawImageLoader", "SelectedCardImg1")
  self.selectedCardImg2 = self:GetUIComponent("RawImageLoader", "SelectedCardImg2")
  self.selectedCardImg3 = self:GetUIComponent("RawImageLoader", "SelectedCardImg3")
  self.skillDetailArea = self:GetGameObject("SkillDetailArea")
  self.skillTitleText = self:GetUIComponent("UILocalizationText", "SkillTitleText")
  self.skillDescBg = self:GetUIComponent("RawImageLoader", "SkillDescBg")
  self.skillDescText = self:GetUIComponent("UILocalizationText", "SkillDescText")
  self.castBtn = self:GetUIComponent("Button", "CastBtn")
  self.dragCardGo = self:GetGameObject("DragCard")
  self.dragCardTran = self:GetUIComponent("RectTransform", "DragCard")
  self.dragCardImg = self:GetUIComponent("RawImageLoader", "DragCardImg")
  self.dragCardImgGo = self:GetGameObject("DragCardImg")
  self._buffEffPosRect = self:GetUIComponent("RectTransform", "CardBuffBegin")
  self._dragCardAnim = self:GetUIComponent("Animation", "DragCard")
  self._cardBagAnim = self:GetUIComponent("Animation", "CardBagArea")
  self._rootAnim = self:GetUIComponent("Animation", "UIWidgetFeatureCardInfo")
  self._selAnim1 = self:GetUIComponent("Animation", "SelectedCell1")
  self._selAnim2 = self:GetUIComponent("Animation", "SelectedCell2")
  self._selAnim3 = self:GetUIComponent("Animation", "SelectedCell3")
  self._castTextTmp = self:GetUIComponent("UILocalizedTMP", "CastText")
  self._closeTextTmp = self:GetUIComponent("UILocalizedTMP", "CloseText")
  self._matRes = {}
  self:InitLocalData()
end

function UIWidgetFeatureCardInfo:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIWidgetFeatureCardInfo:InitLocalData()
  self.depotUi = {
    [FeatureCardType.A] = {
      go = self.cardA,
      numGo = self.cardNumBgA,
      numText = self.cardNumA,
      imgLoader = self.cardImgA,
      imgGo = self.cardImgAGo,
      imgResMore = "n21_jieruo_red5",
      imgRes = {
        [0] = "n21_jieruo_red0",
        [1] = "n21_jieruo_red1",
        [2] = "n21_jieruo_red2",
        [3] = "n21_jieruo_red3"
      }
    },
    [FeatureCardType.B] = {
      go = self.cardB,
      numGo = self.cardNumBgB,
      numText = self.cardNumB,
      imgLoader = self.cardImgB,
      imgGo = self.cardImgBGo,
      imgResMore = "n21_jieruo_yellow5",
      imgRes = {
        [0] = "n21_jieruo_yellow0",
        [1] = "n21_jieruo_yellow1",
        [2] = "n21_jieruo_yellow2",
        [3] = "n21_jieruo_yellow3"
      }
    },
    [FeatureCardType.C] = {
      go = self.cardC,
      numGo = self.cardNumBgC,
      numText = self.cardNumC,
      imgLoader = self.cardImgC,
      imgGo = self.cardImgCGo,
      imgResMore = "n21_jieruo_blue4",
      imgRes = {
        [0] = "n21_jieruo_blue0",
        [1] = "n21_jieruo_blue1",
        [2] = "n21_jieruo_blue2",
        [3] = "n21_jieruo_blue3"
      }
    }
  }
  self.selectedUi = {
    [1] = {
      go = self.selectedFillAreaGo1,
      rect = self.selectedFillAreaRect1,
      imgLoader = self.selectedCardImg1,
      anim = self._selAnim1,
      animNamePutDown = "SelectedCell1_putdown",
      animNameIn = "SelectedCell1_enlarge",
      animNameOut = "SelectedCell1_recover",
      animNameUnselected = "SelectedCell1_off",
      moveInPlayer = nil,
      moveOutPlayer = nil
    },
    [2] = {
      go = self.selectedFillAreaGo2,
      rect = self.selectedFillAreaRect2,
      imgLoader = self.selectedCardImg2,
      anim = self._selAnim2,
      animNamePutDown = "SelectedCell2_putdown",
      animNameIn = "SelectedCell2_enlarge",
      animNameOut = "SelectedCell2_recover",
      animNameUnselected = "SelectedCell2_off",
      moveInPlayer = nil,
      moveOutPlayer = nil
    },
    [3] = {
      go = self.selectedFillAreaGo3,
      rect = self.selectedFillAreaRect3,
      imgLoader = self.selectedCardImg3,
      anim = self._selAnim3,
      animNamePutDown = "SelectedCell3_putdown",
      animNameIn = "SelectedCell3_enlarge",
      animNameOut = "SelectedCell3_recover",
      animNameUnselected = "SelectedCell3_off",
      moveInPlayer = nil,
      moveOutPlayer = nil
    }
  }
  self.selectedCardRes = {
    [FeatureCardType.A] = {
      res = "n21_jieruo_ka_red"
    },
    [FeatureCardType.B] = {
      res = "n21_jieruo_ka_yellow"
    },
    [FeatureCardType.C] = {
      res = "n21_jieruo_ka_blue"
    }
  }
  self.skillLocalInfoDic = {
    [1] = {title = "abc", infoParamType = 2},
    [2] = {title = "aaa", infoParamType = 1},
    [3] = {title = "aab", infoParamType = 0}
  }
  self.comTypeToSkillLocalInfoDic = {
    [FeatureCardCompositionType.ABC] = 1,
    [FeatureCardCompositionType.AAA] = 2,
    [FeatureCardCompositionType.BBB] = 2,
    [FeatureCardCompositionType.CCC] = 2,
    [FeatureCardCompositionType.AAB] = 3,
    [FeatureCardCompositionType.AAC] = 3,
    [FeatureCardCompositionType.BBA] = 3,
    [FeatureCardCompositionType.BBC] = 3,
    [FeatureCardCompositionType.CCA] = 3,
    [FeatureCardCompositionType.CCB] = 3
  }
  self:AttachDragEvent(FeatureCardType.A)
  self:AttachDragEvent(FeatureCardType.B)
  self:AttachDragEvent(FeatureCardType.C)
  self._dragEndDisappearAnimNames = {
    [FeatureCardType.A] = "DragCard_sun",
    [FeatureCardType.B] = "DragCard_moon",
    [FeatureCardType.C] = "DragCard_star"
  }
  self._dragEndDisRefreshDepotAnimNames = {
    [FeatureCardType.A] = "CardBagArea_A",
    [FeatureCardType.B] = "CardBagArea_B",
    [FeatureCardType.C] = "CardBagArea_C"
  }
  self:SetFontMat(self._castTextTmp, "battle_feature_card_info_text_mt.mat")
  self:SetFontMat(self._closeTextTmp, "battle_feature_card_info_text_mt.mat")
end

function UIWidgetFeatureCardInfo:SetUIBattle(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetFeatureCardInfo:GetSkillLocalInfo(compositionType)
  local dicKey = self.comTypeToSkillLocalInfoDic[compositionType]
  if dicKey then
    return self.skillLocalInfoDic[dicKey]
  end
end

function UIWidgetFeatureCardInfo:ResetState()
  self.canCast = false
  self._curSkillID = 0
end

function UIWidgetFeatureCardInfo:RefreshAll()
  if not self._initData then
    return
  end
  self:RefreshCardDepotInfo()
  self:RefreshCardSelectedInfo()
  self:RefreshSkillInfo()
  self:RefreshCastBtn()
end

function UIWidgetFeatureCardInfo:Init(skillInitData, castCb, cancelCb)
  self._initData = skillInitData
  self._castCb = castCb
  self._cancelCb = cancelCb
  self._curSkillID = 0
  self.canCast = false
  self._uiCastClicked = false
  local cards = FeatureServiceHelper.GetCards()
  self._cards = {}
  for cardType, count in pairs(cards) do
    self._cards[cardType] = count
  end
  self._selectedCards = {}
  self:RefreshAll()
  self:PlayEnterAudio()
end

function UIWidgetFeatureCardInfo:GetSelectedCount()
  local count = 0
  for index = 1, self._selectMax do
    local cardType = self._selectedCards[index]
    if cardType and 0 < cardType then
      count = count + 1
    end
  end
  return count
end

function UIWidgetFeatureCardInfo:InsertToSelected(cardType, tarIndex)
  if not tarIndex then
    for index = 1, self._selectMax do
      local cardType = self._selectedCards[index]
      if cardType and 0 < cardType then
      else
        self._selectedCards[index] = cardType
        return
      end
    end
  end
  local curCardType = self._selectedCards[tarIndex]
  if curCardType and 0 < curCardType then
  else
    self._selectedCards[tarIndex] = cardType
  end
end

function UIWidgetFeatureCardInfo:RemoveSelected(index)
  self._selectedCards[index] = 0
end

function UIWidgetFeatureCardInfo:IsSelectedSlotEmpty(index)
  local card = self._selectedCards[index]
  if card and 0 < card then
    return false
  end
  return true
end

function UIWidgetFeatureCardInfo:SelectCard(cardType, tarIndex)
  if self._cards[cardType] and self._cards[cardType] > 0 then
  else
    return -1
  end
  if not tarIndex then
    local bHasEmptySlot = false
    for i = 1, self._selectMax do
      if self:IsSelectedSlotEmpty(i) then
        bHasEmptySlot = true
        tarIndex = i
        break
      end
    end
    if not bHasEmptySlot then
      return 0
    end
  end
  if self:GetSelectedCount() < self._selectMax then
    self._cards[cardType] = self._cards[cardType] - 1
    self:InsertToSelected(cardType, tarIndex)
  end
  return tarIndex
end

function UIWidgetFeatureCardInfo:UnselectCard(cardIndex)
  if self._selectedCards[cardIndex] then
    local cardType = self._selectedCards[cardIndex]
    self:RemoveSelected(cardIndex)
    if not self._cards[cardType] then
      self._cards[cardType] = 0
    end
    if self._cards[cardType] then
      self._cards[cardType] = self._cards[cardType] + 1
    end
  end
end

function UIWidgetFeatureCardInfo:IsSelectedCardsEnough()
  if self._selectedCards and self:GetSelectedCount() == self._selectMax then
    return true
  end
  return false
end

function UIWidgetFeatureCardInfo:CheckCurSkillCastCondition()
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curSkillID)
  if not skillConfigData then
    return false
  end
  return FeatureServiceHelper.CheckFeatureSkillCastCondition(FeatureType.Card, self._curSkillID)
end

function UIWidgetFeatureCardInfo:RefreshSkillInfo()
  if self:IsSelectedCardsEnough() then
    if self._curSkillID and self._curSkillID > 0 then
    else
      self:UIAnimOnCardEnough()
    end
    self.skillDetailArea:SetActive(true)
    local comType = FeatureServiceHelper.CaclCardCompositionType(self._selectedCards)
    local skillLocalInfo = self:GetSkillLocalInfo(comType)
    if skillLocalInfo then
      local skillID = self._initData:GetCardSkillDic()[comType]
      if skillID then
        self._curSkillID = skillID
        local log
        self.canCast, log, self._cannotCastReason = self:CheckCurSkillCastCondition()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._curSkillID)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, FeatureType.Card, self._curSkillID)
      end
      local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curSkillID)
      if skillConfigData then
        local title = skillConfigData:GetSkillName()
        local skillTitle = StringTable.Get(title)
        self.skillTitleText:SetText(skillTitle)
        local skillDesc = ""
        local desc = skillConfigData:GetSkillDesc()
        if skillLocalInfo.infoParamType == 0 then
          skillDesc = StringTable.Get(desc)
        elseif skillLocalInfo.infoParamType == 1 then
          local nameOri = self:_GetTeamLeaderName()
          local name = StringTable.Get(nameOri)
          skillDesc = StringTable.Get(desc, name)
        elseif skillLocalInfo.infoParamType == 2 then
          local nameOri = self:_GetTeamTailName()
          local name = StringTable.Get(nameOri)
          skillDesc = StringTable.Get(desc, name)
        end
        self.skillDescText:SetText(skillDesc)
      end
    else
      self:ResetState()
      self.skillDetailArea:SetActive(false)
    end
  else
    if self._curSkillID and self._curSkillID > 0 then
      self:OnCancelSkill()
    end
    self:ResetState()
    self._cannotCastReason = BattleUIActiveSkillCannotCastReason.CardNotEnough
    self.skillDetailArea:SetActive(false)
  end
end

function UIWidgetFeatureCardInfo:OnCancelSkill()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewFeatureSkill, false, true, self._curSkillID, FeatureType.Card)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  self:UIAnimOnSkillCancel()
end

function UIWidgetFeatureCardInfo:_GetTeamLeaderName()
  return self._uiBattle:GetUITeamLeaderName()
end

function UIWidgetFeatureCardInfo:_GetTeamTailName()
  return self._uiBattle:GetUITeamTailName()
end

function UIWidgetFeatureCardInfo:RefreshCastBtn()
  if self.canCast then
    self.castBtn.interactable = true
    local toColor = Color(1.0, 1.0, 1.0, 1)
    self._castTextTmp.color = toColor
  else
    self.castBtn.interactable = false
    local toColor = Color(1.0, 1.0, 1.0, 0.7058823529411765)
    self._castTextTmp.color = toColor
  end
end

function UIWidgetFeatureCardInfo:RefreshCardDepotInfo()
  self:RefreshOneCardDepotInfo(FeatureCardType.A)
  self:RefreshOneCardDepotInfo(FeatureCardType.B)
  self:RefreshOneCardDepotInfo(FeatureCardType.C)
end

function UIWidgetFeatureCardInfo:RefreshOneCardDepotInfo(cardType)
  local uiInfo = self.depotUi[cardType]
  local cardNum = self._cards[cardType]
  if uiInfo then
    if cardNum and 0 < cardNum then
      uiInfo.numGo:SetActive(true)
      uiInfo.numText:SetText(cardNum)
      local res = uiInfo.imgRes[cardNum] or uiInfo.imgResMore
      uiInfo.imgLoader:LoadImage(res)
    else
      uiInfo.imgLoader:LoadImage(uiInfo.imgRes[0])
      uiInfo.numGo:SetActive(true)
      uiInfo.numText:SetText(0)
    end
  end
end

function UIWidgetFeatureCardInfo:TmpDecressOneCardDepotInfo(cardType)
  local uiInfo = self.depotUi[cardType]
  local oriCardNum = self._cards[cardType]
  local cardNum = 0
  if oriCardNum and 0 < oriCardNum then
    cardNum = oriCardNum - 1
  end
  if uiInfo then
    if cardNum and 0 < cardNum then
      uiInfo.numGo:SetActive(true)
      uiInfo.numText:SetText(cardNum)
      local res = uiInfo.imgRes[cardNum] or uiInfo.imgResMore
      uiInfo.imgLoader:LoadImage(res)
    else
      uiInfo.imgLoader:LoadImage(uiInfo.imgRes[0])
      uiInfo.numGo:SetActive(true)
      uiInfo.numText:SetText(0)
    end
  end
end

function UIWidgetFeatureCardInfo:RefreshCardSelectedInfo()
  for i = 1, self._selectMax do
    self:RefreshOneCardSelectedInfo(i)
  end
end

function UIWidgetFeatureCardInfo:RefreshOneCardSelectedInfo(index)
  local uiInfo = self.selectedUi[index]
  local cardType = self._selectedCards[index]
  if uiInfo then
    if cardType and 0 < cardType then
      uiInfo.go:SetActive(true)
      local res = self.selectedCardRes[cardType].res
      uiInfo.imgLoader:LoadImage(res)
    else
      uiInfo.go:SetActive(false)
    end
  end
end

function UIWidgetFeatureCardInfo:SetData()
end

function UIWidgetFeatureCardInfo:CloseBtnOnClick(go)
  if self._cancelCb then
    self._cancelCb(self._curSkillID)
  end
end

function UIWidgetFeatureCardInfo:CloseArea1OnClick(go)
  self:CloseBtnOnClick(nil)
end

function UIWidgetFeatureCardInfo:CloseArea2OnClick(go)
  self:CloseBtnOnClick(nil)
end

function UIWidgetFeatureCardInfo:CastBtnOnClick(go)
  self:OnCastClick()
end

function UIWidgetFeatureCardInfo:SelectedCardImg1OnClick(go)
  self:UnselectCard(1)
  self:RefreshAll()
  self:UIAnimOnUnSelected(1)
end

function UIWidgetFeatureCardInfo:SelectedCardImg2OnClick(go)
  self:UnselectCard(2)
  self:RefreshAll()
  self:UIAnimOnUnSelected(2)
end

function UIWidgetFeatureCardInfo:SelectedCardImg3OnClick(go)
  self:UnselectCard(3)
  self:RefreshAll()
  self:UIAnimOnUnSelected(3)
end

function UIWidgetFeatureCardInfo:AutoCardImgOnClick(cardType)
  if FeatureCardType.A == cardType then
    self:CardImgAOnClick(nil)
  elseif FeatureCardType.B == cardType then
    self:CardImgBOnClick(nil)
  elseif FeatureCardType.C == cardType then
    self:CardImgCOnClick(nil)
  end
end

function UIWidgetFeatureCardInfo:CardImgAOnClick(go)
  local toSlotIndex = self:SelectCard(FeatureCardType.A)
  if 0 < toSlotIndex then
    self:RefreshAll()
    AudioHelperController.PlayUISoundAutoRelease(2522)
    self:UIAnimOnPutDownSelected(toSlotIndex)
  end
end

function UIWidgetFeatureCardInfo:CardImgBOnClick(go)
  local toSlotIndex = self:SelectCard(FeatureCardType.B)
  if 0 < toSlotIndex then
    self:RefreshAll()
    AudioHelperController.PlayUISoundAutoRelease(2522)
    self:UIAnimOnPutDownSelected(toSlotIndex)
  end
end

function UIWidgetFeatureCardInfo:CardImgCOnClick(go)
  local toSlotIndex = self:SelectCard(FeatureCardType.C)
  if 0 < toSlotIndex then
    self:RefreshAll()
    AudioHelperController.PlayUISoundAutoRelease(2522)
    self:UIAnimOnPutDownSelected(toSlotIndex)
  end
end

function UIWidgetFeatureCardInfo:OnCastClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetFeatureCardInfo",
    input = "TmpCastOnClick",
    args = {}
  })
  if self._uiCastClicked then
    return
  end
  if not self.canCast then
    if not self:MissionCanCast() then
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    elseif self._cannotCastReason then
      local textKey = ActiveSkillCannotCastReasonText[self._cannotCastReason]
      local text = StringTable.Get(textKey)
      ToastManager.ShowToast(text)
    else
      local text = StringTable.Get("str_match_cannot_cast_skill_reason")
      ToastManager.ShowToast(text)
    end
  end
  if self._castCb and self.canCast then
    local skillConfigData = ConfigServiceHelper.GetSkillConfigData(self._curSkillID)
    local pickUpType = skillConfigData:GetSkillPickType()
    if self:MissionCanCast() then
      self.castBtn.interactable = false
      self._uiCastClicked = true
      self:UIAnimOnCast(pickUpType)
      Log.info("[Card] cast on click ")
    else
      local text = StringTable.Get("str_match_pickup_skill_limit")
      ToastManager.ShowToast(text)
    end
  end
end

function UIWidgetFeatureCardInfo:MissionCanCast()
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if enterData:GetMatchType() == MatchType.MT_Mission then
    local currentMissionId = enterData:GetMissionCreateInfo().mission_id
    local current_mission_cfg = Cfg.cfg_mission[currentMissionId]
    if current_mission_cfg == nil then
      return true
    end
    local missionCanCast = current_mission_cfg.CastSkillLimit
    return missionCanCast
  end
  return true
end

function UIWidgetFeatureCardInfo:OnCardDragBegin(cardType)
  local cardNum = self._cards[cardType]
  if cardNum and 0 < cardNum then
    self._dragingCard = true
    self._dragingCardCurSlot = 0
    self:ShowDragCard(cardType)
    self:TmpDecressOneCardDepotInfo(cardType)
    AudioHelperController.PlayUISoundAutoRelease(2522)
    self._dragingSoundID = AudioHelperController.PlayUISoundResource(2525, true)
  end
end

function UIWidgetFeatureCardInfo:ShowDragCard(cardType)
  self.dragCardGo:SetActive(true)
  local res = self.selectedCardRes[cardType].res
  self.dragCardImgGo:SetActive(true)
  self.dragCardImg:LoadImage(res)
end

function UIWidgetFeatureCardInfo:OnDragCardEnd(cardType)
  if self._dragingSoundID then
    AudioHelperController.StopUISound(self._dragingSoundID)
  end
  if self._dragingCard then
    self._dragingCard = false
    self._dragingCardCurSlot = 0
    local toSlotIndex = 0
    for index, info in pairs(self.selectedUi) do
      local tran = info.rect
      local localPos = tran:InverseTransformPoint(self.dragCardTran.position)
      if tran.rect:Contains(localPos) then
        toSlotIndex = index
        break
      end
    end
    if toSlotIndex == 0 then
      self.dragCardImgGo:SetActive(false)
      self:UIAnimOnDragCardEnd(cardType)
      return
    end
    if not self:IsSelectedSlotEmpty(toSlotIndex) then
      self:UnselectCard(toSlotIndex)
    end
    self:SelectCard(cardType, toSlotIndex)
    self:RefreshAll()
    self:HideDragCard()
    self:UIAnimOnPutDownSelected(toSlotIndex)
  end
end

function UIWidgetFeatureCardInfo:HideDragCard()
  self.dragCardGo:SetActive(false)
  self.dragCardImgGo:SetActive(false)
end

function UIWidgetFeatureCardInfo:RefreshDragCardPos(screenPos)
  if self._dragingCard and self.dragCardTran then
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self.dragCardTran.parent, screenPos, camera)
    self.dragCardTran.position = pos
    if self._dragingCard then
      local toSlotIndex = 0
      for index, info in pairs(self.selectedUi) do
        local tran = info.rect
        local localPos = tran:InverseTransformPoint(self.dragCardTran.position)
        if tran.rect:Contains(localPos) then
          toSlotIndex = index
          break
        end
      end
      if toSlotIndex == 0 then
        if 0 < self._dragingCardCurSlot then
          self:UIAnimOnMoveOutSelected(self._dragingCardCurSlot)
          self._dragingCardCurSlot = 0
        end
      elseif self._dragingCardCurSlot ~= toSlotIndex then
        if 0 < self._dragingCardCurSlot then
          self:UIAnimOnMoveOutSelected(self._dragingCardCurSlot)
        end
        self:UIAnimOnMoveInSelected(toSlotIndex)
        self._dragingCardCurSlot = toSlotIndex
      end
    end
  end
end

function UIWidgetFeatureCardInfo:AttachDragEvent(cardType)
  local hostGo
  local uiInfo = self.depotUi[cardType]
  if uiInfo then
    hostGo = uiInfo.imgGo
  end
  if not hostGo then
    return
  end
  local etl = UICustomUIEventListener.Get(hostGo)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    self:OnCardDragBegin(cardType)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    self:RefreshDragCardPos(ped.position)
  end)
  
  local function endDragFunc()
    self:OnDragCardEnd(cardType)
  end
  
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    endDragFunc()
  end)
  if not EDITOR then
    self:AddUICustomEventListener(etl, UIEvent.ApplicationFocus, function(b)
      if not b then
        if not etl.IsDragging then
          return
        end
        etl.IsDragging = false
        endDragFunc()
      end
    end)
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnDragCardEnd(cardType)
  local animName = self._dragEndDisappearAnimNames[cardType]
  if animName then
    self:Lock("UIAnimOnDragCardEnd")
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(self._dragCardAnim, animName),
      EZTL_Callback:New(function()
        self:UIAnimOnDragCardEndRefreshDepot(cardType)
        self:RefreshCardDepotInfo()
        self:HideDragCard()
        self:UnLock("UIAnimOnDragCardEnd")
      end)
    }, "抽牌ui动效")
    player:Play(tl)
    AudioHelperController.PlayUISoundAutoRelease(2527)
    table.insert(self._players, player)
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnDragCardEndRefreshDepot(cardType)
  local animName = self._dragEndDisRefreshDepotAnimNames[cardType]
  if animName then
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(self._cardBagAnim, animName),
      EZTL_Callback:New(function()
        self:UnLock("UIAnimOnDragCardEndRefreshDepot")
      end)
    }, "拖牌空地释放ui动效")
    player:Play(tl)
    table.insert(self._players, player)
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnCardEnough()
  local animName = "UIWidgetFeatureCardInfo_skill"
  if animName then
    self:Lock("UIAnimOnCardEnough")
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(self._rootAnim, animName),
      EZTL_Callback:New(function()
        self:UnLock("UIAnimOnCardEnough")
      end)
    }, "卡牌足够")
    player:Play(tl)
    AudioHelperController.PlayUISoundAutoRelease(2519)
    table.insert(self._players, player)
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnCast(pickUpType)
  local hideDelayMs = 3870
  local animName = "UIWidgetFeatureCardInfo_skill_start"
  if animName then
    local player = EZTL_Player:New()
    local tl1 = EZTL_PlayAnimation:New(self._rootAnim, animName)
    local tl2 = EZTL_Callback:New(function()
      self._castCb(self._curSkillID, pickUpType, hideDelayMs)
    end)
    local tl3 = EZTL_Wait:New(hideDelayMs, "发动")
    local tl = EZTL_Parallel:New({
      tl1,
      tl2,
      tl3
    }, EZTL_EndTag.All, nil, "卡牌技发动")
    player:Play(tl)
    AudioHelperController.PlayUISoundAutoRelease(2529)
    table.insert(self._players, player)
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnPutDownSelected(slotIndex)
  local selectUi = self.selectedUi[slotIndex]
  if not selectUi then
    return
  end
  if selectUi.moveInPlayer then
    if selectUi.moveInPlayer:IsPlaying() then
      selectUi.moveInPlayer:Stop()
    end
    selectUi.moveInPlayer = nil
  end
  if selectUi.moveOutPlayer then
    if selectUi.moveOutPlayer:IsPlaying() then
      selectUi.moveOutPlayer:Stop()
    end
    selectUi.moveOutPlayer = nil
  end
  if selectUi.putDownPlayer then
    if selectUi.putDownPlayer:IsPlaying() then
      selectUi.putDownPlayer:Stop()
    end
    selectUi.putDownPlayer = nil
  end
  local anim = selectUi.anim
  local animName = selectUi.animNamePutDown
  if animName then
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(anim, animName),
      EZTL_Callback:New(function()
        self:UnLock("UIAnimOnPutDownSelected")
      end)
    }, "动效")
    player:Play(tl)
    AudioHelperController.PlayUISoundAutoRelease(2524)
    table.insert(self._players, player)
    selectUi.putDownPlayer = player
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnMoveInSelected(slotIndex)
  local selectUi = self.selectedUi[slotIndex]
  if not selectUi then
    return
  end
  local cardType = self._selectedCards[slotIndex]
  if cardType and 0 < cardType then
    return
  end
  if selectUi.moveInPlayer then
    return
  end
  if selectUi.moveOutPlayer then
    if selectUi.moveOutPlayer:IsPlaying() then
      selectUi.moveOutPlayer:Stop()
    end
    selectUi.moveOutPlayer = nil
  end
  local anim = selectUi.anim
  local animName = selectUi.animNameIn
  if animName then
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(anim, animName),
      EZTL_Callback:New(function()
      end)
    }, "动效")
    player:Play(tl)
    table.insert(self._players, player)
    selectUi.moveInPlayer = player
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnMoveOutSelected(slotIndex)
  local selectUi = self.selectedUi[slotIndex]
  if not selectUi then
    return
  end
  local cardType = self._selectedCards[slotIndex]
  if cardType and 0 < cardType then
    return
  end
  if selectUi.moveOutPlayer then
    return
  end
  if selectUi.moveInPlayer then
    if selectUi.moveInPlayer:IsPlaying() then
      selectUi.moveInPlayer:Stop()
    end
    selectUi.moveInPlayer = nil
  end
  local anim = selectUi.anim
  local animName = selectUi.animNameOut
  if animName then
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(anim, animName),
      EZTL_Callback:New(function()
      end)
    }, "动效")
    player:Play(tl)
    table.insert(self._players, player)
    selectUi.moveOutPlayer = player
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnUnSelected(slotIndex)
  local selectUi = self.selectedUi[slotIndex]
  if not selectUi then
    return
  end
  if selectUi.moveInPlayer then
    if selectUi.moveInPlayer:IsPlaying() then
      selectUi.moveInPlayer:Stop()
    end
    selectUi.moveInPlayer = nil
  end
  if selectUi.moveOutPlayer then
    if selectUi.moveOutPlayer:IsPlaying() then
      selectUi.moveOutPlayer:Stop()
    end
    selectUi.moveOutPlayer = nil
  end
  if selectUi.putDownPlayer then
    if selectUi.putDownPlayer:IsPlaying() then
      selectUi.putDownPlayer:Stop()
    end
    selectUi.putDownPlayer = nil
  end
  local anim = selectUi.anim
  local animName = selectUi.animNameUnselected
  if animName then
    anim:Play(animName)
  end
end

function UIWidgetFeatureCardInfo:UIAnimOnSkillCancel()
  local animName = "UIWidgetFeatureCardInfo_skill_out"
  if animName then
    self:Lock("UIAnimOnSkillCancel")
    local player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(self._rootAnim, animName),
      EZTL_Callback:New(function()
        self:UnLock("UIAnimOnSkillCancel")
      end)
    }, "关闭界面")
    player:Play(tl)
    table.insert(self._players, player)
  end
end

function UIWidgetFeatureCardInfo:PlayEnterAudio()
  AudioHelperController.PlayUISoundAutoRelease(2524)
end

function UIWidgetFeatureCardInfo:GetCardBuffEffBeginScreenPos()
  local pos = self._buffEffPosRect.position
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self._uiBattle:GetName())
  local screenPos = camera:WorldToScreenPoint(pos)
  return screenPos
end

function UIWidgetFeatureCardInfo:GetCardBuffEffBeginPos()
  local pos = self._buffEffPosRect.position
  return pos
end
