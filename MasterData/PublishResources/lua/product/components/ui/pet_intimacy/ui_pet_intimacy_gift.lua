_class("UIPetIntimacyGift", Object)
UIPetIntimacyGift = UIPetIntimacyGift

function UIPetIntimacyGift:Constructor(intimacyMainController, petData)
  self._intimacyMainController = intimacyMainController
  self._petData = petData
  self._isInited = false
  self.uiCustomEventListener = UICustomUIEventListener:New()
end

function UIPetIntimacyGift:Init()
  self._scrollView = self._intimacyMainController:GetUIComponent("UIDynamicScrollView", "GiftListScrollView")
  self._affinityLevelLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "AffinityLevel")
  self._curExpLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "CurrExp")
  self._maxExpLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "MaxExp")
  self._addExpLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "AddExp")
  self._affinityRelationNameLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "AffinityRelationName")
  self._affinityTr = self._intimacyMainController:GetUIComponent("Transform", "RelationShipRoot")
  self._revolvingText = self._intimacyMainController:GetUIComponent("RevolvingTextWithDynamicScroll", "RelationShipRoot")
  self._affinityLevelMaxGo = self._intimacyMainController:GetGameObject("AffinityLevelMax")
  self._petInfoPanelGo = self._intimacyMainController:GetGameObject("PetInfoPanel")
  self._expPanelGo = self._intimacyMainController:GetGameObject("ExpPanel")
  self._addExpGo = self._intimacyMainController:GetGameObject("AddExp")
  self._giveAwayGiftButtonPanelGo = self._intimacyMainController:GetGameObject("GiveAwayGiftButtonPanel")
  self._affinityMaxPanelGo = self._intimacyMainController:GetGameObject("AffinityMaxPanel")
  self._affinityExpBar1 = self._intimacyMainController:GetUIComponent("Image", "AffinityBar1")
  self._affinityExpBar2 = self._intimacyMainController:GetUIComponent("Slider", "AffinityBar2")
  self._buttonSendGo = self._intimacyMainController:GetGameObject("ButtonSend")
  self._buttonClearGo = self._intimacyMainController:GetGameObject("ButtonClear")
  self._attackValueLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "AttackValue")
  self._defendValueLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "DefendValue")
  self._hpValueLabel = self._intimacyMainController:GetUIComponent("UILocalizationText", "HpValue")
  self._sendGiftEff = self._intimacyMainController:GetGameObject("sendGiftEff")
  self._effLevelUp = self._intimacyMainController:GetGameObject("effLevelUp")
  self._effLevelUp:SetActive(false)
  self._sendGiftEffRawImage = self._intimacyMainController:GetUIComponent("RawImage", "sendGiftEffRawImage")
  self._sendGiftEffRawImageRect = self._intimacyMainController:GetUIComponent("RectTransform", "sendGiftEffRawImage")
  self._sendGiftEffRawImageParentRect = self._intimacyMainController:GetUIComponent("RectTransform", "sendGiftEffRawImageRect")
  self._petModle = self._intimacyMainController:GetGameObject("PetModel")
  self._randomEventTips = self._intimacyMainController:GetGameObject("randomEventTips")
  local etlSend = UICustomUIEventListener.Get(self._buttonSendGo)
  self.uiCustomEventListener:AddUICustomEventListener(etlSend, UIEvent.Click, function(go)
    self:_SendButtonClick()
  end)
  local etlClear = UICustomUIEventListener.Get(self._buttonClearGo)
  self.uiCustomEventListener:AddUICustomEventListener(etlClear, UIEvent.Click, function(go)
    self:_ClearButtonClick()
  end)
  local etlClear = UICustomUIEventListener.Get(self._randomEventTips)
  self.uiCustomEventListener:AddUICustomEventListener(etlClear, UIEvent.Click, function(go)
    self:randomEventTipsOnClick()
  end)
  self._hasFavorableGift = false
  self:_InitPetData()
  self:_InitGiftData()
  self:_InitScrollView()
  self:_RefreshPetAniffityInfo()
  self:_LoadVoiceRes()
  self._storyIds = {}
  self:CheckPetStoryCount()
  self:CheckStoryBtn()
end

function UIPetIntimacyGift:PetDataChanged(petData)
  self._petData = petData
  if self._isInited then
    self:Refresh()
  end
end

function UIPetIntimacyGift:CheckPetStoryCount()
  local AirModule = GameGlobal.GetModule(AircraftModule)
  local giftStory = AirModule:GetStoryEventDicByTriggerType(EStoryTriggerType.GiveGift)
  if giftStory and table.count(giftStory) > 0 then
    local cfg = Cfg.cfg_aircraft_pet_stroy_refresh({})
    for key, value in pairs(giftStory) do
      for index, var in ipairs(value.story_event_id_list) do
        if 0 < var then
          local _cfg = cfg[var]
          if _cfg then
            local petid = _cfg.PetID
            if petid == self._petData:GetTemplateID() then
              self._storyIds[#self._storyIds + 1] = var
            end
          else
            Log.error("###[UIPetIntimacyGift] _cfg is nil ! id --> ", var)
          end
        end
      end
    end
  end
end

function UIPetIntimacyGift:CheckStoryBtn()
  Log.debug("###[UIPetIntimacyGift] 检查剧情数量，count --> ", #self._storyIds)
  self._randomEventTips:SetActive(#self._storyIds > 0)
  if #self._storyIds > 0 then
    local first = self._storyIds[1]
    local head = self._petData:GetPetHead(PetSkinEffectPath.HEAD_ICON_PET_INTIMACY)
    local icon = self._intimacyMainController:GetUIComponent("RawImageLoader", "randomEventHead")
    icon:LoadImage(head)
    local cfg_pet_story = Cfg.cfg_pet_story[first]
    if not cfg_pet_story then
      Log.error("###[UIPetIntimacyGift] cfg_pet_story is nil ! id --> ", first)
    end
    local Title = cfg_pet_story.Title
    local TitleTex = self._intimacyMainController:GetUIComponent("UILocalizationText", "randomEventDesc")
    TitleTex:SetText(StringTable.Get(Title))
  end
end

function UIPetIntimacyGift:Refresh()
  if self._isInited then
    self:_InitPetData()
    self:_InitGiftData()
    self:_SetListItemCount()
    self._scrollView:ResetListView()
    self._scrollView:RefreshAllShownItem()
    self:_RefreshPetAniffityInfo()
    self._storyIds = {}
    self:CheckPetStoryCount()
    self:CheckStoryBtn()
  else
    self:Init()
    self._isInited = true
  end
end

function UIPetIntimacyGift:CloseWindow()
  self:_StopPlayVoice()
  if self._randomEventTips then
    self._randomEventTips:SetActive(false)
  end
end

function UIPetIntimacyGift:Destroy()
  self:CloseWindow()
  local pm = GameGlobal.GetModule(PetAudioModule)
  pm:StopAll()
  self.uiCustomEventListener:RemoveAllCustomEventListener()
  if self._playVoiceTask then
    GameGlobal.TaskManager():KillTask(self._playVoiceTask)
    self._playVoiceTask = nil
  end
end

function UIPetIntimacyGift:Update()
end

function UIPetIntimacyGift:_LoadVoiceRes()
end

function UIPetIntimacyGift:_StopPlayVoice(isPlayAnim)
  if self._intimacyMainController then
    self._intimacyMainController:StopPlayVoice(isPlayAnim)
  end
end

function UIPetIntimacyGift:_PlayVoice(isLove)
  local pm = GameGlobal.GetModule(PetAudioModule)
  isLove = isLove or false
  local audioName = isLove and "ReceiveLoveGift" or "ReceiveGift"
  local checkSkinID = self._petData:GetSkinId()
  local petid = self._petData:GetTemplateID()
  local cfgs = Cfg.cfg_pet_voice({PetID = petid, SkinID = checkSkinID})
  local cfg_pet_voice_skin
  if cfgs and next(cfgs) then
    cfg_pet_voice_skin = cfgs[1]
  else
    local tmp_cfgs = Cfg.cfg_pet_voice({PetID = petid, SkinID = nil})
    if tmp_cfgs and next(tmp_cfgs) then
      cfg_pet_voice_skin = tmp_cfgs[1]
    end
  end
  if not cfg_pet_voice_skin then
    Log.error("###[UIPetIntimacyGift] cfg_pet_voice_skin is nil ! id:", petid, "|skin:", checkSkinID)
    return
  end
  local l_audio_id
  local cfg_pet_voice = cfg_pet_voice_skin[audioName]
  if type(cfg_pet_voice) == "table" then
    local giftlv = self._petData:GetPetAffinityLevel()
    if 5 <= giftlv then
      for key, value in pairs(cfg_pet_voice) do
        local lv = value[2]
        if lv and lv == giftlv then
          l_audio_id = value[1]
          break
        end
      end
      Log.error("###[UIPetIntimacyGift] check over , audio id is nil ! petid:", petid, "|giftlv:", giftlv)
    else
      l_audio_id = cfg_pet_voice[1][1]
    end
  elseif type(cfg_pet_voice) == "number" then
    l_audio_id = cfg_pet_voice
  else
    Log.error("###[UIPetIntimacyGift] cfg_pet_voice is nil ! type is other.petid:", petid)
  end
  if not l_audio_id then
    return
  end
  if self._last_audio_id then
    AudioHelperController.StopUIVoice(self._last_audio_id)
  end
  self._last_audio_id = pm:PlayAudio(l_audio_id)
  local cfg = AudioHelperController.GetCfgAudio(l_audio_id)
  if not cfg then
    return
  end
  local l_content_cfg = cfg.Content
  if self._playVoiceTask then
    GameGlobal.TaskManager():KillTask(self._playVoiceTask)
    self._playVoiceTask = nil
  end
  self:_StopPlayVoice()
  self._intimacyMainController:PlayVoice(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(l_content_cfg)), not isLove)
  self._playVoiceTask = GameGlobal.TaskManager():StartTask(function(TT)
    while true do
      YIELD(TT)
      if not self._intimacyMainController then
        return
      end
      local len = AudioHelperController.GetPlayingVoiceSecLengthByAudioId(l_audio_id)
      if 0 < len then
        YIELD(TT, len * 1000)
        break
      end
    end
    if not self._intimacyMainController then
      return
    end
    self:_StopPlayVoice(true)
    self._playVoiceTask = nil
  end, self)
end

function UIPetIntimacyGift:_InitPetData()
  self._maxAffinityMaxLevel = self._petData:GetPetAffinityMaxLevel()
  local petConfig = Cfg.cfg_pet[self._petData:GetTemplateID()]
  self._functionType = petConfig.FunctionType
  self._tags = petConfig.Tags
  self._realLevel = self._petData:GetPetAffinityLevel()
  self._realExp = self._petData:GetPetAffinityExp()
  self._realMaxExp = self._petData:GetPetAffinityMaxExp(self._realLevel)
  self._curLevel = self._realLevel
  self._curExp = self._realExp
  self._curMaxExp = self._realMaxExp
  self._addExp = 0
  local matName = self._petData:GetPetStaticBody(PetSkinEffectPath.BODY_PET_INTIMACY)
  local petCgMat = self._petModle:GetComponent("RawImage").material
  self._sendGiftEffRawImage.texture = petCgMat:GetTexture("_MainTex")
  local petMpdoleRt = self._petModle:GetComponent("RectTransform")
  self._sendGiftEffRawImageRect.sizeDelta = petMpdoleRt.sizeDelta
  self._sendGiftEffRawImageParentRect.anchoredPosition = petMpdoleRt.anchoredPosition + petMpdoleRt.parent.gameObject:GetComponent("RectTransform").anchoredPosition
  self._sendGiftEffRawImageRect.localScale = self._petModle:GetComponent("RectTransform").localScale
  self:_RefreshPetAddAttributes(self._curLevel)
end

function UIPetIntimacyGift:_RefreshPetAddAttributes(level)
  local attack, defend, hp = UIPetIntimacyGift.GetAttributesByPetAffinityLv(self._petData:GetTemplateID(), level)
  self._attackValueLabel.text = "+" .. attack
  self._defendValueLabel.text = "+" .. defend
  self._hpValueLabel.text = "+" .. hp
end

function UIPetIntimacyGift.GetAttributesByPetAffinityLv(petTemplateID, level)
  local cfgs = Cfg.cfg_pet_affinity({PetID = petTemplateID})
  local attack, defend, hp = 0, 0, 0
  if cfgs then
    local cfg
    for k, v in pairs(cfgs) do
      if v.AffinityLevel == level then
        cfg = v
        break
      end
    end
    if cfg then
      attack = cfg.Attack
      defend = cfg.Defence
      hp = cfg.Health
    end
  end
  return attack, defend, hp
end

function UIPetIntimacyGift:_InitGiftData()
  self._itemCountPerRow = 4
  self._itemModule = GameGlobal.GetModule(ItemModule)
  local itemDatas = self._itemModule:GetItemListBySubType(ItemSubType.ItemSubType_PetPresent)
  self._giftDatas = {}
  if itemDatas then
    local giftDatas = {}
    for i = 1, #itemDatas do
      local giftData = {}
      giftData.giftData = itemDatas[i]
      giftData.isSelected = false
      giftData.selectedCount = 0
      local templateId = itemDatas[i]:GetTemplateID()
      local cfg = Cfg.cfg_item_pet_present[templateId]
      if cfg then
        giftData.baseAffinity = cfg.BaseAffinity
        giftData.extAffinity = cfg.ExtAffinity
        giftData.forceFavorType = cfg.ForceFavorType
        giftData.functionFavorType = cfg.FunctionFavorType
        giftData.des = cfg.Desc
      end
      giftData.index = 0
      if self:IsFavorableGift(giftData) then
        giftData.index = 1
      end
      giftDatas[i] = giftData
    end
    self._giftDatas = giftDatas
  end
  self._giftDatas = self:_SortGiftDatas(self._giftDatas)
  self._giftCount = table.count(self._giftDatas)
  self:_CalRow()
end

function UIPetIntimacyGift:_SortGiftDatas(giftDatas)
  if not giftDatas then
    local emptyTable = {}
    return emptyTable
  end
  table.sort(giftDatas, function(a, b)
    if a.index ~= b.index then
      return a.index > b.index
    end
    return a.giftData:GetTemplateID() > b.giftData:GetTemplateID()
  end)
  return giftDatas
end

function UIPetIntimacyGift:_RefreshPetAniffityInfo()
  local curExp = self._curExp - Cfg.cfg_pet_affinity_exp[self._curLevel].NeedAffintyExp
  local percent = curExp / self._curMaxExp
  if self._maxAffinityMaxLevel <= self._curLevel then
    self._affinityLevelMaxGo:SetActive(true)
    self._curExpLabel.text = self._curMaxExp
    self._maxExpLabel.text = self._curMaxExp
    percent = 1
  else
    self._affinityLevelMaxGo:SetActive(false)
    self._curExpLabel.text = curExp
    self._maxExpLabel.text = self._curMaxExp
  end
  if self._realLevel >= self._maxAffinityMaxLevel then
    self._addExpGo:SetActive(false)
  elseif self._addExp ~= 0 then
    self._addExpGo:SetActive(true)
    self._addExpLabel.text = "+" .. self._addExp
  else
    self._addExpGo:SetActive(false)
  end
  self._affinityLevelLabel.text = self._curLevel
  self._affinityExpBar1.fillAmount = percent
  self._affinityExpBar2.value = percent
  local cfg = Cfg.cfg_pet_affinity_exp[self._curLevel]
  if 0 < self._affinityTr.childCount then
    for i = 1, self._affinityTr.childCount do
      local cloneText = self._affinityTr:GetChild(i - 1).gameObject:GetComponent("UILocalizationText")
      cloneText:SetText(StringTable.Get(cfg.Desc))
    end
  end
  self._revolvingText:OnRefreshRevolving()
  if self._realLevel >= self._maxAffinityMaxLevel then
    self._giveAwayGiftButtonPanelGo:SetActive(true)
    self._affinityMaxPanelGo:SetActive(false)
  else
    self._giveAwayGiftButtonPanelGo:SetActive(true)
    self._affinityMaxPanelGo:SetActive(false)
  end
  self:_RefreshPetAddAttributes(self._curLevel)
end

function UIPetIntimacyGift:_CalRow()
  self._giftRow = math.ceil(self._giftCount / self._itemCountPerRow)
  if self._giftRow < 4 then
    self._giftRow = 4
  end
end

function UIPetIntimacyGift:_InitScrollView()
  self._scrollView:InitListView(self._giftRow, function(scrollview, index)
    return self:_OnGeGiftItem(scrollview, index)
  end)
end

function UIPetIntimacyGift:_SetListItemCount()
  self._scrollView:SetListItemCount(self._giftRow)
end

function UIPetIntimacyGift:_OnGeGiftItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self._intimacyMainController:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIPetIntimacyGiftItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local itemWidget = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_RefreshGiftItemInfo(itemWidget, itemIndex)
  end
  return item
end

function UIPetIntimacyGift:_RefreshGiftItemInfo(itemWidget, index)
  itemWidget:Refresh(self._intimacyMainController, self, self._petData, self._giftDatas[index])
end

function UIPetIntimacyGift:OnItemClicked(giftData, isAdd)
  if giftData == nil then
    return false
  end
  if self._realLevel < self._maxAffinityMaxLevel and isAdd and self._curLevel >= self._maxAffinityMaxLevel then
    return false
  end
  local affinityValue = 0
  if giftData.baseAffinity then
    affinityValue = affinityValue + giftData.baseAffinity
  end
  if self:IsFavorableGift(giftData) then
    affinityValue = affinityValue + giftData.extAffinity
  end
  if isAdd then
    self._addExp = self._addExp + affinityValue
    self._curExp = self._curExp + affinityValue
  else
    self._addExp = self._addExp - affinityValue
    self._curExp = self._curExp - affinityValue
  end
  self:_CalPetData()
  self:_RefreshPetAniffityInfo()
  return true
end

function UIPetIntimacyGift:_CalPetData()
  for i = 1, self._maxAffinityMaxLevel do
    local expCfg = Cfg.cfg_pet_affinity_exp[i]
    if expCfg.NeedAffintyExp > self._curExp then
      self._curLevel = i - 1
      break
    end
    if i == self._maxAffinityMaxLevel then
      self._curLevel = self._maxAffinityMaxLevel
    end
  end
  self._curMaxExp = self._petData:GetPetAffinityMaxExp(self._curLevel)
end

function UIPetIntimacyGift:IsFavorableGift(giftData)
  if giftData.forceFavorType and self._tags then
    for i = 1, #self._tags do
      if self._tags[i] == giftData.forceFavorType then
        return true
      end
    end
  end
  if giftData.functionFavorType and self._functionType and giftData.functionFavorType == self._functionType then
    return true
  end
  return false
end

function UIPetIntimacyGift:_ClearButtonClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  self:Refresh()
end

function UIPetIntimacyGift:_SendButtonClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  local items = self:_GetSelectedGiftItems()
  if table.count(items) <= 0 then
    return
  end
  if self._maxAffinityMaxLevel <= self._realLevel then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_affinity_level_has_reachmax"), function(param)
      self._intimacyMainController:Lock("_SendButtonClick")
      GameGlobal.TaskManager():StartTask(self._SendGiftMsg, self, items)
    end, nil, function(param)
    end, nil)
  else
    self._intimacyMainController:Lock("_SendButtonClick")
    GameGlobal.TaskManager():StartTask(self._SendGiftMsg, self, items)
  end
end

function UIPetIntimacyGift:_SendGiftMsg(TT, items)
  local petModule = GameGlobal.GetModule(PetModule)
  local res, replay = petModule:RequestGivePetPresent(TT, self._petData:GetPstID(), items)
  self._intimacyMainController:UnLock("_SendButtonClick")
  if res:GetSucc() then
    self:ShowEff()
    local lvOld = self._curLevel
    self:Refresh()
    local lvNew = self._curLevel
    if lvOld < lvNew then
      GameGlobal.UIStateManager():ShowDialog("UIPetIntimacyLevelUp", self._petData:GetTemplateID(), self._petData:GetSkinId(), lvOld, lvNew)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSendGiftAndLevelUp)
      self:ShowEffLevelUp()
    end
    self:_PickPetTaskReward(replay.m_task_ids)
    local tab = {}
    if replay.trigger_story_event_id and replay.trigger_story_event_id ~= 0 then
      table.insert(tab, replay.trigger_story_event_id)
    end
    Log.debug("###[UIPetIntimacyGift] send gift succ , story count == ", table.count(tab))
    if 0 < #tab then
      for i = 1, #tab do
        local storyid = tab[i]
        self._storyIds[#self._storyIds + 1] = storyid
      end
    end
    Log.debug("###[UIPetIntimacyGift] send gift succ , self._storyIds count == ", table.count(self._storyIds))
    self:CheckStoryBtn()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGiveGift)
    self:_PlayVoice(self._hasFavorableGift)
  else
    Log.error("###[UIPetIntimacyGift] RequestGivePetPresent err:", res.m_result)
  end
end

function UIPetIntimacyGift:ShowEff()
  self._sendGiftEff:SetActive(false)
  self._sendGiftEff:SetActive(true)
end

function UIPetIntimacyGift:ShowEffLevelUp()
  self._effLevelUp:SetActive(false)
  self._effLevelUp:SetActive(true)
end

function UIPetIntimacyGift:_GetSelectedGiftItems()
  self._hasFavorableGift = false
  local items = {}
  local giftCount = table.count(self._giftDatas)
  for i = 1, giftCount do
    local giftData = self._giftDatas[i]
    if giftData.isSelected then
      local item = ItemAsset:New()
      item.assetid = giftData.giftData:GetID()
      item.count = giftData.selectedCount
      table.insert(items, item)
      if self:IsFavorableGift(giftData) then
        self._hasFavorableGift = true
      end
    end
  end
  return items
end

function UIPetIntimacyGift:_PickPetTaskReward(taskIds, storyIds)
  if taskIds == nil or #taskIds <= 0 then
    return
  else
    local taskCfg = Cfg.cfg_pet_task[taskIds[1]]
    local storyId = taskCfg.StoryID
    if storyId and 0 < storyId then
      self._intimacyMainController:ShowDialog("UIStoryBanner", storyId, StoryBannerShowType.HalfPortrait)
    end
  end
end

function UIPetIntimacyGift:randomEventTipsOnClick()
  Log.debug("###[UIPetIntimacyGift] 点击剧情按钮看剧情 !")
  if self._storyIds and #self._storyIds > 0 then
    local eventid = self._storyIds[1]
    Log.debug("###[UIPetIntimacyGift] 看剧情成功,准备请求 , id --> ", eventid)
    local cfg_pet_story = Cfg.cfg_pet_story[eventid]
    if not cfg_pet_story then
      Log.error("###[UIPetIntimacyGift] cfg_pet_story is nil ! id --> ", eventid)
    end
    local storyid = cfg_pet_story.StoryID
    local cfg_aircraft_pet_stroy_refresh = Cfg.cfg_aircraft_pet_stroy_refresh[eventid]
    if not cfg_aircraft_pet_stroy_refresh then
      Log.error("###[UIPetIntimacyGift] cfg_aircraft_pet_stroy_refresh is nil ! id --> ", eventid)
    end
    local type = cfg_aircraft_pet_stroy_refresh.TriggerType
    self._intimacyMainController:Lock("UIPetIntimacyGift:randomEventTipsOnClick")
    GameGlobal.TaskManager():StartTask(self.OnrandomEventTipsOnClick, self, type, storyid, eventid)
  end
end

function UIPetIntimacyGift:OnrandomEventTipsOnClick(TT, type, storyid, eventid)
  local petModule = GameGlobal.GetModule(PetModule)
  local res = petModule:RequestPetViewTriggeredStory(TT, self._petData:GetPstID(), type, eventid)
  self._intimacyMainController:UnLock("UIPetIntimacyGift:randomEventTipsOnClick")
  if res:GetSucc() then
    Log.debug("###[UIPetIntimacyGift] 可以看剧情,开始播放 , storyid --> ", storyid)
    self._intimacyMainController:ShowDialog("UIStoryController", storyid, function()
      self:EndStoryDialog(type, eventid)
    end)
  else
    Log.error("###[UIPetIntimacyGift] OnrandomEventTipsOnClick succ false --> ", res:GetResult())
  end
end

function UIPetIntimacyGift:EndStoryDialog(type, eventid)
  self._intimacyMainController:Lock("UIPetIntimacyGift:EndStoryDialog")
  GameGlobal.TaskManager():StartTask(function(TT)
    local petModule = GameGlobal.GetModule(PetModule)
    local res, replay = petModule:RequestPetFinishTriggeredStory(TT, self._petData:GetPstID(), type, eventid)
    self._intimacyMainController:UnLock("UIPetIntimacyGift:EndStoryDialog")
    if res:GetSucc() then
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", replay.reward, function()
        Log.debug("###[UIPetIntimacyGift] 看完剧情，移除剧情!")
        table.remove(self._storyIds, 1)
        self:CheckStoryBtn()
      end)
      Log.debug("###[UIPetIntimacyGift] story Look end")
    else
      Log.error("###[UIPetIntimacyGift] story Look end res-->", res:GetResult())
    end
  end)
end
