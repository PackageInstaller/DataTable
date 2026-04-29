require("ui_side_enter_center_content_base")
_class("UIPetForecastContent", UISideEnterCenterContentBase)
UIPetForecastContent = UIPetForecastContent

function UIPetForecastContent:DoInit(params)
end

function UIPetForecastContent:DoShow()
  self._forecastData = self._data
  self._obj_title = self:GetGameObject("title")
  self._obj_titleEn = self:GetGameObject("titleEn")
  self:_SetShareUI("normal")
  self:_SetDebugBtn()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.ItemCountChanged)
  self.te = UIActivityHelper.StartTimerEvent(self.te, function()
    self:FlushLeftTime()
  end)
  self.curSelectDay = 0
  self.fsm = StateMachineManager:GetInstance():CreateStateMachine("StatePetForecast", StatePetForecast)
  self.fsm:SetData(self)
  self.fsm:Init(StatePetForecast.Init)
  if self._forecastData and 0 < self._forecastData.id then
    local id = self._forecastData.id
    local key = UIPetForecastEnter.GetLocalDBKey(id)
    LocalDB.SetInt(key, 1)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, -1, nil, nil)
  end
end

function UIPetForecastContent:DoHide()
  UIWidgetHelper.ClearWidgets(self, "_tipsPool")
  self:Close()
  self.te = UIActivityHelper.CancelTimerEvent(self.te)
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.RolePropertyChanged, self.ItemCountChanged)
end

function UIPetForecastContent:DoDestroy()
end

function UIPetForecastContent:RequestPrediction(TT)
  local lockName = "UIPetForecastContent_RequestPrediction"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  if not self._dataLoader then
    self._dataLoader = UIPetForecastDataLoader:New()
  end
  self._data = self._dataLoader:LoadData(TT, res)
  self._forecastData = self._data
  self:Flush()
  self:UnLock(lockName)
end

function UIPetForecastContent:Init()
  self:_SetUIByCfg()
end

function UIPetForecastContent:_SetUIByCfg()
  local mainBg = self._forecastData:GetCfg_cg("mainBg")
  self:GetGameObject("mainBg"):SetActive(mainBg ~= nil)
  if mainBg then
    UIWidgetHelper.SetRawImage(self, "mainBg", mainBg)
  end
  UIWidgetHelper.SetRawImage(self, "ComicBg", self._forecastData:GetCfg_cg("bg"))
  local trans = self:GetUIComponent("RectTransform", "TitleBg")
  trans.anchoredPosition = self._forecastData.posTitle
  trans.sizeDelta = self._forecastData.sizeTitle
  UIWidgetHelper.SetRawImage(self, "TitleBg", self._forecastData:GetCfg_cg("bgTitle"))
  self._forecastData:SetObjColor(self, "Image", "imgLeftTime", "colorLeftTimeBG")
  self._forecastData:SetObjColor(self, "Image", "imgClock", "colorLeftTimeHint")
  self._forecastData:SetObjColor(self, "UILocalizationText", "txtLeftTimeHint", "colorLeftTimeHint")
  self._forecastData:SetObjColor(self, "UILocalizationText", "txtLeftTime", "colorLeftTime")
end

function UIPetForecastContent:Flush(isShow)
  if not self._forecastData then
    Log.warn("### self._forecastData nil.")
    return
  end
  self:FlushLeftTime()
  self:FlushDesc()
  self:_SetComic()
  self:_SetPieceBtn(isShow)
  self:_SetDrawCardPet()
  self:_SetShareBtn("normal")
end

function UIPetForecastContent:FlushLeftTime()
  local text = ""
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if self._forecastData and nowTimestamp < self._forecastData.endTime then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(self._forecastData.endTime)
    local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
    if 1 <= d then
      text = StringTable.Get("str_prediction_left_time_d_h", math.floor(d), math.floor(h))
    elseif 1 <= h then
      text = StringTable.Get("str_prediction_left_time_h_m", math.floor(h), math.floor(m))
    elseif 1 <= m then
      text = StringTable.Get("str_prediction_left_time_m", math.floor(m))
    else
      text = StringTable.Get("str_prediction_left_time_m", "<" .. 1)
    end
  else
    text = StringTable.Get("str_prediction_error_code_1")
    UIActivityHelper.CancelTimerEvent(self.te)
  end
  UIWidgetHelper.SetLocalizationText(self, "txtLeftTime", text)
end

function UIPetForecastContent:FlushDesc()
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  local str = ""
  if self.curSelectDay == 0 then
    str = StringTable.Get("str_prediction_info_" .. self._forecastData.id, name)
  else
    str = StringTable.Get("str_prediction_info_" .. self._forecastData.id .. "_" .. self.curSelectDay, name)
  end
  UIWidgetHelper.SetLocalizationText(self, "txtDesc", str)
  local sv = self:GetUIComponent("ScrollRect", "sv")
  sv.verticalNormalizedPosition = 1
end

function UIPetForecastContent:_SetComic()
  local len = table.count(self._forecastData.pieces)
  local objs = UIWidgetHelper.SpawnObjects(self, "_comicImg", "UIPetForecastComic", len)
  for i, v in ipairs(objs) do
    v:SetData(i, self._forecastData)
  end
  local selectDay = self.curSelectDay
  local isSelected = selectDay ~= 0
  if isSelected then
    local selectImg = self._forecastData:GetCfg_imgs(selectDay, "select")
    UIWidgetHelper.SetRawImage(self, "_selectedImg", selectImg)
  end
  self:GetGameObject("_selectedImg"):SetActive(isSelected)
  UIWidgetHelper.SetRawImage(self, "ComicFrame", self._forecastData:GetCfg_cg("comicFrame"))
end

function UIPetForecastContent:_SetPieceBtn(isShow)
  if isShow == nil then
    isShow = self._forecastData:IsAllAccepted() and self._forecastData:HasNewPieceImage()
  end
  local len = table.count(self._forecastData.pieces)
  local pieceList = UIWidgetHelper.SpawnObjects(self, "_pieceBtn", "UIPetForecastBtn", len)
  for i, v in ipairs(pieceList) do
    v:Flush(i, function(day)
      if day < 1 or day > len then
        Log.fatal("### invalid param. day = ", day)
        return
      end
      self.curSelectDay = self.curSelectDay == day and 0 or day
      self:Flush()
    end, isShow, function()
      self:Flush()
    end, self._isDebug)
  end
end

function UIPetForecastContent:_SetDrawCardPet()
  local isShow = self._forecastData:IsAllAccepted()
  local data = self._forecastData.pets
  self:GetGameObject("_drawCardPetInfo"):SetActive(isShow)
  if not isShow or not data then
    return
  end
  local lenPets = table.count(data)
  local pets = UIWidgetHelper.SpawnObjects(self, "_drawCardPetInfo", "UIDrawCardPetInfoLoader", lenPets)
  local views = UIWidgetHelper.SpawnObjects(self, "_view", "UIPetForecastViewItem", lenPets)
  for i, v in ipairs(pets) do
    local pet = data[i]
    v:SetData(2, pet.petId, Vector2.zero, function(id)
      self:ShowDialog("UIShopPetDetailController", id)
    end)
    local v05 = Vector2.one * 0.5
    self._forecastData:SetObjTransform(v, v05, v05, pet.pos)
    views[i]:Flush(pet.petId)
  end
end

function UIPetForecastContent:ShowTips(matid, pos)
  UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
end

function UIPetForecastContent:Close()
  self.fsm:ChangeState(StatePetForecast.NewUnlockClose)
end

function UIPetForecastContent:ItemCountChanged()
  self:StartTask(self.RequestPrediction, self)
end

function UIPetForecastContent:ShareBtnOnClick(go)
  self:Lock("UIPetForecastShare")
  self:StartTask(function(TT)
    self:_SetShareUI("share")
    YIELD(TT)
    self:ShowDialog("UIShare", "UISideEnterCenterController", ShareAnchorType.CenterRight, function()
      self:_SetShareUI("normal")
    end, ShareAnchorType.TopCenter, nil, nil, ShareSceneType.CampaignPreView)
    self:UnLock("UIPetForecastShare")
  end, self)
end

function UIPetForecastContent:_SetShareUI(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    share = {"shareBg"},
    normal = {
      "ComicBg",
      "TitleBg",
      "RightBottom"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
  self:_SetShareBtn(state)
  local regionRect = self:GetUIComponent("RectTransform", "ComicRegion")
  if not self._defaultPos then
    self._defaultPos = regionRect.anchoredPosition
  end
  if state == "share" then
    self:SetCenterUIHide(true)
    regionRect.anchoredPosition = Vector2(self._defaultPos.x, self._defaultPos.y - 140)
    regionRect.localScale = Vector2(0.95, 0.95)
  else
    self:SetCenterUIHide(false)
    regionRect.anchoredPosition = self._defaultPos
    regionRect.localScale = Vector2(1, 1)
  end
end

function UIPetForecastContent:_SetShareBtn(state)
  local shareBtn = self:GetGameObject("ShareBtn")
  local isZh = UIActivityZhHelper.IsZh()
  if isZh == false then
    shareBtn:SetActive(false)
    return
  end
  local canShare = self:GetModule(ShareModule):CanShare()
  local allAccepted = self._forecastData:IsAllAccepted()
  local isShow = canShare and allAccepted and state ~= "share"
  shareBtn:SetActive(isShow)
end

function UIPetForecastContent:_SetDebugBtn()
  local isShow = UIActivityHelper.CheckDebugOpen()
  self:GetGameObject("DebugBtn"):SetActive(isShow)
  self._isDebug = false
end

function UIPetForecastContent:DebugBtnOnClick(go)
  self._isDebug = not self._isDebug
  self:Flush()
end

function UIPetForecastContent:IsPlaying()
  if self.isPlaying then
    for _, b in ipairs(self.isPlaying) do
      if b then
        return true
      end
    end
  end
  return false
end

function UIPetForecastContent:PlayPetForecastView(view)
  if view and self._forecastData:IsAllAccepted() and self._forecastData:HasNewPieceImage() then
    self.isPlaying = {}
    for i, p in ipairs(view.parallel) do
      self.isPlaying[i] = true
      self:StartTask(function(TT)
        local key = "UIPetForecastPlayPetForecastView" .. i
        self:Lock(key)
        for _, command in ipairs(p.commands) do
          local nameFunc = "PlayPetForecastViewCommand" .. command.name
          local func = self[nameFunc]
          if func then
            func(self, TT, command.params)
          else
            Log.fatal("### no function name: ", nameFunc)
          end
        end
        self.isPlaying[i] = false
        self:UnLock(key)
      end, self)
    end
  end
end

function UIPetForecastContent:PlayPetForecastViewCommandWait(TT, params)
  if params then
    local ms = tonumber(params[1] or "0")
    YIELD(TT, ms)
  end
end

function UIPetForecastContent:PlayPetForecastViewCommandPlayEffect(TT, params)
  if params then
    local effectName = (params[1] or "") .. ".prefab"
    local nodeName = params[2] or ""
    local tranParent = self:GetUIComponent("Transform", nodeName)
    if not tranParent then
      Log.error("###[UIPetForecast] no node:", nodeName)
      return
    end
    local tranChild = tranParent:Find(effectName)
    if tranChild then
      tranChild.gameObject:SetActive(true)
    else
      local effReq = ResourceManager:GetInstance():SyncLoadAsset(effectName, LoadType.GameObject)
      if not effReq then
        Log.error("###[UIPetForecast] effReq is nil !")
      end
      self.dictEffect[effectName] = effReq
      local child = effReq.Obj
      child.transform:SetParent(tranParent)
      local rect = child:GetComponent("RectTransform")
      rect.anchoredPosition = Vector2.zero
      rect.localScale = Vector3.one
      child:SetActive(true)
      child.name = effectName
    end
  end
end

function UIPetForecastContent:PlayPetForecastViewCommandPlayAudio(TT, params)
  if params then
    local audioId = tonumber(params[1] or "0")
    AudioHelperController.PlayUISoundAutoRelease(audioId)
  end
end

function UIPetForecastContent:PlayPetForecastViewCommandReplaceImage(TT, params)
  self:Flush(true)
end

function UIPetForecastContent:PlayPetForecastViewCommandPlayAnim(TT, params)
  if params then
    local nodeName = params[1] or ""
    local tranAnimNode = self:GetUIComponent("Animation", nodeName)
    if not tranAnimNode then
      Log.error("###[UIPetForecast] no node:", tranAnimNode)
      return
    end
    tranAnimNode:Play()
  end
end

local StatePetForecast = {
  Init = 0,
  Normal = 1,
  NewUnlockLast = 2,
  NewUnlockNormal = 3,
  NewUnlockClose = 4
}
_enum("StatePetForecast", StatePetForecast)
