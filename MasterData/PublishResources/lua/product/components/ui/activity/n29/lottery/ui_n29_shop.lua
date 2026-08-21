_class("UIN29Shop", UIController)
UIN29Shop = UIN29Shop

function UIN29Shop:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = UIN29ShopData:New()
  self.mPet = self:GetModule(PetModule)
  self._uiModule = self:GetModule(RoleModule).uiModule
  self.clientHelper = ClientCampaignDrawShop:New()
  self.fsm = StateMachineManager:GetInstance():CreateStateMachine("StateN29Shop", StateN29Shop)
  self.fsm:SetData(self)
  self.fsm:Init(StateN29Shop.Init)
  self.multiPrice = 1000
  self.uiData = {}
  self.jackpotCount = 0
  self.unlockBoxs = {}
  self._curPageIndex = 1
  self.spineSkipClickCallback = nil
  AudioHelperController.RequestUISoundSync(CriAudioIDConst.N29Single)
  AudioHelperController.RequestUISoundSync(CriAudioIDConst.N29Multi)
end

function UIN29Shop:LoadDataOnEnter(TT, res, uiParams)
  self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N29, res)
  if res and not res:GetSucc() then
    self.mCampaign:CheckErrorCode(res.m_result, self.mCampaign._id, nil, nil)
    return
  end
end

function UIN29Shop:OnShow(uiParams)
  self._campaignLotteryType = nil
  self.imgRT = uiParams[1]
  self:_GetComponents()
  self:_InitData(true, true)
  self:OnValue()
  self:PlayAnim()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
end

function UIN29Shop:OnHide()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.N29Single)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.N29Multi)
end

function UIN29Shop:PlayAnim(callback)
  self:StartTask(function(TT)
    local key = "UIN29ShopPlayAnim"
    self:Lock(key)
    self.anim:Play("uieff_UIN29Shop_in")
    self:PlayAnimItem()
    YIELD(TT, 767)
    self:UnLock(key)
    if callback then
      callback()
    end
  end, self)
end

function UIN29Shop:ShowHideItems(isShow)
  local pools = self.awardPool:GetAllSpawnList()
  for index, item in ipairs(pools) do
    item:ShowHide(isShow)
  end
end

function UIN29Shop:PlayItemsOut()
  local pools = self.awardPool:GetAllSpawnList()
  for index, item in ipairs(pools) do
    item:PlayOutAnim()
  end
end

function UIN29Shop:PlayAnimItem()
  local pools = self.awardPool:GetAllSpawnList()
  local awards = self.data:GetPoolAwards(self._curPageIndex)
  local len = #awards
  for index, item in ipairs(pools) do
    if index > len then
      break
    end
    item:PlayAnim(index)
  end
end

function UIN29Shop:OnValue(donotPlaySpine)
  self:_InitAwardListUi()
  self:ArrowBtnState()
  self:ShowPoolLock()
  self:_RefreshBoxTitle()
  self:_RefreshCurBoxRest()
  self:ShowPageValue()
  self:_RefreshDrawBtn()
  if not donotPlaySpine then
    self:ShowSpineAnim3()
  end
end

function UIN29Shop:ArrowBtnState()
  self.boxLeftBtnGo:SetActive(not (self._curPageIndex <= 1))
  self.boxRightBtnGo:SetActive(not (self._curPageIndex >= self.jackpotCount))
end

function UIN29Shop:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN29Shop:_ForceRefresh(isOpenNew, donotPlaySpine)
  self:_InitData(isOpenNew)
  self:OnValue(donotPlaySpine)
end

function UIN29Shop:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIN29Shop:_GetComponents()
  self.anim = self:GetUIComponent("Animation", "animation")
  self.tipsAnimation = self:GetUIComponent("Animation", "tipsAnimation")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self.rt = self:GetUIComponent("RawImage", "shot")
  self.rt.texture = self.imgRT
  local s = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self.awardPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.lockInfoAreaGo = self:GetGameObject("LockInfoArea")
  self.allGet = self:GetGameObject("allGet")
  self.sinMask = self:GetGameObject("sinMask")
  self.mulMask = self:GetGameObject("mulMask")
  self.drawSingleBtnText = self:GetUIComponent("UILocalizationText", "DrawSingleBtnText")
  self.drawSingleCostText = self:GetUIComponent("UILocalizationText", "DrawSingleCostText")
  self.drawMultiBtnText = self:GetUIComponent("UILocalizationText", "DrawMultiBtnText")
  self.drawMultiCostText = self:GetUIComponent("UILocalizationText", "DrawMultiCostText")
  self.boxLeftBtnGo = self:GetGameObject("BoxLeftBtn")
  self.boxRightBtnGo = self:GetGameObject("BoxRightBtn")
  self.pointNumText = self:GetUIComponent("UILocalizationText", "PointNumText")
  local backBtnGen = self:GetUIComponent("UISelectObjectPath", "TopLeft")
  self.backBtns = backBtnGen:SpawnObject("UICommonTopButton")
  self.backBtns:SetData(function()
    self:CloseDialogWithAnim()
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  self.TopTips = self:GetGameObject("TopTips")
  self.tipsImg = self:GetGameObject("tipsImg")
  self:ShowTopTips(false)
  self.awardProgress = self:GetUIComponent("UILocalizationText", "awardProgress")
  self.awardListTitleText = self:GetUIComponent("UILocalizationText", "AwardListTitleText")
  self.spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineSke = self.spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self.spine.CurrentMultiSkeleton
  end
  if self._spineSke then
    self._spineSke.AnimationState.Data.DefaultMix = 0
  end
  self.slideAreaGo = self:GetGameObject("SpineArea")
  self.selfRect = self:GetUIComponent("RectTransform", "SpineArea")
  if self.slideAreaGo then
    self.etl = UICustomUIEventListener.Get(self.slideAreaGo)
    self:RegUIEventTriggerListener(function(ped)
      self:OnBeginDrag(ped)
    end, function(ped)
      self:OnDrag(ped)
    end, function(ped)
      self:OnEndDrag(ped)
    end)
  end
  self.spineSkipGo = self:GetGameObject("SpineSkip")
  self.spineSkipGo:SetActive(false)
  self._pageValue = self:GetUIComponent("UILocalizationText", "PageValue")
end

function UIN29Shop:PlaySpineAnimation(spineAnim, loop)
  if not self._spineSke then
    Log.debug("###[UIMainLobbyController] not self._spineSke")
    return
  end
  local entry
  
  local function func()
    self._spineSke:Initialize(true)
    entry = self._spineSke.AnimationState:SetAnimation(0, spineAnim, loop)
  end
  
  local succ = pcall(func)
  if not succ then
    Log.error("###[UIMainLobbyController] set spine anim fail ! anim[", spineAnim, "]")
    return
  end
  if not entry then
    Log.error("###[UIMainLobbyController] entry is nil ! anim[", spineAnim, "]")
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  return yieldTime
end

function UIN29Shop:RegUIEventTriggerListener(onBeginDrag, onDrag, onEndDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.BeginDrag, onBeginDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.Drag, onDrag)
  self:AddUICustomEventListener(self.etl, UIEvent.EndDrag, onEndDrag)
end

function UIN29Shop:OnBeginDrag(ped)
  local deltaX = ped.delta.x
  if self:IsEdge(deltaX) then
    return
  end
  local pos = UIN29Shop.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xBegainDrag = pos.x
end

function UIN29Shop:OnDrag(ped)
  local pos = UIN29Shop.ScreenPointToLocalPointInRectangle(self.selfRect, ped)
  self._xCurDrag = pos.x
end

function UIN29Shop:OnEndDrag(ped)
  self:InitDragField()
end

function UIN29Shop:_UpdateDragSwitch()
  if not self.etl then
    return
  end
  if not self.etl.IsDragging then
    return
  end
  if not self._xBegainDrag or not self._xCurDrag then
    return
  end
  local deltaX = self._xCurDrag - self._xBegainDrag
  if deltaX == 0 then
    return
  end
  if self:IsEdge(deltaX) then
    return
  end
  local absDeltaX = math.abs(deltaX)
  if 100 < absDeltaX then
    self:OnEndDrag()
    if deltaX < 0 then
      self:BoxRightBtnOnClick()
    else
      self:BoxLeftBtnOnClick()
    end
  end
end

function UIN29Shop.ScreenPointToLocalPointInRectangle(rect, ped)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, ped.position, ped.pressEventCamera, nil)
  return pos
end

function UIN29Shop:IsEdge(deltaX)
  if 0 < deltaX and self._curPageIndex == 1 then
    return true
  end
  if deltaX < 0 and self._curPageIndex == self.jackpotCount then
    return true
  end
  return false
end

function UIN29Shop:InitDragField()
  self._xBegainDrag = nil
  self._xCurDrag = nil
  self._posBGLogo = Vector2(-667, 0)
end

function UIN29Shop:_InitData(isOpenNew, isOnShow)
  self.unlockBoxs = {}
  self.uiData = {}
  local cLottery = self.data:GetComponentShop()
  local cInfoLottery = self.data:GetComponentInfoShop()
  if cLottery and cInfoLottery then
    self.currencyId = cInfoLottery.m_cost_item_id
    self.multiPrice = cInfoLottery.m_cost_count * cInfoLottery.m_multi_lottery
    self.unlockBoxs = cInfoLottery.m_unlock_jackpots
    for index, value in ipairs(cInfoLottery.m_jackpots) do
      local itemBox = DCampaignDrawShopItemBox:New()
      itemBox:Refresh(value, cLottery)
      table.insert(self.uiData, itemBox)
    end
    self.jackpotCount = #self.uiData
    local unlockBoxNum = #self.unlockBoxs
    if isOnShow then
      self._initPageIndex = self:_GetDefaultPageIndexOnShow()
    elseif isOpenNew then
      if 0 < unlockBoxNum then
        self._initPageIndex = self.unlockBoxs[unlockBoxNum]
      else
        self._initPageIndex = 1
      end
    else
      self._initPageIndex = self._curPageIndex
    end
  end
  self._curPageIndex = self._initPageIndex
end

function UIN29Shop:CloseDialogWithAnim()
  UIActivityHelper.Snap(self._shot, self:GetUIComponent("RectTransform", "SafeArea").rect.size, GameGlobal.UIStateManager():GetControllerCamera(self:GetName()), function(cache_rt)
    self:StartTask(function(TT)
      self:SwitchState(UIStateType.UIActivityN29MainController)
    end, self)
  end)
end

function UIN29Shop:ShowTopTips(show)
  self.TopTips:SetActive(show)
  self.tipsImg:SetActive(show)
end

function UIN29Shop:_InitAwardListUi()
  local unlock = self.data:IsPoolUnlock(self._curPageIndex)
  local awards = self.data:GetPoolAwards(self._curPageIndex)
  local len = #awards
  self.awardPool:SpawnObjects("UIN29ShopItem", len)
  local pools = self.awardPool:GetAllSpawnList()
  for i = 1, len do
    local item = pools[i]
    local data = awards[i]
    item:InitData(data, function(id, pos)
      self:_ShowItemTips(id, pos)
    end, unlock)
  end
end

function UIN29Shop:PlayAnimUIN29ShopEffZhuanchang()
  self:StartTask(function(TT)
    local key = "UIN29ShopPlayAnimUIN29ShopEffZhuanchang"
    self:Lock(key)
    self:OnValue()
    self:PlayItemsOut()
    self.anim:Play("uieff_UIN29Shop_UnlocktoUnlock")
    YIELD(TT, 230)
    self:ShowHideItems(false)
    self:PlayAnimItem()
    YIELD(TT, 503)
    self:UnLock(key)
  end, self)
end

function UIN29Shop:OnUpdate(deltaTimeMS)
  self:_UpdateDragSwitch()
end

function UIN29Shop:_ShowItemTips(id, pos)
  self:ShowTips(id, pos)
end

function UIN29Shop:ShowPageValue()
  self._pageValue:SetText(self._curPageIndex .. "/" .. self.jackpotCount)
end

function UIN29Shop:GetLessDrawCount()
  local max = 10
  if not self.data:IsPoolUnlock(self._curPageIndex) then
    return max
  end
  local canDrawCardCount, isEmpty = self.data:GetPoolLeftDrawCount(self._curPageIndex)
  if isEmpty then
    return max
  end
  if max < canDrawCardCount then
    return max
  end
  return canDrawCardCount
end

function UIN29Shop:_RefreshDrawBtn()
  self.drawSingleBtnText:SetText(StringTable.Get("str_n29_draw_btn", 1))
  local canDrawCardCount = self:GetLessDrawCount()
  self.drawMultiBtnText:SetText(StringTable.Get("str_n29_draw_btn", canDrawCardCount))
  self:SetPointNumber()
  self:_RefreshSingleDrawBtn()
  self:_RefreshMultiDrawBtn()
end

function UIN29Shop:ShowPoolLock()
  if not self.data:IsPoolUnlock(self._curPageIndex) then
    self.lockInfoAreaGo:SetActive(false)
    self.lockInfoAreaGo:SetActive(true)
    self.allGet:SetActive(false)
  else
    self.lockInfoAreaGo:SetActive(false)
    local isEmpty = self.data:IsPoolEmpty(self._curPageIndex)
    if isEmpty then
      self.allGet:SetActive(false)
      self.allGet:SetActive(true)
    else
      self.allGet:SetActive(false)
    end
  end
end

function UIN29Shop:_RefreshSingleDrawBtn()
  local enable = self.data:IsPoolUnlock(self._curPageIndex) and not self.data:IsPoolEmpty(self._curPageIndex)
  self.sinMask:SetActive(not enable)
end

function UIN29Shop:_RefreshMultiDrawBtn()
  local enable = self.data:IsPoolUnlock(self._curPageIndex) and not self.data:IsPoolEmpty(self._curPageIndex)
  self.mulMask:SetActive(not enable)
end

function UIN29Shop:_RefreshBoxTitle()
  local boxNameText = StringTable.Get("str_n29_award_preview_tip", self._curPageIndex)
  self.awardListTitleText:SetText(boxNameText)
end

function UIN29Shop:_RefreshCurBoxRest()
  local curBoxRest = 0
  local curBoxTotal = 0
  local boxData = self.uiData[self._curPageIndex]
  if boxData then
    curBoxRest, curBoxTotal = boxData:GetTotalRestItem()
  end
  local tmpText = StringTable.Get("str_n29_award_progress", curBoxRest, curBoxTotal)
  self.awardProgress:SetText(tmpText)
end

function UIN29Shop:_OnItemCountChanged()
  self:_RefreshSingleDrawBtn()
  self:_RefreshMultiDrawBtn()
  self:SetPointNumber()
end

function UIN29Shop:SetPointNumber()
  local totalNum = self.data:GetCostCount()
  local count = self:GetLessDrawCount()
  local cInfoLottery = self.data:GetComponentInfoShop()
  self.drawSingleCostText:SetText(cInfoLottery.m_cost_count)
  self.drawMultiCostText:SetText(cInfoLottery.m_cost_count * count)
  if self.data:IsCostEnough(1) then
    self.drawSingleCostText.color = Color(1, 0.796078431372549, 0.24313725490196078, 1)
  else
    self.drawSingleCostText.color = Color.red
  end
  if self.data:IsCostEnough(count) then
    self.drawMultiCostText.color = Color(1.0, 0.796078431372549, 0.24313725490196078, 1)
  else
    self.drawMultiCostText.color = Color.red
  end
  self:SetTopNumber()
end

function UIN29Shop:SetTopNumber()
  local totalNum = self.data:GetCostCount()
  local c1 = "#898568"
  local c2 = "#efc961"
  local text = UIActivityHelper.FormatNumber_PreZero(7, totalNum, c1, c2)
  self.pointNumText:SetText(text)
end

function UIN29Shop:_GetDefaultPageIndexOnShow()
  local pageIndex = 1
  local cLottery = self.data:GetComponentShop()
  if cLottery then
    for index, value in ipairs(self.unlockBoxs) do
      local isNoRestBigReward = cLottery:IsLotteryJeckpotNoRestBigReward(value)
      if not isNoRestBigReward then
        return value
      end
    end
    for index, value in ipairs(self.unlockBoxs) do
      local isEmpty = cLottery:IsLotteryJeckpotEmpty(value)
      if not isEmpty then
        return value
      end
    end
  end
  return pageIndex
end

function UIN29Shop:_RecordRewardsInfo(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
  if not self.rewardRecord then
    self.rewardRecord = DCampaignDrawShopDrawResultRecord:New()
  end
  self.rewardRecord:Record(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
end

function UIN29Shop:ShowSpineAnim3()
  local spineAnim = self._curPageIndex .. "_idle"
  self:PlaySpineAnimation(spineAnim, true)
end

function UIN29Shop:BoxLeftBtnOnClick(go)
  local nextIndex = self._curPageIndex - 1
  if nextIndex < 1 then
    return
  end
  self._curPageIndex = nextIndex
  self:PlayAnimUIN29ShopEffZhuanchang()
end

function UIN29Shop:BoxRightBtnOnClick(go)
  local nextIndex = self._curPageIndex + 1
  if nextIndex > self.jackpotCount then
    return
  end
  self._curPageIndex = nextIndex
  self:PlayAnimUIN29ShopEffZhuanchang()
end

function UIN29Shop:DrawSingleBtnOnClick(go)
  if self.data:IsPoolEmpty(self._curPageIndex) then
    return
  end
  if not self.data:IsPoolUnlock(self._curPageIndex) then
    return
  end
  if not self.data:IsCostEnough(1) then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_9001"))
    return
  end
  self._campaignLotteryType = ECampaignLotteryType.E_CLT_SINGLE
  self.fsm:ChangeState(StateN29Shop.DrawCard, self._campaignLotteryType)
  self._playerID = AudioHelperController.PlayUISoundResource(CriAudioIDConst.N29Single, false)
end

function UIN29Shop:DrawMultiBtnOnClick(go)
  if self.data:IsPoolEmpty(self._curPageIndex) then
    return
  end
  if not self.data:IsPoolUnlock(self._curPageIndex) then
    return
  end
  local count = self:GetLessDrawCount()
  if not self.data:IsCostEnough(count) then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_9001"))
    return
  end
  self._campaignLotteryType = ECampaignLotteryType.E_CLT_MULTI
  self.fsm:ChangeState(StateN29Shop.DrawCard, self._campaignLotteryType)
  self._playerID = AudioHelperController.PlayUISoundResource(CriAudioIDConst.N29Multi, false)
end

function UIN29Shop:SpineSkipOnClick(go)
  if self.spineSkipClickCallback then
    self.spineSkipClickCallback(self._campaignLotteryType)
  end
  if self._playerID then
    AudioHelperController.StopUISound(self._playerID)
  end
end

function UIN29Shop:TopTipsOnClick(go)
  self:StartTask(function(TT)
    local key = "UIN29ShopTopTipsOnClick"
    self:Lock(key)
    self.tipsAnimation:Play("uieff_UIN29Shop_Tipsout")
    YIELD(TT, 233)
    self:ShowTopTips(false)
    self:UnLock(key)
  end, self)
end

function UIN29Shop:PointAreaOnClick(go)
  self:StartTask(function(TT)
    local key = "UIN29ShopPointAreaOnClick"
    self:Lock(key)
    self:ShowTopTips(true)
    self.tipsAnimation:Play("uieff_UIN29Shop_Tipsin")
    YIELD(TT, 300)
    self:UnLock(key)
  end, self)
end

function UIN29Shop:RuleDescriptionBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN29ShopIntro")
end

local StateN29Shop = {
  Init = 0,
  DrawCard = 1,
  SpineAnim = 2,
  SpineAnim2 = 3,
  GetAward = 4,
  SpecialAllIn = 5
}
_enum("StateN29Shop", StateN29Shop)
