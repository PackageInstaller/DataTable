_class("UIN20MiniGameWayPoint", UICustomWidget)
UIN20MiniGameWayPoint = UIN20MiniGameWayPoint

function UIN20MiniGameWayPoint:OnShow(uiParams)
  self._ziImg = {
    [ScoreType.B] = "n20_game_smlB",
    [ScoreType.A] = "n20_game_smlA",
    [ScoreType.S] = "n20_game_smlS"
  }
  self:_GetComponents()
end

function UIN20MiniGameWayPoint:_GetComponents()
  self._tu = self:GetUIComponent("Image", "tu")
  self._zi = self:GetUIComponent("Image", "zi")
  self._ziObj = self:GetGameObject("zi")
  self._nameBg = self:GetUIComponent("Image", "NameBg")
  self._lock = self:GetGameObject("Lock")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._redPoint = self:GetGameObject("RedPoint")
  self._stateObj = self:GetGameObject("State")
  self._newFlag = self:GetGameObject("NewFlag")
  self._atlas = self:GetAsset("N20MiniGame.spriteatlas", LoadType.SpriteAtlas)
end

function UIN20MiniGameWayPoint:SetData(stagecontroller, missionID, cfg, miss_info, servertime, callback, showNew)
  self._stageController = stagecontroller
  self._missionID = missionID
  self._cfg = cfg
  self._miss_info = miss_info
  self._serverTime = servertime
  self._callBack = callback
  self._showNew = showNew
  self:_SetUIInfo()
end

function UIN20MiniGameWayPoint:_SetUIInfo()
  self._tu.sprite = self._atlas:GetSprite("n20_game_tu" .. self._cfg.Bg .. "2")
  self._newFlag:SetActive(self._showNew)
  self:RefreshRedpointStateZi(self._miss_info.mission_info)
  self:RefreshUnLockState(self._serverTime)
end

function UIN20MiniGameWayPoint:RefreshUnLockState(servertime)
  self._serverTime = servertime
  if self._miss_info.unlock_time > self._serverTime then
    self._name:SetText(self._stageController:_GetRemainTime(self._miss_info.unlock_time - self._serverTime))
    self._nameBg.sprite = self._atlas:GetSprite("n20_game_spot3")
    self._lock:SetActive(true)
  else
    self._name:SetText(StringTable.Get(self._cfg.Title))
    self._nameBg.sprite = self._atlas:GetSprite("n20_game_spot1")
    self._lock:SetActive(false)
  end
end

function UIN20MiniGameWayPoint:RefreshRedpointStateZi(miss_info)
  local showredpoint = self:_CheckRedpoint(miss_info)
  self._redPoint:SetActive(showredpoint)
  self._stateObj:SetActive(not showredpoint and miss_info.mission_grade >= ScoreType.S)
  if miss_info.mission_grade >= ScoreType.B then
    self._ziObj:SetActive(true)
    self._zi.sprite = self._atlas:GetSprite(self._ziImg[miss_info.mission_grade])
  else
    self._ziObj:SetActive(false)
  end
end

function UIN20MiniGameWayPoint:_CheckRedpoint(miss_info)
  for _, value in pairs(ScoreType) do
    if value <= miss_info.mission_grade and miss_info.reward_mask & value == 0 then
      return true
    end
  end
  return false
end

function UIN20MiniGameWayPoint:SetNameBg(selected)
  if selected then
    self._tu.sprite = self._atlas:GetSprite("n20_game_tu" .. self._cfg.Bg .. "1")
    self._nameBg.sprite = self._atlas:GetSprite("n20_game_spot2")
  else
    self._tu.sprite = self._atlas:GetSprite("n20_game_tu" .. self._cfg.Bg .. "2")
    self._nameBg.sprite = self._atlas:GetSprite("n20_game_spot1")
  end
end

function UIN20MiniGameWayPoint:BtnOnClick(go)
  if self._showNew then
    self._showNew = false
    self._newFlag:SetActive(self._showNew)
  end
  self._callBack(self._missionID)
end
