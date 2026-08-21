_class("UICN16N45SeaNoteRoadPointItem", UICustomWidget)
UICN16N45SeaNoteRoadPointItem = UICN16N45SeaNoteRoadPointItem

function UICN16N45SeaNoteRoadPointItem:Constructor()
  self._pos = {
    [1] = Vector2(-250, -200),
    [2] = Vector2(2600, -100),
    [3] = Vector2(3000, 175),
    [4] = Vector2(3400, -100),
    [5] = Vector2(3750, 175),
    [6] = Vector2(4125, -100)
  }
end

function UICN16N45SeaNoteRoadPointItem:OnHide()
  self.CloseHide = true
end

function UICN16N45SeaNoteRoadPointItem:OnShow(uiParams)
  self:_InitWidget()
end

function UICN16N45SeaNoteRoadPointItem:_InitWidget()
  self._rect = self:GetUIComponent("RectTransform", "gameObj")
  self._RoadPointNameText = self:GetUIComponent("UILocalizationText", "RoadPointNameText")
  self._bg = self:GetUIComponent("Image", "bg")
  self._pass = self:GetGameObject("Pass")
  self._atlas = self:GetAsset("UICN9.spriteatlas", LoadType.SpriteAtlas)
  self._lockobj = self:GetGameObject("Lock")
  self._lockobj:SetActive(false)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self.animation = self:GetUIComponent("Animation", "Lock")
  self._redPointobj = self:GetGameObject("RedPoint")
  self._redPointobj:SetActive(false)
end

function UICN16N45SeaNoteRoadPointItem:SetData(id, pass, info, clickCallback, cfg, camp)
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
  self._pass:SetActive(pass)
  self._clickCallback = clickCallback
  self._id = id
  local cfg = Cfg.cfg_component_asheep_mission[self._id]
  local name = cfg.MissionName
  self.name = name
  local bg = cfg.MissionBG
  self._RoadPointNameText:SetText(StringTable.Get(name))
  self._bg.sprite = self._atlas:GetSprite(bg)
  self:SetPos(id)
  self.cfg = cfg
  self._campaign = camp
  self:RefreshTimelock()
end

function UICN16N45SeaNoteRoadPointItem:RefreshTimelock()
  if self.cfg.OpenTime == nil then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
    local timeStr = "SeaNoteEnter_RedCheck" .. day .. self.cfg.MissionID
    if not UIActivityHelper.HasLocalDB(timeStr) and not self._pass.activeSelf then
      self._redPointobj:SetActive(true)
    end
    return
  end
  if self.CloseHide then
    return
  end
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(self.cfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = time
  if curTime < endTime then
    self._RoadPointNameText:SetText(StringTable.Get("str_luckland_road_time_locked", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
    self._lockobj:SetActive(true)
    LocalDB.SetInt("UICN16N45SeaNoteRoadPointItem:Lock2" .. self._id, 1)
  else
    self._RoadPointNameText:SetText(StringTable.Get(self.name))
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
    local timeStr = "SeaNoteEnter_RedCheck" .. day .. self.cfg.MissionID
    if not UIActivityHelper.HasLocalDB(timeStr) and not self._pass.activeSelf then
      self._redPointobj:SetActive(true)
    end
    if LocalDB.GetInt("UICN16N45SeaNoteRoadPointItem:Lock2" .. self._id) == 1 then
      self._lockobj:SetActive(true)
      self.animation:Play("uianim_UICN16N45SeaNoteRoadPointItem_UnLock")
      LocalDB.SetInt("UICN16N45SeaNoteRoadPointItem:Lock2" .. self._id, 0)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, self._campaign._id)
    else
    end
    return
  end
end

function UICN16N45SeaNoteRoadPointItem:SetPos(id)
  local pos = Vector2(200, -200)
  pos.x = pos.x + (id - 16) * 400
  if id % 2 == 0 then
    pos.y = pos.y + 50
  end
  self._rect.transform.anchoredPosition = pos
end

function UICN16N45SeaNoteRoadPointItem:ClickBtnOnClick()
  if self.cfg.OpenTime ~= nil then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(self.cfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = time
    if curTime < endTime then
      ToastManager.ShowToast(StringTable.Get("str_luckland_road_time_locked", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
      return
    end
  end
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
  local timeStr = "SeaNoteEnter_RedCheck" .. day .. self.cfg.MissionID
  UIActivityHelper.SetLocalDB(timeStr)
  self._redPointobj:SetActive(false)
  if self._clickCallback then
    self._clickCallback(self._id)
  end
end
