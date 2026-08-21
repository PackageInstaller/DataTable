_class("UIN26Movie", UIController)
UIN26Movie = UIN26Movie

function UIN26Movie:Constructor(ui_root_transform)
  self._isInHomeland = false
  self._atlas = self:GetAsset("UIN23.spriteatlas", LoadType.SpriteAtlas)
  self._campaign_module = GameGlobal.GetModule(CampaignModule)
end

function UIN26Movie:OnShow(uiParams)
  self._isInHomeland = uiParams[1]
  if self._isInHomeland then
    GameGlobal.TaskManager():StartTask(function(TT)
      self:RemoveRed(TT)
    end)
  end
  self:InitWidget()
  self:InitFilmItem()
  self:_SetTimer()
end

function UIN26Movie:RemoveRed(TT)
end

function UIN26Movie:OnHide()
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIN26Movie:InitWidget()
  self._movieContent = self:GetUIComponent("UILocalizationText", "movieContent")
  self._goBtn = self:GetUIComponent("Image", "goBtn")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._typeTitle = self:GetUIComponent("UILocalizationText", "typeTitle")
  self._bottomBG = self:GetGameObject("bottomBG")
  self._tipsObj = self:GetGameObject("tips")
  self._tips = self:GetUIComponent("UILocalizationText", "tips")
  self._countDownObj = self:GetGameObject("countDown")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._time = self:GetUIComponent("UILocalizationText", "time")
  self._newText = self:GetUIComponent("UILocalizationText", "newText")
  self._endText = self:GetUIComponent("UILocalizationText", "endText")
  self._secondText = self:GetUIComponent("UILocalizationText", "secondText")
  self._itemContent = self:GetUIComponent("UISelectObjectPath", "itemContent")
  self._movieContent:SetText(StringTable.Get("str_movie_campaign_intro"))
  local cfg = Cfg.cfg_global({})
  local rewards = cfg.homeland_movie_task_reward.ArrayValue
  local len = table.count(rewards)
  local index = 1
  self._widgets = self._rewardContent:SpawnObjects("UIItemHomeland", len)
  for i, v in pairs(rewards) do
    local rew = {}
    rew.assetid = v
    rew.count = nil
    self._widgets[index]:Flush(rew)
    index = index + 1
  end
  if self._isInHomeland then
    self:GetGameObject("goBtn"):SetActive(false)
    self._tipsObj:SetActive(true)
    self._tips:SetText(StringTable.Get("str_movie_enter_text_1"))
    self._bottomBG:SetActive(true)
  else
    self._bottomBG:SetActive(false)
  end
  self._secondText:SetText(StringTable.Get("str_movie_enter_text_2"))
  self._newText:SetText(StringTable.Get("str_movie_enter_text_3"))
  self._endText:SetText(StringTable.Get("str_movie_enter_text_4"))
  self._countText:SetText(StringTable.Get("str_movie_enter_text_5"))
end

function UIN26Movie:InitFilmItem()
  self._movieDataHelper = MovieDataHelper:New()
  local data = self._movieDataHelper:SortAnonymous()
  local index = 1
  self._cfgAnonymousLetter = Cfg.cfg_homeland_anonymous_letter({})
  self._cfgmovice = Cfg.cfg_homeland_movice({})
  self._cfgitem = Cfg.cfg_item({})
  self._widgets = self._itemContent:SpawnObjects("UIN26MovieItem", 3)
  for i, v in pairs(data) do
    local rew = {}
    rew.anonymousId = self._cfgAnonymousLetter[v].ID
    local movieId = self._cfgAnonymousLetter[v].MovieId
    local itemId = self._cfgmovice[movieId].UnlockItem
    rew.item = itemId
    rew.icon = self._cfgitem[itemId].Icon
    self._widgets[index]:SetData(rew)
    index = index + 1
  end
end

function UIN26Movie:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    local havenew = self._movieDataHelper:ShowOrNot()
    local str = self:_SetTimeStr()
    if str and havenew == false then
      self._countDownObj:SetActive(true)
      self._time:SetText(str)
      self:GetGameObject("newText"):SetActive(false)
      self:GetGameObject("endText"):SetActive(false)
    elseif havenew then
      self:GetGameObject("newText"):SetActive(true)
      self:GetGameObject("endText"):SetActive(false)
      self._countDownObj:SetActive(false)
    elseif havenew == false and str == nil then
      self:GetGameObject("endText"):SetActive(true)
      self:GetGameObject("newText"):SetActive(false)
      self._countDownObj:SetActive(false)
    end
  end)
end

function UIN26Movie:_SetTimeStr()
  local count = {}
  local countdown
  self._movieDataHelper = MovieDataHelper:New()
  local id = self._movieDataHelper:GetAllAnonymousId()
  for k, v in ipairs(id) do
    countdown = self._movieDataHelper:GetAnonymousCountdownTimeById(v)
    if 0 < countdown then
      table.insert(count, countdown)
    end
  end
  if #count ~= 0 then
    countdown = table.min(count)
    local str = self._movieDataHelper:GetFormatTimerStr(countdown)
    return str
  else
    return nil
  end
end

function UIN26Movie:CloseBtnOnClick()
  self:CloseDialog()
end

function UIN26Movie:GoBtnOnClick()
  if self._isInHomeland then
    return
  else
    self._functionId = 34
    local functionLockCfg = Cfg.cfg_module_unlock[self._functionId]
    if not functionLockCfg then
      Log.debug("don't have function config")
      return
    end
    local module = GameGlobal.GetModule(RoleModule)
    if module:CheckModuleUnlock(self._functionId) == false then
      local cfg = Cfg.cfg_module_unlock[self._functionId]
      if cfg then
        ToastManager.ShowToast(StringTable.Get(cfg.Tips))
      end
      return
    end
    GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
  end
end
