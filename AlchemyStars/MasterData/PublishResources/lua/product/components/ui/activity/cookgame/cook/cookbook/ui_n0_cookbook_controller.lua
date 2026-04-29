_class("UIN0CookBookController", UIController)
UIN0CookBookController = UIN0CookBookController

function UIN0CookBookController:LoadDataOnEnter(TT, res)
end

function UIN0CookBookController:OnShow(uiParams)
  self._cookData = uiParams[1]
  self._closeCallback = uiParams[2]
  local com, comInfo = self._cookData:GetComponnet()
  self._foodData = comInfo
  self._componnetId = self._cookData:GetComponentId()
  self._unlockNum = 0
  self._foodStatusTb = {}
  self._foodCfgTb = Cfg.cfg_component_newyear_dinner_food({
    ComponentID = self._componnetId
  })
  self._curFoodWidget = nil
  self._foodWidgets = {}
  self._rewardWidgets = {}
  self._atlas = self:GetAsset("CookGame.spriteatlas", LoadType.SpriteAtlas)
  self._isFirst = true
  self:AddListener()
  self:InitWidget()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    local campaign = self._cookData:GetCampaign()
    campaign:ReLoadCampaignInfo_Force(TT, res)
    self._foodPidGo:SetActive(true)
    self:_RefreshFoodList()
    self:_SetFirstSelect()
  end, self)
end

function UIN0CookBookController:OnHide()
  self:RemoveListener()
end

function UIN0CookBookController:AddListener()
  self:AttachEvent(GameEventType.OnN0CookMakeSucc, self.CookSuccess)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UIN0CookBookController:RemoveListener()
  self:DetachEvent(GameEventType.OnN0CookMakeSucc, self.CookSuccess)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UIN0CookBookController:InitWidget()
  self._foodContent = self:GetUIComponent("UISelectObjectPath", "foodContent")
  self._selfNumTxt = self:GetUIComponent("UILocalizationText", "selfNum")
  self._foodName = self:GetUIComponent("UILocalizedTMP", "foodName")
  self._foodPic = self:GetUIComponent("RawImageLoader", "foodPic")
  self._foodPidGo = self:GetGameObject("foodPic")
  self._foodPidGo:SetActive(false)
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._createBtnBg = self:GetUIComponent("Image", "createBtnBg")
  self._createBtnTxtObj = self:GetGameObject("createBtnTxt")
  self._timeObj = self:GetGameObject("timeBg")
  self._foodInfo = self:GetUIComponent("UILocalizationText", "foodInfo")
  self._isDoneObj = self:GetGameObject("isDone")
  self._createBtnObj = self:GetGameObject("CreateBtn")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  self._panelAnim = self:GetUIComponent("Animation", "panelAnim")
  self._leftAnim = self:GetUIComponent("Animation", "leftAnim")
end

function UIN0CookBookController:_RefreshFoodList()
  self:InitFoodList()
  self._req = ResourceManager:GetInstance():SyncLoadAsset("ui_n0_foodbook.mat", LoadType.Mat)
  if self._req and self._req.Obj then
    self.material = self._req.Obj
    local oldMaterial = self._foodName.fontMaterial
    self._foodName.fontMaterial = self.material
    self._foodName.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
  end
end

function UIN0CookBookController:InitFoodList()
  if self._foodData then
    self._foodStatusTb = self._foodData.data_info.food_list
  end
  self._unlockNum = 0
  self._foodWidgets = self._foodContent:SpawnObjects("UIN0CookBookItem", #self._foodCfgTb)
  for i, v in pairs(self._foodWidgets) do
    local cfg = self._foodCfgTb[i]
    local status = self._foodStatusTb[cfg.FoodID]
    if status then
      self._unlockNum = self._unlockNum + 1
    else
      status = NewYearDinner_Status.E_NewYearDinner_Status_LOCK
    end
    v:SetData(cfg, status, function(widget)
      if self._curFoodWidget == widget then
        return
      end
      self:RefreshFoodInfo(widget)
    end, i)
    if not self._curFoodWidget then
    end
  end
  self._selfNumTxt:SetText(self._unlockNum .. "/" .. #self._foodCfgTb)
end

function UIN0CookBookController:RefreshFoodInfo(widget)
  if self._curFoodWidget then
    self._curFoodWidget:SetSelect(false)
  end
  if self._isFirst then
    local curFood = widget:GetInfo()
    self._foodPic:LoadImage(curFood.BigTu)
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    if self._isFirst then
      self._isFirst = false
    else
      self:Lock("UIN0CookBookController_Switch")
      self._leftAnim:Play("uieff_N0_CookBookController_left_out")
      local time = self._leftAnim:GetClip("uieff_N0_CookBookController_left_out").length
      YIELD(TT, time * 1000)
      self._leftAnim:Play("uieff_N0_CookBookController_left_in")
      self:UnLock("UIN0CookBookController_Switch")
    end
    local curFood = widget:GetInfo()
    self._curFoodWidget = widget
    self._foodPic:LoadImage(curFood.BigTu)
    self._foodName:SetText(StringTable.Get(curFood.Name))
    self._foodInfo:SetText(StringTable.Get(curFood.Description))
    local status = widget:GetStatus()
    if status == NewYearDinner_Status.E_NewYearDinner_Status_LOCK then
      self._createBtnBg.sprite = self._atlas:GetSprite("n0_food_btn03")
      self._isDoneObj:SetActive(false)
      self._createBtnObj:SetActive(true)
      self._createBtnTxtObj:SetActive(false)
      self._timeObj:SetActive(true)
      local loginModule = GameGlobal.GetModule(LoginModule)
      local descId = "str_n0_foodbook_remainTime"
      local time = curFood.UnlockTime
      local timer = loginModule:GetTimeStampByTimeStr(time, Enum_DateTimeZoneType.E_ZoneType_GMT)
      self:_SetRemainingTime("remainingTimePool", descId, timer)
    elseif status == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
      self._createBtnBg.sprite = self._atlas:GetSprite("n0_food_btn02")
      self._createBtnTxtObj:SetActive(true)
      self._timeObj:SetActive(false)
      self._isDoneObj:SetActive(false)
      self._createBtnObj:SetActive(true)
    else
      self._createBtnTxtObj:SetActive(false)
      self._timeObj:SetActive(false)
      self._isDoneObj:SetActive(true)
      self._createBtnObj:SetActive(false)
    end
    local rewards = curFood.Reward
    local rewardWidget = self._rewardContent:SpawnObject("UIN0CookRewardItem")
    local id = rewards[1][1]
    local num = rewards[1][2]
    rewardWidget:SetData(id, num, function(tplId, pos)
      self:OnItemClicked(tplId, pos)
    end, function(tplId, pos)
      self.OnItemClicked(tplId, pos)
    end)
  end, self)
end

function UIN0CookBookController:_SetRemainingTime(widgetName, descId, endTime)
  local sop = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = sop:SpawnObject("UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_n0_foodbook_remainTime_End"
  })
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIN0CookBookController:_SetFirstSelect()
  for _, v in pairs(self._foodWidgets) do
    if v:GetStatus() == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
      v:ItemBtnOnClick()
      return
    end
  end
  self._foodWidgets[1]:ItemBtnOnClick()
end

function UIN0CookBookController:CookSuccess()
  self._createBtnTxtObj:SetActive(false)
  self._timeObj:SetActive(false)
  self._isDoneObj:SetActive(true)
  self._createBtnObj:SetActive(false)
  self._curFoodWidget:SetDone()
end

function UIN0CookBookController:OnItemClicked(matid, pos)
  self._selectInfo:SetData(matid, pos)
end

function UIN0CookBookController:_CloseFunc(TT)
  self:Lock("UIN0CookBookController_Close")
  self._panelAnim:Play("uieff_N0_CookBookController_out")
  local time = self._panelAnim:GetClip("uieff_N0_CookBookController_out").length
  YIELD(TT, time * 1000)
  self:UnLock("UIN0CookBookController_Close")
  self:CloseDialog()
end

function UIN0CookBookController:CloseBtnOnClick()
  if self._closeCallback then
    self._closeCallback()
  end
  GameGlobal.TaskManager():StartTask(self._CloseFunc, self)
end

function UIN0CookBookController:CreateBtnOnClick()
  if self._cookData:IsActivityClose() then
    local result = self._cookData:GetCampaign():CheckComponentOpenClientError(ECCampaignInlandDinnerComponentID.ECAMPAIGN_INLAND_DINNER)
    self._cookData:GetCampaign():CheckErrorCode(result)
    return
  end
  if self._curFoodWidget then
    local status = self._curFoodWidget:GetStatus()
    if status == NewYearDinner_Status.E_NewYearDinner_Status_LOCK then
      return
    end
    local foodId = self._curFoodWidget:GetID()
    self:ShowDialog("UIN0CookMakeController", foodId, self._cookData)
  end
end

function UIN0CookBookController:OnActivityCloseEvent(campaignId)
  local campaign = self._cookData:GetCampaign()
  if campaign and campaign._id == campaignId then
    self:CloseDialog()
  end
end
