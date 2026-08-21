_class("UIMiniGameWayPoint", UICustomWidget)
UIMiniGameWayPoint = UIMiniGameWayPoint

function UIMiniGameWayPoint:OnShow(uiParams)
  self._ziImg = {
    [ScoreType.B] = "B",
    [ScoreType.A] = "A",
    [ScoreType.S] = "S"
  }
  self:_GetComponents()
end

function UIMiniGameWayPoint:_GetComponents()
  self._di = self:GetGameObject("di")
  self._tu = self:GetUIComponent("RawImageLoader", "tu")
  self._tuRect = self:GetUIComponent("RectTransform", "tu")
  self._zi = self:GetUIComponent("RawImageLoader", "zi")
  self._ziObj = self:GetGameObject("zi")
  self._nameBg = self:GetUIComponent("Image", "NameBg")
  self._lock = self:GetGameObject("Lock")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._redPoint = self:GetGameObject("RedPoint")
  self._stateObj = self:GetGameObject("State")
  self._newFlag = self:GetGameObject("NewFlag")
  self._atlas = self:GetAsset("UISummer.spriteatlas", LoadType.SpriteAtlas)
end

function UIMiniGameWayPoint:SetData(stagecontroller, missionID, cfg, miss_info, servertime, callback, showNew)
  self._stageController = stagecontroller
  self._missionID = missionID
  self._cfg = cfg
  self._miss_info = miss_info
  self._serverTime = servertime
  self._callBack = callback
  self._showNew = showNew
  self:_SetUIInfo()
end

function UIMiniGameWayPoint:_SetUIInfo()
  self._tu:LoadImage(string.format("xiahuo_game_%stu", self._cfg.Bg))
  self._newFlag:SetActive(self._showNew)
  self:RefreshRedpointStateZi(self._miss_info.mission_info)
  self:RefreshUnLockState(self._serverTime)
end

function UIMiniGameWayPoint:RefreshUnLockState(servertime)
  self._serverTime = servertime
  if self._miss_info.unlock_time > self._serverTime then
    self._name:SetText(self._stageController:_GetRemainTime(self._miss_info.unlock_time - self._serverTime))
    self._name.alignment = UnityEngine.TextAnchor.MiddleRight
    self._nameBg.sprite = self._atlas:GetSprite("xiahuo_game_di8")
    self._lock:SetActive(true)
  else
    self._name:SetText(StringTable.Get(self._cfg.Title))
    self._name.alignment = UnityEngine.TextAnchor.MiddleCenter
    self._nameBg.sprite = self._atlas:GetSprite("xiahuo_game_di7")
    self._lock:SetActive(false)
  end
end

function UIMiniGameWayPoint:RefreshRedpointStateZi(miss_info)
  local showredpoint = self:_CheckRedpoint(miss_info)
  self._redPoint:SetActive(showredpoint)
  self._stateObj:SetActive(not showredpoint and miss_info.mission_grade >= ScoreType.S)
  if miss_info.mission_grade >= ScoreType.B then
    self._ziObj:SetActive(true)
    self._zi:LoadImage(string.format("xiahuo_game_%szi", self._ziImg[miss_info.mission_grade]))
    self._tuRect.anchoredPosition = Vector2(-72.5, 43.5)
  else
    self._ziObj:SetActive(false)
    self._tuRect.anchoredPosition = Vector2(-20.7, 43.5)
  end
end

function UIMiniGameWayPoint:_CheckRedpoint(miss_info)
  for key, value in pairs(ScoreType) do
    if value <= miss_info.mission_grade and miss_info.reward_mask & value == 0 then
      return true
    end
  end
  return false
end

function UIMiniGameWayPoint:BtnOnClick(go)
  if self._showNew then
    self._showNew = false
    self._newFlag:SetActive(self._showNew)
  end
  self._callBack(self._missionID)
end
