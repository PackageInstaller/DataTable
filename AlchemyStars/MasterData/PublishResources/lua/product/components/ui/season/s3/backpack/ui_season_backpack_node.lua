_class("UISeasonBackpackNode", UICustomWidget)
UISeasonBackpackNode = UISeasonBackpackNode

function UISeasonBackpackNode:OnShow(uiParams)
  self._isUnlock = false
  self._seasonModule = self:GetModule(SeasonModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._loginModule = self:GetModule(LoginModule)
  self._atlas = self:GetAsset("UIS3Backpack.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UISeasonBackpackNode:InitWidget()
  self._stateImg = self:GetUIComponent("Image", "StateImg")
  self._levelRect = self:GetUIComponent("RectTransform", "Level")
  self._name = self:GetUIComponent("UILocalizedTMP", "Name")
  self._doneGO = self:GetGameObject("Done")
  self._redpoint = self:GetGameObject("Redpoint")
  self._animation = self:GetGameObject():GetComponent("Animation")
  self._levelAnimation = self:GetUIComponent("Animation", "Level")
end

function UISeasonBackpackNode:SetData(index, cfg)
  self._index = index
  self._cfg = cfg
  self._levelCfg = Cfg.cfg_season_debris_level[self._cfg.ID]
  self._levelRect.anchoredPosition = Vector2(0, self._levelCfg.Y)
  self._key = "UISeasonBackpack" .. GameGlobal.GetModule(LoginModule):GetRoleShowID() .. self._cfg.ID
  self:_RefreshUI()
end

function UISeasonBackpackNode:_RefreshUI()
  local levelImgName = "exp_s3_xxg_btn01"
  local name = StringTable.Get(self._levelCfg.Title)
  local isDone = self._seasonModule:GetHasPassedDebris(self._cfg.ID)
  if isDone then
    self._isUnlock = true
    levelImgName = "exp_s3_xxg_btn02"
  else
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local unlockTime = self._loginModule:GetTimeStampByTimeStr(self._cfg.DateTimeBegin, self._cfg.TimeTransform)
    self._isUnlock = curTime >= unlockTime
    if not self._isUnlock then
      levelImgName = "exp_s3_xxg_btn03"
      name = StringTable.Get("str_season_debris_locktime", UIActivityHelper.GetFormatTimerStr(unlockTime - curTime))
    end
  end
  self._doneGO:SetActive(isDone)
  self._name:SetText(name)
  self._redpoint:SetActive(self:_CheckRedpoint())
  self._stateImg.sprite = self._atlas:GetSprite(levelImgName)
end

function UISeasonBackpackNode:LevelOnClick(go)
  if self._isUnlock then
    self:ShowDialog("UISeasonBackpackInfo", self._cfg)
  else
    ToastManager.ShowToast(StringTable.Get("str_season_debris_lock"))
  end
end

function UISeasonBackpackNode:_CheckRedpoint()
  if self._isUnlock then
    local record = LocalDB.GetInt(self._key, 0)
    LocalDB.SetInt(self._key, 1)
    return record <= 0
  else
    return false
  end
end

function UISeasonBackpackNode:Index()
  return self._index
end

function UISeasonBackpackNode:IsUnlock()
  return self._isUnlock
end

function UISeasonBackpackNode:Refresh()
  self:_RefreshUI()
end

function UISeasonBackpackNode:PlayAnimation()
  if self._isUnlock then
    self._levelAnimation:Play("uieff_UISeasonBackpackNode_level_in")
  end
  if self._index % 2 == 1 then
    self._animation:Play("uieff_UISeasonBackpackNode_in01")
  else
    self._animation:Play("uieff_UISeasonBackpackNode_in")
  end
end
