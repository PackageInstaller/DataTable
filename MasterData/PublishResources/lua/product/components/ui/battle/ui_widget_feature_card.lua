_class("UIWidgetFeatureCard", UICustomWidget)
UIWidgetFeatureCard = UIWidgetFeatureCard

function UIWidgetFeatureCard:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureCard:OnHide()
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIWidgetFeatureCard:InitWidget()
  self.enableFakeInput = true
  self._imageNormal = self:GetUIComponent("Image", "ImageNormal")
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageWarningGo = self:GetGameObject("ImageWarning")
  self._imageNotFullFrontGo = self:GetGameObject("ImageNotFullFront")
  self._imageFullFrontGo = self:GetGameObject("ImageFullFront")
  self._uIWidgetFeatureCard = self:GetUIComponent("Image", "UIWidgetFeatureCard")
  self._anim = self:GetUIComponent("Animation", "UIWidgetFeatureCard")
  self._cardCountText = self:GetUIComponent("UILocalizationText", "CardCountText")
  self._cardInfoPool = self:GetUIComponent("UISelectObjectPath", "CardInfoGen")
  self._skillID = 0
  self._uiBattle = nil
  self._switchTimeEvent = nil
  self._switchTimeLength = 100
  self:InitLocalData()
  self:RegisterEvent()
end

function UIWidgetFeatureCard:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetFeatureCard:InitLocalData()
  self._cardAnimNames = {
    [FeatureCardType.A] = "UIWidgetFeatureCard_sun",
    [FeatureCardType.B] = "UIWidgetFeatureCard_moon",
    [FeatureCardType.C] = "UIWidgetFeatureCard_star"
  }
end

function UIWidgetFeatureCard:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureUIPlayDrawCard, self._OnFeatureUIPlayDrawCard)
  self:AttachEvent(GameEventType.FeatureUIRefreshCardNum, self._OnFeatureUIRefreshCardNum)
end

function UIWidgetFeatureCard:_OnFeatureUIPlayDrawCard(cardType)
  local cardAnimName = self._cardAnimNames[cardType]
  if cardAnimName then
    self._player = EZTL_Player:New()
    local tl = EZTL_Sequence:New({
      EZTL_PlayAnimation:New(self._anim, cardAnimName),
      EZTL_Callback:New(function()
        self:RefreshCardNum()
      end)
    }, "抽牌ui动效")
    self._player:Play(tl)
  end
end

function UIWidgetFeatureCard:_OnFeatureUIRefreshCardNum()
  self:RefreshCardNum()
end

function UIWidgetFeatureCard:SetUIBattle(uiBattle)
  self._uiBattle = uiBattle
end

function UIWidgetFeatureCard:GetUIBattle()
  return self._uiBattle
end

function UIWidgetFeatureCard:SetData(skillInitData)
  self._cardInitData = skillInitData
  self._skillDic = self._cardInitData:GetCardSkillDic()
  self:RefreshCardNum()
end

function UIWidgetFeatureCard:RefreshCardNum()
  local cardNum = FeatureServiceHelper.GetCurCardCount()
  self._cardCountText:SetText(cardNum)
  if 0 < cardNum then
    self._imageNormalGo:SetActive(false)
    self._imageWarningGo:SetActive(true)
    self._imageFullFrontGo:SetActive(true)
    self._imageNotFullFrontGo:SetActive(false)
  else
    self._imageNormalGo:SetActive(true)
    self._imageWarningGo:SetActive(false)
  end
end

function UIWidgetFeatureCard:UIWidgetFeatureCardOnClick(go)
  if self:IsAutoFighting() or InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:OnClickUI()
end

function UIWidgetFeatureCard:OnClickUI()
  local canCastSkill = true
  if canCastSkill then
    local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
    local enableInput = GameGlobal:GetInstance():IsInputEnable()
    if coreGameStateID == GameStateID.WaitInput and enableInput == true then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
      self:ShowCardInfoUI()
    elseif coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget then
      if self._switchTimeEvent == nil then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.UISwitchActiveSkillUI)
        self:ShowCardInfoUI()
        Log.notice("preclickhead card skill", self._skillID)
        self._switchTimeEvent = GameGlobal.Timer():AddEvent(self._switchTimeLength, function()
          self._switchTimeEvent = nil
          Log.notice("preview card skill", self._skillID)
        end)
      else
        Log.notice("still in switch", self._skillID)
      end
    end
  end
end

function UIWidgetFeatureCard:ShowCardInfoUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, true, FeatureType.Card)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillCast)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PauseGuideWeakLine)
  local canCast = true
  
  local function castCb(castSkillID, pickUpType, delayCloseMs)
    self:OnCastSkill(castSkillID, pickUpType, delayCloseMs)
  end
  
  local function cancelCb(curSkillID)
    self:OnCancelSkill(curSkillID)
  end
  
  self._uiBattle:GetFeatureCardUI(self._cardInitData:GetUiType()):Init(self._cardInitData, castCb, cancelCb)
  self._uiBattle:ShowFeatureCardInfo(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickUI2ClosePreviewMonster)
end

function UIWidgetFeatureCard:OnCastSkill(castSkillID, pickUpType, delayCloseMs)
  self:Lock("UIAnimOnCast")
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, castSkillID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    self:HideCardInfoUI(delayCloseMs)
  elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
    Log.fatal("[UIWidgetFeaturePersonaSkill] cast skill pick up type error:", pickUpType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
    self:HideCardInfoUI(delayCloseMs)
  else
    Log.fatal("[UIWidgetFeaturePersonaSkill] cast skill pick up type error:", pickUpType)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    local petPstID = 0
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveSkillPickUp, castSkillID, petPstID)
    self:HideCardInfoUI(delayCloseMs)
  end
end

function UIWidgetFeatureCard:OnCancelSkill(curSkillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StopPreviewFeatureSkill, false, true, curSkillID, FeatureType.Card)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, -1)
  self:HideCardInfoUI()
end

function UIWidgetFeatureCard:HideCardInfoUI(delayCloseMs)
  if delayCloseMs and 0 < delayCloseMs then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self._timerHandler = GameGlobal.Timer():AddEvent(delayCloseMs, function()
      self:UnLock("UIAnimOnCast")
      self._uiBattle:ShowFeatureCardInfo(false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, FeatureType.Card)
    end)
  else
    self:UnLock("UIAnimOnCast")
    self._uiBattle:ShowFeatureCardInfo(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIFeatureSkillInfoShow, false, FeatureType.Card)
  end
end

function UIWidgetFeatureCard:OnSwitchActiveSkillUI()
  self:HideCardInfoUI()
end
