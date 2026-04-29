_class("UIMainLobbyBtnGamble", Object)
UIMainLobbyBtnGamble = UIMainLobbyBtnGamble

function UIMainLobbyBtnGamble:Constructor(icon, freeMulGo, freeSinGo, newGo, sumBtn, atlas)
  self._gambleNew = newGo
  self._freeMulGo = freeMulGo
  self._freeSinGo = freeSinGo
  self._main_sumBtn = sumBtn
  self._main_atlas = atlas
  self._freeMulGo:SetActive(false)
  self._freeSinGo:SetActive(false)
  self._gambleNew:SetActive(false)
  self._latestPoolId = 0
  local gambleModule = GameGlobal.GetModule(GambleModule)
  local pools = gambleModule:GetPrizePools()
  local temp = {}
  for i = 1, #pools do
    local pool = pools[i]
    if pool.prize_pool_type == 2 then
      table.insert(temp, pool)
    end
  end
  local openTime = 0
  if 0 < table.count(temp) then
    for i = 1, #temp do
      if openTime < temp[i].open_time then
        self._latestPoolId = temp[i].prize_pool_id
        openTime = temp[i].open_time
      end
    end
  end
  if self._latestPoolId ~= 0 then
    local cfg_gamble = Cfg.cfg_gamble_icon[self._latestPoolId]
    if cfg_gamble then
      if cfg_gamble.Icon then
        icon.gameObject:SetActive(true)
        icon:LoadImage(cfg_gamble.Icon)
      else
        icon.gameObject:SetActive(false)
      end
    else
      icon.gameObject:SetActive(false)
    end
  else
    icon.gameObject:SetActive(false)
  end
  GameGlobal.TaskManager():StartTask(self.GetCampaign, self)
  self:RefreshNew()
end

function UIMainLobbyBtnGamble:ShowNewAndRed(show)
  if show then
    self:RefreshNew()
    self:RefreshRed()
  else
    if self._gambleNew ~= nil then
      self._gambleNew:SetActive(false)
    end
    if self._gambleRed ~= nil then
      self._gambleRed:SetActive(false)
    end
  end
end

function UIMainLobbyBtnGamble:RefreshNew()
  local freeMul, freeSin, hasNew = false, false, false
  freeMul = self:_HasFreeDraw_Multi()
  if freeMul then
    self._freeMulGo:SetActive(true)
  else
    self._freeMulGo:SetActive(false)
    freeSin = self:_HasFreeDraw_Single()
    if freeSin then
      self._freeSinGo:SetActive(true)
    else
      self._freeSinGo:SetActive(false)
    end
  end
  hasNew = self:_HasNew()
  local sprite
  if hasNew then
    self._gambleNew:SetActive(true)
    sprite = "main_zjm_new_di06_1"
  else
    self._gambleNew:SetActive(false)
    sprite = "main_zjm_new_di06"
  end
  self._hasGambleNew = hasNew
  if self._main_sumBtn then
    local sp = self._main_atlas:GetSprite(sprite)
    self._main_sumBtn.sprite = sp
  end
end

function UIMainLobbyBtnGamble:_HasFreeDraw_Multi()
  local gambleModule = GameGlobal.GetModule(GambleModule)
  local pools = gambleModule:GetPrizePools()
  for _, pool in ipairs(pools) do
    if pool.mul_remain_free_count > 0 then
      return true
    end
  end
  return false
end

function UIMainLobbyBtnGamble:_HasFreeDraw_Single()
  local gambleModule = GameGlobal.GetModule(GambleModule)
  local pools = gambleModule:GetPrizePools()
  for _, pool in ipairs(pools) do
    if pool.remain_free_count > 0 then
      return true
    end
  end
  return false
end

function UIMainLobbyBtnGamble:Dispose()
end

function UIMainLobbyBtnGamble:_HasNew()
  return GameGlobal.GetModule(GambleModule):HasNewPool()
end

function UIMainLobbyBtnGamble:OnClicked()
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_DrawCardController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Gamble)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_SUMMON)
  if self._hasGambleNew and self._latestPoolId ~= 0 then
    local openId = GameGlobal.GameLogic():GetOpenId()
    local key = tostring(openId) .. "GambleNew"
    UnityEngine.PlayerPrefs.SetInt(key, self._latestPoolId)
  end
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIMain, function()
    GameGlobal.UIStateManager():ShowDialog("UIRecruit")
  end)
end

function UIMainLobbyBtnGamble:InitGambleRed(gambleRed)
  self._gambleRed = gambleRed
  self:RefreshRed()
end

function UIMainLobbyBtnGamble:RefreshRed()
  if self._gambleRed == nil then
    return
  end
  if tolua.isnull(self._gambleRed) then
    return
  end
  local showRed = false
  local module = GameGlobal.GetModule(GambleModule)
  local awardPools = module:GetPrizePools()
  for idx, pool in ipairs(awardPools) do
    showRed = module:CheckOptionalRed(idx)
    if showRed then
      break
    end
  end
  if self._hasGambleNew then
    showRed = false
  end
  if not showRed and self._questComponent then
    local curQuest = self:GetCurQuest()
    if not curQuest then
      showRed = false
    else
      showRed = curQuest._questInfo.status == QuestStatus.QUEST_Completed
    end
  end
  self._gambleRed:SetActive(showRed)
end

function UIMainLobbyBtnGamble:GetCampaign(TT, cb)
  if GameGlobal.GetModule(CampaignModule):GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_GAMBLE) then
    local res = AsyncRequestRes:New()
    self._campaign = UIActivityCampaign:New()
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_GAMBLE)
    if res and not res:GetSucc() then
      res:SetSucc(true)
    else
      self._campaign:ReLoadCampaignInfo_Force(TT, res)
      self._questComponent = self._campaign:GetComponent(ECampaignGambleComponentID.ECAMPAIGN_Gamble_QUEST)
    end
  end
  if cb then
    cb()
  end
end

function UIMainLobbyBtnGamble:GetCurQuest()
  local curQuest
  local questList = self._questComponent:GetQuestInfo()
  for _, quest in pairs(questList) do
    if quest._questInfo.status < QuestStatus.QUEST_Completed then
      curQuest = quest
      break
    elseif quest._questInfo.status == QuestStatus.QUEST_Completed then
      curQuest = quest
      break
    end
  end
  if not curQuest then
    local len = table.count(questList)
    curQuest = questList[len]
  end
  return curQuest
end
