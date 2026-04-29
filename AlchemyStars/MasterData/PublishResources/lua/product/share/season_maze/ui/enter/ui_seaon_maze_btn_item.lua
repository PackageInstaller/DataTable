_class("UISeaonMazeBtnItem", UICustomWidget)
UISeaonMazeBtnItem = UISeaonMazeBtnItem

function UISeaonMazeBtnItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeaonMazeBtnItem:InitWidget()
  self.seasonMazeBtnNew = self:GetGameObject("SeasonMazeBtnNew")
  self.uISeaonMazeBtnItem = self:GetGameObject("UISeaonMazeBtnItem")
  self.point = self:GetGameObject("Point")
  self.point:SetActive(false)
  self.Over = self:GetGameObject("Over")
  self.Over:SetActive(false)
end

function UISeaonMazeBtnItem:SetData(id, action, first, cb)
  self.cb = cb
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  if self._seasonMazeModule == nil then
    self.uISeaonMazeBtnItem:SetActive(false)
    return
  end
  self._sample = self._seasonMazeModule:GetCurSample()
  if self._sample == nil then
    self.uISeaonMazeBtnItem:SetActive(false)
    return
  end
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._sample.end_time
  if curTime > endTime then
    self.Over:SetActive(true)
    return
  end
  if not self._sample.is_open then
    self.uISeaonMazeBtnItem:SetActive(false)
    return
  end
  self.uISeaonMazeBtnItem:SetActive(true)
  self.seasonMazeBtnNew:SetActive(false)
  local new, red = self:CheckNewAndRed()
  if new then
    self.seasonMazeBtnNew:SetActive(true)
  end
  if red then
    self.point:SetActive(true)
  else
    self.point:SetActive(false)
  end
end

function UISeaonMazeBtnItem:CheckNewAndRed()
  local new = false
  local red = false
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_Processs_New") then
    new = true
  end
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_HandBook_New") then
    new = true
  end
  if not UIActivityHelper.HasLocalDB("UISeasonMazeEnterController_BanPet_New") then
    new = true
  end
  if LocalDB.HasKey("UISeasonMazeEnterController_Boss_New") and LocalDB.GetInt("UISeasonMazeEnterController_Boss_New") == 1 then
    new = true
  end
  if not LocalDB.HasKey("UISeasonMazeEnterController_Enter_Game_New") and self._sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    new = true
  end
  if self._sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD) then
    red = true
  end
  if new then
    red = false
  end
  return new, red
end

function UISeaonMazeBtnItem:BgOnClick(go)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  if self.Over.activeSelf then
    return
  end
  self._sample = self._seasonMazeModule:GetCurSample()
  if self._sample == nil then
    self.uISeaonMazeBtnItem:SetActive(false)
    ToastManager.ShowToast(StringTable.Get("str_world_boss_season_end"))
    return
  end
  if not self._sample.is_open then
    self.uISeaonMazeBtnItem:SetActive(false)
    ToastManager.ShowToast(StringTable.Get("str_world_boss_season_end"))
    return
  end
  self:ShowDialog("UISeasonMazeEnterController", function()
    if self.cb then
      self.cb()
    end
  end)
  UIActivityHelper.SetLocalDB("S5SeasonMazeBtnNew")
end
