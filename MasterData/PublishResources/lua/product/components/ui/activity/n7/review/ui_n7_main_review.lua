_class("UIN7MainReview", UIController)
UIN7MainReview = UIN7MainReview

function UIN7MainReview:Constructor(ui_root_transform)
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN7DataReview()
  self.CampaignTypeN7Review = ECampaignType.CAMPAIGN_TYPE_REVIEW_N7
end

function UIN7MainReview:LoadDataOnEnter(TT, res, uiParams)
  self.data:RequestCampaign(TT, self.CampaignTypeN7Review, res)
  if res and not res:GetSucc() then
    self.mCampaign:CheckErrorCode(res.m_result, self.mCampaign._id, nil, nil)
    return
  end
  self.data:Init()
end

function UIN7MainReview:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self:ShowHideUi(false)
  end)
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self.ui = self:GetGameObject("ui")
  self._levelRed = self:GetGameObject("LevelRed")
  self.ImgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self.sldProgress = self:GetUIComponent("Slider", "sldProgress")
  self.poolAward = self:GetUIComponent("UISelectObjectPath", "poolAward")
  self.txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self.goBtnNot = self:GetGameObject("BtnNot")
  self.goBtnCanGet = self:GetGameObject("BtnCanGet")
  self.goBtnGot = self:GetGameObject("BtnGot")
  self.shot = self:GetUIComponent("RawImage", "RawImage")
  self.imgRT = uiParams[1]
  if self.imgRT then
    self.shot.color = Color.white
    self.shot.texture = self.imgRT
  else
    self.shot.color = Color.black
  end
  self:AttachEvent(GameEventType.ActivityN7MainRefresh, self.RequestAndRefresh)
  self:AttachEvent(GameEventType.SummerTwoLoginRed, self.FlushRed)
  self:Flush()
  self:CheckGuide()
  CutsceneManager.ExcuteCutsceneOut()
end

function UIN7MainReview:OnHide()
  self.ImgIcon:DestoryLastImage()
  self:DetachEvent(GameEventType.ActivityN7MainRefresh, self.RequestAndRefresh)
  self:DetachEvent(GameEventType.SummerTwoLoginRed, self.FlushRed)
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
end

function UIN7MainReview:RequestAndRefresh()
  self:StartTask(self.RequestData, self, function()
    self:Flush()
  end)
end

function UIN7MainReview:RequestData(TT, callback)
  self:Lock("UIActivityN7MainController_RequestData")
  local checkList = {}
  checkList[#checkList + 1] = RedDotType.RDT_SHADOW_TOWN
  checkList[#checkList + 1] = RedDotType.RDT_BLACKFIST_PRESTIGE
  checkList[#checkList + 1] = RedDotType.RDT_BLACKFIST_FUNCTION
  self._redStatus = self._redDotModule:RequestRedDotStatus(TT, checkList)
  if callback then
    callback()
  end
  self:UnLock("UIActivityN7MainController_RequestData")
end

function UIN7MainReview:CloseCoro(TT)
  self:Lock("UIActivityN7MainController_CloseCoro")
  self:SwitchState(UIStateType.UIActivityReview)
  self:UnLock("UIActivityN7MainController_CloseCoro")
end

function UIN7MainReview:Flush()
  self:FlushRed()
  self:FlushProgress()
end

function UIN7MainReview:FlushRed()
  self._levelRed:SetActive(self.data:CheckRedNormal())
end

function UIN7MainReview:FlushProgress()
  local percent = self.data:GetCurProgressPercent()
  self.sldProgress.value = percent
  self.txtProgress:SetText(math.floor(percent * 100) .. "%")
  local progressCanGet = self.data:GetProgressCanGet()
  self.goBtnGot:SetActive(false)
  self.goBtnCanGet:SetActive(false)
  self.goBtnNot:SetActive(false)
  local icon, name, desc = "", "", ""
  if progressCanGet then
    self.goBtnCanGet:SetActive(true)
    icon, name, desc = progressCanGet:IconNameDesc()
  else
    local progressNext = self.data:GetProgressNext()
    if progressNext then
      self.goBtnNot:SetActive(true)
      icon, name, desc = progressNext:IconNameDesc()
    else
      self.goBtnGot:SetActive(true)
      local len = table.count(self.data.progresses)
      local lastProgress = self.data.progresses[len]
      icon, name, desc = lastProgress:IconNameDesc()
    end
  end
  self.ImgIcon:LoadImage(icon)
  self:FlushAwards()
end

function UIN7MainReview:FlushAwards()
  local percent = self.data:GetCurProgressPercent()
  local nextIndex = 0
  for i, progress in pairs(self.data.progresses) do
    if percent * 100 < progress.progress then
      nextIndex = i
      break
    end
  end
  local len = #self.data.progresses
  self.poolAward:SpawnObjects("UIN7MainAwardItemReview", len)
  local uis = self.poolAward:GetAllSpawnList()
  for i, progress in pairs(self.data.progresses) do
    local ui = uis[i]
    local isReach = false
    if progress.progress <= percent * 100 then
      isReach = true
    end
    ui:Flush(isReach, nextIndex == i, self.data:CheckGot(progress.progress))
  end
  self:StartTask(function(TT)
    for i, ui in ipairs(uis) do
      ui:PlayAnim()
      YIELD(TT, 40)
    end
  end, self)
end

function UIN7MainReview:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN7MainReview)
end

function UIN7MainReview:ShowHideUi(isShow)
  self._showBtn:SetActive(not isShow)
  self.ui:SetActive(isShow)
end

function UIN7MainReview:ShowBtnOnClick()
  self:ShowHideUi(true)
end

function UIN7MainReview:LevelBtnOnClick()
  local cType, cId = self.data:GetCampaignTypeId()
  self.mCampaign:CampaignSwitchState(true, UIStateType.UIN7LevelReview, UIStateType.UIMain, nil, cId)
end

function UIN7MainReview:BlackFightAwardBtnOnClick()
  self:ShowDialog("UIBlackFightPaperReview")
end

function UIN7MainReview:BtnAwardIntroOnClick()
  self:ShowDialog("UIN7AwardProgressReview")
end

function UIN7MainReview:BtnCanGetOnClick()
  local progressCanGet = self.data:GetProgressCanGet()
  if not progressCanGet then
    return
  end
  self:StartTask(function(TT)
    local key = "UIN7AwardProgressReviewImgCanGetOnClick"
    self:Lock(key)
    local c = self.data:GetComponentProgress()
    local res = AsyncRequestRes:New()
    c:HandleReceiveReward(TT, res, progressCanGet.progress)
    if N7DataReview.CheckCode(res) then
      self:ShowUIGetItemController(progressCanGet.awards)
      self:Flush()
    end
    self:UnLock(key)
  end, self)
end

function UIN7MainReview:ShowUIGetItemController(rewards)
  if not rewards then
    return
  end
  self._petModule = GameGlobal.GetModule(PetModule)
  local tempPets = {}
  if 0 < #rewards then
    for i = 1, #rewards do
      local ispet = self._petModule:IsPetID(rewards[i].assetid)
      if ispet then
        table.insert(tempPets, rewards[i])
      end
    end
  end
  
  local function cbFunc()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end
  
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards, cbFunc)
    end)
  else
    self:ShowDialog("UIGetItemController", rewards, cbFunc)
  end
end

function UIN7MainReview:ImgIconOnClick()
  local ra
  local progressCanGet = self.data:GetProgressCanGet()
  if progressCanGet then
    ra = progressCanGet:Get1stAward()
  else
    local progressNext = self.data:GetProgressNext()
    if progressNext then
      ra = progressNext:Get1stAward()
    else
      local len = table.count(self.data.progresses)
      local lastProgress = self.data.progresses[len]
      ra = lastProgress:Get1stAward()
    end
  end
  self:ShowDialog("UIItemTips", ra, self.ImgIcon.gameObject, "UIN7MainReview", Vector2(400, 150))
end

function UIN7MainReview:BtnOnClick()
  self:ShowDialog("UIN7AwardProgressReview")
end
