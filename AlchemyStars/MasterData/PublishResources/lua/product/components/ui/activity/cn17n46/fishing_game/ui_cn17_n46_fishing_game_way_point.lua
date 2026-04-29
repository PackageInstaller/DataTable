_class("UICN17N46FishingGameWayPoint", UICustomWidget)
UICN17N46FishingGameWayPoint = UICN17N46FishingGameWayPoint

function UICN17N46FishingGameWayPoint:OnShow(uiParams)
  self._ziImg = {
    [ScoreType.B] = "B",
    [ScoreType.A] = "A",
    [ScoreType.S] = "S"
  }
  self._normalColor = Color(1.0, 0.9725490196078431, 0.8431372549019608)
  self._lockColor = Color(0.5333333333333333, 0.5333333333333333, 0.9058823529411765)
  self._normalFishColor = Color(1.0, 1.0, 1.0)
  self._lockFishColor = Color(0.5333333333333333, 0.5333333333333333, 0.5333333333333333)
  self:_GetComponents()
end

function UICN17N46FishingGameWayPoint:_GetComponents()
  self._di = self:GetGameObject("di")
  self._diRectTf = self:GetUIComponent("RectTransform", "di")
  self._diImg = self:GetUIComponent("Image", "di")
  self._diImg2 = self:GetUIComponent("Image", "di2")
  self._yu = self:GetUIComponent("Image", "yu")
  self._zi = self:GetUIComponent("UILocalizationText", "zi")
  self._ziBg = self:GetGameObject("zidi")
  self._nameBg = self:GetUIComponent("Image", "NameBg")
  self._lock = self:GetGameObject("lock")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._redPoint = self:GetGameObject("RedPoint")
  self._btn = self:GetGameObject("Image")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._downLine = self:GetGameObject("DownLine")
  self._upLline = self:GetGameObject("UpLline")
end

function UICN17N46FishingGameWayPoint:SetData(stagecontroller, index, cfg, miss_info, servertime, callback, showNew, isCurrent, missionLock, maxIndex, campaign, lockCB)
  self._stageController = stagecontroller
  self._index = index
  self._cfg = cfg
  self._miss_info = miss_info
  self._serverTime = servertime
  self._callBack = callback
  self._showNew = showNew
  self._isCurrent = isCurrent
  self._missionLock = missionLock
  self._canClick = true
  self:_SetUIInfo()
  self._clicked = false
  self._campaign = campaign
  self._lockCB = lockCB
  local pos = self._diRectTf.anchoredPosition
  if self._index % 2 == 0 then
    pos.x = 240
    self._downLine:SetActive(false)
  else
    pos.x = -240
    self._upLline:SetActive(false)
  end
  self._diRectTf.anchoredPosition = pos
  if index == maxIndex then
    self._downLine:SetActive(false)
    self._upLline:SetActive(false)
  end
  self.isRank = false
  local campcfg = Cfg.cfg_campaign_component({
    CampaignID = self._campaign._id
  })[1]
  local subKey = campcfg.RankSubKey[1]
  if subKey == self._cfg.ID then
    self.isRank = true
  end
  if self.isRank then
    self._downLine:SetActive(false)
    self._upLline:SetActive(false)
    pos.x = 50
    self._diRectTf.anchoredPosition = pos
  end
end

function UICN17N46FishingGameWayPoint:_SetUIInfo()
  self._yu.sprite = self._atlas:GetSprite(self._cfg.Bg)
  self:RefreshRedpointStateZi(self._miss_info.mission_info)
  self:RefreshUnLockState(self._serverTime, self._missionLock)
end

function UICN17N46FishingGameWayPoint:RefreshUnLockState(servertime, missionLock)
  self._serverTime = servertime
  self._missionLock = missionLock
  self._canClick = self._miss_info.unlock_time <= self._serverTime and not self._missionLock
  if self._miss_info.unlock_time > self._serverTime then
    self._btn:SetActive(true)
    self._name:SetText(self._stageController:_GetRemainTime(self._miss_info.unlock_time - self._serverTime))
    self._nameBg.sprite = self._atlas:GetSprite("n14_fish_bg_name_lock")
    self._name.color = self._lockColor
    self._yu.color = self._lockFishColor
    self._diImg.color = self._lockFishColor
    self._lock:SetActive(true)
  elseif self._missionLock then
    self._btn:SetActive(true)
    self._name:SetText(StringTable.Get("str_fishing_game_lock_title"))
    self._nameBg.sprite = self._atlas:GetSprite("n14_fish_bg_name_lock")
    self._name.color = self._lockColor
    self._yu.color = self._lockFishColor
    self._diImg.color = self._lockFishColor
    self._lock:SetActive(true)
  else
    self._btn:SetActive(false)
    self._name:SetText(StringTable.Get(self._cfg.Title))
    self._nameBg.sprite = self._atlas:GetSprite("n14_fish_bg_name")
    self._name.color = self._normalColor
    self._yu.color = self._normalFishColor
    self._diImg.color = self._normalFishColor
    self._lock:SetActive(false)
  end
end

function UICN17N46FishingGameWayPoint:RefreshRedpointStateZi(miss_info)
  local showredpoint = self:_CheckRedpoint(miss_info)
  self._redPoint:SetActive(showredpoint)
  if miss_info.mission_grade >= ScoreType.B then
    self._ziBg:SetActive(true)
    self._zi.text = self._ziImg[miss_info.mission_grade]
  else
    self._ziBg:SetActive(false)
  end
end

function UICN17N46FishingGameWayPoint:_CheckRedpoint(miss_info)
  for key, value in pairs(ScoreType) do
    if value <= miss_info.mission_grade and miss_info.reward_mask & value == 0 then
      return true
    end
  end
  return false
end

function UICN17N46FishingGameWayPoint:BtnOnClick(go)
  if not self._canClick then
    return
  end
  if self._showNew then
    self._showNew = false
  end
  self._animation:Play("uieff_N14_Fishing_Way_Click")
  self._callBack(self._index)
end

function UICN17N46FishingGameWayPoint:RefreshClickStatus(clickIndex)
  if self._index == clickIndex then
    self._clicked = true
  else
    if self._miss_info.unlock_time > self._serverTime or self._missionLock then
      self._diImg.sprite = self._atlas:GetSprite("n14_fish_bg_guanqia_2")
    elseif self._miss_info.mission_info.max_score > 0 then
      self._diImg.sprite = self._atlas:GetSprite("n14_fish_bg_guanqia_1")
    else
      self._diImg.sprite = self._atlas:GetSprite("n14_fish_bg_guanqia_2")
    end
    if self._clicked then
      self._animation:Play("uieff_N14_Fishing_Way_Click_back")
      self._clicked = false
    end
  end
  self._diImg2.gameObject:SetActive(self._index == clickIndex)
  self._diImg2.enabled = self._index == clickIndex
  self._diImg:SetNativeSize()
  self._diImg2:SetNativeSize()
end

function UICN17N46FishingGameWayPoint:LockOnClick(go)
  if self._lockCB then
    self._lockCB()
  end
  if self._miss_info.unlock_time > self._serverTime then
    local str = self._stageController:_GetRemainTime(self._miss_info.unlock_time - self._serverTime)
    ToastManager.ShowToast(StringTable.Get("str_fishing_cn17_lock_time", str))
    return
  end
  if self._missionLock then
    ToastManager.ShowToast(StringTable.Get("str_fishing_cn17_lock_mission"))
  end
end

function UICN17N46FishingGameWayPoint:RefreshData(data)
  self._miss_info = data
end
